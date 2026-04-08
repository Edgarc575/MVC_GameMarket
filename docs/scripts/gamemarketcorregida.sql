CREATE DATABASE IF NOT EXISTS gamemarket;
USE gamemarket;

SET FOREIGN_KEY_CHECKS=0;


-- ESTO ES TOMADO DEL EJEMPLO DE CLASE 
CREATE TABLE usuario (
    usercod bigint(10) NOT NULL AUTO_INCREMENT,
    useremail varchar(80) DEFAULT NULL,
    username varchar(80) DEFAULT NULL,
    userpswd varchar(128) DEFAULT NULL,
    userfching datetime DEFAULT NULL,
    userpswdest char(3) DEFAULT NULL,
    userpswdexp datetime DEFAULT NULL,
    userest char(3) DEFAULT NULL,
    useractcod varchar(128) DEFAULT NULL,
    userpswdchg varchar(128) DEFAULT NULL,
    usertipo char(3) DEFAULT NULL COMMENT 'Tipo de Usuario',
    PRIMARY KEY (usercod),
    UNIQUE KEY useremail_UNIQUE (useremail),
    KEY usertipo (usertipo,useremail,usercod,userest)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE roles (
    rolcod bigint(10) NOT NULL AUTO_INCREMENT,
    roldsc varchar(80) DEFAULT NULL,
    rolest char(3) DEFAULT NULL,
    PRIMARY KEY (rolcod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE roles_usuarios (
    rolcod bigint(10) NOT NULL,
    usercod bigint(10) NOT NULL,
    PRIMARY KEY (rolcod,usercod),
    KEY usercod_idx (usercod),
    CONSTRAINT roles_user_fk
        FOREIGN KEY (usercod)
        REFERENCES usuario(usercod),
    CONSTRAINT roles_rol_fk
        FOREIGN KEY (rolcod)
        REFERENCES roles(rolcod)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE funciones (
    funcod bigint(10) NOT NULL AUTO_INCREMENT,
    fundsc varchar(100) DEFAULT NULL,
    funurl varchar(255) DEFAULT NULL,
    funest char(3) DEFAULT NULL,
    PRIMARY KEY (funcod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE funciones_roles (
    rolcod bigint(10) NOT NULL,
    funcod bigint(10) NOT NULL,
    PRIMARY KEY (rolcod,funcod),
    KEY funcod_idx (funcod),
    CONSTRAINT funciones_roles_rol_fk
        FOREIGN KEY (rolcod)
        REFERENCES roles(rolcod),
    CONSTRAINT funciones_roles_fun_fk
        FOREIGN KEY (funcod)
        REFERENCES funciones(funcod)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE bitacora (
    bitcod bigint(10) NOT NULL AUTO_INCREMENT,
    usercod bigint(10) DEFAULT NULL,
    bitaccion varchar(255) DEFAULT NULL,
    bitfecha datetime DEFAULT NULL,
    bitip varchar(50) DEFAULT NULL,
    PRIMARY KEY (bitcod),
    KEY usercod_idx (usercod),
    CONSTRAINT bitacora_user_fk
        FOREIGN KEY (usercod)
        REFERENCES usuario(usercod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



-- ESTAS SON LAS TABLAS QUE HABIA QUE CREAR SEGUN EDGARDO
CREATE TABLE proveedor (
    provcod bigint(10) NOT NULL AUTO_INCREMENT,
    provnom varchar(100) DEFAULT NULL,
    provtel varchar(20) DEFAULT NULL,
    provemail varchar(100) DEFAULT NULL,
    provdir varchar(150) DEFAULT NULL,
    provest char(3) DEFAULT NULL,
    PRIMARY KEY (provcod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE cliente (
    clicod bigint(10) NOT NULL AUTO_INCREMENT,
    clinom varchar(100) DEFAULT NULL,
    clitel varchar(20) DEFAULT NULL,
    cliemail varchar(100) DEFAULT NULL,
    clidir varchar(150) DEFAULT NULL,
    cliest char(3) DEFAULT NULL,
    PRIMARY KEY (clicod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE producto (
    prodcod bigint(10) NOT NULL AUTO_INCREMENT,
    prodnom varchar(120) DEFAULT NULL,
    proddsc varchar(255) DEFAULT NULL,
    prodprecio decimal(10,2) DEFAULT NULL,
    prodstock int DEFAULT NULL,
    provcod bigint(10) DEFAULT NULL,
    prodest char(3) DEFAULT NULL,
    PRIMARY KEY (prodcod),
    KEY proveedor_idx (provcod),
    CONSTRAINT producto_proveedor_fk
        FOREIGN KEY (provcod)
        REFERENCES proveedor(provcod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE factura (
    factcod bigint(10) NOT NULL AUTO_INCREMENT,
    clicod bigint(10) DEFAULT NULL,
    usercod bigint(10) DEFAULT NULL,
    factfecha datetime DEFAULT NULL,
    facttotal decimal(10,2) DEFAULT NULL,
    factest char(3) DEFAULT NULL,
    PRIMARY KEY (factcod),
    KEY cliente_idx (clicod),
    KEY usuario_idx (usercod),
    CONSTRAINT factura_cliente_fk
        FOREIGN KEY (clicod)
        REFERENCES cliente(clicod),
    CONSTRAINT factura_usuario_fk
        FOREIGN KEY (usercod)
        REFERENCES usuario(usercod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE factura_detalle (
    factdetcod bigint(10) NOT NULL AUTO_INCREMENT,
    factcod bigint(10) DEFAULT NULL,
    prodcod bigint(10) DEFAULT NULL,
    factdetcant int DEFAULT NULL,
    factdetprecio decimal(10,2) DEFAULT NULL,
    factdetsub decimal(10,2) DEFAULT NULL,
    PRIMARY KEY (factdetcod),
    KEY factura_idx (factcod),
    KEY producto_idx (prodcod),
    CONSTRAINT factdet_factura_fk
        FOREIGN KEY (factcod)
        REFERENCES factura(factcod),
    CONSTRAINT factdet_producto_fk
        FOREIGN KEY (prodcod)
        REFERENCES producto(prodcod)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS=1;