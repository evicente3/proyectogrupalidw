from werkzeug.security import generate_password_hash
from db.connection import getconnection as get_connection

def crear_admin():
    nombre = "Admin"
    email = "admin@tienda.com"
    password_plano = "Admin123"

    password_hash = generate_password_hash(password_plano)

    conn = get_connection()
    cursor = conn.cursor()

    sql = """
        INSERT INTO usuarios (nombre, email, password_hash, rol)
        VALUES (%s, %s, %s, %s)
    """
    cursor.execute(sql, (nombre, email, password_hash, "admin"))
    conn.commit()

    cursor.close()
    conn.close()
    print("Admin creado:", email, "/", password_plano)

if __name__ == "__main__":
    crear_admin()
