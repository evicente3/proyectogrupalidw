from werkzeug.security import generate_password_hash, check_password_hash
from mysql.connector import Error
from db.connection import get_connection

def crear_usuario(nombre, email, password, rol="usuario"):
    conn = None
    cursor = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT id FROM usuarios WHERE email = %s", (email,))
        if cursor.fetchone():
            return False, "El correo ya está registrado"

        password_hash = generate_password_hash(password)

        cursor.execute(
            """
            INSERT INTO usuarios (nombre, email, password_hash, rol)
            VALUES (%s, %s, %s, %s)
            """,
            (nombre, email, password_hash, rol),
        )
        conn.commit()
        return True, "Usuario creado"
    except Error as e:
        print("Error MySQL (crear_usuario):", e)
        return False, "Error en el servidor"
    finally:
        if cursor is not None:
            cursor.close()
        if conn is not None and conn.is_connected():
            conn.close()


def autenticar_usuario(email, password):
    """Devuelve dict usuario si ok, o (None, msg) si falla."""
    conn = None
    cursor = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute(
            "SELECT id, nombre, email, password_hash, rol FROM usuarios WHERE email = %s",
            (email,),
        )
        user = cursor.fetchone()
        if not user or not check_password_hash(user["password_hash"], password):
            return None, "Credenciales inválidas"

        return user, "Login correcto"
    except Error as e:
        print("Error MySQL (autenticar_usuario):", e)
        return None, "Error en el servidor"
    finally:
        if cursor is not None:
            cursor.close()
        if conn is not None and conn.is_connected():
            conn.close()
