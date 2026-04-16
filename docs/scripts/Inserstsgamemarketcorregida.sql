
USE gamemarket;


INSERT INTO usuario (useremail, username, userpswd, userfching, userpswdest, userpswdexp, userest, useractcod, userpswdchg, usertipo) VALUES
('admin@gamemarket.com',    'Administrador',  SHA2('Admin123!', 256),   NOW(), 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT', UUID(), NULL, 'ADM'),
('carlos.lopez@gmail.com',  'Carlos López',   SHA2('Carlos123!', 256),  NOW(), 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT', UUID(), NULL, 'VEN'),
('maria.garcia@gmail.com',  'María García',   SHA2('Maria123!', 256),   NOW(), 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT', UUID(), NULL, 'VEN'),
('pedro.martinez@gmail.com','Pedro Martínez', SHA2('Pedro123!', 256),   NOW(), 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT', UUID(), NULL, 'USR'),
('ana.rodriguez@gmail.com', 'Ana Rodríguez',  SHA2('Ana123!', 256),     NOW(), 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT', UUID(), NULL, 'USR');


INSERT INTO roles (roldsc, rolest) VALUES
('Administrador', 'ACT'),
('Vendedor',      'ACT'),
('Cliente',        'ACT'),
('Supervisor',    'ACT'),
('Consultor',     'ACT');


INSERT INTO roles_usuarios (rolcod, usercod) VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 4),
(5, 5);

INSERT INTO funciones (fundsc, funurl, funest) VALUES
('Gestión de Usuarios',   'index.php?page=Usuarios_Usuarios',     'ACT'),
('Gestión de Productos',  'index.php?page=Productos_Productos',   'ACT'),
('Gestión de Clientes',   'index.php?page=Clientes_Clientes',     'ACT'),
('Gestión de Facturas',   'index.php?page=Facturas_Facturas',     'ACT'),
('Gestión de Reportes',   'index.php?page=Reportes_Reportes',     'ACT');


INSERT INTO funciones_roles (rolcod, funcod) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 4);


INSERT INTO bitacora (usercod, bitaccion, bitfecha, bitip) VALUES
(1, 'Inicio de sesión exitoso',         NOW(), '192.168.1.1'),
(2, 'Creó una nueva factura',           NOW(), '192.168.1.2'),
(3, 'Actualizó datos de un cliente',    NOW(), '192.168.1.3'),
(4, 'Consultó listado de productos',    NOW(), '192.168.1.4'),
(5, 'Cerró sesión',                     NOW(), '192.168.1.5');


INSERT INTO proveedor (provnom, provtel, provemail, provdir, provest) VALUES
('Nintendo de América',   '+1-800-255-3700', 'contacto@nintendo.com',   'Redmond, Washington, USA',        'ACT'),
('Sony Interactive',      '+1-800-345-7669', 'soporte@sony.com',        'San Mateo, California, USA',      'ACT'),
('Microsoft Xbox',        '+1-800-469-9269', 'ventas@microsoft.com',    'Redmond, Washington, USA',        'ACT'),
('Electronic Arts',       '+1-650-628-1500', 'info@ea.com',             'Redwood City, California, USA',   'ACT'),
('Activision Blizzard',   '+1-310-255-2000', 'soporte@activision.com',  'Santa Monica, California, USA',   'ACT');


INSERT INTO cliente (clinom, clitel, cliemail, clidir, cliest) VALUES
('Juan Carlos Pérez',    '+504-9876-5432', 'juancarlos@gmail.com',  'Col. Kennedy, Tegucigalpa, HN',     'ACT'),
('Sofía Hernández',      '+504-9765-4321', 'sofia.hdz@gmail.com',   'Col. Palmira, Tegucigalpa, HN',     'ACT'),
('Roberto Flores',       '+504-9654-3210', 'roberto.f@gmail.com',   'Col. Miramontes, San Pedro Sula',   'ACT'),
('Daniela Reyes',        '+504-9543-2109', 'daniela.r@gmail.com',   'Col. Los Andes, Choloma, HN',       'ACT'),
('Luis Fernando Ortiz',  '+504-9432-1098', 'luis.ortiz@gmail.com',  'Col. Trejo, La Ceiba, HN',          'ACT');


INSERT INTO producto (prodnom, proddsc, prodprecio, prodstock, provcod, prodest) VALUES
('Nintendo Switch OLED',        'Consola Nintendo Switch modelo OLED 64GB',         349.99,  15, 1, 'ACT'),
('PlayStation 5 Digital',       'Consola PS5 edición digital sin lector de disco',  399.99,  10, 2, 'ACT'),
('Xbox Series S',               'Consola Xbox Series S 512GB color blanco',         299.99,  12, 3, 'ACT'),
('FIFA 25 PS5',                 'Videojuego FIFA 25 para PlayStation 5',             69.99,  30, 4, 'ACT'),
('Call of Duty Modern Warfare', 'Call of Duty Modern Warfare III para Xbox',         59.99,  25, 5, 'ACT');


INSERT INTO factura (clicod, usercod, factfecha, facttotal, factest) VALUES
(1, 2, NOW(), 419.98, 'PAG'),
(2, 2, NOW(), 299.99, 'PAG'),
(3, 3, NOW(), 469.98, 'PEN'),
(4, 3, NOW(),  69.99, 'PAG'),
(5, 2, NOW(), 659.98, 'PEN');


INSERT INTO factura_detalle (factcod, prodcod, factdetcant, factdetprecio, factdetsub) VALUES
(1, 1, 1, 349.99, 349.99),
(1, 4, 1,  69.99,  69.99),
(2, 3, 1, 299.99, 299.99),
(3, 2, 1, 399.99, 399.99),
(3, 5, 1,  59.99,  59.99);