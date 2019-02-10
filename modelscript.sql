-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ibextube
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ibextube` ;

-- -----------------------------------------------------
-- Schema ibextube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ibextube` DEFAULT CHARACTER SET utf8 ;
USE `ibextube` ;

-- -----------------------------------------------------
-- Table `ibextube`.`GENRE_TYPE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`GENRE_TYPE` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`GENRE_TYPE` (
  `id` INT NOT NULL,
  `name` VARCHAR(25) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`GENRE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`GENRE` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`GENRE` (
  `genre_id` INT NOT NULL,
  `name` VARCHAR(25) NULL,
  `description` VARCHAR(45) NULL,
  `GENRE_TYPE_id` INT NOT NULL,
  PRIMARY KEY (`genre_id`),
  INDEX `fk_GENRE_GENRE_TYPE1_idx` (`GENRE_TYPE_id` ASC),
  CONSTRAINT `fk_GENRE_GENRE_TYPE1`
    FOREIGN KEY (`GENRE_TYPE_id`)
    REFERENCES `ibextube`.`GENRE_TYPE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`PHOTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`PHOTO` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`PHOTO` (
  `photo_id` INT NOT NULL,
  `photo_name` VARCHAR(45) NULL,
  `url` VARCHAR(50) NULL,
  PRIMARY KEY (`photo_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`MOVIE_RATING`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`MOVIE_RATING` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`MOVIE_RATING` (
  `rating_id` INT NOT NULL,
  `rating_point` DOUBLE NULL,
  `total_rating_count` INT NULL,
  `last_rated` DATE NULL,
  PRIMARY KEY (`rating_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`MOVIES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`MOVIES` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`MOVIES` (
  `movie_id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `length` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `release_date` DATE NULL,
  `like_vote` INT NULL,
  `dislike_vote` INT NULL,
  `PHOTO_photo_id` INT NOT NULL,
  `average_rating` DOUBLE NULL,
  `ins_date` DATE NULL,
  `last_use_date` DATE NULL,
  `MOVIE_RATING_rating_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`),
  INDEX `fk_MOVIES_PHOTO1_idx` (`PHOTO_photo_id` ASC),
  INDEX `fk_MOVIES_MOVIE_RATING1_idx` (`MOVIE_RATING_rating_id` ASC),
  CONSTRAINT `fk_MOVIES_PHOTO1`
    FOREIGN KEY (`PHOTO_photo_id`)
    REFERENCES `ibextube`.`PHOTO` (`photo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIES_MOVIE_RATING1`
    FOREIGN KEY (`MOVIE_RATING_rating_id`)
    REFERENCES `ibextube`.`MOVIE_RATING` (`rating_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`MOVIE_GENRES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`MOVIE_GENRES` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`MOVIE_GENRES` (
  `movie_genere_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`movie_genere_id`),
  INDEX `fk_MOVIE_GENRES_MOVIES1_idx` (`movie_id` ASC),
  INDEX `fk_MOVIE_GENRES_GENRE1_idx` (`genre_id` ASC),
  CONSTRAINT `fk_MOVIE_GENRES_MOVIES1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `ibextube`.`MOVIES` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE_GENRES_GENRE1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `ibextube`.`GENRE` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`TAGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`TAGS` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`TAGS` (
  `tag_id` INT NOT NULL,
  `value` VARCHAR(25) NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`MOVIE-TAGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`MOVIE-TAGS` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`MOVIE-TAGS` (
  `movie_tag_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`movie_tag_id`),
  INDEX `fk_MOVIE-TAGS_MOVIES1_idx` (`movie_id` ASC),
  INDEX `fk_MOVIE-TAGS_TAGS1_idx` (`tag_id` ASC),
  CONSTRAINT `fk_MOVIE-TAGS_MOVIES1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `ibextube`.`MOVIES` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE-TAGS_TAGS1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `ibextube`.`TAGS` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`ARTIST`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`ARTIST` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`ARTIST` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `gender` CHAR(1) NULL,
  `PHOTO_photo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ARTIST_PHOTO1_idx` (`PHOTO_photo_id` ASC),
  CONSTRAINT `fk_ARTIST_PHOTO1`
    FOREIGN KEY (`PHOTO_photo_id`)
    REFERENCES `ibextube`.`PHOTO` (`photo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`MOVIE_ARTIST`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`MOVIE_ARTIST` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`MOVIE_ARTIST` (
  `idMOVIE_ARTIST` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`idMOVIE_ARTIST`),
  INDEX `fk_MOVIE_ARTIST_ARTIST1_idx` (`artist_id` ASC),
  INDEX `fk_MOVIE_ARTIST_MOVIES1_idx` (`movie_id` ASC),
  CONSTRAINT `fk_MOVIE_ARTIST_ARTIST1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `ibextube`.`ARTIST` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE_ARTIST_MOVIES1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `ibextube`.`MOVIES` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`USER` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`USER` (
  `idUSER` INT NOT NULL,
  PRIMARY KEY (`idUSER`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibextube`.`MOVIE_COMMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibextube`.`MOVIE_COMMENT` ;

CREATE TABLE IF NOT EXISTS `ibextube`.`MOVIE_COMMENT` (
  `comment_id` INT NOT NULL,
  `comment` VARCHAR(45) NULL,
  `comment_date` DATE NULL,
  `MOVIES_movie_id` INT NOT NULL,
  `USER_idUSER` INT NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_MOVIE_COMMENT_MOVIES1_idx` (`MOVIES_movie_id` ASC),
  INDEX `fk_MOVIE_COMMENT_USER1_idx` (`USER_idUSER` ASC),
  CONSTRAINT `fk_MOVIE_COMMENT_MOVIES1`
    FOREIGN KEY (`MOVIES_movie_id`)
    REFERENCES `ibextube`.`MOVIES` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE_COMMENT_USER1`
    FOREIGN KEY (`USER_idUSER`)
    REFERENCES `ibextube`.`USER` (`idUSER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE TABLE oauth_client_details (
    client_id VARCHAR(256) PRIMARY KEY,
    resource_ids VARCHAR(256),
    client_secret VARCHAR(256),
    scope VARCHAR(256),
    authorized_grant_types VARCHAR(256),
    web_server_redirect_uri VARCHAR(256),
    authorities VARCHAR(256),
    access_token_validity INTEGER,
    refresh_token_validity INTEGER,
    additional_information VARCHAR(4096),
    autoapprove VARCHAR(256)
);
