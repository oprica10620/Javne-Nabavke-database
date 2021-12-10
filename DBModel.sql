-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema javne_nabavke
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema javne_nabavke
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `javne_nabavke` DEFAULT CHARACTER SET utf8 ;
USE `javne_nabavke` ;

-- -----------------------------------------------------
-- Table `javne_nabavke`.`Narucilac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Narucilac` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`ObjavaPlana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`ObjavaPlana` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`PlanJavneNabavke`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`PlanJavneNabavke` (
  `id` INT NOT NULL,
  `idNarucioca` INT NOT NULL,
  `idObjave` INT NOT NULL,
  PRIMARY KEY (`id`, `idNarucioca`, `idObjave`),
  INDEX `fk_plan_narucilac` (`idNarucioca` ASC) INVISIBLE,
  INDEX `fk_plan_objava` (`idObjave` ASC) INVISIBLE,
  CONSTRAINT `fk_plan_narucilac`
    FOREIGN KEY (`idNarucioca`)
    REFERENCES `javne_nabavke`.`Narucilac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_objava`
    FOREIGN KEY (`idObjave`)
    REFERENCES `javne_nabavke`.`ObjavaPlana` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`StavkaJavneNabavke`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`StavkaJavneNabavke` (
  `id` INT NOT NULL,
  `idPlana` INT NOT NULL,
  PRIMARY KEY (`id`, `idPlana`),
  INDEX `fk_stavka_plan` (`idPlana` ASC) VISIBLE,
  CONSTRAINT `fk_stavka_plan`
    FOREIGN KEY (`idPlana`)
    REFERENCES `javne_nabavke`.`PlanJavneNabavke` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Postupak`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Postupak` (
  `id` INT NOT NULL,
  `idNarucioca` INT NOT NULL,
  PRIMARY KEY (`id`, `idNarucioca`),
  INDEX `fk_postupak_narucilac` (`idNarucioca` ASC) VISIBLE,
  CONSTRAINT `fk_postupak_narucilac`
    FOREIGN KEY (`idNarucioca`)
    REFERENCES `javne_nabavke`.`Narucilac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Partija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Partija` (
  `id` INT NOT NULL,
  `idPostupka` INT NOT NULL,
  PRIMARY KEY (`id`, `idPostupka`),
  INDEX `fk_partija_postupak` (`idPostupka` ASC) INVISIBLE,
  CONSTRAINT `fk_partija_postupak`
    FOREIGN KEY (`idPostupka`)
    REFERENCES `javne_nabavke`.`Postupak` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`DocPartije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`DocPartije` (
  `id` INT NOT NULL,
  `idPartije` INT NOT NULL,
  PRIMARY KEY (`id`, `idPartije`),
  INDEX `fk_DocPartije_Partija1_idx` (`idPartije` ASC) VISIBLE,
  CONSTRAINT `fk_docP_Partija`
    FOREIGN KEY (`idPartije`)
    REFERENCES `javne_nabavke`.`Partija` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`KonkursnaDoc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`KonkursnaDoc` (
  `id` INT NOT NULL,
  `idPostupka` INT NOT NULL,
  PRIMARY KEY (`id`, `idPostupka`),
  INDEX `fk_konkD_postupak` (`idPostupka` ASC) VISIBLE,
  CONSTRAINT `fk_konkD_postupak`
    FOREIGN KEY (`idPostupka`)
    REFERENCES `javne_nabavke`.`Postupak` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Ponudjac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Ponudjac` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Dobavljac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Dobavljac` (
  `id` INT NOT NULL,
  `idPonudjaca` INT NOT NULL,
  PRIMARY KEY (`id`, `idPonudjaca`),
  INDEX `fk_dobavljac_ponudjac` (`idPonudjaca` ASC) VISIBLE,
  CONSTRAINT `fk_dobavljac_ponudjac`
    FOREIGN KEY (`idPonudjaca`)
    REFERENCES `javne_nabavke`.`Ponudjac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Ugovor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Ugovor` (
  `id` INT NOT NULL,
  `idPonudjaca` INT NOT NULL,
  `idNarucioca` INT NOT NULL,
  `Dobavljac_id` INT NOT NULL,
  `Dobavljac_idPonudjaca` INT NOT NULL,
  PRIMARY KEY (`id`, `idPonudjaca`, `idNarucioca`, `Dobavljac_id`, `Dobavljac_idPonudjaca`),
  INDEX `fk_ugovor_narucilac` (`idNarucioca` ASC) VISIBLE,
  INDEX `fk_Ugovor_Dobavljac1_idx` (`Dobavljac_id` ASC, `Dobavljac_idPonudjaca` ASC) VISIBLE,
  CONSTRAINT `fk_ugovor_narucilac`
    FOREIGN KEY (`idNarucioca`)
    REFERENCES `javne_nabavke`.`Narucilac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ugovor_Dobavljac1`
    FOREIGN KEY (`Dobavljac_id` , `Dobavljac_idPonudjaca`)
    REFERENCES `javne_nabavke`.`Dobavljac` (`id` , `idPonudjaca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Ponuda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Ponuda` (
  `id` INT NOT NULL,
  `idPonude` INT NOT NULL,
  `idPostupka` INT NOT NULL,
  PRIMARY KEY (`id`, `idPonude`, `idPostupka`),
  INDEX `fk_ponuda_ponudjac` (`idPonude` ASC) VISIBLE,
  INDEX `fk_ponuda_postupak` (`idPostupka` ASC) VISIBLE,
  CONSTRAINT `fk_ponuda_ponudjac`
    FOREIGN KEY (`idPonude`)
    REFERENCES `javne_nabavke`.`Ponudjac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ponuda_postupak`
    FOREIGN KEY (`idPostupka`)
    REFERENCES `javne_nabavke`.`Postupak` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`ResenjeNarucioca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`ResenjeNarucioca` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`NSTJ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`NSTJ` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`CPV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`CPV` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`ResenjeRepublickeKomisije`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`ResenjeRepublickeKomisije` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`ZahtevZaZastituPrava`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`ZahtevZaZastituPrava` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`OkvirniSporazum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`OkvirniSporazum` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Komisija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Komisija` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`Preduzece`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`Preduzece` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`OdgovornoLice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`OdgovornoLice` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`PredlagacNabavke`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`PredlagacNabavke` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`OkvirniSporazum_has_Narucilac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`OkvirniSporazum_has_Narucilac` (
  `OkvirniSporazum_id` INT NOT NULL,
  `Narucilac_id` INT NOT NULL,
  PRIMARY KEY (`OkvirniSporazum_id`, `Narucilac_id`),
  INDEX `fk_OkvirniSporazum_has_Narucilac_Narucilac1_idx` (`Narucilac_id` ASC) VISIBLE,
  INDEX `fk_OkvirniSporazum_has_Narucilac_OkvirniSporazum1_idx` (`OkvirniSporazum_id` ASC) VISIBLE,
  CONSTRAINT `fk_OkvirniSporazum_has_Narucilac_OkvirniSporazum1`
    FOREIGN KEY (`OkvirniSporazum_id`)
    REFERENCES `javne_nabavke`.`OkvirniSporazum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OkvirniSporazum_has_Narucilac_Narucilac1`
    FOREIGN KEY (`Narucilac_id`)
    REFERENCES `javne_nabavke`.`Narucilac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `javne_nabavke`.`OkvirniSporazum_has_Dobavljac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `javne_nabavke`.`OkvirniSporazum_has_Dobavljac` (
  `OkvirniSporazum_id` INT NOT NULL,
  `Dobavljac_id` INT NOT NULL,
  `Dobavljac_idPonudjaca` INT NOT NULL,
  PRIMARY KEY (`OkvirniSporazum_id`, `Dobavljac_id`, `Dobavljac_idPonudjaca`),
  INDEX `fk_OkvirniSporazum_has_Dobavljac_Dobavljac1_idx` (`Dobavljac_id` ASC, `Dobavljac_idPonudjaca` ASC) VISIBLE,
  INDEX `fk_OkvirniSporazum_has_Dobavljac_OkvirniSporazum1_idx` (`OkvirniSporazum_id` ASC) VISIBLE,
  CONSTRAINT `fk_OkvirniSporazum_has_Dobavljac_OkvirniSporazum1`
    FOREIGN KEY (`OkvirniSporazum_id`)
    REFERENCES `javne_nabavke`.`OkvirniSporazum` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OkvirniSporazum_has_Dobavljac_Dobavljac1`
    FOREIGN KEY (`Dobavljac_id` , `Dobavljac_idPonudjaca`)
    REFERENCES `javne_nabavke`.`Dobavljac` (`id` , `idPonudjaca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
