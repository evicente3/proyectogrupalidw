# backend/app.py

from flask import Flask, request, jsonify, session
from functools import wraps
from flask_cors import CORS
from config import config
from models.usuario import crear_usuario, autenticar_usuario
from models.pedido import (
    crear_pedido,
    listar_pedidos_usuario,
    listar_pedidos_admin,
    actualizar_estado_pedido,
)

app = Flask(__name__)
app.secret_key = config.SECRET_KEY
CORS(app, supports_credentials=True)

# =============== HELPERS ===============

def login_requerido(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if "user_id" not in session:
            return jsonify({"ok": False, "msg": "Debes iniciar sesión"}), 401
        return f(*args, **kwargs)
    return wrapper


def admin_requerido(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if session.get("user_role") != "admin":
            return jsonify({"ok": False, "msg": "Solo administradores"}), 403
        return f(*args, **kwargs)
    return wrapper


# =============== AUTENTICACIÓN ===============

@app.route("/registro", methods=["POST"])
def registro():
    nombre = request.form.get("nombre")
    email = request.form.get("email")
    password = request.form.get("password")

    if not nombre or not email or not password:
        return jsonify({"ok": False, "msg": "Faltan datos"}), 400

    ok, msg = crear_usuario(nombre, email, password)
    return jsonify({"ok": ok, "msg": msg}), (200 if ok else 400)


@app.route("/login", methods=["POST"])
def login():
    email = request.form.get("email")
    password = request.form.get("password")

    if not email or not password:
        return jsonify({"ok": False, "msg": "Faltan datos"}), 400

    user, msg = autenticar_usuario(email, password)
    if not user:
        return jsonify({"ok": False, "msg": msg}), 401

    # Guardar datos mínimos en sesión
    session["user_id"] = user["id"]
    session["user_name"] = user["nombre"]
    session["user_role"] = user["rol"]

    return jsonify({"ok": True, "msg": "Login correcto"})


@app.route("/logout")
def logout():
    session.clear()
    return jsonify({"ok": True, "msg": "Sesión cerrada"})


# =============== ESTADO DE SESIÓN ===============

@app.route("/me", methods=["GET"])
def me():
    if "user_id" not in session:
        return jsonify({"logged": False})

    return jsonify({
        "logged": True,
        "id": session["user_id"],
        "nombre": session["user_name"],
        "rol": session["user_role"],
    })


# =============== PEDIDOS (ACCIÓN PRINCIPAL) ===============

@app.route("/pedido/nuevo", methods=["POST"])
@login_requerido
def pedido_nuevo():
    id_producto = request.form.get("id_producto")
    cantidad = request.form.get("cantidad", type=int, default=1)

    if not id_producto or cantidad <= 0:
        return jsonify({"ok": False, "msg": "Datos de pedido inválidos"}), 400

    ok, msg = crear_pedido(session["user_id"], id_producto, cantidad)
    return jsonify({"ok": ok, "msg": msg}), (200 if ok else 400)


@app.route("/mis-pedidos", methods=["GET"])
@login_requerido
def ver_mis_pedidos():
    pedidos = listar_pedidos_usuario(session["user_id"])
    return jsonify({"ok": True, "data": pedidos})


@app.route("/admin/pedidos", methods=["GET"])
@login_requerido
@admin_requerido
def ver_pedidos_admin():
    pedidos = listar_pedidos_admin()
    return jsonify({"ok": True, "data": pedidos})


@app.route("/admin/pedidos/<int:id_pedido>/estado", methods=["POST"])
@login_requerido
@admin_requerido
def cambiar_estado_pedido(id_pedido):
    nuevo_estado = request.form.get("estado")  # pendiente, confirmado, cancelado
    if nuevo_estado not in ["pendiente", "confirmado", "cancelado"]:
        return jsonify({"ok": False, "msg": "Estado inválido"}), 400

    ok = actualizar_estado_pedido(id_pedido, nuevo_estado)
    if not ok:
        return jsonify({"ok": False, "msg": "No se pudo actualizar"}), 400

    return jsonify({"ok": True, "msg": "Estado actualizado"})


# =============== ROOT SIMPLE ===============

@app.route("/", methods=["GET"])
def root():
    return jsonify({"msg": "API tienda_tech funcionando"})


if __name__ == "__main__":
    app.run(debug=True)
