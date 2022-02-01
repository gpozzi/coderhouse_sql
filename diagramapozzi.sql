/* Script de creación de tablas en SQL para el curso de  */

CREATE DATABASE IF NOT EXISTS diagramaPozzi;
USE diagramapozzi;

/* Tabla que contiene datos sobre proveedores */
CREATE TABLE IF NOT EXISTS proveedor (
	cod_proveedor smallint UNIQUE NOT NULL,
    numero_doc mediumint UNIQUE NOT NULL,
    razon_social varchar(30) NOT NULL,
    nombre_fantasia varchar(30),
    localidad varchar(30),
    codigo_postal varchar(8),
    calle varchar(40),
    altura smallint,
    piso tinyint,
    pais varchar(15),
    condicion_IVA varchar(20) NOT NULL,
    tipo_retencion_IVA decimal(5,4) NOT NULL,
    categoria_IVA char(1) NOT NULL,
    telefono bigint,
    email varchar(254),
	PRIMARY KEY(cod_proveedor)
);

/* Tabla que contiene datos sobre clientes */
CREATE TABLE IF NOT EXISTS cliente (
	cod_cliente smallint UNIQUE NOT NULL,
    numero_doc mediumint UNIQUE NOT NULL,
    razon_social varchar(30) NOT NULL,
    nombre_fantasia varchar(30),
    localidad varchar(30),
    codigo_postal varchar(8),
    calle varchar(40),
    altura smallint,
    piso tinyint,
    pais varchar(15),
    condicion_IVA varchar(20) NOT NULL,
    tipo_retencion_IVA decimal(5,4) NOT NULL,
    categoria_IVA char(1) NOT NULL,
    telefono bigint,
    email varchar(254),
    lista_precios_asociada varchar(15) NOT NULL,
    descuento decimal(3,2) DEFAULT 0,
    dias_vencim_factura tinyint,
	PRIMARY KEY(cod_cliente)
);

/* Tabla que contiene información sobre las categorías de productos (nombres de categorías en 3 niveles,/* 
/* tipo de IVA y márgenes para las distintas listas de precios) */
CREATE TABLE IF NOT EXISTS categoria (
	idcat tinyint UNIQUE NOT NULL,
	catnivel1 varchar(30) NOT NULL,
	catnivel2 varchar(30) NOT NULL,
	catnivel3 varchar(30) NOT NULL,
    margenminorista decimal(3,2) NOT NULL,
    margenmayorista decimal(3,2) NOT NULL,
    margenecommerce decimal(3,2) NOT NULL,
    tipo_iva decimal(5,4) NOT NULL,
    PRIMARY KEY(idcat)
);

/* Tabla que contiene información sobre cada producto en el inventario */
CREATE TABLE IF NOT EXISTS productos (
	sku char(8) NOT NULL,
    cbarras varchar(20),
    nomcorto varchar(60) NOT NULL,
	descripcion varchar(200) NOT NULL,
    presentacion varchar(30) NOT NULL,
    costosiniva decimal(5,2) DEFAULT 0,
    sin_tacc varchar(10) NOT NULL,
    peso tinyint,
    ancho tinyint,
    alto tinyint,
    longitud tinyint,
    id_ecommerce mediumint,
    imagen_ecommerce varchar(400),
	cod_proveedor smallint NOT NULL,
    idcat tinyint NOT NULL,
    PRIMARY KEY(sku),
    FOREIGN KEY(cod_proveedor) REFERENCES proveedor(cod_proveedor),
    FOREIGN KEY(idcat) REFERENCES categoria(idcat)
	);

/* Tabla que contiene información sobre cada pedido realizado en el ERP */
CREATE TABLE IF NOT EXISTS pedido (
	numero mediumint UNIQUE NOT NULL,
    fecha DATETIME NOT NULL,
    punto_venta tinyint NOT NULL,
    sucursal varchar(20) NOT NULL,
    cae bigint,
    costo_unitario decimal(5,2) NOT NULL,
    precio_unitario decimal(5,2) NOT NULL,
    cantidad tinyint NOT NULL,
    total_item decimal(5,2) NOT NULL,
    importe_total decimal(5,2) NOT NULL,
    condicion_venta char(1) NOT NULL,
    tipo char(2) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    vendedor varchar(30) NOT NULL,
    observacion_interna tinyblob,
	pedido_web varchar(10) NOT NULL,
	sku char(8) NOT NULL,
	cod_cliente smallint UNIQUE NOT NULL,
	PRIMARY KEY(numero),
    FOREIGN KEY(sku) REFERENCES productos(sku),
    FOREIGN KEY(cod_cliente) REFERENCES cliente(cod_cliente)
	);
