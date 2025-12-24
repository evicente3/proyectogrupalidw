# backend/models/pedido.py
from mysql.connector import Error
from db.connection import get_connection

def crear_pedido(id_usuario, id_producto, cantidad):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        # Verificar que el producto exista
        cursor.execute("SELECT id FROM productos WHERE id = %s", (id_producto,))
        if not cursor.fetchone():
            return False, "Producto no encontrado"

        cursor.execute(
            """
            INSERT INTO pedidos (id_usuario, id_producto, cantidad, estado)
            VALUES (%s, %s, %s, %s)
            """,
            (id_usuario, id_producto, cantidad, "pendiente"),
        )
        conn.commit()
        return True, "Pedido creado"
    except Error as e:
        print("Error MySQL (crear_pedido):", e)
        return False, "Error en el servidor"
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


def listar_pedidos_usuario(id_usuario):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute(
            """
            SELECT p.id, pr.nombre AS producto, p.cantidad, p.estado, p.creado_en
            FROM pedidos p
            JOIN productos pr ON p.id_producto = pr.id
            WHERE p.id_usuario = %s
            ORDER BY p.id DESC
            """,
            (id_usuario,),
        )
        return cursor.fetchall()
    except Error as e:
        print("Error MySQL (listar_pedidos_usuario):", e)
        return []
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


def listar_pedidos_admin():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute(
            """
            SELECT p.id, u.nombre AS usuario, pr.nombre AS producto,
                   p.cantidad, p.estado, p.creado_en
            FROM pedidos p
            JOIN usuarios u ON p.id_usuario = u.id
            JOIN productos pr ON p.id_producto = pr.id
            ORDER BY p.id DESC
            """
        )
        return cursor.fetchall()
    except Error as e:
        print("Error MySQL (listar_pedidos_admin):", e)
        return []
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


def actualizar_estado_pedido(id_pedido, nuevo_estado):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute(
            "UPDATE pedidos SET estado = %s WHERE id = %s",
            (nuevo_estado, id_pedido),
        )
        conn.commit()
        return cursor.rowcount > 0
    except Error as e:
        print("Error MySQL (actualizar_estado_pedido):", e)
        return False
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
