USE tienda_tech;

-- Usuario admin (luego le actualizas el password_hash desde Python si quieres)
INSERT INTO usuarios (nombre, email, password_hash, rol)
VALUES ('Admin', 'admin@tiendatech.com', 'hash_provisional', 'admin');

-- Algunos productos de ejemplo
INSERT INTO productos (nombre, categoria, descripcion, precio) VALUES
('Samsung Galaxy S25 Ultra', 'celular', 'Gama alta con cámara avanzada', 5499.00),
('MacBook Pro 16 M3',       'laptop',  'Portátil profesional de alto rendimiento', 12999.00),
('iPad Pro M4 13\"',        'tablet',  'Tablet potente para productividad y ocio', 7999.00),
('Samsung S95D QD-OLED',    'televisor','Televisor 4K con panel QD-OLED', 9999.00);
