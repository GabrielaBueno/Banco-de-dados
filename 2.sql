-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`SETOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SETOR` (
  `SET_CODIGO` INT NOT NULL,
  `SET_NOME` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SET_CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SUBSETOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SUBSETOR` (
  `SUB_CODIGO` INT NOT NULL,
  `SUB_NOME` VARCHAR(45) NOT NULL,
  `SET_CODIGO` INT NOT NULL,
  PRIMARY KEY (`SUB_CODIGO`),
  INDEX `fk_SUBSETOR ECONOMICO_SETOR ECONOMICO_idx` (`SET_CODIGO` ASC),
  CONSTRAINT `fk_SUBSETOR ECONOMICO_SETOR ECONOMICO`
    FOREIGN KEY (`SET_CODIGO`)
    REFERENCES `mydb`.`SETOR` (`SET_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SEGMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SEGMENTO` (
  `SEG_CODIGO` INT NOT NULL,
  `SEG_NOME` VARCHAR(45) NOT NULL,
  `SUB_CODIGO` INT NOT NULL,
  PRIMARY KEY (`SEG_CODIGO`),
  INDEX `fk_SEGMENTO ECONOMICO_SUBSETOR ECONOMICO1_idx` (`SUB_CODIGO` ASC),
  CONSTRAINT `fk_SEGMENTO ECONOMICO_SUBSETOR ECONOMICO1`
    FOREIGN KEY (`SUB_CODIGO`)
    REFERENCES `mydb`.`SUBSETOR` (`SUB_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GOVERNANCA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GOVERNANCA` (
  `GOV_CODIGO` VARCHAR(3) NOT NULL,
  `GOV_NOME` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`GOV_CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPRESA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPRESA` (
  `EMP_CODIGO` VARCHAR(12) NOT NULL,
  `EMP_NOME` VARCHAR(45) NOT NULL,
  `GOV_CODIGO` VARCHAR(3) NULL,
  `SEG_CODIGO` INT NOT NULL,
  PRIMARY KEY (`EMP_CODIGO`),
  INDEX `fk_EMPRESA_NIVEIS GORVERNANCA1_idx` (`GOV_CODIGO` ASC),
  INDEX `fk_EMPRESA_SEGMENTO ECONOMICO1_idx` (`SEG_CODIGO` ASC),
  CONSTRAINT `fk_EMPRESA_NIVEIS GORVERNANCA1`
    FOREIGN KEY (`GOV_CODIGO`)
    REFERENCES `mydb`.`GOVERNANCA` (`GOV_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPRESA_SEGMENTO ECONOMICO1`
    FOREIGN KEY (`SEG_CODIGO`)
    REFERENCES `mydb`.`SEGMENTO` (`SEG_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ACAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ACAO` (
  `ACAO_CODIGO` VARCHAR(12) NOT NULL,
  `EMP_CODIGO` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`ACAO_CODIGO`),
  INDEX `fk_ACAO_EMPRESA1_idx` (`EMP_CODIGO` ASC),
  CONSTRAINT `fk_ACAO_EMPRESA1`
    FOREIGN KEY (`EMP_CODIGO`)
    REFERENCES `mydb`.`EMPRESA` (`EMP_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_INDICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_INDICE` (
  `TIND_CODIGO` INT NOT NULL,
  `TIND_NOME` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TIND_CODIGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`INDICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INDICE` (
  `IND_SIGLA` VARCHAR(8) NOT NULL,
  `IND_NOME` VARCHAR(45) CHARACTER SET 'ascii' NOT NULL,
  `TIND_CODIGO` INT NOT NULL,
  PRIMARY KEY (`IND_SIGLA`),
  INDEX `fk_INDICE_TIPOS DE INDICE1_idx` (`TIND_CODIGO` ASC),
  CONSTRAINT `fk_INDICE_TIPOS DE INDICE1`
    FOREIGN KEY (`TIND_CODIGO`)
    REFERENCES `mydb`.`TIPO_INDICE` (`TIND_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LISTAGEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LISTAGEM` (
  `ACAO_CODIGO` VARCHAR(12) NOT NULL,
  `IND_SIGLA` VARCHAR(8) NOT NULL,
  `LIST_QUADRIMESTRE` INT(4) NOT NULL,
  `LIST_QTD_ACOES` INT NOT NULL,
  `LIST_ANO` YEAR(4) NOT NULL,
  `LIST_PERCENT_ACOES` DECIMAL(6,3) NOT NULL,
  PRIMARY KEY (`ACAO_CODIGO`, `IND_SIGLA`),
  INDEX `fk_ACAO_has_INDICE_INDICE1_idx` (`IND_SIGLA` ASC),
  INDEX `fk_ACAO_has_INDICE_ACAO1_idx` (`ACAO_CODIGO` ASC),
  CONSTRAINT `fk_ACAO_has_INDICE_ACAO1`
    FOREIGN KEY (`ACAO_CODIGO`)
    REFERENCES `mydb`.`ACAO` (`ACAO_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACAO_has_INDICE_INDICE1`
    FOREIGN KEY (`IND_SIGLA`)
    REFERENCES `mydb`.`INDICE` (`IND_SIGLA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COTACAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COTACAO` (
  `COT_PREGAO` DATE NOT NULL,
  `ACAO_CODIGO` VARCHAR(12) NOT NULL,
  `COT_PREABE` DECIMAL(13,2) NOT NULL,
  `COT_PREMAX` DECIMAL(13,2) NOT NULL,
  `COT_PREMIN` DECIMAL(13,2) NOT NULL,
  `COT_PREULT` DECIMAL(13,2) NOT NULL,
  `COT_TOTNEG` INT(5) NOT NULL,
  `COT_QUATOT` INT(18) NOT NULL,
  `COT_VOLTOT` DECIMAL(18,2) NOT NULL,
  PRIMARY KEY (`COT_PREGAO`, `ACAO_CODIGO`),
  INDEX `fk_COTACAO_ACAO1_idx` (`ACAO_CODIGO` ASC),
  CONSTRAINT `fk_COTACAO_ACAO1`
    FOREIGN KEY (`ACAO_CODIGO`)
    REFERENCES `mydb`.`ACAO` (`ACAO_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
