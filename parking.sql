-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-06-2017 a las 17:41:05
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `parking`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE IF NOT EXISTS `administrador` (
  `id_administrador` int(11) NOT NULL COMMENT 'id administrador, es el unico que puede ingresar  al sistema  sin ninguna restricccion',
  `usuario` varchar(20) NOT NULL COMMENT 'usuario, se encarga de ingresar  los datos de los clientes  ala base de datos   al ingreso y a la salida .',
  `contraseña` int(11) NOT NULL COMMENT 'se utiliza una contraseña  para el ingreso  al sistema, que el administrador  nos crea.',
  `id_sistema` int(11) NOT NULL COMMENT 'id _sistema, es el encargado de validar a los usuarios  esistente.',
  PRIMARY KEY (`id_administrador`),
  KEY `id_sistema` (`id_sistema`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL COMMENT 'id_cliente, ingresamos todos los datos del cliente  al sistema  para  tener un mejor control de seguridad al ingreso y ala salida.',
  `documento_de_identidad` int(11) NOT NULL COMMENT 'al cliente se le  solicitara  la cedula  para ingresarla al sistema.',
  `tarjeta_de_propiedad` int(11) NOT NULL COMMENT 'se le solicita la targeta de propiedad  al cliente  para saber si en verdad,  el es el propietario de la moto.',
  `id_vigilante` int(11) NOT NULL COMMENT 'id_vigilante, el vigilante se logea en el sistema  asi poder  revisar ala salida del cliente , verificando  los datos entregados al ingresa y ala salida  para un mayor control.',
  PRIMARY KEY (`id_cliente`),
  KEY `id_vigilante` (`id_vigilante`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE IF NOT EXISTS `pago` (
  `id_pago` int(11) NOT NULL COMMENT 'id_pago, en el resivo  de pago aparecera  los datos del cliente  el cual  dira  la hora  de ingreso y salida del cliente.',
  `monto` int(11) NOT NULL COMMENT 'el monto  sera el pago que  calcula , cuanto debe pagar el cliente  por el tiempo  utilizado en el parqueadero.',
  `registro_pago` date NOT NULL COMMENT 'registro de pago,  ingresamos  el pago al sistema para  poder  generar  el resivo de salida del parqueadero.',
  `id_cliente` int(11) NOT NULL COMMENT 'id_cliente aparecera en el tiket de el cliente con sus datos  personales.',
  PRIMARY KEY (`id_pago`),
  KEY `id_cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sistema`
--

CREATE TABLE IF NOT EXISTS `sistema` (
  `id_sistema` int(11) NOT NULL COMMENT 'el sistema  validara  los usuarios  existentes  en el parqueadero.',
  `usuario` varchar(20) NOT NULL COMMENT 'los usarios estaran en el sistema  , siendo verificados  mensualmente,   sus contraseñas  seran cambiadas  periodicamente.',
  `contraseña` int(11) NOT NULL COMMENT 'el sistema se encarga de validar las contraseñas, y generar mensualmente el cambio  de contraseña.',
  `id_vigilante` int(11) NOT NULL COMMENT 'el sistema  validara a los vigilantes para tener un control  de calidad y no tener falsos vigilantes.',
  PRIMARY KEY (`id_sistema`),
  KEY `id_vigilante` (`id_vigilante`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vigilante`
--

CREATE TABLE IF NOT EXISTS `vigilante` (
  `id_vigilante` int(11) NOT NULL COMMENT 'los vigilantes ingresa al sistema  , el cual  estara pendiente de los clientes y sus motos.',
  `usuario` text NOT NULL COMMENT 'los usuarios  deben trabajar en grupo con los vigilantes  para  a si , tener  un mejor equipo de trabajo.',
  `registro_entrada` date NOT NULL COMMENT 'se registra la entrada  de los clientes  al sistema  para llevar un control de entrada.',
  `registro_salida` date NOT NULL COMMENT 'se registra la salida de los cliente  y sus motos  para tener un mayor  control  en sus  propietarios .',
  `id_cliente` int(11) NOT NULL COMMENT 'el vigilante estara encargado  de el control de las motos  y sus clientes.',
  PRIMARY KEY (`id_vigilante`),
  KEY `id_cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`id_sistema`) REFERENCES `sistema` (`id_sistema`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_vigilante`) REFERENCES `vigilante` (`id_vigilante`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `sistema`
--
ALTER TABLE `sistema`
  ADD CONSTRAINT `sistema_ibfk_1` FOREIGN KEY (`id_vigilante`) REFERENCES `vigilante` (`id_vigilante`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
