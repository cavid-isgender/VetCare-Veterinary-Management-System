from flask import Flask,request, render_template
from sqlalchemy import text
from db import db,init_db
from decimal import Decimal,InvalidOperation



app = Flask(__name__)

init_db(app)

@app.route('/')
def home():
    return render_template('index.html')


@app.route('/db-test')
def test_database():
    try:
        with db.engine.connect() as connection:
            result = connection.execute(text('SELECT * from products'))
            value = result.scalar()

            return {"database":"connected",
                    "test_result":value}

    except Exception as error:
        app.logger.exception("Database connection failed")

        return {
            "database": "connection failed",
            "error": str(error)
        }, 500

    # for getting a full table of Products:
    # with db.engine.connect() as connection:
    #     result = connection.execute(text('select * from products'))
    #     products = result.mappings().all()
    #
    # return {'products':[dict(product) for product in products]}



@app.route('/products',methods = ['GET'])
def get_products():
    with db.engine.connect() as connection:
        result = connection.execute(text("select * from products order by product_id"))
        products = result.mappings().all()

    return {"products":[dict(product) for product in products]}



@app.route('/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    with db.engine.connect() as connection:
        result = connection.execute(text("""
        select * from products
        where product_id = :product_id
        """
        ),{"product_id":product_id})

        product = result.mappings().first()

        if product is None:
            return {"error":'Product not found'}

        return {"product":dict(product)}



# 3. POST: Create a new product
@app.route("/products", methods=["POST"])
def create_product():
    data = request.get_json(silent=True)

    if not isinstance(data, dict):
        return {"error": "Request body must be valid JSON"}, 400

    required_fields = ["name", "category", "price", "stock_quantity"]

    missing_fields = [
        field for field in required_fields
        if field not in data
    ]

    if missing_fields:
        return {
            "error": "Required fields are missing",
            "missing_fields": missing_fields
        }, 400

    if not isinstance(data["name"], str) or not data["name"].strip():
        return {"error": "Name must be a non-empty string"}, 400

    if not isinstance(data["category"], str) or not data["category"].strip():
        return {"error": "Category must be a non-empty string"}, 400

    try:
        price = Decimal(str(data["price"]))
        if not price.is_finite() or price < 0:
            raise InvalidOperation
    except (InvalidOperation, ValueError):
        return {"error": "Price must be a valid non-negative number"}, 400

    stock = data["stock_quantity"]

    if isinstance(stock, bool) or not isinstance(stock, int) or stock < 0:
        return {
            "error": "Stock quantity must be a non-negative integer"
        }, 400

    description = data.get("description")
    brand = data.get("brand")
    is_active = data.get("is_active", True)

    if not isinstance(is_active, bool):
        return {"error": "is_active must be true or false"}, 400

    with db.engine.begin() as connection:
        result = connection.execute(
            text("""
                INSERT INTO products
                    (name, category, description, price,
                     stock_quantity, brand, is_active)
                VALUES
                    (:name, :category, :description, :price,
                     :stock_quantity, :brand, :is_active)
                RETURNING *
            """),
            {
                "name": data["name"].strip(),
                "category": data["category"].strip(),
                "description": description,
                "price": price,
                "stock_quantity": stock,
                "brand": brand,
                "is_active": is_active
            }
        )

        product = dict(result.mappings().one())

    return {
        "message": "Product created successfully",
        "product": product
    }, 201



# 4. PUT: Update an existing product
@app.route("/products/<int:product_id>", methods=["PUT"])
def update_product(product_id):
    data = request.get_json(silent=True)

    if not isinstance(data, dict):
        return {"error": "Request body must be valid JSON"}, 400

    required_fields = ["name", "category", "price", "stock_quantity"]

    missing_fields = [
        field for field in required_fields
        if field not in data
    ]

    if missing_fields:
        return {
            "error": "Required fields are missing",
            "missing_fields": missing_fields
        }, 400

    if not isinstance(data["name"], str) or not data["name"].strip():
        return {"error": "Name must be a non-empty string"}, 400

    if not isinstance(data["category"], str) or not data["category"].strip():
        return {"error": "Category must be a non-empty string"}, 400

    try:
        price = Decimal(str(data["price"]))
        if not price.is_finite() or price < 0:
            raise InvalidOperation
    except (InvalidOperation, ValueError):
        return {"error": "Price must be a valid non-negative number"}, 400

    stock = data["stock_quantity"]

    if isinstance(stock, bool) or not isinstance(stock, int) or stock < 0:
        return {
            "error": "Stock quantity must be a non-negative integer"
        }, 400

    description = data.get("description")
    brand = data.get("brand")
    is_active = data.get("is_active", True)

    if not isinstance(is_active, bool):
        return {"error": "is_active must be true or false"}, 400

    with db.engine.begin() as connection:
        result = connection.execute(
            text("""
                UPDATE products
                SET name = :name,
                    category = :category,
                    description = :description,
                    price = :price,
                    stock_quantity = :stock_quantity,
                    brand = :brand,
                    is_active = :is_active
                WHERE product_id = :product_id
                RETURNING *
            """),
            {
                "product_id": product_id,
                "name": data["name"].strip(),
                "category": data["category"].strip(),
                "description": description,
                "price": price,
                "stock_quantity": stock,
                "brand": brand,
                "is_active": is_active
            }
        )

        product_row = result.mappings().first()
        product = dict(product_row) if product_row is not None else None

    if product is None:
        return {"error": "Product not found"}, 404

    return {
        "message": "Product updated successfully",
        "product": product
    }


# 5. DELETE: Delete a product
@app.route("/products/<int:product_id>", methods=["DELETE"])
def delete_product(product_id):
    with db.engine.begin() as connection:
        result = connection.execute(
            text("""
                DELETE FROM products
                WHERE product_id = :product_id
                RETURNING product_id, name
            """),
            {"product_id": product_id}
        )

        deleted_product = result.mappings().first()

    if deleted_product is None:
        return {"error": "Product not found"}, 404

    return {
        "message": "Product deleted successfully",
        "deleted_product": dict(deleted_product)
    }


@app.route("/reports/completed-appointments", methods=["GET"])
def completed_appointments_report():
    with db.engine.connect() as connection:
        result = connection.execute(text("""
            SELECT *
            FROM completed_veter_appointments
            ORDER BY veterinarian_id
        """))
        rows = [dict(row) for row in result.mappings().all()]

    return {"completed_appointments": rows}



@app.route("/reports/best-selling-products", methods=["GET"])
def best_selling_products():
    with db.engine.connect() as connection:
        result = connection.execute(text("""
            SELECT
                p.product_id,
                p.name,
                SUM(oi.quantity) AS total_quantity_sold,
                SUM(oi.quantity * oi.unit_price) AS total_revenue
            FROM products p
            JOIN order_items oi ON oi.product_id = p.product_id
            GROUP BY p.product_id, p.name
            HAVING SUM(oi.quantity) > 5
            ORDER BY total_quantity_sold DESC
        """))
        rows = [dict(row) for row in result.mappings().all()]

    return {"best_selling_products": rows}


@app.route("/reports/union-products", methods=["GET"])
def union_products():
    with db.engine.connect() as connection:
        result = connection.execute(text("""
            SELECT name, category
            FROM products
            WHERE stock_quantity > 0

            UNION

            SELECT name, category
            FROM products
            WHERE is_active = TRUE

            ORDER BY name
        """))
        rows = [dict(row) for row in result.mappings().all()]

    return {"union_products": rows}


@app.route("/functions/customer-spending", methods=["POST"])
def customer_spending():
    data = request.get_json(silent=True)

    if not isinstance(data, dict):
        return {"error": "Request body must be valid JSON"}, 400

    customer_id = data.get("customer_id")

    if isinstance(customer_id, bool) or not isinstance(customer_id, int) or customer_id <= 0:
        return {"error": "customer_id must be a positive integer"}, 400

    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("""
                    SELECT public.calculate_customer_spending(:customer_id)
                    AS total_spending
                """),
                {"customer_id": customer_id}
            )
            spending = result.scalar()

        return {
            "customer_id": customer_id,
            "total_spending": spending,
            "message": "Customer spending calculated successfully"
        }

    except Exception:
        app.logger.exception("Customer spending calculation failed")
        return {"error": "Could not calculate customer spending"}, 500



@app.route("/functions/order-total", methods=["POST"])
def order_total():
    data = request.get_json(silent=True)

    if not isinstance(data, dict):
        return {"error": "Request body must be valid JSON"}, 400

    order_id = data.get("order_id")

    if isinstance(order_id, bool) or not isinstance(order_id, int) or order_id <= 0:
        return {"error": "order_id must be a positive integer"}, 400

    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("""
                    SELECT public.calculate_order_total(:order_id)
                    AS total_amount
                """),
                {"order_id": order_id}
            )
            total = result.scalar()

        return {
            "order_id": order_id,
            "total_amount": total,
            "message": "Order total calculated successfully"
        }

    except Exception:
        app.logger.exception("Order total calculation failed")
        return {"error": "Could not calculate order total"}, 500




@app.route("/functions/check-stock", methods=["POST"])
def check_stock():
    data = request.get_json(silent=True)

    if not isinstance(data, dict):
        return {"error": "Request body must be valid JSON"}, 400

    product_id = data.get("product_id")
    quantity = data.get("requested_quantity")

    if isinstance(product_id, bool) or not isinstance(product_id, int) or product_id <= 0:
        return {"error": "product_id must be a positive integer"}, 400

    if isinstance(quantity, bool) or not isinstance(quantity, int) or quantity <= 0:
        return {"error": "requested_quantity must be a positive integer"}, 400

    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("""
                    SELECT public.check_product_stock(
                        :product_id, :quantity
                    ) AS sufficient_stock
                """),
                {
                    "product_id": product_id,
                    "quantity": quantity
                }
            )
            sufficient = result.scalar()

        return {
            "product_id": product_id,
            "requested_quantity": quantity,
            "sufficient_stock": sufficient,
            "message": (
                "Enough stock available"
                if sufficient
                else "Not enough stock"
            )
        }

    except Exception as error:
        app.logger.exception("Stock check failed")
        return {"error": str(error)}, 400



@app.route('/functions/customer-orders', methods=['POST'])
def get_customer_orders():
    data = request.get_json(silent=True) or {}

    customer_id = data.get('customer_id')

    if customer_id is None:
        return {'error': 'customer_id is required'}, 400

    try:
        customer_id = int(customer_id)
    except (ValueError, TypeError):
        return {'error': 'customer_id must be an integer'}, 400

    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("SELECT * FROM public.get_customer_orders(:customer_id)"),
                {'customer_id': customer_id})

            orders = [ dict(row._mapping) for row in result ]

        return {
            'customer_id': customer_id,
            'orders': orders
        }

    except Exception as error:
        return {'error': str(error)}, 500



@app.route('/order-items', methods=['POST'])
def create_order_item():
    data = request.get_json(silent=True) or {}

    order_id = data.get('order_id')
    product_id = data.get('product_id')
    quantity = data.get('quantity')
    unit_price = data.get('unit_price')

    if None in (order_id, product_id, quantity, unit_price):
        return {'error': 'All fields are required'}, 400

    try:
        order_id = int(order_id)
        product_id = int(product_id)
        quantity = int(quantity)
        unit_price = Decimal(str(unit_price))

        if order_id <= 0 or product_id <= 0:
            return {'error': 'IDs must be greater than zero'}, 400

        if quantity <= 0:
            return {'error': 'Quantity must be greater than zero'}, 400

        if not unit_price.is_finite() or unit_price < 0:
            return {'error': 'Unit price must be a valid non-negative number'}, 400

    except (ValueError, TypeError, InvalidOperation):
        return {'error': 'Invalid input values'}, 400

    try:
        with db.engine.begin() as connection:
            result = connection.execute(
                text("""
                    INSERT INTO order_items
                        (order_id, product_id, quantity, unit_price)
                    VALUES
                        (:order_id, :product_id, :quantity, :unit_price)
                    RETURNING order_item_id
                """),
                {
                    'order_id': order_id,
                    'product_id': product_id,
                    'quantity': quantity,
                    'unit_price': unit_price
                }
            )

            order_item_id = result.scalar_one()

            stock_result = connection.execute(
                text("""
                    SELECT stock_quantity
                    FROM products
                    WHERE product_id = :product_id
                """),
                {'product_id': product_id}
            )

            remaining_stock = stock_result.scalar_one()

            total_result = connection.execute(
                text("""
                    SELECT total_amount
                    FROM orders
                    WHERE order_id = :order_id
                """),
                {'order_id': order_id}
            )

            order_total = total_result.scalar_one()

        return {
            'message': (
                'Order item added successfully. '
                'Stock validation, stock update and order total triggers executed.'
            ),
            'order_item_id': order_item_id,
            'remaining_stock': remaining_stock,
            'order_total': str(order_total)
        }, 201

    except Exception as error:
        return {
            'error': str(error),
            'message': (
                'Order item could not be added. '
                'Check the order, product, stock and database triggers.'
            )
        }, 400



@app.route('/appointments', methods=['POST'])
def create_appointment():
    data = request.get_json(silent=True) or {}

    pet_id = data.get('pet_id')
    veterinarian_id = data.get('veterinarian_id')
    appointment_date = data.get('appointment_date')
    appointment_time = data.get('appointment_time')
    reason = data.get('reason')
    status = data.get('status') or 'Pending'
    notes = data.get('notes') or ''

    if not all([
        pet_id,
        veterinarian_id,
        appointment_date,
        appointment_time,
        reason
    ]):
        return {'error': 'All required fields must be provided'}, 400

    try:
        pet_id = int(pet_id)
        veterinarian_id = int(veterinarian_id)

        if pet_id <= 0 or veterinarian_id <= 0:
            return {'error': 'Pet ID and Veterinarian ID must be positive'}, 400

    except (ValueError, TypeError):
        return {'error': 'Pet ID and Veterinarian ID must be integers'}, 400

    try:
        with db.engine.begin() as connection:
            result = connection.execute(
                text("""
                    INSERT INTO vet_appointments (
                        pet_id,
                        veterinarian_id,
                        appointment_date,
                        appointment_time,
                        reason,
                        status,
                        notes
                    )
                    VALUES (
                        :pet_id,
                        :veterinarian_id,
                        :appointment_date,
                        :appointment_time,
                        :reason,
                        :status,
                        :notes
                    )
                    RETURNING appointment_id
                """),
                {
                    'pet_id': pet_id,
                    'veterinarian_id': veterinarian_id,
                    'appointment_date': appointment_date,
                    'appointment_time': appointment_time,
                    'reason': reason,
                    'status': status,
                    'notes': notes
                }
            )

            appointment_id = result.scalar_one()

        return {
            'message': (
                'Appointment created successfully. '
                'The appointment date trigger allowed the date.'
            ),
            'appointment_id': appointment_id
        }, 201

    except Exception as error:
        return {
            'error': str(error),
            'message': (
                'Appointment was not created. '
                'The database may have rejected the date through its trigger.'
            )
        }, 400



if  __name__ == "__main__":
    app.run(debug=True)