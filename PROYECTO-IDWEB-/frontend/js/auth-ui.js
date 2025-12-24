// js/auth-ui.js

const API_BASE = "http://127.0.0.1:5000";

/* ---------- Utilidad: saber quién está logueado ---------- */

async function getMe() {
  try {
    const resp = await fetch(`${API_BASE}/me`, { credentials: "include" });
    return await resp.json();
  } catch (e) {
    console.error("Error llamando /me", e);
    return { logged: false };
  }
}

/* ---------- Botón azul del header ---------- */

async function initHeaderButton() {
  const btn = document.getElementById("btn-login-header");
  if (!btn) return;

  const me = await getMe();

  if (!me.logged) {
    btn.textContent = "Login";
    btn.href = "login.html";
  } else if (me.rol === "admin") {
    btn.textContent = `Admin: ${me.nombre}`;
    btn.href = "panel-admin.html";
  } else {
    btn.textContent = me.nombre;
    btn.href = "perfil.html";
  }
}

/* ---------- Perfil de usuario (cliente) ---------- */

async function cargarPerfil() {
  const infoDiv = document.getElementById("info-usuario");
  const pedidosDiv = document.getElementById("lista-pedidos");
  if (!infoDiv || !pedidosDiv) return; // no estamos en perfil.html

  const me = await getMe();
  if (!me.logged || me.rol !== "usuario") {
    window.location.href = "login.html";
    return;
  }

  infoDiv.innerHTML = `
    <p><strong>Nombre:</strong> ${me.nombre}</p>
    <p><strong>Rol:</strong> ${me.rol}</p>
  `;

  try {
    const resp = await fetch(`${API_BASE}/mis-pedidos`, {
      credentials: "include",
    });
    const data = await resp.json();

    if (!data.ok) {
      pedidosDiv.textContent = "No se pudieron cargar los pedidos.";
      return;
    }

    if (data.data.length === 0) {
      pedidosDiv.textContent = "Aún no tienes pedidos.";
      return;
    }

    const items = data.data
      .map(
        (p) =>
          `<li>${p.producto} - Cantidad: ${p.cantidad} - Estado: ${p.estado}</li>`
      )
      .join("");

    pedidosDiv.innerHTML = `<ul>${items}</ul>`;
  } catch (e) {
    console.error(e);
    pedidosDiv.textContent = "Error al cargar pedidos.";
  }
}

/* ---------- Panel admin ---------- */

async function cargarPanelAdmin() {
  const cont = document.getElementById("tabla-pedidos-admin");
  if (!cont) return; // no estamos en panel-admin.html

  const me = await getMe();
  if (!me.logged || me.rol !== "admin") {
    window.location.href = "login.html";
    return;
  }

  try {
    const resp = await fetch(`${API_BASE}/admin/pedidos`, {
      credentials: "include",
    });
    const data = await resp.json();

    if (!data.ok) {
      cont.textContent = "No se pudieron cargar los pedidos.";
      return;
    }

    if (data.data.length === 0) {
      cont.textContent = "No hay pedidos registrados.";
      return;
    }

    const rows = data.data
      .map(
        (p) => `
        <tr>
          <td>${p.id}</td>
          <td>${p.usuario}</td>
          <td>${p.producto}</td>
          <td>${p.cantidad}</td>
          <td>${p.estado}</td>
        </tr>`
      )
      .join("");

    cont.innerHTML = `
      <table class="tabla-admin">
        <thead>
          <tr>
            <th>ID</th>
            <th>Usuario</th>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Estado</th>
          </tr>
        </thead>
        <tbody>${rows}</tbody>
      </table>
    `;
  } catch (e) {
    console.error(e);
    cont.textContent = "Error al cargar pedidos.";
  }
}

/* ---------- Logout ---------- */

function initLogout() {
  const btnLogout = document.getElementById("btn-logout");
  if (!btnLogout) return;

  btnLogout.addEventListener("click", async () => {
    try {
      await fetch(`${API_BASE}/logout`, { credentials: "include" });
    } catch (e) {
      console.error(e);
    } finally {
      window.location.href = "home.html";
    }
  });
}

/* ---------- Inicialización global ---------- */

document.addEventListener("DOMContentLoaded", () => {
  initHeaderButton();
  cargarPerfil();
  cargarPanelAdmin();
  initLogout();
});
