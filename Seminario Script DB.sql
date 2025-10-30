-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categorias` (
  `Id` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `Id` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `FotoPerfil` VARCHAR(255) NULL,
  `Rol` VARCHAR(45) NULL,
  `FechaRegistro` DATE NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Publicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Publicaciones` (
  `Id` INT NOT NULL,
  `Titulo` VARCHAR(255) NULL,
  `Contenido` LONGTEXT NULL,
  `FechaCreacion` DATE NULL,
  `FechaActualizacion` DATE NULL,
  `IdUsuario` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `PublicacionIdUsuario_idx` (`IdUsuario` ASC),
  CONSTRAINT `PublicacionIdUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `mydb`.`Usuarios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PublicacionCategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PublicacionCategoria` (
  `Id` INT NOT NULL,
  `IdPublicacion` INT NULL,
  `IdCategoria` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `PublicacionFK_idx` (`IdPublicacion` ASC),
  INDEX `CategoriaFK_idx` (`IdCategoria` ASC),
  CONSTRAINT `PublicacionFK`
    FOREIGN KEY (`IdPublicacion`)
    REFERENCES `mydb`.`Publicaciones` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CategoriaFK`
    FOREIGN KEY (`IdCategoria`)
    REFERENCES `mydb`.`Categorias` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Votos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Votos` (
  `Id` INT NOT NULL,
  `IdUsuario` INT NULL,
  `IdPublicaion` INT NULL,
  `Tipo` TINYINT NULL,
  PRIMARY KEY (`Id`),
  INDEX `VotosUsuario_idx` (`IdUsuario` ASC),
  INDEX `VotosPublicacion_idx` (`IdPublicaion` ASC),
  CONSTRAINT `VotosUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `mydb`.`Usuarios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `VotosPublicacion`
    FOREIGN KEY (`IdPublicaion`)
    REFERENCES `mydb`.`Publicaciones` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comentarios` (
  `Id` INT NOT NULL,
  `Descripcion` VARCHAR(255) NULL,
  `IdUsuario` INT NULL,
  `IdPublicacion` INT NULL,
  `IdComentarioPadre` INT NULL,
  `FechaCreacion` DATE NULL,
  PRIMARY KEY (`Id`),
  INDEX `ComentarioUsuario_idx` (`IdUsuario` ASC),
  INDEX `ComentarioPublicacion_idx` (`IdPublicacion` ASC),
  INDEX `ComentarioPadre_idx` (`IdComentarioPadre` ASC),
  CONSTRAINT `ComentarioUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `mydb`.`Usuarios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ComentarioPublicacion`
    FOREIGN KEY (`IdPublicacion`)
    REFERENCES `mydb`.`Publicaciones` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ComentarioPadre`
    FOREIGN KEY (`IdComentarioPadre`)
    REFERENCES `mydb`.`Comentarios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Documentos` (
  `Id` INT NOT NULL,
  `UrlDocumento` VARCHAR(255) NULL,
  `Nombre` VARCHAR(255) NULL,
  `IdPublicacion` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `DocumentoPublicacion_idx` (`IdPublicacion` ASC),
  CONSTRAINT `DocumentoPublicacion`
    FOREIGN KEY (`IdPublicacion`)
    REFERENCES `mydb`.`Publicaciones` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `seminariodb`.`Imagenes` (
  `Id` INT NOT NULL,
  `UrlImagen` VARCHAR(255) NULL,
  `Nombre` VARCHAR(255) NULL,
  `IdPublicacion` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ImagenPublicacion_idx` (`IdPublicacion` ASC),
  CONSTRAINT `ImagenPublicacion`
    FOREIGN KEY (`IdPublicacion`)
    REFERENCES `seminariodb`.`Publicaciones` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
