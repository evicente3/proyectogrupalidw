-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 24-12-2025 a las 03:32:00
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `tienda_tech`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT '1',
  `estado` enum('pendiente','confirmado','cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_producto` (`id_producto`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `id_usuario`, `id_producto`, `cantidad`, `estado`, `creado_en`) VALUES
(1, 5, 3, 1, 'pendiente', '2025-12-24 02:19:34'),
(2, 5, 3, 1, 'pendiente', '2025-12-24 02:19:36'),
(3, 5, 3, 1, 'pendiente', '2025-12-24 02:33:53'),
(4, 5, 2, 1, 'pendiente', '2025-12-24 02:54:17'),
(5, 5, 12, 1, 'pendiente', '2025-12-24 02:54:26'),
(6, 5, 3, 1, 'pendiente', '2025-12-24 03:00:38'),
(7, 5, 8, 1, 'pendiente', '2025-12-24 03:00:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('celular','laptop','tablet','televisor') COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=33 ;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `categoria`, `descripcion`, `precio`, `creado_en`) VALUES
(1, 'Samsung Galaxy S25 Ultra', 'celular', 'Gama alta con cámara avanzada', '5499.00', '2025-12-23 20:50:46'),
(2, 'MacBook Pro 16 M3', 'laptop', 'Portátil profesional de alto rendimiento', '12999.00', '2025-12-23 20:50:46'),
(3, 'iPad Pro M4 13"', 'tablet', 'Tablet potente para productividad y ocio', '7999.00', '2025-12-23 20:50:46'),
(4, 'Samsung S95D QD-OLED', 'televisor', 'Televisor 4K con panel QD-OLED', '9999.00', '2025-12-23 20:50:46'),
(5, 'Dell XPS 15', 'laptop', 'Ultrabook premium con pantalla de alta resolución y gran rendimiento para trabajo y estudio.', '8999.00', '2025-12-24 02:38:41'),
(6, 'Lenovo ThinkPad X1 Carbon', 'laptop', 'Laptop empresarial ultraligera con teclado cómodo y excelente autonomía para uso profesional.', '8499.00', '2025-12-24 02:38:41'),
(7, 'Asus ROG Strix Scar 18', 'laptop', 'Laptop gamer delgada con gráfica dedicada y alta tasa de refresco para juegos exigentes.', '9399.00', '2025-12-24 02:38:41'),
(8, 'Samsung Galaxy Tab S9 Ultra', 'tablet', 'Tablet Android de gama alta con pantalla AMOLED grande y soporte para S Pen.', '6599.00', '2025-12-24 02:38:41'),
(9, 'Xiaomi Pad 7 Pro', 'tablet', 'Tablet versátil con buena potencia y excelente relación calidad-precio para multimedia y estudio.', '3599.00', '2025-12-24 02:38:41'),
(10, 'Lenovo Tab P12 Pro', 'tablet', 'Tablet con pantalla OLED y buen rendimiento, ideal para contenido y productividad ligera.', '4299.00', '2025-12-24 02:38:41'),
(11, 'LG G4 (OLED Evo)', 'televisor', 'Televisor OLED Evo de alta luminosidad con procesador Alpha 11 y gran calidad de imagen.', '11999.00', '2025-12-24 02:38:41'),
(12, 'Sony Bravia 9 (Mini LED)', 'televisor', 'Televisor Mini LED con procesador Cognitive XR para contraste y detalle mejorados.', '11499.00', '2025-12-24 02:38:41'),
(13, 'TCL X1K (Mini LED)', 'televisor', 'Televisor Mini LED con muchas zonas de atenuación locales y buena relación calidad-precio.', '8999.00', '2025-12-24 02:38:41'),
(14, 'iPhone 15 Pro max', 'celular', 'Gama alta de Apple con pantalla Super Retina XDR y chip de última generación.', '12999.00', '2025-12-24 02:38:41'),
(15, 'Xiaomi 15 Ultra', 'celular', 'Celular premium con cámara avanzada y gran batería optimizada para alto rendimiento.', '8999.00', '2025-12-24 02:38:41'),
(16, 'Google Pixel 9 Pro', 'celular', 'Smartphone enfocado en fotografía e IA, con experiencia Android pura y fluida.', '9499.00', '2025-12-24 02:38:41'),
(17, 'OnePlus 13', 'celular', 'Celular de alto desempeño con pantalla fluida y software ligero ideal para gamers.', '8499.00', '2025-12-24 02:38:41'),
(18, 'Dell XPS 15', 'laptop', 'Ultrabook premium con pantalla de alta resolución y gran rendimiento para trabajo y estudio.', '8999.00', '2025-12-24 02:38:48'),
(19, 'Lenovo ThinkPad X1 Carbon', 'laptop', 'Laptop empresarial ultraligera con teclado cómodo y excelente autonomía para uso profesional.', '8499.00', '2025-12-24 02:38:48'),
(20, 'Asus ROG Zephyrus', 'laptop', 'Laptop gamer delgada con gráfica dedicada y alta tasa de refresco para juegos exigentes.', '9399.00', '2025-12-24 02:38:48'),
(21, 'Samsung Galaxy Tab S9 Ultra', 'tablet', 'Tablet Android de gama alta con pantalla AMOLED grande y soporte para S Pen.', '6599.00', '2025-12-24 02:38:48'),
(22, 'Xiaomi Pad 7 Pro', 'tablet', 'Tablet versátil con buena potencia y excelente relación calidad-precio para multimedia y estudio.', '3599.00', '2025-12-24 02:38:48'),
(23, 'Lenovo Tab P12 Pro', 'tablet', 'Tablet con pantalla OLED y buen rendimiento, ideal para contenido y productividad ligera.', '4299.00', '2025-12-24 02:38:48'),
(24, 'LG G4 (OLED Evo)', 'televisor', 'Televisor OLED Evo de alta luminosidad con procesador Alpha 11 y gran calidad de imagen.', '11999.00', '2025-12-24 02:38:48'),
(25, 'Sony Bravia 9 (Mini LED)', 'televisor', 'Televisor Mini LED con procesador Cognitive XR para contraste y detalle mejorados.', '11499.00', '2025-12-24 02:38:48'),
(26, 'TCL X1K (Mini LED)', 'televisor', 'Televisor Mini LED con muchas zonas de atenuación locales y buena relación calidad-precio.', '8999.00', '2025-12-24 02:38:48'),
(27, 'iPhone 16 Pro', 'celular', 'Gama alta de Apple con pantalla Super Retina XDR y chip de última generación.', '12999.00', '2025-12-24 02:38:48'),
(28, 'Xiaomi 15 Ultra', 'celular', 'Celular premium con cámara avanzada y gran batería optimizada para alto rendimiento.', '8999.00', '2025-12-24 02:38:48'),
(29, 'Google Pixel 9 Pro', 'celular', 'Smartphone enfocado en fotografía e IA, con experiencia Android pura y fluida.', '9499.00', '2025-12-24 02:38:48'),
(30, 'OnePlus 13', 'celular', 'Celular de alto desempeño con pantalla fluida y software ligero ideal para gamers.', '8499.00', '2025-12-24 02:38:48'),
(31, 'MSI Summit E16 AI Studio', 'laptop', 'La fusión perfecta entre potencia, diseño profesional y capacidades de IA integradas para creadores modernos. Pantalla 16" QHD+ táctil, Intel Core Ultra 9, RTX 4070, 32 GB DDR5, AI Engine y lector de huella digital.', '11599.00', '2025-12-24 02:48:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('usuario','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'usuario',
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password_hash`, `rol`, `creado_en`) VALUES
(1, 'Admin', 'admin@tiendatech.com', 'hash_provisional', 'admin', '2025-12-23 20:50:46'),
(2, 'eder', 'EVICENTE@UNSA.EDU.PE', 'scrypt:32768:8:1$rqFPQaPW7IpwbYs1$60acd0859a76aa3006d817799dabd1816e1b88ab178a085935152fa070717ed8e4f033928ff63a5689a517c7dc97616fabcbb6a6b87af46e8232b0de1043961d', 'usuario', '2025-12-24 00:21:32'),
(3, 'joel', 'joel@unsa.com', 'scrypt:32768:8:1$93ZVA6g3Dc5aksTW$5f844f2f5ab676adca6a13930d6f2b7c888fd9e0ecd8076fcc71b8565a07638d0aa26e4dedce39731d207c4ba81b59f0491983f671de24247d36ead825ecd301', 'usuario', '2025-12-24 00:22:23'),
(4, 'paul', 'paul@unsa.com', 'scrypt:32768:8:1$ZszzVoN310nQ4pZD$86901f6406cca8fa39d459ea2ab6d373a0a3fe65c228aba7352462e9a69756702ebdb195411b7fd2c573641c2985d7b0143881b8a4182d7520e8cbdde33ceaf1', 'usuario', '2025-12-24 00:25:31'),
(5, 'prueba3', 'prueba3@unsa.com', 'scrypt:32768:8:1$K0Y5cCaoZVVigG31$416a8649b5c733fafd2110d7975287bbdf58fa7f5355651176383ba3ccd02f8b782fb65cf51e985a18ae157d37a88240a6a96c43029a3a6acd79e3a575ed3919', 'usuario', '2025-12-24 00:51:51'),
(6, 'prueba4', 'prueba4@unsa.com', 'scrypt:32768:8:1$tDI3KTqePhaeQZq8$7c056fb06d24eb342c0373e9adf68c34d13577c1ab9dd8aaba85d915ba893156b50b51151e152d1a9c79a1d2e3815599e1d0faf672092d39d1d772cf6535906e', 'usuario', '2025-12-24 00:58:46'),
(7, 'Admin', 'admin@tienda.com', '<hash_bcrypt_aquí>', 'admin', '2025-12-24 01:57:20');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
