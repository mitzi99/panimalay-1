-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.31-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table panimalay.account
CREATE TABLE IF NOT EXISTS `account` (
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `accountType` enum('Renter','Owner') DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.buildings
CREATE TABLE IF NOT EXISTS `buildings` (
  `buildingNo` int(11) NOT NULL AUTO_INCREMENT,
  `RBID` int(11) NOT NULL,
  PRIMARY KEY (`buildingNo`),
  KEY `RBID` (`RBID`),
  CONSTRAINT `buildings_ibfk_1` FOREIGN KEY (`RBID`) REFERENCES `rentalbusiness` (`RBID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.facilities
CREATE TABLE IF NOT EXISTS `facilities` (
  `buildingNo` int(11) DEFAULT NULL,
  `facility` varchar(255) NOT NULL,
  KEY `buildingNo` (`buildingNo`),
  CONSTRAINT `facilities_ibfk_1` FOREIGN KEY (`buildingNo`) REFERENCES `buildings` (`buildingNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.feedbacks
CREATE TABLE IF NOT EXISTS `feedbacks` (
  `username` varchar(255) NOT NULL,
  `RBID` int(11) NOT NULL,
  `feedbackNo` int(11) NOT NULL AUTO_INCREMENT,
  `feedback` varchar(255) NOT NULL,
  `starRating` int(11) DEFAULT NULL,
  `feedbackDate` date NOT NULL,
  PRIMARY KEY (`feedbackNo`),
  KEY `username` (`username`),
  KEY `RBID` (`RBID`),
  CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feedbacks_ibfk_2` FOREIGN KEY (`RBID`) REFERENCES `rentalbusiness` (`RBID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.images
CREATE TABLE IF NOT EXISTS `images` (
  `imageID` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`imageID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.locations
CREATE TABLE IF NOT EXISTS `locations` (
  `buildingNo` int(11) NOT NULL,
  `locationID` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(255) NOT NULL,
  `barangay` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `zipcode` int(11) NOT NULL,
  PRIMARY KEY (`locationID`),
  KEY `buildingNo` (`buildingNo`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`buildingNo`) REFERENCES `buildings` (`buildingNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `username` varchar(255) NOT NULL,
  `RBID` int(11) NOT NULL,
  `paymentNo` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(11) NOT NULL,
  `paymentDate` date NOT NULL,
  PRIMARY KEY (`paymentNo`),
  KEY `username` (`username`),
  KEY `RBID` (`RBID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`RBID`) REFERENCES `rentalbusiness` (`RBID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.profilephonenumber
CREATE TABLE IF NOT EXISTS `profilephonenumber` (
  `ownerID` int(11) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  PRIMARY KEY (`phoneNumber`),
  KEY `ownerID` (`ownerID`),
  CONSTRAINT `profilephonenumber_ibfk_1` FOREIGN KEY (`ownerID`) REFERENCES `profiles` (`profileID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.profilepictures
CREATE TABLE IF NOT EXISTS `profilepictures` (
  `profileID` int(11) NOT NULL,
  `imageID` int(11) NOT NULL,
  KEY `profileID` (`profileID`),
  KEY `imageID` (`imageID`),
  CONSTRAINT `profilepictures_ibfk_1` FOREIGN KEY (`profileID`) REFERENCES `profiles` (`profileID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profilepictures_ibfk_2` FOREIGN KEY (`imageID`) REFERENCES `images` (`imageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.profiles
CREATE TABLE IF NOT EXISTS `profiles` (
  `usernameP` varchar(255) NOT NULL,
  `profileID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  PRIMARY KEY (`profileID`),
  KEY `usernameP` (`usernameP`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`usernameP`) REFERENCES `account` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.protocols
CREATE TABLE IF NOT EXISTS `protocols` (
  `RBID` int(11) NOT NULL,
  `protocol` varchar(255) NOT NULL,
  KEY `RBID` (`RBID`),
  CONSTRAINT `protocols_ibfk_1` FOREIGN KEY (`RBID`) REFERENCES `rentalbusiness` (`RBID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.rentalbusiness
CREATE TABLE IF NOT EXISTS `rentalbusiness` (
  `rbName` varchar(255) NOT NULL,
  `RBID` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ownerUserName` varchar(255) NOT NULL,
  PRIMARY KEY (`RBID`),
  KEY `ownerUserName` (`ownerUserName`),
  CONSTRAINT `rentalbusiness_ibfk_1` FOREIGN KEY (`ownerUserName`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.rentalbusinessphonenumber
CREATE TABLE IF NOT EXISTS `rentalbusinessphonenumber` (
  `RBID` int(11) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  PRIMARY KEY (`phoneNumber`),
  KEY `RBID` (`RBID`),
  CONSTRAINT `rentalbusinessphonenumber_ibfk_1` FOREIGN KEY (`RBID`) REFERENCES `rentalbusiness` (`RBID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.renters
CREATE TABLE IF NOT EXISTS `renters` (
  `username` varchar(255) NOT NULL,
  `unitID` int(11) NOT NULL,
  `checkinDate` date NOT NULL,
  `checkoutDate` date NOT NULL,
  KEY `username` (`username`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `renters_ibfk_1` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `renters_ibfk_2` FOREIGN KEY (`unitID`) REFERENCES `units` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.reservation
CREATE TABLE IF NOT EXISTS `reservation` (
  `username` varchar(255) NOT NULL,
  `unitID` int(11) NOT NULL,
  `reservationNo` int(11) NOT NULL AUTO_INCREMENT,
  `reservationDate` date NOT NULL,
  `span` int(11) NOT NULL,
  `projectedPaymentAmount` int(11) NOT NULL,
  PRIMARY KEY (`reservationNo`),
  KEY `username` (`username`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`unitID`) REFERENCES `units` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.services
CREATE TABLE IF NOT EXISTS `services` (
  `RBID` int(11) NOT NULL,
  `service` varchar(255) NOT NULL,
  KEY `RBID` (`RBID`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`RBID`) REFERENCES `rentalbusiness` (`RBID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.unitimages
CREATE TABLE IF NOT EXISTS `unitimages` (
  `unitID` int(11) NOT NULL,
  `imageID` int(11) NOT NULL,
  KEY `unitID` (`unitID`),
  KEY `imageID` (`imageID`),
  CONSTRAINT `unitimages_ibfk_1` FOREIGN KEY (`unitID`) REFERENCES `units` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unitimages_ibfk_2` FOREIGN KEY (`imageID`) REFERENCES `images` (`imageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table panimalay.units
CREATE TABLE IF NOT EXISTS `units` (
  `buildingNo` int(11) NOT NULL,
  `unitID` int(11) NOT NULL AUTO_INCREMENT,
  `unitType` enum('Hotel Room','Bed Spacer','Apartment','Event Venue','Commercial Place') NOT NULL,
  `capacity` int(11) NOT NULL,
  `rate` varchar(255) NOT NULL,
  `genderAccomodation` enum('Unisex','For Female','For Male') NOT NULL,
  PRIMARY KEY (`unitID`),
  KEY `buildingNo` (`buildingNo`),
  CONSTRAINT `units_ibfk_1` FOREIGN KEY (`buildingNo`) REFERENCES `buildings` (`buildingNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
