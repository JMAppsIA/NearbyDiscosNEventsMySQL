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

insert into personas
values ('1', 'Marlong', 'Cesar', 'Cubas', 'Nuñez', 'Marlong Cesar Cubas Nuñez', 2, '71642931', '1995/12/07', '24', '5570064', 'Av El Retablo', 'M'),
('2', 'Jorge', 'Martin', 'Herrera', 'Tume', 'Jorge Martin Herrera Tume', 2, '71642940', '1995/08/11', '24', '589623654', 'Carabayllo', 'M'),
('3', 'Juan', 'JJJJ', 'Ortiz', 'Tume', 'Juan Ortiz Tume', 2, '71642941', '1995/08/11', '24', '58962', 'Carabayllo', 'M'),
('4', 'Mario', 'Luis', 'Parra', 'Lopez', 'Mario Luis Parra Lopez', 2, '71642910', '1995/12/07', '24', '5571552', 'Comas', 'M'),
('5', 'Mario', '---', 'Parra', 'Lopez', 'Mario Luis Parra Lopez', 2, '71742910', '1995/12/07', '24', '5571552', 'Comas', 'M'),
('6', 'Macarena', 'Luis', 'Montoya', 'Lopez', 'Macarena Luis Montoya Lopez', 2, '71644910', '1995/12/07', '24', '5571552', 'Comas', 'M'),
('7', 'Tulio', 'Enrique', 'Parra', 'Lopez', 'Tulio Enrique Parra Lopez', 2, '71642930', '1995/12/07', '24', '5571552', 'Comas', 'M');


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
  `id_local` INT NOT NULL,
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
  PRIMARY KEY (`id_local`),
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
CHANGE COLUMN `nom_comp` `nom_comp` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `tip_doc` `tip_doc` INT NOT NULL,
CHANGE COLUMN `num_doc` `num_doc` VARCHAR(12) NOT NULL,
CHANGE COLUMN `fec_nac` `fec_nac` DATE NOT NULL ,
CHANGE COLUMN `genero_per` `genero_per` CHAR NOT NULL,
CHANGE COLUMN `nom_comp` `nom_comp` VARCHAR(120) NOT NULL ;

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
IN `genre` CHAR(1), IN `idUser` INT, IN `userName` VARCHAR(45),
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

CREATE TABLE tipo_doc
(
id INT PRIMARY KEY AUTO_INCREMENT,
descripcion VARCHAR(200)
);

INSERT INTO tipo_doc(descripcion) values ('DNI'),('C.E.');

delete from usuarios;
delete from personas;

ALTER TABLE personas
add CONSTRAINT `id_tipo_doc_persona`
FOREIGN KEY personas(tip_doc)
REFERENCES tipo_doc (id) on update no action on delete no action;

DELIMITER ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;