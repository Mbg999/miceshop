-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-02-2020 a las 08:57:29
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `onlineshop`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `referencia` int(10) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `precio` int(6) NOT NULL,
  `path_imagen` varchar(100) NOT NULL,
  `stock` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`referencia`, `descripcion`, `precio`, `path_imagen`, `stock`) VALUES
(1, 'Razer Deathadder Essential Ratón Gaming 6400 DPI. Es usado por jugadores de eSports en todo el mundo.', 50, '1582749771983.jpg', 9),
(2, 'Newskill Helios Ratón Gaming RGB 10000DPI. Perfecto para aquellos que busquen un ratón de gran calidad para todo tipo de juegos.', 36, '1582749879832.jpg', 4),
(3, 'Corsair Scimitar Pro Ratón Óptico RGB Gaming 16000 DPI. Con 12 botones laterales mecánicos para adaptarse a las necesidades profesionales y ofrecer una respuesta rápida y precisa.', 75, '1582750044430.jpg', 5),
(4, 'Corsair Nightsword RGB Performance Tunable Ratón Gaming PS/MOBA 18000DPI. Con Sistema de peso ajustable e inteligente y el sensor óptico de CORSAIR más avanzado hasta el momento.', 65, '1582750148613.jpg', 4),
(5, 'Asus Cerberus Ratón Gaming 2500 DPI. Ratón de juego óptico con cuatro etapas interruptor DPI y LED indicado.', 24, '1582750256016.jpg', 5),
(6, 'Razer Basilisk Ultimate Ratón Gaming 20000DPI Negro. Mucho más rápido. Más preciso. Más mortal. Lleva tus habilidades al siguiente nivel con el Razer Basilisk Ultimate.', 190, '1582750341039.jpg', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `fec_nac` varchar(10) NOT NULL,
  `direccion` varchar(60) NOT NULL,
  `password` varchar(10) NOT NULL,
  `admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`dni`, `nombre`, `fec_nac`, `direccion`, `password`, `admin`) VALUES
('37912145A', 'pepe', '1999-05-05', 'Calle Pez 12', 'Usuario0?', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `l_tickets`
--

CREATE TABLE `l_tickets` (
  `num_ticket` int(10) NOT NULL,
  `referencia` int(10) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `precio` int(6) NOT NULL,
  `ctd` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `l_tickets`
--

INSERT INTO `l_tickets` (`num_ticket`, `referencia`, `descripcion`, `precio`, `ctd`) VALUES
(1, 1, 'Razer Deathadder Essential Ratón Gaming 6400 DPI. Es usado por jugadores de eSports en todo el mundo.', 50, 2),
(1, 5, 'Asus Cerberus Ratón Gaming 2500 DPI. Ratón de juego óptico con cuatro etapas interruptor DPI y LED indicado.', 24, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `num_ticket` int(11) NOT NULL,
  `fecha` varchar(10) NOT NULL,
  `dni` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tickets`
--

INSERT INTO `tickets` (`num_ticket`, `fecha`, `dni`) VALUES
(1, '27-02-2020', '37912145A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`referencia`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `l_tickets`
--
ALTER TABLE `l_tickets`
  ADD KEY `referencia` (`referencia`),
  ADD KEY `num_ticket` (`num_ticket`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`num_ticket`),
  ADD KEY `dni` (`dni`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tickets`
--
ALTER TABLE `tickets`
  MODIFY `num_ticket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `l_tickets`
--
ALTER TABLE `l_tickets`
  ADD CONSTRAINT `l_tickets_ibfk_1` FOREIGN KEY (`referencia`) REFERENCES `articulos` (`referencia`),
  ADD CONSTRAINT `l_tickets_ibfk_2` FOREIGN KEY (`num_ticket`) REFERENCES `tickets` (`num_ticket`);

--
-- Filtros para la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`dni`) REFERENCES `clientes` (`dni`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
