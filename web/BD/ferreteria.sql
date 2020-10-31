-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-10-2020 a las 16:36:02
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ferreteria`
--
CREATE DATABASE IF NOT EXISTS `ferreteria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ferreteria`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_DEL_CATEGORIA` (IN `P_ID_CATEGORIA` INT)  DELETE FROM CATEGORIA WHERE ID_CATEGORIA = P_ID_CATEGORIA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_DEL_EMPLEADO` (IN `P_ID_EMPLEADO` INT)  DELETE FROM EMPLEADO WHERE ID_EMPLEADO = P_ID_EMPLEADO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_DEL_FORMA_PAGO` (IN `P_ID_FORMA_PAGO` INT)  DELETE FROM FORMA_PAGO WHERE ID_FORMA_PAGO = P_ID_FORMA_PAGO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_DEL_MARCA` (IN `P_ID_MARCA` INT)  DELETE FROM MARCA WHERE ID_MARCA = P_ID_MARCA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_DEL_PRODUCTO` (IN `P_ID_PRODUCTO` INT)  DELETE FROM PRODUCTO WHERE ID_PRODUCTO = P_ID_PRODUCTO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_DEL_PROVEEDOR` (IN `P_ID_PROVEEDOR` INT)  DELETE FROM PROVEEDOR WHERE ID_PROVEEDOR = P_ID_PROVEEDOR$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_DEL_PUESTO` (IN `P_ID_PUESTO` INT)  DELETE FROM PUESTO WHERE ID_PUESTO = P_ID_PUESTO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_CATEGORIA` (IN `P_CODIGO` VARCHAR(10), IN `P_NOMBRE` VARCHAR(50))  INSERT INTO Categoria (COD_CATEGORIA, NOMBRE, FECHA_GRABACION) VALUES (P_CODIGO, P_NOMBRE, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_DETALLE` (IN `P_ID_PRODUCTO` INT, IN `P_ID_FACTURA` INT, IN `P_CANTIDAD` INT, IN `P_MONTO` VARCHAR(50))  INSERT INTO detalle (CANTIDAD, ID_FACTURA, ID_PRODUCTO, MONTO_UNITARIO)
VALUES (P_CANTIDAD, P_ID_FACTURA, P_ID_PRODUCTO, P_MONTO)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_EMPLEADO` (IN `P_ID_PUESTO` INT, IN `P_CODIGO` VARCHAR(10), IN `P_USUARIO` VARCHAR(50), IN `P_PASS` VARCHAR(50), IN `P_NOMBRE` VARCHAR(50), IN `P_APELLIDO` VARCHAR(50), IN `P_FECHANAC` DATE, IN `P_DIRE` VARCHAR(100), IN `P_TELEFONO` VARCHAR(20), IN `P_DPI` VARCHAR(20), IN `P_CORREO` VARCHAR(100))  INSERT INTO EMPLEADO
(ID_PUESTO, COD_TRABAJADOR, USUARIO, CONTRASENIA, NOMBRE, APELLIDO, FECHA_NACIMIENTO, DIRECCION, TELEFONO, DPI, CORREO_ELECTRONICO, FECHA_GRABACION) 
VALUES (P_ID_PUESTO, P_CODIGO, P_USUARIO, P_PASS, P_NOMBRE, P_APELLIDO, P_FECHANAC, P_DIRE, P_TELEFONO, P_DPI, P_CORREO, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_FACTURA` (IN `P_ID_EMPLEADO` INT, IN `P_ID_CLIENTE` INT, IN `P_TOTAL` VARCHAR(50))  BEGIN
	INSERT 
    INTO factura (ID_EMPLEADO, ID_CLIENTE, ID_FORMA_PAGO, FECHA_GRABACION, MONTO_TOTAL, ESTADO)
    VALUE (P_ID_EMPLEADO, P_ID_CLIENTE, 1, CURRENT_DATE(), P_TOTAL, 'G');

    SELECT f.id_factura 
    FROM factura f
    ORDER BY f.id_factura DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_FORMA_PAGO` (IN `P_CODIGO` VARCHAR(10), IN `P_NOMBRE` VARCHAR(50))  INSERT INTO forma_pago (COD_PAGO, NOMBRE, FECHA_GRABACION) VALUES (P_CODIGO, P_NOMBRE, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_MARCA` (IN `P_CODIGO` VARCHAR(10), IN `P_NOMBRE` VARCHAR(50))  INSERT INTO Marca (COD_MARCA, NOMBRE, FECHA_GRABACION) VALUES (P_CODIGO, P_NOMBRE, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_PRODUCTO` (IN `P_ID_MARCA` INT, IN `P_CODIGO` VARCHAR(25), IN `P_NOMBRE` VARCHAR(40), IN `P_PRECIO` VARCHAR(40), IN `P_EXISTENCIA` VARCHAR(40), IN `P_ORDEN_COMPRA` VARCHAR(40), IN `P_SERIE_FACTURA` VARCHAR(80), IN `P_NUMERO_FACTURA` VARCHAR(20), IN `P_ID_CATEGORIA` INT, IN `P_ID_PROVEEDOR` INT)  INSERT INTO PRODUCTO
(ID_MARCA, ID_CATEGORIA, ID_PROVEEDOR, COD_PRODUCTO, NOMBRE, PRECIO, EXISTENCIA, ORDEN_COMPRA, SERIE_FACTURA, NUMERO_FACTURA, FECHA_GRABACION)
VALUES (P_ID_MARCA, P_ID_CATEGORIA, P_ID_PROVEEDOR, P_CODIGO, P_NOMBRE, P_PRECIO, P_EXISTENCIA, P_ORDEN_COMPRA, P_SERIE_FACTURA, P_NUMERO_FACTURA, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_PROVEEDOR` (IN `P_CODIGO` VARCHAR(10), IN `P_NOMBRE` VARCHAR(50))  INSERT INTO Proveedor (COD_PROVEEDOR, NOMBRE, FECHA_GRABACION) VALUES (P_CODIGO, P_NOMBRE, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_PUESTO` (IN `P_CODIGO` VARCHAR(10), IN `P_NOMBRE` VARCHAR(50))  INSERT INTO puesto (COD_PUESTO, NOMBRE, FECHA_GRABACION) VALUES (P_CODIGO, P_NOMBRE, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_INS_UPD_CLIENTE` (IN `P_NIT` VARCHAR(50), IN `P_NOMBRE` VARCHAR(50), IN `P_DIRECCION` VARCHAR(50))  BEGIN
	DECLARE V_ID_CLIENTE INT;
    SELECT
        C.id_cliente
    INTO V_ID_CLIENTE
    FROM cliente C
    WHERE C.nit = P_NIT;

    IF (V_ID_CLIENTE IS NULL) THEN
    	INSERT
        INTO cliente (DIRECCION, FECHA_GRABACION, NIT, NOMBRE_COMPLETO) 
        VALUES (P_DIRECCION, CURRENT_DATE(), P_NIT, P_NOMBRE);
        
    	SELECT
        	C.id_cliente
        INTO V_ID_CLIENTE
        FROM cliente C
        ORDER BY c.id_cliente DESC LIMIT 1;
    END IF;
    
    SELECT
        C.id_cliente,
        c.nombre_completo,
        c.direccion,
        c.nit
    FROM cliente C
    WHERE C.id_cliente = V_ID_CLIENTE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_CATEGORIA_BY_ID` (IN `P_ID_CATEGORIA` INT)  SELECT id_Categoria, cod_Categoria, nombre 
FROM Categoria 
WHERE id_Categoria = P_ID_CATEGORIA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_COMBO_CATEGORIA` ()  SELECT
	c.id_categoria,
    concat(c.cod_categoria, ' - ', c.nombre) as 'cat'
from categoria c
order by c.nombre ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_COMBO_FORMA_PAGO` ()  SELECT
	fp.id_forma_pago,
    concat(fp.cod_pago, ' - ', fp.nombre)
from forma_pago fp
order by fp.nombre ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_COMBO_MARCA` ()  select
	p.id_Marca,
    concat(p.cod_Marca, ' - ',  p.nombre) as 'marca'
from marca p
order by p.nombre ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_COMBO_PRODUCTO` ()  SELECT
	pr.id_producto,
    concat(pr.cod_producto, ' - ', pr.nombre)
from producto pr
order by pr.nombre asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_COMBO_PROVEEDOR` ()  SELECT
	p.id_proveedor,
    concat(p.cod_proveedor, ' - ', p.nombre) as 'prov'
from proveedor p
order by p.nombre ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_COMBO_PUESTO` ()  select
	p.id_puesto,
    concat(p.cod_puesto, ' - ',  p.nombre) as 'puesto'
from puesto p
order by p.nombre ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_EMPLEADO_BY_ID` (IN `P_ID_EMPLEADO` INT)  select
	e.id_empleado,
    e.id_puesto,
    e.cod_trabajador,
    e.usuario,
    e.contrasenia,
    e.nombre,
    e.apellido,
    e.fecha_nacimiento,
    e.direccion,
    e.telefono,
    e.dpi,
    e.correo_electronico,
    p.nombre as 'nombre_puesto'
from empleado e,
puesto p
where e.id_puesto = p.id_puesto
and e.id_empleado = P_ID_EMPLEADO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_FORMA_PAGO_BY_ID` (IN `P_ID_FORMA_PAGO` INT)  SELECT id_forma_pago, cod_pago, nombre 
FROM forma_pago 
WHERE id_forma_pago = P_ID_FORMA_PAGO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_CATEGORIA` ()  SELECT * FROM Categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_EMPLEADO` ()  select
	e.id_empleado,
    e.id_puesto,
    e.cod_trabajador,
    e.usuario,
    e.contrasenia,
    e.nombre,
    e.apellido,
    e.fecha_nacimiento,
    e.direccion,
    e.telefono,
    e.dpi,
    e.correo_electronico,
    p.nombre as 'nombre_puesto'
from empleado e,
puesto p
where e.id_puesto = p.id_puesto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_FORMA_PAGO` ()  SELECT * FROM FORMA_PAGO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_LISTADO` (IN `P_ID_FACTURA` INT)  SELECT
d.id_detalle,
P.cod_producto,
P.nombre,
P.precio,
D.cantidad
FROM detalle D,
producto P
WHERE D.id_producto = P.id_producto
AND D.id_factura = P_ID_FACTURA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_MARCA` ()  SELECT * from Marca$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_PEDIDOS_GRABADOS` ()  SELECT f.id_factura, c.id_cliente, c.nombre_completo, f.monto_total
from factura f, cliente c
WHERE c.id_cliente = f.id_cliente
AND F.estado = 'G'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_PRODUCTO` ()  select 
      p.id_producto,
      m.id_marca,
      p.id_categoria,
      p.id_proveedor,
      p.cod_producto,
      p.nombre,
      p.precio,
      p.existencia,
      p.orden_compra,
      p.serie_factura,
      p.numero_factura,
      m.nombre as 'marca_nombre',
      pr.nombre as 'prov_nombre',
      ct.nombre as 'cat_nombre'
      
from producto p,
marca m,
proveedor pr,
categoria ct
where p.id_marca = m.id_marca
and p.id_proveedor = pr.id_proveedor
and p.id_categoria = ct.id_categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_PROVEEDOR` ()  SELECT * from Proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_GRID_PUESTO` ()  SELECT * from puesto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_MARCA_BY_ID` (IN `P_ID_MARCA` INT)  SELECT id_Marca, cod_Marca, nombre 
FROM Marca 
WHERE id_Marca = P_ID_MARCA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_PRODUCTO_BY_ID` (IN `P_ID_PRODUCTO` INT)  select 
      p.id_producto,
      m.id_marca,
      p.id_categoria,
      p.id_proveedor,
      p.cod_producto,
      p.nombre,
      p.precio,
      p.existencia,
      p.orden_compra,
      p.serie_factura,
      p.numero_factura,
      m.nombre as 'marca_nombre',
      pr.nombre as 'prov_nombre',
      ct.nombre as 'cat_nombre'
      
from producto p,
marca m,
proveedor pr,
categoria ct
where p.id_marca = m.id_marca
and p.id_proveedor = pr.id_proveedor
and p.id_categoria = ct.id_categoria
and p.id_producto = P_ID_PRODUCTO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_PROVEEDOR_BY_ID` (IN `P_ID_PROVEEDOR` INT)  SELECT id_Proveedor, cod_Proveedor, nombre 
FROM proveedor
WHERE id_Proveedor = P_ID_PROVEEDOR$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_PUESTO_BY_ID` (IN `P_ID_PUESTO` INT)  SELECT id_puesto, cod_puesto, nombre 
FROM puesto 
WHERE id_puesto = P_ID_PUESTO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_SEL_VALIDAR_LOGIN` (IN `P_USUARIO` VARCHAR(50), IN `P_PASS` VARCHAR(50))  SELECT
	E.id_empleado,
    E.cod_trabajador,
    E.nombre,
    E.apellido,
    P.nombre as 'puesto'
FROM EMPLEADO E,
PUESTO P
WHERE P.id_puesto = E.id_puesto
AND E.usuario = P_USUARIO
AND E.contrasenia = P_PASS$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_CATEGORIA` (IN `P_ID_CATEGORIA` INT, IN `P_NOMBRE` VARCHAR(50), IN `P_CODIGO` VARCHAR(20))  UPDATE Categoria fp
SET fp.cod_Categoria = P_CODIGO,
fp.nombre = P_NOMBRE
WHERE fp.id_Categoria = P_ID_CATEGORIA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_EMPLEADO` (IN `P_ID_PUESTO` INT, IN `P_CODIGO` VARCHAR(10), IN `P_USUARIO` VARCHAR(50), IN `P_PASS` VARCHAR(50), IN `P_NOMBRE` VARCHAR(50), IN `P_APELLIDO` VARCHAR(50), IN `P_FECHA` DATE, IN `P_DIRE` VARCHAR(100), IN `P_TELEFONO` VARCHAR(20), IN `P_DPI` VARCHAR(20), IN `P_CORREO` VARCHAR(100), IN `P_ID_EMPLEADO` INT)  UPDATE EMPLEADO E
SET E.id_puesto = P_ID_PUESTO,
E.cod_trabajador = P_CODIGO,
E.usuario = P_USUARIO,
E.contrasenia = P_PASS,
E.nombre = P_NOMBRE,
E.apellido = P_APELLIDO,
E.fecha_nacimiento = P_FECHA,
E.direccion = P_DIRE,
E.telefono = P_TELEFONO,
E.dpi = P_DPI,
E.correo_electronico = P_CORREO
WHERE E.id_empleado = P_ID_EMPLEADO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_FACTURA` (IN `P_ID_FACTURA` INT, IN `P_ID_FORMA_PAGO` INT)  UPDATE factura F
SET F.id_forma_pago = P_ID_FORMA_PAGO,
F.estado = 'P'
WHERE F.id_factura = P_ID_FACTURA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_FORMA_PAGO` (IN `P_ID_FORMA_PAGO` INT, IN `P_NOMBRE` VARCHAR(50), IN `P_CODIGO` VARCHAR(10))  UPDATE forma_pago fp
SET fp.cod_pago = P_CODIGO,
fp.nombre = P_NOMBRE
WHERE fp.id_forma_pago = P_ID_FORMA_PAGO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_MARCA` (IN `P_ID_MARCA` INT, IN `P_NOMBRE` VARCHAR(50), IN `P_CODIGO` VARCHAR(20))  UPDATE Marca p
SET p.cod_Categoria = P_CODIGO,
P.nombre = P_NOMBRE
WHERE P.id_Categoria = P_ID_CATEGORIA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_PRODUCTO` (IN `P_ID_PRODUCTO` INT, IN `P_ID_MARCA` INT, IN `P_ID_CATEGORIA` INT, IN `P_ID_PROVEEDOR` INT, IN `P_CODIGO` VARCHAR(25), IN `P_NOMBRE` VARCHAR(60), IN `P_PRECIO` VARCHAR(60), IN `P_EXISTENCIA` VARCHAR(50), IN `P_ORDEN_COMPRA` VARCHAR(50), IN `P_SERIE_FACTURA` VARCHAR(60), IN `P_NUMERO_FACTURA` VARCHAR(60))  UPDATE PRODUCTO R
SET R.id_marca = P_ID_MARCA,
R.id_categoria = P_ID_CATEGORIA,
R.id_proveedor = P_ID_PROVEEDOR,
R.cod_producto = P_CODIGO,
R.nombre = P_NOMBRE,
R.precio = P_PRECIO,
R.existencia = P_EXISTENCIA,
R.orden_compra = P_ORDEN_COMPRA,
R.serie_factura = P_SERIE_FACTURA,
R.numero_factura = P_NUMERO_FACTURA
WHERE R.id_producto = P_ID_PRODUCTO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_PROVEEDOR` (IN `P_ID_FORMA_PAGO` INT, IN `P_NOMBRE` VARCHAR(50), IN `P_CODIGO` VARCHAR(20))  UPDATE Proveedor fp
SET fp.cod_Proveedor = P_CODIGO,
fp.nombre = P_NOMBRE
WHERE fp.id_Proveedor = P_ID_PROVEEDOR$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPR_UPD_PUESTO` (IN `P_ID_PUESTO` INT, IN `P_NOMBRE` VARCHAR(50), IN `P_CODIGO` VARCHAR(10))  UPDATE PUESTO p
SET p.cod_puesto = P_CODIGO,
P.nombre = P_NOMBRE
WHERE P.id_puesto = P_ID_PUESTO$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `cod_categoria` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` VALUES
(1, 'CAT-001', 'Categoria1', '2020-10-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` VALUES
(1, 'Vicente Fernandez', '123-4', 'CIUDAD', '2020-10-29'),
(2, 'JUAN PEREZ', '78545-f', 'PEREZ', '2020-10-30'),
(3, 'JULIO LOPEZ', '543-GDF', 'DIRE', '2020-10-30'),
(4, 'AGUSTIN CAAL', '453hg', 'DIRE', '2020-10-30'),
(5, 'HUMBERTO GARCIA', '45t45', 'DIRE', '2020-10-30'),
(6, 'MANUEL RIVERA', '534', 'DIRE', '2020-10-30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle`
--

CREATE TABLE `detalle` (
  `id_detalle` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_factura` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `monto_unitario` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle`
--

INSERT INTO `detalle` VALUES
(1, 2, 2, 2, '12.00'),
(2, 4, 1, 1, '321.00'),
(3, 4, 1, 1, '321.00'),
(4, 4, 1, 2, '321.00'),
(5, 4, 1, 2, '321.00'),
(6, 2, 1, 2, '12.00'),
(7, 2, 1, 3, '12.00'),
(8, 4, 1, 3, '321.00'),
(9, 3, 1, 3, '43.00'),
(10, 4, 1, 4, '321.00'),
(11, 2, 1, 4, '12.00'),
(12, 3, 5, 4, '43.00'),
(13, 3, 5, 3, '43.00'),
(14, 2, 5, 0, '12.00'),
(15, 2, 6, 2, '12.00'),
(16, 3, 6, 3, '43.00'),
(17, 2, 7, 2, '12.00'),
(18, 3, 7, 5, '43.00'),
(19, 2, 8, 2, '12.32'),
(20, 3, 8, 3, '43.43'),
(21, 2, 9, 2, '12.32'),
(22, 3, 9, 3, '43.43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `id_puesto` int(11) NOT NULL,
  `cod_trabajador` varchar(10) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasenia` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `dpi` varchar(20) NOT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` VALUES
(1, 10, 'E001', 'user1', '123', 'eduardo', 'garcia', '2020-02-12', 'ciudad', '456789', '10111213', 'HGJHGJHGJH@GHJ.COM', '2020-10-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_forma_pago` int(11) NOT NULL,
  `fecha_grabacion` date NOT NULL,
  `monto_total` decimal(12,2) NOT NULL,
  `estado` varchar(1) DEFAULT NULL,
  `serie` varchar(10) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` VALUES
(1, 1, 1, 1, '2020-10-29', '773.00', 'G', NULL, NULL),
(2, 1, 1, 2, '2020-10-29', '1285.00', 'P', NULL, NULL),
(5, 1, 6, 2, '2020-10-30', '304.00', 'P', NULL, NULL),
(6, 1, 1, 2, '2020-10-30', '155.00', 'P', NULL, NULL),
(7, 1, 2, 2, '2020-10-30', '242.00', 'P', NULL, NULL),
(8, 1, 1, 2, '2020-10-30', '154.93', 'P', NULL, NULL),
(9, 1, 1, 2, '2020-10-30', '154.93', 'P', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `forma_pago`
--

CREATE TABLE `forma_pago` (
  `id_forma_pago` int(11) NOT NULL,
  `cod_pago` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `forma_pago`
--

INSERT INTO `forma_pago` VALUES
(1, 'FP001', 'Efectivo', '2020-10-14'),
(2, 'FP002', 'Cheque', '2020-10-14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL,
  `cod_marca` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` VALUES
(2, 'M001', 'MARCA 1', '2020-10-25'),
(3, 'M002', 'Marca 2', '2020-10-26'),
(4, 'M003', 'Marca 3', '2020-10-26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `id_marca` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `cod_producto` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio` decimal(12,2) NOT NULL,
  `existencia` int(11) NOT NULL,
  `orden_compra` varchar(50) NOT NULL,
  `serie_factura` varchar(50) NOT NULL,
  `numero_factura` varchar(50) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` VALUES
(2, 2, 1, 2, 'PRO01', 'Alicate', '12.32', 321, 'JK', 'EIREO', 'FJDKS332', '2020-10-27'),
(3, 3, 1, 2, 'PRO02', 'Serrucho', '43.43', 21, 'JK', 'EIREO', 'FJDKS332', '2020-10-27'),
(4, 2, 1, 1, 'PRO03', 'Martillo', '321.20', 4324, 'JK', 'EIREO', 'FJDKS332', '2020-10-27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `cod_proveedor` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` VALUES
(1, 'PROV-001', 'Proveedor 1', '2020-10-26'),
(2, 'PROV-002', 'Proveedor 2', '2020-10-26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puesto`
--

CREATE TABLE `puesto` (
  `id_puesto` int(11) NOT NULL,
  `cod_puesto` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_grabacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `puesto`
--

INSERT INTO `puesto` VALUES
(1, 'P001', 'Administrador', '2020-10-13'),
(5, 'P002', 'Bodeguero', '2020-10-13'),
(10, 'P003', 'Cajero', '2020-10-13');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_factura` (`id_factura`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `id_puesto` (`id_puesto`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_forma_pago` (`id_forma_pago`);

--
-- Indices de la tabla `forma_pago`
--
ALTER TABLE `forma_pago`
  ADD PRIMARY KEY (`id_forma_pago`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id_marca`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_marca` (`id_marca`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD PRIMARY KEY (`id_puesto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `detalle`
--
ALTER TABLE `detalle`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `forma_pago`
--
ALTER TABLE `forma_pago`
  MODIFY `id_forma_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `id_marca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `puesto`
--
ALTER TABLE `puesto`
  MODIFY `id_puesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD CONSTRAINT `detalle_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `detalle_ibfk_2` FOREIGN KEY (`id_factura`) REFERENCES `factura` (`id_factura`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_puesto`) REFERENCES `puesto` (`id_puesto`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `factura_ibfk_3` FOREIGN KEY (`id_forma_pago`) REFERENCES `forma_pago` (`id_forma_pago`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
