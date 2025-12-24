# backend/models/producto.py
from mysql.connector import Error
from db.connection import get_connection

def listar_productos(categoria=None):
    """Lista todos los productos o filtra por categoría."""
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        if categoria:
            cursor.execute(
                "SELECT * FROM productos WHERE categoria = %s ORDER BY id DESC",
                (categoria,),
            )
        else:
            cursor.execute("SELECT * FROM productos ORDER BY id DESC")
        return cursor.fetchall()
    except Error as e:
        print("Error MySQL (listar_productos):", e)
        return []
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


def obtener_producto(id_producto):
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM productos WHERE id = %s", (id_producto,))
        return cursor.fetchone()
    except Error as e:
        print("Error MySQL (obtener_producto):", e)
        return None
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()
