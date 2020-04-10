
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd` DEFAULT CHARACTER SET utf8 ;
USE `bd` ;

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
-- Table `bd`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`usuarios` (
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
    REFERENCES `bd`.`personas` (`id_per`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


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
  `descrip_local` VARCHAR(500) NOT NULL,
  `telf_local` INT NOT NULL,
  `direc_local` VARCHAR(45) NOT NULL,
  `estado_local` TEXT(30) NOT NULL,
  PRIMARY KEY (`id_local`),
  UNIQUE INDEX `lat_local_UNIQUE` (`lat_local` ASC) VISIBLE,
  UNIQUE INDEX `long_local_UNIQUE` (`long_local` ASC) VISIBLE,
  UNIQUE INDEX `telf_local_UNIQUE` (`telf_local` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`horarios_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`horarios_local` (
  `dia_hor_local` INT NOT NULL,
  `mes_hor_local` DATE NOT NULL,
  `año_hor_local` YEAR NOT NULL,
  `fecha_hor_local` DATETIME NOT NULL,
  `hora_hor_local` TIME NOT NULL,
  `estado_local` TEXT(30) NOT NULL,
  PRIMARY KEY (`dia_hor_local`))
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
  PRIMARY KEY (`id_cater`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`shows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`shows` (
  `id_show` INT NOT NULL AUTO_INCREMENT,
  `id_local` INT NOT NULL,
  `nomb_show` VARCHAR(45) NOT NULL,
  `img_show` VARCHAR(45) NOT NULL,
  `descr_show` VARCHAR(500) NOT NULL,
  `precio_show` DECIMAL NOT NULL,
  PRIMARY KEY (`id_show`),
  INDEX `id_local_idx` (`id_local` ASC) VISIBLE,
  CONSTRAINT `id_local`
    FOREIGN KEY (`id_local`)
    REFERENCES `bd`.`locales` (`id_local`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`productos` (
  `id_prod` INT NOT NULL AUTO_INCREMENT,
  `id_carter` INT NOT NULL,
  `id_show` INT NOT NULL,
  `id_local` INT NOT NULL,
  `usuarios_id_usu` INT NOT NULL,
  `nom_prod` VARCHAR(45) NOT NULL,
  `tipo_prod` VARCHAR(45) NOT NULL,
  `descr_prod` VARCHAR(45) NOT NULL,
  `precio_prod` DECIMAL NOT NULL,
  `stock_prod` INT NOT NULL,
  PRIMARY KEY (`id_prod`),
  INDEX `id_carter_idx` (`id_carter` ASC) VISIBLE,
  INDEX `id_show_idx` (`id_show` ASC) VISIBLE,
  INDEX `id_local_idx` (`id_local` ASC) VISIBLE,
  INDEX `fk_productos_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  CONSTRAINT `id_carter_productos`
    FOREIGN KEY (`id_carter`)
    REFERENCES `bd`.`catering` (`id_cater`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_show_productos`
    FOREIGN KEY (`id_show`)
    REFERENCES `bd`.`shows` (`id_show`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_local_productos`
    FOREIGN KEY (`id_local`)
    REFERENCES `bd`.`locales` (`id_local`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `bd`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`orden_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`orden_compra` (
  `id_orden` INT NOT NULL,
  `usuarios_id_usu` INT NOT NULL,
  `fecha_orden` DATETIME NOT NULL,
  `pais` VARCHAR(45) NULL,
  `productos_id_prod` INT NOT NULL,
  PRIMARY KEY (`id_orden`),
  INDEX `fk_orden_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  INDEX `fk_orden_compra_productos1_idx` (`productos_id_prod` ASC) VISIBLE,
  CONSTRAINT `fk_orden_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `bd`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orden_compra_productos1`
    FOREIGN KEY (`productos_id_prod`)
    REFERENCES `bd`.`productos` (`id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`tarjeta_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`tarjeta_usuario` (
  `id_tarjeta` INT NOT NULL,
  `usuarios_id_usu` INT NOT NULL,
  `id_ent_banc` VARCHAR(45) NOT NULL,
  `num_tarj` INT NOT NULL,
  `tipo_tarj` VARCHAR(45) NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  UNIQUE INDEX `id_tarjeta_UNIQUE` (`id_tarjeta` ASC) VISIBLE,
  UNIQUE INDEX `id_ent_banc_UNIQUE` (`id_ent_banc` ASC) VISIBLE,
  INDEX `fk_tarjeta_usuario_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  CONSTRAINT `fk_tarjeta_usuario_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `bd`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`categ_prod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`categ_prod` (
  `id_cat_prod` INT NOT NULL,
  `nom_cat_prod` VARCHAR(45) NOT NULL,
  `productos_id_prod` INT NOT NULL,
  PRIMARY KEY (`id_cat_prod`),
  INDEX `fk_categ_prod_productos1_idx` (`productos_id_prod` ASC) VISIBLE,
  CONSTRAINT `fk_categ_prod_productos1`
    FOREIGN KEY (`productos_id_prod`)
    REFERENCES `bd`.`productos` (`id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`tipo_tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`tipo_tarjeta` (
  `id_tipo_tarjeta` INT NOT NULL,
  `nomb_tipo_tarjeta` VARCHAR(45) NOT NULL,
  `tarjeta_usuario_id_tarjeta` INT NOT NULL,
  PRIMARY KEY (`id_tipo_tarjeta`),
  INDEX `fk_tipo_tarjeta_tarjeta_usuario1_idx` (`tarjeta_usuario_id_tarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_tarjeta_tarjeta_usuario1`
    FOREIGN KEY (`tarjeta_usuario_id_tarjeta`)
    REFERENCES `bd`.`tarjeta_usuario` (`id_tarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd`.`reserva` (
  `id_reserva` INT NOT NULL,
  `tarjeta_usuario_id_tarjeta` INT NOT NULL,
  `usuarios_id_usu` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reserva_tarjeta_usuario1_idx` (`tarjeta_usuario_id_tarjeta` ASC) VISIBLE,
  INDEX `fk_reserva_usuarios1_idx` (`usuarios_id_usu` ASC) VISIBLE,
  UNIQUE INDEX `id_reserva_UNIQUE` (`id_reserva` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_tarjeta_usuario1`
    FOREIGN KEY (`tarjeta_usuario_id_tarjeta`)
    REFERENCES `bd`.`tarjeta_usuario` (`id_tarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_usuarios1`
    FOREIGN KEY (`usuarios_id_usu`)
    REFERENCES `bd`.`usuarios` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
