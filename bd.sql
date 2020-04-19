-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `bd` DEFAULT CHARACTER SET utf8 ;
USE `bd` ;


-- -----------------------------------------------------
-- Table `bd`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`estados` (
`id_estado` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`nom_estado` VARCHAR  (45) NOT NULL
)
ENGINE = InnoDB;

INSERT INTO estados
VALUES (default, 'Reservado'),
(default, 'Ocupado'),
(default, 'Abierto'),
(default, 'Cerrado'),
(default, 'Mantenimiento'),
(default, 'Activo'),
(default, 'Inactivo'),
(default, 'Disponible'),
(default, 'No Disponible');

-- -----------------------------------------------------
-- Table `bd`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`personas` (
  `id_per` INT NOT NULL AUTO_INCREMENT,
  `pri_nomb` TEXT(45) NOT NULL,
  `seg_nomb` TEXT(45) NOT NULL,
  `pri_apel` TEXT(45) NOT NULL,
  `seg_apel` TEXT(45) NOT NULL,
  `nom_comp` TEXT(100) NOT NULL,
  `tip_doc` INT NOT NULL,
  `num_doc` INT NOT NULL,
  `fec_nac` DATETIME NOT NULL,
  `edad` INT NOT NULL,
  `telf` INT NOT NULL,
  `direc_per` VARCHAR(45) NOT NULL,
  `genero_per` TEXT(20) NOT NULL,
  PRIMARY KEY (`id_per`)
  )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd`.`origen_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`origen_usuarios`(
`id_origen_usu` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`nom_origen_usu` VARCHAR(45) NOT NULL
)
ENGINE = InnoDB;

insert into origen_usuarios
values (default,'facebook'),
(default,'gmail');

-- -----------------------------------------------------
-- Table `bd`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`usuarios` (
  `id_usu` INT NOT NULL AUTO_INCREMENT,
  `id_per` INT NOT NULL,
  `nom_usu` TEXT(45) NOT NULL,
  `pass_usu` VARCHAR(45) NOT NULL,
  `email_usu` VARCHAR(45) NOT NULL,
  `telf_usu` INT NOT NULL,
  `id_origen_usu` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_usu`),
  UNIQUE INDEX `pass_usu_UNIQUE` (`pass_usu` ASC) VISIBLE,
  UNIQUE INDEX `email_usu_UNIQUE` (`email_usu` ASC) VISIBLE,
  INDEX `id_per_idx` (`id_per` ASC) VISIBLE,
  CONSTRAINT `id_per`
    FOREIGN KEY (`id_per`)
    REFERENCES `bd`.`personas` (`id_per`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_origen_usu_usuarios`
  FOREIGN KEY (`id_origen_usu`)
  REFERENCES `bd`.`origen_usuarios` (`id_origen_usu`)
  ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_estado_usuarios`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




insert into usuarios
values('1','1','marlong','marlong123','marlongcubas@gmail.com','943697336','1','6'),
('2','2','jorge','jorge123','jorge.herrera.tume@gmail.com','997603069','2','6');

-- -----------------------------------------------------
-- Table `bd`.`locales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`locales` (
  `id_local` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nom_local` VARCHAR(45) NOT NULL,
  `img_local` VARCHAR(45) NOT NULL,
  `precio_local` FLOAT NOT NULL,
  `lat_local` FLOAT NOT NULL,
  `long_local` FLOAT NOT NULL,
  `descrip_local` LONGTEXT NOT NULL,
  `telf_local` INT NOT NULL,
  `direc_local` VARCHAR(45) NOT NULL,
  `id_estado` INT NOT NULL,
  `ranking` DECIMAL(18,2) NULL,
  UNIQUE INDEX `lat_local_UNIQUE` (`lat_local` ASC) VISIBLE,
  UNIQUE INDEX `long_local_UNIQUE` (`long_local` ASC) VISIBLE,
  UNIQUE INDEX `telf_local_UNIQUE` (`telf_local` ASC) VISIBLE,
  CONSTRAINT `id_estado_locales`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`votacion_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`votacion_local`(
`id_votacion_local` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`votacion` INT NOT NULL,
`id_usu` INT NOT NULL,
`id_local` INT NOT NULL,
`fecha_votacion` DATE NOT NULL,
CONSTRAINT `id_usu_votacion_local`
    FOREIGN KEY (`id_usu`)
    REFERENCES `bd`.`usuario` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT `id_local_votacion_local`
    FOREIGN KEY (`id_local`)
    REFERENCES `bd`.`locales` (`id_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;


-- -----------------------------------------------------
-- Table `bd`.`horarios_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`horarios_local` (
  `id_horarios_local` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `dia_hor_local` INT NOT NULL,
  `mes_hor_local` DATE NOT NULL,
  `año_hor_local` YEAR NOT NULL,
  `fecha_hor_local` DATETIME NOT NULL,
  `hora_hor_local` TIME NOT NULL,
  `id_local` INT NOT NULL,
  CONSTRAINT `id_local_horarios_local`
  FOREIGN KEY (`id_local`)
  REFERENCES `db`.`locales`(`id_local`) 
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`catering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`catering` (
  `id_cater` INT NOT NULL AUTO_INCREMENT,
  `nom_cater` VARCHAR(45) NOT NULL,
  `tipo_cater` VARCHAR(45) NOT NULL,
  `precio_cater` DECIMAL NOT NULL,
  `img_cater` VARCHAR(45) NOT NULL,
  `descr_cater` VARCHAR(500) NOT NULL,
  `id_local` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_cater`),
  CONSTRAINT `id_estado_catering`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
    
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`locales_has_catering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`locales_has_catering` (
  `locales_id_local` INT NOT NULL,
  `catering_id_cater` INT NOT NULL,
  PRIMARY KEY (`locales_id_local`, `catering_id_cater`),
  INDEX `fk_locales_has_catering_catering1_idx` (`catering_id_cater` ASC) VISIBLE,
  INDEX `fk_locales_has_catering_locales1_idx` (`locales_id_local` ASC) VISIBLE,
  CONSTRAINT `fk_locales_has_catering_locales1`
    FOREIGN KEY (`locales_id_local`)
    REFERENCES `bd`.`locales` (`id_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locales_has_catering_catering1`
    FOREIGN KEY (`catering_id_cater`)
    REFERENCES `bd`.`catering` (`id_cater`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


- -----------------------------------------------------
-- Table `bd`.`shows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`shows` (
  `id_show` INT NOT NULL AUTO_INCREMENT,
  `id_local` INT NOT NULL,
  `nomb_show` VARCHAR(45) NOT NULL,
  `img_show` VARCHAR(45) NOT NULL,
  `descr_show` VARCHAR(500) NOT NULL,
  `precio_show` DECIMAL NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_show`),
  INDEX `id_local_idx` (`id_local` ASC) VISIBLE,
  CONSTRAINT `id_local`
    FOREIGN KEY (`id_local`)
    REFERENCES `bd`.`locales` (`id_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_estado_shows`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`categ_prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`categ_prod` (
  `id_cat_prod` INT NOT NULL AUTO_INCREMENT,
  `nom_cat_prod` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cat_prod`)
  )
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `bd`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`productos` (
  `id_prod` INT NOT NULL AUTO_INCREMENT,
  `id_cater` INT NOT NULL,
  `usuarios_id_usu` INT NOT NULL,
  `nom_prod` VARCHAR(45) NOT NULL,
  `tipo_prod` VARCHAR(45) NOT NULL,
  `descr_prod` VARCHAR(45) NOT NULL,
  `precio_prod` DECIMAL NOT NULL,
  `stock_prod` INT NOT NULL,
  `id_cat_prod` INT NOT NULL,
  PRIMARY KEY (`id_prod`),
  INDEX `id_cater_idx` (`id_cater` ASC) VISIBLE,
  INDEX `fk_productos_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  CONSTRAINT `id_cater_productos`
    FOREIGN KEY (`id_cater`)
    REFERENCES `bd`.`catering` (`id_cater`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `bd`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_cat_prod_productos`
    FOREIGN KEY (`id_cat_prod`)
    REFERENCES `bd`.`categ_prod` (`id_cat_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd`.`orden_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`orden_detalle`(
	`id_orden_detalle` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `id_local` INT NOT NULL,
    `id_prod` INT NOT NULL,
    `id_show` INT NOT NULL,
    CONSTRAINT `id_local_orden_detalle`
    FOREIGN KEY (`id_local`)
    REFERENCES `bd`.`locales` (`id_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_prod_orden_detalle`
    FOREIGN KEY (`id_prod`)
    REFERENCES `bd`.`productos` (`id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_show_orden_detalle`
    FOREIGN KEY (`id_show`)
    REFERENCES `bd`.`shows` (`id_show`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`orden_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`orden_compra` (
  `id_orden` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `usuarios_id_usu` INT NOT NULL,
  `fecha_orden` DATETIME NOT NULL,
  `id_orden_detalle` INT NOT NULL,
  CONSTRAINT `id_orden_detalle_orden_compra`
  FOREIGN KEY (`id_orden_detalle`)
  REFERENCES `bd`.`orden_detalle` (`id_orden_detalle`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`entidad_bancaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `entidad_bancaria`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`descripcion` VARCHAR(45)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`tipo_tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_tarjeta`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`descripcion` VARCHAR(45)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd`.`tarjeta_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`tarjeta_usuario` (
  `id_tarjeta` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id_usu` INT NOT NULL,
  `id_entidad_bancaria` INT NOT NULL,
  `num_tarj` INT NOT NULL,
  `id_tipo_tarjeta` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  UNIQUE INDEX `id_tarjeta_UNIQUE` (`id_tarjeta` ASC) VISIBLE,
  INDEX `fk_tarjeta_usuario_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  CONSTRAINT `fk_tarjeta_usuario_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `bd`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
   CONSTRAINT `id_entidad_bancaria_tarjeta_usuario`
	FOREIGN KEY (`id_entidad_bancaria`)
    REFERENCES `bd`.`entidad_bancaria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_tipo_tarjeta_tarjeta_usuario`
	FOREIGN KEY (`id_tipo_tarjeta`)
    REFERENCES `bd`.`tipo_tarjeta` (`id`)
    ON DELETE NO ACTION
	ON UPDATE NO ACTION,
    CONSTRAINT `id_estado`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd`.`reserva_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`reserva_detalle`(
`id_reserva_detalle` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`descripcion` INT NOT NULL,
`id_local` INT NOT NULL,
`id_prod` INT NOT NULL,
`id_show` INT NOT NULL,
`id_horarios_local` INT NOT NULL,
`fecha_reserva` DATETIME NOT NULL,
CONSTRAINT `id_local_reserva_detalle`
FOREIGN KEY (`id_local`)
REFERENCES `bd`.`locales` (`id_local`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `id_prod_reserva_detalle`
FOREIGN KEY (`id_prod`)
REFERENCES `bd`.`productos`  (`id_prod`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `id_show_reserva_detalle`
FOREIGN KEY (`id_show`)
REFERENCES `bd`.`shows`  (`id_show`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `id_horarios_local_reserva_detalle`
FOREIGN KEY (`id_horarios_local`)
REFERENCES `bd`.`horarios_local`  (`id_horarios_local`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`reserva` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id_usu` INT NOT NULL,
  `id_estado` INT NOT NULL,
  `id_reserva_detalle` INT NOT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reserva_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  UNIQUE INDEX `id_reserva_UNIQUE` (`id_reserva` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `bd`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_estado_reserva`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_reserva_detalle_reserva`
    FOREIGN KEY (`id_reserva_detalle`)
    REFERENCES `bd`.`reserva.detalle` (`id_reserva_detalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;

ALTER TABLE `bd`.`personas` 
CHANGE COLUMN `pri_nomb` `pri_nomb` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `seg_nomb` `seg_nomb` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `pri_apel` `pri_apel` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `seg_apel` `seg_apel` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `nom_comp` `nom_comp` VARCHAR(120) NOT NULL ,
CHANGE COLUMN `tip_doc` `tip_doc` INT NOT NULL,
CHANGE COLUMN `num_doc` `num_doc` VARCHAR(12) NOT NULL,
CHANGE COLUMN `fec_nac` `fec_nac` DATE NOT NULL ,
CHANGE COLUMN `genero_per` `genero_per` CHAR NOT NULL;

ALTER TABLE `bd`.`personas`
DROP COLUMN `telf`;

ALTER TABLE `bd`.`usuarios` 
CHANGE COLUMN `nom_usu` `nom_usu` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `id_origen_usu` `id_origen_usu`INT NOT NULL ,
CHANGE COLUMN `pass_usu` `pass_usu` LONGTEXT NOT NULL ,
DROP INDEX `pass_usu_UNIQUE` ;

DROP procedure IF EXISTS `SP_USER_GLOBAL`;

DELIMITER $$
USE `bd`$$
CREATE PROCEDURE `SP_USER_GLOBAL` (IN `vAccion` VARCHAR(45),
IN `idPerson` INT, IN `firstName` VARCHAR(40), IN `secondName` VARCHAR(40),
IN `firstLastName` VARCHAR(40), IN `secondLastName` VARCHAR(40),
IN `fullName` VARCHAR(120), IN `documentType`INT,
IN `documentNumber` VARCHAR(12),  IN `bornDate` DATE,
IN `age` INT, IN `mobileNumber` INT, IN `address` VARCHAR(45), 
IN `genre` INT, IN `idUser` INT, IN `userName` VARCHAR(45),
IN `passwordUser` LONGTEXT, IN `email` VARCHAR(45),
IN `sourceUser`INT, IN `userStatus` INT)
BEGIN
	DECLARE personId INT;

	IF vAccion = "registrar" THEN
		INSERT INTO personas(
			pri_nomb,seg_nomb,pri_apel,
			seg_apel,nom_comp,tip_doc,
			num_doc,fec_nac,edad,
			direc_per,genero_per) 
        VALUES 
			(firstName,secondName,firstLastName,
			secondLastName,fullName,
			documentType,documentNumber,bornDate,
			age,address,genre);
        
        SET personId = last_insert_id();
        
        INSERT INTO usuarios(
			id_per, nom_usu, pass_usu,
            email_usu, telf_usu, id_origen_usu, id_estado)
		VALUES 
			(personId, userName, passwordUser,
            email, mobileNumber, sourceUser, userStatus); 
    
    END IF;
    
    IF vAccion = "login" THEN
			SELECT 
				P.id_per as personId, P.pri_nomb as firstName, P.seg_nomb as secondName, P.pri_apel as firstLastName,
                P.seg_apel as secondLastName, P.nom_comp as fullName, P.tip_doc as documentType,
                P.num_doc as documentNumber, DATE_FORMAT(P.fec_nac,'%d/%m/%Y') as bornDate, P.direc_per as address,
                P.genero_per as genre, U.nom_usu as userName, U.email_usu as email, 
                U.telf_usu as mobileNumber, E.nom_estado as userStatus, E.id_estado as statudID
            FROM 
				USUARIOS U 
			INNER JOIN PERSONAS P ON P.id_per = U.id_per 
            INNER JOIN ESTADOS E ON E.id_estado = U.id_estado
            WHERE 
				U.nom_usu = userName 
				AND U.pass_usu = passwordUser;
	END IF;
	
    IF vAccion = "obtener" THEN
			SELECT 
				P.id_per as personId, P.pri_nomb as firstName, P.seg_nomb as secondName, P.pri_apel as firstLastName,
                P.seg_apel as secondLastName, P.nom_comp as fullName, P.tip_doc as documentType,
                P.num_doc as documentNumber, DATE_FORMAT(P.fec_nac,'%d/%m/%Y') as bornDate, P.direc_per as address,
                P.genero_per as genre, U.nom_usu as userName, U.email_usu as email, 
                U.telf_usu as mobileNumber, U.id_estado as userStatus
            FROM 
				USUARIOS U 
			INNER JOIN PERSONAS P ON P.id_per = U.id_per 
            WHERE 
				P.id_per = idPerson 
				OR P.num_doc = documentNumber;
	END IF;
    
    IF vAccion = "estado/cambiar" THEN
		UPDATE 
			USUARIOS 
		SET 
			id_estado = userStatus 
		WHERE 
			id_per = idPerson;    
    END IF;
    
    IF vAccion = "eliminar" THEN
		DELETE FROM 
			USUARIOS
		WHERE id_per = idPerson AND nom_usu = userName;
        
        DELETE FROM 
			PERSONAS
		WHERE id_per = idPerson;
	END IF;
    
    IF vAccion = "datos/actualizar" THEN
			UPDATE PERSONAS p, USUARIOS u  
				set P.pri_nomb=firstName, P.seg_nomb=secondName, P.pri_apel=firstLastName,
                P.seg_apel=secondLastName, P.nom_comp=fullName, P.tip_doc=documentType,
                P.num_doc=documentNumber, P.fec_nac=bornDate, P.direc_per=address,
                P.genero_per=genre, U.nom_usu = userName, U.email_usu = email, 
				U.telf_usu = mobileNumber, U.id_estado = userStatus
			WHERE p.id_per = idPerson
            AND u.id_per = idPerson;

	END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `bd`$$

CREATE PROCEDURE `SP_LOCAL_GLOBAL` (IN accion VARCHAR(30), IN idLocal INT,  IN nombreLocal MEDIUMTEXT, IN imagenLocal VARCHAR(45),
									IN precioLocal FLOAT, IN latitudLocal FLOAT, IN longitudLocal FLOAT,
                                    IN descripcionLocal LONGTEXT, IN telefonoLocal INT, IN direccionLocal VARCHAR(45),
                                    IN estadoLocal INT, IN rankingLocal DECIMAL(18,2))
BEGIN
	IF accion = 'locales/obtener' THEN
	   SELECT 
		l.id_local as idLocal, l.nom_local as nombreLocal, l.img_local as imagenLocal,
		l.precio_local as precioLocal, l.lat_local as latitudLocal, l.long_local as longitudLocal,
		l.descrip_local as descripcionLocal, l.telf_local as telefonoLocal, l.direc_local as direccionLocal,
		l.id_estado as idEstado, e.nom_estado as estadoLocal, l.ranking as rankingLocal
		FROM locales l 
		INNER JOIN estados e ON e.id_estado = l.id_estado
		WHERE l.id_estado = estadoLocal;
	END IF;
    /*
    IN PROGRESS
    */
END$$

DELIMITER ;

CREATE TABLE tipo_doc
(
id INT PRIMARY KEY AUTO_INCREMENT,
descripcion VARCHAR(200)
);

INSERT INTO tipo_doc(descripcion) values ('DNI'),('C.E.');

CREATE TABLE tipo_genero
(
id INT PRIMARY KEY AUTO_INCREMENT,
descripcion VARCHAR(200)
);
INSERT INTO tipo_genero(descripcion) values ('Masculino'),('Femenino'),('No determinado');

delete from usuarios;
delete from personas;

ALTER TABLE `bd`.`personas` 
CHANGE COLUMN `genero_per` `genero_per` INT NOT NULL ;

ALTER TABLE `bd`.`personas` 
CHANGE COLUMN `pri_nomb` `pri_nomb` VARCHAR(50) NULL ,
CHANGE COLUMN `seg_nomb` `seg_nomb` VARCHAR(50) NULL ,
CHANGE COLUMN `pri_apel` `pri_apel` VARCHAR(50) NULL ,
CHANGE COLUMN `seg_apel` `seg_apel` VARCHAR(50) NULL ;

ALTER TABLE personas
add CONSTRAINT `id_tipo_doc_persona`
FOREIGN KEY personas(tip_doc)
REFERENCES tipo_doc (id) on update no action on delete no action;

ALTER TABLE personas
add CONSTRAINT `id_tipo_genero_persona`
FOREIGN KEY personas(genero_per)
REFERENCES tipo_genero (id) on update no action on delete no action;

ALTER TABLE `bd`.`locales` 
CHANGE COLUMN `nom_local` `nom_local` MEDIUMTEXT NOT NULL ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('porttitor id', '221.81.88.216/9', '128.82', 60.9, 44.11, 'nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam', 348931497, '09804 Sutherland Avenue', 3, 4.45);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sit amet lobortis', '16.218.92.186/29', '714.30', 97.85, 57.8, 'ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget', 125937188, '88 Heath Park', 2, 2.74);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('dictumst morbi vestibulum', '162.102.141.222/14', '414.19', 78.97, 33.42, 'vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet', 898341919, '0688 Kings Place', 4, 3.04);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('volutpat sapien', '42.155.235.179/27', '105.85', 51.74, 18.71, 'massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris', 863422684, '0 Clarendon Crossing', 1, 3.25);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nulla integer', '47.184.199.55/23', '909.49', 93.44, 68.92, 'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in', 948103268, '5387 Delaware Street', 5, 3.42);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tempus sit amet', '218.148.125.167/20', '326.85', 9.51, 71.9, 'non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque', 762511918, '1 Farragut Place', 5, 1.6);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis turpis sed', '234.174.119.170/1', '371.26', 40.43, 27.44, 'convallis nulla neque libero convallis eget eleifend luctus ultricies eu', 314997208, '81957 Shasta Park', 5, 4.95);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quam pharetra magna', '91.248.9.232/14', '927.88', 95.83, 45.3, 'condimentum neque sapien placerat ante nulla justo aliquam quis turpis', 223843658, '65416 Montana Terrace', 4, 3.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('molestie nibh in', '20.33.78.166/8', '436.82', 9.0, 8.51, 'tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis', 687038808, '350 Pond Court', 1, 4.74);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('erat fermentum justo', '52.29.57.208/29', '928.13', 11.6, 59.64, 'eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a', 599250648, '1359 Longview Place', 3, 4.17);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tincidunt nulla mollis', '73.114.219.35/7', '209.24', 47.68, 65.82, 'orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio', 778042912, '48 Cordelia Plaza', 1, 3.64);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('libero nullam', '11.89.173.83/29', '270.86', 70.71, 46.33, 'et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum', 384626880, '750 Lake View Drive', 1, 3.22);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('duis bibendum', '203.90.176.56/22', '652.06', 97.24, 93.47, 'odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat', 895750705, '14 Spohn Drive', 2, 4.55);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget semper', '25.202.178.78/19', '285.60', 91.09, 75.03, 'tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris', 646814021, '6 Vernon Center', 5, 3.33);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('volutpat eleifend', '38.154.172.127/13', '827.15', 81.57, 55.21, 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes', 392443217, '930 Butternut Street', 3, 2.9);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('purus aliquet at', '17.13.160.230/23', '613.08', 89.75, 53.71, 'ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam', 501491144, '7268 Dorton Park', 1, 2.78);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in quam', '50.54.75.36/8', '453.55', 15.99, 62.11, 'cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit', 335751990, '11 Warrior Trail', 5, 3.99);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nulla facilisi cras', '108.103.43.146/4', '837.58', 98.98, 99.84, 'viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper', 186720969, '21331 Schiller Plaza', 2, 1.94);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sit amet', '144.194.225.174/8', '460.48', 32.71, 84.69, 'lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla', 796108300, '34185 Arrowood Plaza', 4, 3.14);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vel nulla', '4.179.191.34/14', '157.90', 52.08, 38.92, 'augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero', 590219064, '1 Pleasure Circle', 2, 2.36);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quisque porta', '166.22.77.196/4', '882.54', 1.97, 99.44, 'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet', 514310013, '1 Northwestern Drive', 1, 1.26);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('congue vivamus metus', '33.83.164.129/21', '816.81', 39.09, 72.44, 'vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in', 765924035, '32 High Crossing Place', 3, 3.11);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('magna vestibulum aliquet', '62.20.219.96/23', '982.53', 77.33, 97.65, 'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a', 969282812, '743 Graedel Alley', 2, 4.29);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vel enim', '172.161.210.219/24', '583.34', 92.67, 12.94, 'luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur', 595253415, '029 Melrose Court', 2, 1.11);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('pede libero', '228.197.187.208/16', '276.63', 87.8, 19.09, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse', 781156192, '5 Linden Alley', 5, 3.78);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('consequat morbi a', '102.132.163.4/14', '703.92', 34.33, 49.68, 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et', 968784909, '949 Jenifer Center', 1, 2.25);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ut at', '154.236.53.21/13', '854.16', 80.66, 7.36, 'ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam', 554792722, '7654 Evergreen Way', 3, 4.36);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('turpis donec', '87.107.71.121/30', '594.37', 25.02, 17.93, 'eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus', 868143210, '1 Miller Park', 4, 2.3);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nec euismod scelerisque', '69.30.13.94/10', '431.66', 26.43, 90.11, 'adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at', 591374414, '256 Welch Trail', 2, 2.01);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('praesent id', '31.17.91.193/22', '689.34', 24.34, 56.22, 'consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices', 385390917, '5848 Oneill Center', 3, 2.52);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('imperdiet sapien', '191.176.210.242/13', '124.09', 48.49, 6.96, 'potenti in eleifend quam a odio in hac habitasse platea', 839984216, '43205 Reindahl Junction', 4, 3.81);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('aliquam quis turpis', '63.37.16.242/5', '496.16', 57.1, 54.14, 'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel', 185957944, '95 Transport Park', 3, 3.14);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget massa', '89.162.22.99/20', '118.71', 12.04, 80.54, 'eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices', 862356665, '79025 Northridge Parkway', 4, 3.23);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lorem integer tincidunt', '119.55.102.37/1', '152.23', 47.78, 16.87, 'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh', 307178029, '5935 West Street', 5, 3.11);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in faucibus orci', '158.235.37.151/21', '545.29', 43.31, 2.48, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus', 699805751, '18 Sunfield Pass', 5, 1.13);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vitae consectetuer', '113.208.169.206/28', '319.94', 3.23, 60.93, 'sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus', 322371036, '3 Thierer Avenue', 3, 3.78);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sapien quis', '111.31.116.166/3', '357.24', 69.66, 80.64, 'nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede', 205405498, '0706 Oriole Street', 5, 2.78);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tincidunt eu felis', '60.59.148.56/30', '950.99', 25.62, 65.68, 'non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', 111223747, '347 Village Hill', 4, 3.28);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lectus in', '254.162.133.133/23', '321.13', 83.96, 81.24, 'quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec', 294570601, '62 Barnett Center', 5, 2.96);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('purus phasellus', '39.2.36.64/27', '104.22', 1.31, 53.94, 'eu magna vulputate luctus cum sociis natoque penatibus et magnis', 414665746, '12 Corscot Pass', 4, 1.78);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('donec odio justo', '198.147.129.33/10', '833.10', 18.52, 85.25, 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae', 867505144, '902 Golf Course Junction', 1, 3.18);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quisque erat', '146.45.104.98/16', '344.01', 22.29, 71.11, 'vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi', 255791912, '79443 Holmberg Junction', 5, 3.68);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum proin', '6.32.185.102/17', '442.63', 43.12, 91.21, 'orci eget orci vehicula condimentum curabitur in libero ut massa', 159789737, '60542 Meadow Vale Street', 2, 2.11);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('augue a', '53.185.40.107/29', '817.33', 11.12, 55.26, 'tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum', 482411672, '9 Katie Alley', 4, 3.19);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('interdum mauris', '102.68.144.150/6', '839.83', 67.96, 40.02, 'justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus', 442226322, '6841 Stuart Drive', 5, 2.5);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('orci vehicula', '139.46.99.123/17', '531.07', 14.13, 70.28, 'vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget', 898343525, '53 Sullivan Junction', 2, 2.02);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('curae nulla', '148.25.186.159/19', '872.72', 59.75, 58.34, 'sed justo pellentesque viverra pede ac diam cras pellentesque volutpat', 753767832, '0867 Novick Park', 2, 3.5);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis turpis eget', '79.130.127.29/1', '830.86', 81.17, 48.41, 'at turpis a pede posuere nonummy integer non velit donec', 907246317, '0006 Sauthoff Street', 3, 3.09);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nibh in', '171.98.209.144/8', '460.63', 86.05, 22.35, 'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id', 146379117, '081 Erie Circle', 4, 2.76);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('odio in', '194.94.28.98/2', '110.83', 5.66, 7.34, 'aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis', 489409553, '75 Stoughton Plaza', 2, 2.21);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tortor risus', '182.140.118.56/4', '745.37', 21.11, 6.14, 'augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac', 727397488, '5454 Manitowish Court', 5, 4.57);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mauris vulputate', '145.248.211.28/28', '657.37', 67.62, 81.62, 'rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam', 909064329, '48379 Schmedeman Trail', 4, 4.51);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget semper', '109.154.147.151/24', '355.49', 82.03, 83.76, 'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla', 742498993, '30679 Pawling Plaza', 5, 1.57);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget tempus vel', '80.220.227.18/22', '489.87', 69.07, 51.3, 'donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', 692385794, '2062 Bluejay Hill', 5, 3.65);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('a libero', '80.104.64.40/19', '642.42', 59.8, 17.27, 'eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien', 112691295, '4 Washington Crossing', 1, 4.14);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vel pede', '27.120.132.198/29', '508.42', 21.28, 47.45, 'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in', 533120324, '95372 Forster Center', 4, 1.51);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('fusce congue diam', '205.94.7.201/13', '875.53', 75.04, 90.92, 'dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus', 398935305, '0499 Michigan Court', 2, 2.65);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('dignissim vestibulum vestibulum', '48.113.159.163/9', '905.61', 76.02, 60.29, 'tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis', 793972467, '376 Starling Court', 5, 3.3);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nisi at', '215.49.121.66/12', '344.29', 74.37, 86.95, 'sapien sapien non mi integer ac neque duis bibendum morbi', 252925289, '3278 Vernon Junction', 1, 2.39);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('integer a', '41.150.83.150/20', '515.43', 47.22, 50.82, 'morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed', 645509256, '9645 Carberry Drive', 5, 3.82);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('blandit non interdum', '129.152.184.200/1', '587.16', 41.25, 31.42, 'placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis', 445021517, '42 Meadow Valley Alley', 5, 4.33);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('pede lobortis ligula', '246.61.137.50/23', '952.31', 52.76, 27.33, 'amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus', 750570709, '13653 Fulton Road', 2, 1.82);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vehicula condimentum', '95.79.140.36/20', '303.04', 13.48, 11.87, 'eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc', 624008788, '9863 John Wall Circle', 5, 3.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('velit eu est', '136.36.158.117/29', '253.17', 10.64, 22.98, 'posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien', 388732023, '8496 Summer Ridge Plaza', 1, 2.09);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum proin eu', '179.235.104.142/7', '104.21', 4.48, 53.81, 'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam', 521459576, '3 Anthes Plaza', 1, 1.92);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('integer non', '123.188.156.66/31', '733.90', 94.96, 98.55, 'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu', 220442695, '0421 Nevada Junction', 1, 3.52);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget eros', '187.161.67.177/29', '673.10', 31.92, 63.32, 'in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla', 828898537, '71733 Beilfuss Center', 3, 3.07);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('donec odio justo', '184.27.196.144/21', '409.58', 75.9, 31.01, 'mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue', 291586787, '73 Johnson Center', 4, 2.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('platea dictumst etiam', '99.8.19.187/26', '263.69', 74.15, 34.75, 'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id', 638865996, '781 Glendale Road', 5, 2.13);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tortor id nulla', '221.63.140.56/9', '533.59', 2.41, 33.75, 'diam erat fermentum justo nec condimentum neque sapien placerat ante', 872934625, '3555 Armistice Park', 1, 2.09);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nec euismod', '254.65.132.238/6', '222.17', 36.54, 83.49, 'ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat', 557013216, '485 Valley Edge Drive', 2, 4.56);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in imperdiet', '197.249.240.211/29', '856.03', 47.05, 55.25, 'mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor', 568943592, '065 Oak Valley Place', 2, 3.5);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('accumsan tortor quis', '165.175.148.200/23', '370.43', 30.08, 73.41, 'non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus', 814206013, '677 Jenifer Street', 2, 2.53);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('congue diam', '160.241.226.91/12', '728.89', 98.9, 46.87, 'semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum', 724317411, '66 Northport Park', 4, 3.87);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum sed magna', '181.250.118.37/26', '899.91', 78.21, 89.49, 'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut', 955178993, '16001 Stone Corner Hill', 3, 2.94);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget orci vehicula', '20.200.195.254/10', '978.80', 99.51, 54.04, 'sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed', 699391378, '0743 John Wall Point', 2, 2.91);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eu felis', '187.123.226.61/8', '244.94', 44.61, 73.42, 'venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem', 762850718, '501 Mayfield Lane', 5, 2.38);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in purus eu', '66.110.234.193/15', '454.99', 17.31, 67.8, 'in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum', 988932214, '6 Merchant Park', 5, 3.26);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('imperdiet sapien', '192.98.20.82/28', '691.68', 95.1, 64.52, 'ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in', 473362059, '63 Doe Crossing Circle', 2, 3.66);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('erat curabitur gravida', '91.117.246.49/30', '699.48', 94.65, 62.2, 'nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et', 764749754, '9 Ridgeview Crossing', 4, 4.97);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lobortis convallis tortor', '134.30.74.93/11', '636.97', 96.2, 67.4, 'nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante', 621095821, '057 Kedzie Crossing', 2, 3.48);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ut erat', '221.78.189.21/21', '659.19', 23.51, 52.1, 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque', 836204583, '304 Fair Oaks Park', 5, 4.3);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ante ipsum', '57.116.170.23/2', '493.79', 27.38, 92.47, 'augue vel accumsan tellus nisi eu orci mauris lacinia sapien', 969743789, '7286 Florence Plaza', 3, 1.2);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget massa tempor', '40.52.38.89/5', '795.75', 5.82, 36.99, 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum', 906053922, '1 Erie Hill', 4, 3.97);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('convallis eget', '201.96.34.156/22', '993.42', 30.33, 27.2, 'posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi', 523944826, '4852 Mallory Terrace', 2, 2.13);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('cum sociis natoque', '65.245.156.82/1', '917.47', 6.72, 88.58, 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget', 729327882, '6 Bultman Circle', 5, 3.16);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('convallis tortor risus', '17.64.69.63/21', '990.57', 25.6, 59.12, 'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit', 621780485, '3634 Hanover Junction', 3, 2.74);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('odio elementum eu', '188.75.228.245/3', '792.37', 34.21, 74.03, 'sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam', 926296300, '5 Miller Court', 3, 1.68);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lobortis est', '3.208.228.137/11', '798.58', 49.62, 95.39, 'orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum', 161958556, '6006 Green Avenue', 5, 3.49);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('cum sociis natoque', '186.232.191.45/16', '972.78', 8.91, 91.7, 'vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at', 514994345, '222 John Wall Avenue', 1, 1.4);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ante vel ipsum', '102.220.13.198/3', '209.99', 63.84, 77.63, 'primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut', 833783822, '5 Alpine Circle', 5, 1.88);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lacinia nisi venenatis', '110.208.140.89/18', '449.24', 6.58, 83.57, 'vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit', 754637495, '92159 Mesta Crossing', 1, 1.62);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis turpis', '214.191.67.34/16', '190.74', 52.06, 7.47, 'vel est donec odio justo sollicitudin ut suscipit a feugiat', 488005806, '00748 Meadow Vale Drive', 2, 1.99);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('consequat varius', '180.77.73.239/12', '702.38', 2.47, 52.16, 'nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at', 946468658, '26 David Plaza', 3, 1.28);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ultrices enim', '38.36.219.72/24', '410.86', 30.04, 5.73, 'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum', 657935120, '1 Crescent Oaks Pass', 4, 4.39);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('porta volutpat', '113.20.163.117/27', '470.94', 61.04, 64.17, 'in leo maecenas pulvinar lobortis est phasellus sit amet erat', 267092848, '11 Marquette Parkway', 4, 3.37);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('luctus tincidunt nulla', '24.64.119.249/11', '424.92', 44.36, 33.02, 'sapien sapien non mi integer ac neque duis bibendum morbi non quam nec', 871739574, '71 Thompson Pass', 5, 1.19);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('felis fusce', '5.56.169.86/10', '274.82', 39.36, 1.03, 'risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus', 974985628, '3 Westerfield Alley', 3, 3.25);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('pede libero', '128.75.94.142/13', '723.86', 76.36, 98.19, 'volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut', 502801049, '2359 Continental Court', 4, 1.41);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lobortis ligula sit', '123.175.197.91/13', '594.10', 87.67, 77.34, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit', 758307946, '1833 Badeau Avenue', 1, 2.69);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('enim in', '40.162.232.234/5', '466.77', 16.64, 50.99, 'vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc', 976815225, '8261 1st Circle', 4, 4.27);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('elit sodales', '81.34.141.125/23', '479.40', 94.6, 43.07, 'dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis', 889139974, '730 Thierer Alley', 4, 1.95);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('posuere cubilia', '253.195.6.13/22', '187.66', 39.62, 11.75, 'vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit', 896295665, '43674 Lakewood Gardens Parkway', 4, 4.99);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('imperdiet nullam', '113.143.176.38/31', '961.95', 40.59, 27.08, 'augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo', 347506490, '398 Canary Point', 3, 2.79);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nec dui', '30.17.47.225/13', '885.43', 45.1, 87.02, 'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu', 288157745, '5341 Schiller Street', 2, 4.8);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('aliquam convallis nunc', '71.158.230.182/22', '676.68', 75.65, 45.71, 'nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim', 114810021, '55 Debs Plaza', 4, 4.59);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('morbi a ipsum', '85.17.12.102/9', '767.72', 9.55, 62.58, 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse', 210867872, '66924 Hermina Hill', 1, 4.04);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ut suscipit a', '86.226.57.170/7', '725.58', 66.51, 82.01, 'blandit mi in porttitor pede justo eu massa donec dapibus', 715123646, '34 Coolidge Road', 1, 3.71);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('odio curabitur convallis', '64.44.153.56/11', '106.05', 58.45, 75.14, 'sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus', 411963941, '5 Green Ridge Crossing', 5, 2.31);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vel est', '26.45.100.78/11', '887.14', 78.49, 62.97, 'quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id', 581439521, '4 Graceland Road', 2, 3.39);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ligula sit amet', '51.122.72.33/14', '977.87', 48.07, 5.63, 'amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean', 349567030, '6 Mccormick Way', 4, 4.03);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('amet diam in', '169.144.68.28/8', '966.55', 76.81, 33.91, 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien', 322667983, '51882 Vera Street', 2, 2.94);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('odio in', '85.198.231.139/16', '805.08', 43.47, 96.89, 'adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer', 461351402, '5564 Browning Drive', 2, 2.06);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum velit id', '85.8.106.143/9', '775.40', 41.4, 67.7, 'praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus', 919384828, '26 Sloan Hill', 5, 1.21);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('convallis duis consequat', '131.157.80.97/11', '172.51', 59.55, 79.01, 'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis', 729001794, '12 Rieder Center', 5, 3.56);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('congue elementum in', '165.74.232.52/22', '341.42', 66.87, 93.42, 'molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst', 796331839, '06225 Pine View Parkway', 4, 2.06);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ipsum dolor sit', '188.89.189.137/19', '669.03', 56.17, 85.56, 'dolor morbi vel lectus in quam fringilla rhoncus mauris enim', 859951553, '08761 Sycamore Lane', 2, 1.06);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ultrices libero', '234.220.254.154/25', '766.47', 90.48, 53.69, 'ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum', 408703104, '63985 Pearson Lane', 1, 2.76);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('non quam', '63.63.222.177/29', '673.11', 78.09, 5.57, 'mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum', 111243728, '72 Milwaukee Street', 4, 4.35);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('dapibus dolor vel', '248.32.198.99/13', '999.44', 11.45, 44.86, 'congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat', 429187400, '16 Namekagon Pass', 1, 2.34);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('neque vestibulum', '82.167.225.251/8', '787.89', 82.27, 60.81, 'id turpis integer aliquet massa id lobortis convallis tortor risus', 498245787, '9 Montana Way', 5, 1.51);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('duis ac nibh', '237.223.180.192/4', '981.81', 43.53, 50.33, 'sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate', 138362273, '3 Dunning Avenue', 1, 1.38);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('blandit non', '220.92.21.112/5', '323.76', 38.18, 27.83, 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum', 618930506, '7 Jay Street', 1, 1.22);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('integer ac neque', '159.53.62.160/13', '980.99', 71.34, 6.5, 'eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum', 359146022, '0 Katie Pass', 2, 4.43);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ipsum integer', '84.235.34.19/14', '995.95', 50.23, 58.8, 'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie', 352847142, '209 Sachs Point', 4, 4.48);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('odio elementum', '237.23.76.226/27', '131.90', 41.18, 47.34, 'integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris', 463837124, '8762 Saint Paul Pass', 2, 3.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('donec ut', '177.151.10.129/24', '262.66', 29.54, 4.2, 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at', 558718282, '9 Bartillon Lane', 3, 4.59);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nunc proin at', '45.222.140.193/26', '279.65', 68.45, 36.11, 'pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio', 390833226, '45 Heath Point', 1, 2.33);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('erat fermentum', '138.176.252.33/4', '645.51', 96.5, 44.22, 'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat', 182986636, '358 7th Place', 4, 3.6);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sapien placerat', '179.151.105.176/18', '957.42', 52.93, 26.15, 'a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula', 390908463, '4 Sauthoff Road', 2, 1.43);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('enim leo rhoncus', '129.233.105.26/17', '842.77', 80.35, 82.62, 'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed', 684477281, '401 Jenna Street', 2, 3.61);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lectus in', '18.144.113.178/15', '653.36', 13.75, 29.62, 'proin eu mi nulla ac enim in tempor turpis nec euismod', 984947010, '67938 Artisan Trail', 5, 1.59);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mi sit', '226.251.122.19/6', '829.48', 13.26, 82.4, 'commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum', 278666952, '00 Glendale Avenue', 2, 1.14);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eu sapien', '129.252.55.131/27', '722.76', 79.87, 60.26, 'suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt', 249015849, '4 Sullivan Drive', 3, 4.8);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis orci', '147.82.64.102/13', '132.73', 2.08, 41.06, 'ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor', 711074516, '05287 Old Gate Alley', 3, 2.91);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sagittis nam congue', '157.88.58.34/17', '190.61', 24.1, 2.69, 'id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique', 815155270, '589 Carpenter Terrace', 5, 2.98);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nisi vulputate', '41.14.195.184/18', '421.35', 72.4, 31.68, 'nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor', 256544892, '1052 Buhler Circle', 2, 2.13);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sodales scelerisque', '154.161.181.168/21', '271.65', 93.67, 99.13, 'elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante', 711212740, '26 Colorado Parkway', 4, 2.15);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('pellentesque ultrices phasellus', '49.203.192.153/18', '534.79', 64.57, 73.16, 'habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit', 113751236, '1744 Summerview Lane', 2, 3.31);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('faucibus cursus', '66.34.216.243/21', '374.60', 22.16, 70.85, 'odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat', 506859125, '45 Cody Court', 1, 2.84);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ultrices libero non', '59.166.125.233/4', '677.27', 69.48, 7.21, 'vivamus in felis eu sapien cursus vestibulum proin eu mi', 861281215, '16940 Arrowood Park', 5, 1.65);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nunc proin at', '178.178.79.115/24', '166.89', 4.83, 59.9, 'dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius', 181361791, '8 Banding Avenue', 5, 4.77);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ante vivamus', '93.198.144.22/7', '663.47', 40.8, 91.71, 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis', 292786645, '33300 Sloan Alley', 3, 3.64);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ut nulla', '178.42.90.179/5', '337.84', 30.16, 18.39, 'donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu', 601431663, '1 Shopko Plaza', 2, 4.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lacus at', '102.47.173.186/13', '524.59', 38.13, 67.04, 'donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum', 126099878, '326 Mallard Place', 1, 3.84);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('porttitor lorem id', '109.22.209.166/28', '407.63', 46.27, 7.07, 'a nibh in quis justo maecenas rhoncus aliquam lacus morbi', 242816450, '105 Alpine Way', 2, 1.72);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ante ipsum', '169.40.200.159/4', '501.84', 28.4, 98.9, 'felis ut at dolor quis odio consequat varius integer ac', 676234534, '0 Cordelia Hill', 4, 4.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mi pede malesuada', '91.135.7.110/13', '856.92', 1.76, 2.86, 'amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id', 207942257, '5789 Kropf Place', 2, 2.63);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('morbi non', '126.214.15.75/3', '176.94', 23.47, 61.35, 'elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed', 419834263, '3932 Loomis Center', 3, 4.39);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('accumsan odio curabitur', '157.225.91.201/20', '491.47', 46.46, 15.84, 'ac lobortis vel dapibus at diam nam tristique tortor eu pede', 471760487, '35747 Mallory Way', 5, 1.96);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('aliquet pulvinar', '246.217.253.151/12', '395.80', 31.33, 77.05, 'in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam', 292122926, '93184 Hermina Street', 5, 2.0);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('imperdiet sapien urna', '222.161.225.84/12', '762.17', 20.0, 77.99, 'posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam', 875580934, '600 Bultman Way', 4, 3.82);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lectus vestibulum', '146.124.146.28/22', '906.77', 74.41, 31.2, 'in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum', 954831594, '2 Park Meadow Trail', 3, 4.38);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('pede justo', '85.62.57.8/26', '429.87', 60.27, 46.76, 'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit', 536964113, '48 Merry Lane', 1, 3.06);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tincidunt eu felis', '216.40.224.128/23', '926.91', 5.52, 77.5, 'eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus', 343378163, '411 Lotheville Junction', 3, 3.5);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eros suspendisse accumsan', '87.141.39.186/5', '250.22', 96.58, 58.04, 'pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id', 180498748, '2873 Ridgeview Avenue', 4, 4.15);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lectus in est', '155.221.105.76/6', '289.03', 32.07, 44.45, 'dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse', 482151425, '37 7th Street', 3, 3.01);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('morbi vel lectus', '146.52.182.51/27', '850.01', 78.33, 65.24, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula', 223528221, '35 Mifflin Street', 3, 3.25);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('convallis morbi', '51.152.169.71/4', '783.46', 40.1, 32.87, 'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', 299294854, '451 Kim Court', 4, 1.93);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('hac habitasse platea', '89.251.135.19/28', '780.67', 13.24, 10.46, 'id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at', 353949734, '6 Rockefeller Circle', 5, 2.61);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nisi vulputate nonummy', '240.168.240.193/15', '550.99', 90.5, 88.99, 'magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget', 536671329, '72 Sherman Hill', 2, 3.3);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('velit id', '169.118.126.27/23', '307.36', 74.42, 14.61, 'donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies', 536972138, '8916 Bowman Way', 2, 1.04);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('rhoncus mauris enim', '147.62.85.90/12', '305.97', 67.41, 5.81, 'eu orci mauris lacinia sapien quis libero nullam sit amet', 428448910, '79 Golden Leaf Pass', 3, 4.62);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('et tempus', '209.211.227.241/27', '165.94', 12.09, 8.34, 'suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem', 936218312, '5 Oakridge Plaza', 2, 1.47);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('magna ac consequat', '15.34.98.233/11', '538.24', 47.16, 11.48, 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 471029277, '767 Derek Parkway', 3, 4.26);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('libero convallis', '29.111.64.133/7', '403.28', 26.49, 11.91, 'nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque', 437034229, '09 Susan Crossing', 3, 1.34);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tellus nisi', '60.162.216.35/23', '203.44', 54.4, 48.33, 'suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla', 474102793, '936 Springview Road', 2, 3.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sed justo pellentesque', '87.242.66.189/8', '586.30', 22.75, 10.78, 'diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 873936492, '46 Maywood Point', 5, 2.47);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tempus vel', '243.131.142.60/25', '163.36', 55.56, 82.92, 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien', 747988640, '15092 Lake View Point', 1, 4.25);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('semper est', '167.159.200.254/12', '554.75', 20.58, 85.1, 'eleifend donec ut dolor morbi vel lectus in quam fringilla', 888285120, '82884 Sugar Crossing', 5, 3.88);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('iaculis justo in', '83.4.210.162/19', '604.10', 90.28, 52.0, 'congue elementum in hac habitasse platea dictumst morbi vestibulum velit', 983757259, '92 Holy Cross Terrace', 5, 4.65);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('primis in', '200.229.235.61/22', '525.33', 33.27, 52.56, 'dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at', 843475453, '5 Eastlawn Crossing', 5, 2.29);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sit amet', '64.218.168.144/9', '481.54', 85.19, 6.93, 'quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae', 908210572, '58 Dryden Plaza', 4, 3.14);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sapien a libero', '109.225.97.206/11', '231.92', 96.18, 41.01, 'et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit', 481144189, '90341 Chinook Trail', 4, 1.62);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sit amet', '153.23.104.129/6', '938.24', 79.45, 33.78, 'bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit', 800035440, '0 Fair Oaks Circle', 4, 2.74);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('at velit vivamus', '227.145.157.180/1', '737.07', 8.02, 94.48, 'rutrum ac lobortis vel dapibus at diam nam tristique tortor eu', 992027085, '10 Kinsman Parkway', 2, 2.15);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ac consequat metus', '244.81.19.136/24', '400.79', 47.37, 98.73, 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida', 524050982, '37853 8th Lane', 5, 1.92);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vulputate vitae', '68.211.100.120/4', '840.92', 56.59, 63.24, 'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum', 250898017, '66570 Jenna Drive', 3, 3.79);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nibh in quis', '209.147.127.251/5', '994.80', 92.2, 15.15, 'pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis', 904478385, '7 Thompson Pass', 5, 4.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nulla ut erat', '133.145.89.53/22', '577.66', 28.74, 96.4, 'quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in', 915320367, '67 Division Trail', 3, 3.28);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eu orci', '125.165.141.212/16', '968.74', 39.78, 12.08, 'at turpis a pede posuere nonummy integer non velit donec diam neque', 241352033, '7 Novick Alley', 2, 3.97);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nunc purus', '111.101.230.16/11', '819.02', 6.75, 84.62, 'luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse', 284242809, '8 Spenser Junction', 5, 3.06);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum quam sapien', '12.51.231.221/31', '166.15', 7.48, 90.07, 'vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor', 791434227, '621 Oak Trail', 1, 2.6);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nulla tempus', '3.183.202.28/11', '328.83', 77.79, 65.11, 'eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum', 941469579, '88 Ramsey Point', 1, 4.11);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nisi vulputate', '27.61.115.209/22', '295.28', 89.89, 3.31, 'ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a', 188185598, '126 Wayridge Alley', 3, 4.23);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('amet nunc', '203.103.79.211/21', '845.89', 92.86, 53.9, 'pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus', 984910235, '44 Service Parkway', 5, 3.9);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('orci mauris lacinia', '207.245.191.47/4', '733.46', 63.29, 16.17, 'dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean', 359035841, '26497 Evergreen Street', 1, 1.65);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('posuere metus', '179.92.51.4/1', '136.42', 8.1, 11.72, 'donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum', 607327102, '0 Washington Avenue', 4, 1.62);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ac lobortis', '243.101.66.88/19', '390.48', 52.13, 29.14, 'nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate', 542932048, '91741 Melody Way', 3, 1.95);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tempus semper est', '131.207.4.233/10', '875.16', 82.47, 68.35, 'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu', 405390236, '640 Forest Run Lane', 1, 3.4);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mauris laoreet', '210.38.201.69/23', '499.96', 41.83, 71.12, 'eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis', 494132450, '46017 Heffernan Drive', 3, 3.2);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('parturient montes', '178.169.39.142/5', '274.69', 52.78, 6.89, 'convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum', 912762709, '1 Lake View Pass', 1, 3.52);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('id nulla ultrices', '53.70.7.253/29', '985.19', 46.66, 30.85, 'mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam', 293110926, '41 Stoughton Alley', 1, 4.09);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sit amet sem', '191.12.136.58/13', '185.00', 80.5, 97.7, 'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis', 359289890, '79562 La Follette Place', 5, 4.16);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tincidunt eget tempus', '77.14.227.81/10', '300.08', 4.11, 87.87, 'eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in', 226833289, '2 Alpine Road', 2, 4.22);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('cubilia curae', '160.18.12.244/23', '395.11', 70.92, 49.69, 'lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum', 738983579, '52351 Prairieview Road', 3, 3.05);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('adipiscing lorem vitae', '80.110.106.174/22', '325.93', 66.41, 82.9, 'ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo', 915940915, '8 Petterle Place', 4, 2.81);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mi sit amet', '222.110.98.145/7', '201.48', 15.26, 16.06, 'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis', 814463134, '9795 Bashford Crossing', 4, 4.89);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('duis bibendum felis', '67.68.101.85/4', '266.24', 44.54, 42.12, 'cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis', 118860773, '46 Clove Terrace', 1, 1.49);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('blandit non', '127.18.186.54/18', '461.91', 16.0, 63.56, 'libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in', 544796410, '07 Arrowood Junction', 3, 2.6);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ullamcorper augue a', '87.207.2.234/14', '136.58', 71.88, 71.8, 'in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices', 815852249, '37037 Arkansas Way', 4, 2.68);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('augue luctus tincidunt', '40.79.113.33/13', '858.76', 88.6, 6.36, 'malesuada in imperdiet et commodo vulputate justo in blandit ultrices', 506612384, '24458 Armistice Drive', 2, 1.8);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('luctus et', '222.38.65.44/9', '841.85', 97.69, 46.26, 'erat fermentum justo nec condimentum neque sapien placerat ante nulla justo', 153032871, '62603 Oneill Terrace', 2, 4.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('donec dapibus duis', '200.29.82.37/31', '428.37', 18.04, 60.06, 'mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea', 566856376, '8657 Autumn Leaf Avenue', 1, 4.19);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('dui proin', '30.247.91.248/21', '800.43', 79.08, 94.5, 'dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam', 221309506, '7792 Gina Way', 2, 2.32);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('habitasse platea dictumst', '170.161.94.142/12', '632.00', 91.83, 81.41, 'a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis', 336688983, '02 Pierstorff Trail', 2, 1.43);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vulputate nonummy', '30.172.172.176/11', '566.90', 84.03, 28.85, 'tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante', 171006281, '2621 Armistice Avenue', 2, 1.37);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('erat nulla', '90.190.197.128/7', '961.42', 81.43, 88.04, 'vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan', 367214017, '30 Towne Crossing', 5, 4.84);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('luctus nec molestie', '127.183.198.224/11', '852.47', 63.34, 45.77, 'etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id', 456790887, '7656 Golf Place', 4, 4.74);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('pellentesque eget nunc', '180.74.203.128/21', '481.21', 64.51, 64.16, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in', 506371676, '95 Gulseth Street', 4, 2.12);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ante ipsum', '120.83.86.238/16', '722.52', 90.87, 33.85, 'eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea', 529472557, '3 Laurel Parkway', 2, 1.6);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in hac', '60.110.80.152/3', '787.27', 44.3, 83.18, 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis', 608804711, '8914 Garrison Court', 1, 2.76);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('blandit ultrices', '235.245.250.211/13', '585.72', 89.67, 69.16, 'ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus', 684656790, '0 Cody Terrace', 3, 1.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('parturient montes nascetur', '12.250.50.214/10', '281.50', 52.53, 62.39, 'ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis', 996916887, '00 Norway Maple Circle', 3, 1.23);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('aliquam augue quam', '167.92.166.114/31', '292.43', 78.26, 13.01, 'amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras', 140432069, '012 Corry Trail', 5, 2.05);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('odio elementum', '233.193.63.51/28', '589.40', 79.73, 64.75, 'turpis enim blandit mi in porttitor pede justo eu massa donec dapibus', 522049094, '2 David Point', 1, 1.56);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vivamus metus arcu', '218.189.228.238/28', '672.27', 54.98, 64.37, 'at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum', 265982525, '3014 Mayer Pass', 2, 3.07);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('molestie hendrerit', '149.253.26.110/4', '625.50', 32.51, 8.33, 'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet', 301964720, '7819 Summit Pass', 4, 4.37);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vel ipsum', '203.90.20.27/31', '556.25', 7.3, 18.12, 'at turpis a pede posuere nonummy integer non velit donec diam', 902182873, '8217 Carberry Terrace', 5, 1.48);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('amet cursus', '95.74.241.10/4', '514.14', 30.56, 93.37, 'orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu', 697878711, '158 Burning Wood Plaza', 3, 4.63);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis orci eget', '227.219.50.3/30', '132.12', 53.19, 85.38, 'a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis', 254161253, '06016 Hovde Road', 1, 2.0);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum sagittis sapien', '154.120.236.248/3', '694.46', 99.2, 1.62, 'ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam', 186171923, '865 Cottonwood Court', 1, 2.82);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('augue aliquam', '136.101.166.196/24', '360.93', 70.94, 46.91, 'integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis', 548555849, '32 Susan Alley', 3, 5.0);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('libero quis orci', '16.80.119.216/26', '501.34', 9.56, 28.45, 'nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare', 875315900, '874 Eagan Point', 2, 1.48);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sit amet cursus', '238.115.86.44/23', '634.32', 71.72, 75.53, 'nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec', 620943847, '24003 Old Shore Avenue', 1, 2.79);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in libero ut', '98.12.230.113/6', '844.15', 2.86, 25.4, 'metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 449742489, '8 Fairfield Junction', 2, 1.44);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nam ultrices libero', '250.206.199.238/4', '267.41', 22.33, 30.05, 'pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis', 892674544, '1709 Hollow Ridge Circle', 1, 1.28);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis orci', '44.98.139.45/22', '623.41', 2.42, 68.05, 'nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin', 878810994, '16 Fairview Alley', 4, 2.32);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('libero rutrum', '101.14.7.132/6', '901.26', 13.77, 98.46, 'enim in tempor turpis nec euismod scelerisque quam turpis adipiscing', 776024644, '4 7th Drive', 5, 3.04);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ante vivamus tortor', '127.204.70.82/20', '568.96', 63.79, 36.65, 'augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc', 328834421, '51 Pepper Wood Circle', 3, 1.18);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('augue aliquam erat', '181.207.140.185/5', '216.64', 85.82, 8.92, 'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus', 399359764, '67626 Carpenter Terrace', 3, 4.39);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quisque erat', '220.19.210.117/28', '510.76', 30.72, 14.9, 'sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus', 439010102, '7170 Basil Avenue', 8, 2.9);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('at turpis donec', '248.31.173.120/2', '352.18', 93.21, 15.19, 'in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum', 772295285, '0 Chive Drive', 8, 1.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('elementum ligula', '114.161.4.180/11', '128.31', 55.21, 2.98, 'in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem', 346480652, '59491 Kingsford Avenue', 8, 2.51);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('diam nam', '151.132.167.97/20', '341.78', 92.84, 7.23, 'convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices', 222095846, '3 Hoepker Center', 8, 4.62);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('erat tortor', '97.213.98.208/19', '609.27', 33.0, 43.89, 'ut odio cras mi pede malesuada in imperdiet et commodo vulputate', 990055597, '824 Doe Crossing Park', 8, 2.99);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('erat quisque', '64.38.52.38/19', '183.41', 71.99, 68.51, 'elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum', 173267715, '90 David Avenue', 8, 1.12);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('rhoncus aliquam', '203.158.246.114/21', '671.87', 29.82, 27.79, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in', 190970930, '383 Coleman Hill', 8, 1.05);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ut tellus', '178.14.14.253/14', '553.52', 95.67, 83.58, 'rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet', 728384911, '24 Coleman Center', 8, 3.9);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('iaculis justo in', '135.65.136.162/18', '529.21', 28.54, 11.57, 'porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor', 447707110, '5 Luster Avenue', 8, 2.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('pretium nisl', '70.66.91.183/5', '826.89', 33.55, 35.47, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet', 814461047, '56883 Ronald Regan Center', 8, 4.97);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lacus purus aliquet', '180.129.83.245/7', '862.05', 65.19, 81.37, 'mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum', 728689500, '356 Sommers Circle', 8, 1.44);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('magna vulputate', '116.130.138.242/28', '626.53', 28.65, 57.83, 'sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus', 576691375, '661 Waxwing Way', 8, 4.79);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('viverra eget', '179.155.253.9/4', '975.53', 42.42, 76.22, 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna', 777873631, '43 Cardinal Plaza', 8, 2.33);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in hac habitasse', '45.247.203.35/11', '724.05', 97.07, 98.15, 'posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue', 967758755, '6 Cardinal Alley', 8, 3.89);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tortor eu', '246.219.153.32/1', '658.55', 26.99, 37.66, 'tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla', 640969560, '3 Manufacturers Point', 8, 1.51);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nulla eget eros', '89.22.44.28/29', '792.33', 75.7, 73.93, 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis', 571074979, '18738 Alpine Trail', 8, 2.97);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('posuere nonummy', '198.170.9.64/5', '967.30', 2.45, 45.81, 'id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue', 506869850, '3 Pepper Wood Pass', 8, 1.17);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tincidunt nulla', '226.229.92.195/16', '464.31', 75.1, 46.79, 'nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus', 147297508, '5 Redwing Street', 8, 3.83);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sem praesent', '199.109.33.182/24', '645.95', 27.26, 84.5, 'libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras', 885694757, '66 Linden Way', 8, 1.52);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('aenean auctor gravida', '83.87.237.226/10', '973.59', 64.97, 77.83, 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue', 484265450, '985 Washington Circle', 8, 4.42);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sed interdum venenatis', '36.114.188.144/24', '226.11', 88.58, 91.29, 'duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero', 477935766, '1 Sutteridge Court', 8, 2.33);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ligula vehicula consequat', '180.126.88.134/13', '201.21', 40.19, 95.72, 'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in', 712909836, '323 Fairview Lane', 8, 3.61);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('dapibus at', '229.10.113.135/25', '243.57', 27.86, 70.75, 'ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl', 772671351, '99 Loeprich Alley', 8, 3.31);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nisl ut', '118.23.188.136/15', '366.08', 39.82, 34.85, 'odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet', 610304738, '13517 Westend Street', 8, 4.46);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('porttitor lorem', '231.58.57.68/29', '145.52', 47.92, 97.78, 'sapien sapien non mi integer ac neque duis bibendum morbi non quam nec', 830626927, '48 Eliot Trail', 8, 4.19);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eu interdum', '28.254.103.42/16', '720.44', 19.6, 71.4, 'sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus', 520670949, '424 Jana Park', 8, 1.21);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('enim sit amet', '240.208.221.118/3', '797.79', 88.79, 49.88, 'lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo', 965083153, '66478 Bartelt Parkway', 8, 2.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('integer tincidunt ante', '206.194.103.49/19', '189.83', 17.76, 3.3, 'massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet', 143096340, '7 Burrows Trail', 8, 4.47);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('interdum in ante', '21.209.7.137/22', '668.76', 2.01, 98.13, 'donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla', 698017081, '4 Lunder Drive', 8, 4.17);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('enim sit', '199.5.153.33/25', '197.34', 29.99, 31.29, 'platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat', 436729906, '8 Oak Drive', 8, 4.01);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in tempus sit', '237.246.51.235/8', '537.25', 46.88, 40.73, 'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend', 549428571, '694 Fremont Lane', 8, 3.99);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('id lobortis convallis', '250.202.12.187/18', '742.30', 69.33, 94.83, 'blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel', 941741037, '18 Merrick Court', 8, 4.2);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in porttitor pede', '130.143.78.201/3', '755.46', 84.92, 34.29, 'lobortis sapien sapien non mi integer ac neque duis bibendum morbi', 775693542, '56631 John Wall Trail', 8, 3.77);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in faucibus', '114.205.54.49/23', '129.87', 41.92, 56.34, 'purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat', 972703813, '2 Kim Road', 8, 2.94);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ultrices libero non', '227.198.181.24/13', '464.04', 57.74, 7.82, 'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at', 113347587, '883 Utah Road', 8, 3.35);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('diam id', '209.184.57.117/26', '232.84', 45.19, 44.33, 'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in', 361855784, '9 Crownhardt Terrace', 8, 3.94);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('duis consequat', '19.253.35.200/5', '437.99', 99.66, 2.32, 'odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla', 555287992, '53894 Roxbury Parkway', 8, 3.73);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mus vivamus', '151.14.166.60/24', '780.42', 50.14, 3.6, 'etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus', 945948751, '7179 Delladonna Lane', 8, 2.67);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('turpis enim', '54.61.30.171/15', '356.99', 92.98, 99.88, 'leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue', 284962544, '3955 Walton Junction', 8, 4.29);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum sed', '203.87.241.142/28', '879.10', 89.11, 32.93, 'pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper', 346056711, '73 Division Hill', 8, 4.94);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('luctus tincidunt', '203.201.144.154/4', '641.15', 74.74, 43.18, 'quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus', 920969385, '5471 Rowland Parkway', 8, 1.51);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vivamus tortor', '18.18.60.128/23', '355.95', 33.08, 82.8, 'vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa', 129992651, '0 Lillian Hill', 8, 2.15);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sollicitudin mi sit', '97.124.239.238/25', '398.01', 15.43, 89.24, 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem', 448035957, '6 Marcy Lane', 8, 3.96);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in lacus', '216.131.134.98/11', '682.62', 67.81, 31.95, 'erat nulla tempus vivamus in felis eu sapien cursus vestibulum', 469271981, '7434 Debs Junction', 8, 4.37);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('volutpat erat quisque', '47.220.193.122/23', '260.85', 66.0, 17.84, 'faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at', 795794849, '939 Elka Court', 8, 2.31);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('integer ac', '61.170.143.129/5', '529.75', 93.96, 32.06, 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat', 806005715, '78 Straubel Point', 8, 1.43);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ligula suspendisse', '147.45.2.241/28', '514.24', 76.16, 71.77, 'volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante', 399293935, '49779 Kings Lane', 8, 2.61);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis tortor id', '23.102.235.31/3', '271.39', 27.1, 2.62, 'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante', 481383231, '3039 Butterfield Center', 8, 1.16);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mauris ullamcorper purus', '66.250.90.199/18', '992.53', 13.86, 20.33, 'morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla', 899451422, '933 Anzinger Street', 8, 2.87);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quam turpis adipiscing', '78.21.5.63/15', '816.20', 46.23, 64.64, 'dolor morbi vel lectus in quam fringilla rhoncus mauris enim', 709758459, '888 Comanche Park', 8, 1.82);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('morbi sem mauris', '34.206.69.101/9', '757.22', 35.58, 5.35, 'vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis', 122153370, '497 Lakeland Junction', 8, 4.87);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('justo pellentesque viverra', '249.180.211.55/16', '358.54', 82.19, 34.38, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum', 207546444, '90 Waywood Hill', 8, 4.75);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mauris ullamcorper purus', '248.176.87.134/4', '223.92', 32.38, 57.29, 'praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum', 823286112, '75 Waxwing Trail', 8, 2.67);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in eleifend', '66.129.47.182/30', '283.50', 82.25, 30.04, 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit', 604328999, '2 Messerschmidt Lane', 8, 1.96);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('est donec odio', '19.53.89.114/28', '495.56', 87.02, 78.35, 'cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla', 564041788, '8656 Bartillon Plaza', 8, 3.67);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eros vestibulum ac', '159.52.226.33/9', '420.76', 30.25, 21.5, 'posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed', 205690703, '3035 Hoepker Circle', 8, 3.76);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('orci pede venenatis', '31.119.241.7/5', '584.67', 11.33, 94.77, 'non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut', 939570712, '372 Merry Hill', 8, 3.08);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nec nisi', '115.212.221.66/2', '370.39', 94.29, 90.25, 'in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur', 327821491, '99 Valley Edge Crossing', 8, 4.48);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('elementum in', '104.221.102.231/31', '881.12', 12.48, 84.95, 'nisl aenean lectus pellentesque eget nunc donec quis orci eget', 166853145, '414 Schmedeman Way', 8, 3.85);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('quis orci nullam', '105.243.190.71/1', '809.57', 47.39, 1.51, 'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla', 544178052, '9914 Rowland Junction', 8, 4.48);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('luctus et ultrices', '32.224.175.228/11', '623.07', 51.33, 99.58, 'consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi', 394123430, '30 Vidon Crossing', 8, 4.42);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget congue eget', '130.164.139.213/24', '379.68', 96.8, 50.56, 'at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus', 407871201, '11302 Grim Center', 8, 4.34);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ac neque duis', '38.100.250.87/25', '267.55', 7.81, 50.44, 'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum', 933793908, '0 Talisman Trail', 8, 3.79);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('venenatis turpis', '37.248.16.165/19', '613.02', 35.97, 74.64, 'eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus', 164492783, '8891 Thompson Road', 8, 4.13);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('non mattis pulvinar', '216.225.63.175/18', '196.82', 87.78, 84.65, 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis', 721034848, '4255 Arapahoe Alley', 8, 1.48);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('accumsan tellus', '58.123.22.216/20', '862.43', 43.05, 52.24, 'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem', 766465932, '007 Dexter Road', 8, 1.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sapien varius ut', '81.220.124.225/6', '454.11', 98.81, 95.03, 'vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla', 464594607, '5 Sachtjen Trail', 8, 3.88);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('felis fusce', '116.62.212.243/31', '463.89', 35.57, 48.63, 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus', 460827474, '539 Myrtle Alley', 8, 3.81);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('venenatis non sodales', '24.106.191.218/28', '382.59', 40.71, 57.42, 'blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing', 915509380, '39026 Declaration Parkway', 8, 3.22);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('platea dictumst', '75.217.31.119/16', '597.24', 33.58, 38.54, 'sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate', 284318415, '3969 Fulton Court', 8, 3.82);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('elementum nullam', '237.44.23.99/27', '275.07', 48.79, 30.25, 'eget eleifend luctus ultricies eu nibh quisque id justo sit', 447449151, '53590 Katie Plaza', 8, 1.43);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sapien quis libero', '5.173.215.142/6', '426.98', 39.98, 50.46, 'quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam', 626558548, '61 Everett Drive', 8, 1.8);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in hac habitasse', '143.101.155.198/12', '305.51', 54.39, 54.33, 'est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac', 904738982, '18930 Dwight Hill', 8, 4.32);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vitae nisi nam', '167.168.73.175/28', '129.74', 30.42, 96.36, 'luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien', 983240134, '16415 Northwestern Place', 8, 3.76);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sed tristique', '82.254.143.216/12', '181.99', 40.13, 19.13, 'in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo', 858983842, '211 Katie Pass', 8, 3.85);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('id ornare', '7.78.201.199/21', '209.00', 65.89, 90.56, 'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed', 335240918, '8 Farwell Crossing', 8, 3.07);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('mauris eget massa', '49.154.252.241/5', '865.29', 64.08, 69.44, 'nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut', 668895171, '4250 Arizona Lane', 8, 4.59);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('curae duis', '214.238.187.86/1', '576.34', 57.64, 24.89, 'orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus', 140729471, '461 West Alley', 8, 4.12);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('morbi ut odio', '87.100.180.240/8', '223.13', 12.78, 91.78, 'vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget', 814088300, '5 Rockefeller Terrace', 8, 4.52);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in faucibus orci', '39.123.23.12/11', '692.96', 66.47, 11.49, 'tincidunt eget tempus vel pede morbi porttitor lorem id ligula', 535201786, '0 Anniversary Trail', 8, 3.27);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ultrices posuere cubilia', '37.130.54.36/19', '338.67', 54.96, 44.19, 'ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit', 502625367, '31 Reinke Plaza', 8, 3.44);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tempus sit', '237.127.39.242/21', '840.84', 27.58, 44.36, 'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum', 312611318, '248 Melody Court', 8, 4.03);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('non mattis pulvinar', '70.216.83.123/23', '622.16', 96.99, 90.5, 'dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero', 131433102, '4 Calypso Alley', 8, 1.82);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('eget eros', '90.125.121.90/2', '945.60', 26.09, 78.66, 'amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla', 395160815, '61 Loeprich Center', 8, 4.7);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('donec semper', '160.32.50.77/4', '884.03', 77.63, 97.17, 'eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio', 344426481, '3 Holy Cross Park', 8, 2.68);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sed vel enim', '73.94.153.140/8', '711.33', 47.55, 66.92, 'hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum', 585500190, '849 Eliot Lane', 8, 2.55);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('lacinia aenean', '211.10.139.92/12', '104.84', 39.29, 85.88, 'congue risus semper porta volutpat quam pede lobortis ligula sit', 736522651, '20938 Fairview Trail', 8, 4.27);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('vestibulum quam sapien', '142.175.81.20/19', '315.18', 53.72, 45.17, 'lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea', 190872595, '08763 Fulton Parkway', 8, 4.62);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nisl nunc', '144.166.158.56/13', '494.61', 38.11, 54.22, 'tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas', 988086257, '22838 Hansons Center', 8, 3.54);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('penatibus et', '101.70.159.236/13', '117.28', 75.71, 15.51, 'pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus', 978509131, '28617 Green Terrace', 8, 2.58);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nulla dapibus dolor', '60.133.250.238/5', '291.51', 19.42, 73.49, 'ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus', 992810405, '019 Dennis Avenue', 8, 1.36);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ultrices posuere cubilia', '123.30.165.220/28', '601.29', 88.88, 96.46, 'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat', 517571541, '67 Basil Circle', 8, 3.27);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('velit eu', '53.150.62.51/14', '619.11', 92.75, 25.55, 'sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae', 711179671, '67711 Autumn Leaf Road', 8, 4.06);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('nunc viverra dapibus', '148.202.149.141/19', '723.70', 39.35, 98.61, 'sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque', 838000518, '35 Gulseth Center', 8, 2.8);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('hac habitasse platea', '95.87.111.158/1', '957.41', 73.83, 11.85, 'integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui', 564747146, '17590 New Castle Junction', 8, 2.19);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('magna vulputate', '249.192.125.67/20', '445.62', 79.98, 34.67, 'id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue', 170279555, '0 Johnson Pass', 8, 1.71);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('morbi vel lectus', '80.130.128.252/25', '126.46', 33.65, 55.36, 'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec', 210495435, '1 Hazelcrest Circle', 8, 3.95);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('proin eu', '114.86.190.74/7', '248.40', 57.27, 55.49, 'sit amet eleifend pede libero quis orci nullam molestie nibh in', 228864186, '17 Longview Drive', 8, 4.35);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('praesent blandit', '102.191.57.224/24', '686.57', 44.32, 82.79, 'non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu', 655721487, '9 Debs Park', 8, 2.76);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('massa id lobortis', '170.202.101.23/16', '800.35', 65.91, 81.0, 'odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus', 937001368, '7767 Lakewood Place', 8, 4.73);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('tempus semper', '145.33.219.110/15', '970.87', 63.2, 61.88, 'a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla', 851594906, '50032 Everett Drive', 8, 2.8);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('in est risus', '142.181.35.201/4', '817.94', 24.25, 79.41, 'consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum', 506722886, '50 Cambridge Pass', 8, 3.64);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('ante ipsum primis', '109.60.86.23/3', '874.11', 55.43, 29.57, 'lorem quisque ut erat curabitur gravida nisi at nibh in', 419703468, '2936 Chive Pass', 8, 2.86);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('posuere cubilia curae', '186.105.141.197/20', '830.90', 19.13, 43.38, 'maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi', 439833740, '53 Crowley Drive', 8, 3.84);
insert into locales (nom_local, img_local, precio_local, lat_local, long_local, descrip_local, telf_local, direc_local, id_estado, ranking) values ('sollicitudin mi', '12.112.59.221/10', '708.51', 50.36, 75.33, 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus', 538645968, '7 Dayton Drive', 8, 3.79);
