-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nearbydiscosnevents
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `nearbydiscosnevents` DEFAULT CHARACTER SET utf8 ;
USE `nearbydiscosnevents` ;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`estados` (
`id_estado` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`nom_estado` VARCHAR  (45) NOT NULL
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`personas` (
  `id_per` INT NOT NULL AUTO_INCREMENT,
  `pri_nomb` TEXT(45) NOT NULL,
  `seg_nomb` TEXT(45) NOT NULL,
  `pri_apel` TEXT(45) NOT NULL,
  `seg_apel` TEXT(45) NOT NULL,
  `nom_comp` TEXT(100) NOT NULL,
  `tip_doc` TEXT(50) NOT NULL,
  `num_doc` INT NOT NULL,
  `fec_nac` DATETIME NOT NULL,
  `edad` INT NOT NULL,
  `telf` INT NOT NULL,
  `direc_per` VARCHAR(45) NOT NULL,
  `genero_per` TEXT(20) NOT NULL,
  PRIMARY KEY (`id_per`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`usuarios` (
  `id_usu` INT NOT NULL AUTO_INCREMENT,
  `id_per` INT NOT NULL,
  `nom_usu` TEXT(45) NOT NULL,
  `pass_usu` VARCHAR(45) NOT NULL,
  `email_usu` VARCHAR(45) NOT NULL,
  `telf_usu` INT NOT NULL,
  `origen_usu` TEXT(40) NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_usu`),
  UNIQUE INDEX `pass_usu_UNIQUE` (`pass_usu` ASC) VISIBLE,
  UNIQUE INDEX `email_usu_UNIQUE` (`email_usu` ASC) VISIBLE,
  INDEX `id_per_idx` (`id_per` ASC) VISIBLE,
  CONSTRAINT `id_per`
    FOREIGN KEY (`id_per`)
    REFERENCES `nearbydiscosnevents`.`personas` (`id_per`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_estado_usuarios`
    FOREIGN KEY (`id_estado`)
    REFERENCES `nearbydiscosnevents`.`estados` (`id_estado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`locales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`locales` (
  `id_local` INT NOT NULL,
  `nom_local` VARCHAR(45) NOT NULL,
  `img_local` VARCHAR(45) NOT NULL,
  `precio_local` FLOAT NOT NULL,
  `lat_local` FLOAT NOT NULL,
  `long_local` FLOAT NOT NULL,
  `descrip_local` VARCHAR(500) NOT NULL,
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
    REFERENCES `nearbydiscosnevents`.`estados` (`id_estado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`votacion_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`votacion_local`(
`id_votacion_local` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`votacion` INT NOT NULL,
`id_usu` INT NOT NULL,
`id_local` INT NOT NULL,
`fecha_votacion` DATE NOT NULL,
CONSTRAINT `id_usu_votacion_local`
    FOREIGN KEY (`id_usu`)
    REFERENCES `nearbydiscosnevents`.`usuario` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT `id_local_votacion_local`
    FOREIGN KEY (`id_local`)
    REFERENCES `nearbydiscosnevents`.`locales` (`id_local`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
) ;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`horarios_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`horarios_local` (
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
-- Table `nearbydiscosnevents`.`catering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`catering` (
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
    REFERENCES `nearbydiscosnevents`.`estados` (`id_estado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    )
    
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`locales_has_catering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`locales_has_catering` (
  `locales_id_local` INT NOT NULL,
  `catering_id_cater` INT NOT NULL,
  PRIMARY KEY (`locales_id_local`, `catering_id_cater`),
  INDEX `fk_locales_has_catering_catering1_idx` (`catering_id_cater` ASC) VISIBLE,
  INDEX `fk_locales_has_catering_locales1_idx` (`locales_id_local` ASC) VISIBLE,
  CONSTRAINT `fk_locales_has_catering_locales1`
    FOREIGN KEY (`locales_id_local`)
    REFERENCES `nearbydiscosnevents`.`locales` (`id_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locales_has_catering_catering1`
    FOREIGN KEY (`catering_id_cater`)
    REFERENCES `nearbydiscosnevents`.`catering` (`id_cater`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`shows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`shows` (
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
    REFERENCES `nearbydiscosnevents`.`locales` (`id_local`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT `id_estado_shows`
    FOREIGN KEY (`id_estado`)
    REFERENCES `nearbydiscosnevents`.`estados` (`id_estado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`categ_prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`categ_prod` (
  `id_cat_prod` INT NOT NULL AUTO_INCREMENT,
  `nom_cat_prod` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cat_prod`)
  )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`productos` (
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
    REFERENCES `nearbydiscosnevents`.`catering` (`id_cater`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `nearbydiscosnevents`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_cat_prod_productos`
    FOREIGN KEY (`id_cat_prod`)
    REFERENCES `nearbydiscosnevents`.`categ_prod` (`id_cat_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`orden_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`orden_detalle`(
	`id_orden_detalle` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `id_local` INT NOT NULL,
    `id_prod` INT NOT NULL,
    `id_show` INT NOT NULL,
    CONSTRAINT `id_local_orden_detalle`
    FOREIGN KEY (`id_local`)
    REFERENCES `nearbydiscosnevents`.`locales` (`id_local`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT `id_prod_orden_detalle`
    FOREIGN KEY (`id_prod`)
    REFERENCES `nearbydiscosnevents`.`productos` (`id_prod`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT `id_show_orden_detalle`
    FOREIGN KEY (`id_show`)
    REFERENCES `nearbydiscosnevents`.`shows` (`id_show`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`orden_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`orden_compra` (
  `id_orden` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `usuarios_id_usu` INT NOT NULL,
  `fecha_orden` DATETIME NOT NULL,
  `id_orden_detalle` INT NOT NULL,
  CONSTRAINT `id_orden_detalle_orden_compra`
  FOREIGN KEY (`id_orden_detalle`)
  REFERENCES `nearbydiscosnevents`.`orden_detalle` (`id_orden_detalle`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`entidad_bancaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `entidad_bancaria`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`descripcion` VARCHAR(45)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`tipo_tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_tarjeta`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`descripcion` VARCHAR(45)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`tarjeta_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`tarjeta_usuario` (
  `id_tarjeta` INT NOT NULL,
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
    REFERENCES `nearbydiscosnevents`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
   CONSTRAINT `id_entidad_bancaria_tarjeta_usuario`
	FOREIGN KEY (`id_entidad_bancaria`)
    REFERENCES `nearbydiscosnevents`.`entidad_bancaria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_tipo_tarjeta_tarjeta_usuario`
	FOREIGN KEY (`id_tipo_tarjeta`)
    REFERENCES `nearbydiscosnevents`.`tipo_tarjeta` (`id`)
    ON DELETE NO ACTION
	ON UPDATE NO ACTION
    )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`reserva_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`reserva_detalle`(
`id_reserva_detalle` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`descripcion` INT NOT NULL,
`id_local` INT NOT NULL,
`id_prod` INT NOT NULL,
`id_show` INT NOT NULL,
`id_horarios_local` INT NOT NULL,
`fecha_reserva` DATETIME NOT NULL,
CONSTRAINT `id_local_reserva_detalle`
FOREIGN KEY (`id_local`)
REFERENCES `nearbydiscosnevents`.`locales` (`id_local`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `id_prod_reserva_detalle`
FOREIGN KEY (`id_prod`)
REFERENCES `nearbydiscosnevents`.`productos`  (`id_prod`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `id_show_reserva_detalle`
FOREIGN KEY (`id_show`)
REFERENCES `nearbydiscosnevents`.`shows`  (`id_show`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `id_horarios_local_reserva_detalle`
FOREIGN KEY (`id_horarios_local`)
REFERENCES `nearbydiscosnevents`.`horarios_local`  (`id_horarios_local`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `nearbydiscosnevents`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nearbydiscosnevents`.`reserva` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id_usu` INT NOT NULL,
  `id_estado` INT NOT NULL,
  `id_reserva_detalle` INT NOT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reserva_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  UNIQUE INDEX `id_reserva_UNIQUE` (`id_reserva` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `nearbydiscosnevents`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_reserva_detalle`
    FOREIGN KEY (`id_reserva_detalle`)
    REFERENCES `nearbydiscosnevents`.`reserva.detalle` (`id_reserva_detalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `id_estado_reserva`
    FOREIGN KEY (`id_estado`)
    REFERENCES `nearbydiscosnevents`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;

ALTER TABLE `nearbydiscosnevents`.`personas` 
CHANGE COLUMN `pri_nomb` `pri_nomb` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `seg_nomb` `seg_nomb` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `pri_apel` `pri_apel` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `seg_apel` `seg_apel` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `nom_comp` `nom_comp` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `tip_doc` `tip_doc` INT NOT NULL,
CHANGE COLUMN `num_doc` `num_doc` VARCHAR(12) NOT NULL,
CHANGE COLUMN `fec_nac` `fec_nac` DATE NOT NULL ,
CHANGE COLUMN `genero_per` `genero_per` CHAR NOT NULL ;

ALTER TABLE `nearbydiscosnevents`.`personas`
DROP COLUMN `telf`;

ALTER TABLE `nearbydiscosnevents`.`usuarios` 
CHANGE COLUMN `nom_usu` `nom_usu` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `origen_usu` `origen_usu` VARCHAR(10) NOT NULL ;



DROP procedure IF EXISTS `SP_USER_GLOBAL`;

DELIMITER $$
USE `nearbydiscosnevents`$$
CREATE PROCEDURE `SP_USER_GLOBAL` (IN `vAccion` VARCHAR(45),
IN `idPerson` INT, IN `firstName` VARCHAR(40), IN `secondName` VARCHAR(40),
IN `firstLastName` VARCHAR(40), IN `secondLastName` VARCHAR(40),
IN `fullName` VARCHAR(40), IN `documentType`INT,
IN `documentNumber` VARCHAR(12),  IN `bornDate` DATE,
IN `age` INT, IN `mobileNumber` INT, IN `address` VARCHAR(45), 
IN `genre` CHAR(1), IN `idUser` INT, IN `userName` VARCHAR(45),
IN `passwordUser` VARCHAR(45), IN `email` VARCHAR(45),
IN `sourceUser` VARCHAR(45), IN `userStatus` INT)
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
            email_usu, telf_usu, origen_usu, id_estado)
		VALUES 
			(personId, userName, passwordUser,
            email, mobileNumber, sourceUser, userStatus); 
    
    END IF;
    
    IF vAccion = "login" THEN
			SELECT 
				P.id_per as personId, P.pri_nomb as firstName, P.seg_nomb as secondName, P.pri_apel as firstLastName,
                P.seg_apel as secondLastName, P.nom_comp as fullName, P.tip_doc as documentType,
                P.num_doc as documentNumber, P.fec_nac as bornDate, P.direc_per as address,
                P.genero_per as genre, U.nom_usu as userName, U.email_usu as email, 
                U.telf_usu as mobileNumber, U.id_estado as userStatus
            FROM 
				USUARIOS U 
			INNER JOIN PERSONAS P ON P.id_per = U.id_per 
            WHERE 
				U.nom_usu = userName 
				OR U.pass_usu = passwordUser;
	END IF;
	
    IF vAccion = "obtener" THEN
			SELECT 
				P.id_per as personId, P.pri_nomb as firstName, P.seg_nomb as secondName, P.pri_apel as firstLastName,
                P.seg_apel as secondLastName, P.nom_comp as fullName, P.tip_doc as documentType,
                P.num_doc as documentNumber, P.fec_nac as bornDate, P.direc_per as address,
                P.genero_per as genre, U.nom_usu as userName, U.email_usu as email, 
                U.telf_usu as mobileNumber, U.id_estado as userStatus
            FROM 
				USUARIOS U 
			INNER JOIN PERSONAS P ON P.id_per = U.id_per 
            WHERE 
				P.ide_per = idPerson 
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
		WHERE id_per = idPerson;
	END IF;
    
    IF vAccion = "datos/actualizar" THEN
			UPDATE PERSONAS p  
				set P.pri_nomb=firstName, P.seg_nomb=secondName, P.pri_apel=firstLastName,
                P.seg_apel=secondLastName, P.nom_comp=fullName, P.tip_doc=documentType,
                P.num_doc=documentNumber, P.fec_nac=bornDate, P.direc_per=address,
                P.genero_per=genre
			WHERE p.id_per = idPerson;
            
            UPDATE USUARIOS u
				set
					U.nom_usu = userName, U.email_usu = email, 
					U.telf_usu = mobileNumber, U.id_estado = userStatus
				WHERE u.id_usu = idUser;
	END IF;
END$$

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;