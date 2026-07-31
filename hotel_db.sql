/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 10.4.32-MariaDB : Database - perhotelan
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`perhotelan` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `perhotelan`;

/*Table structure for table `check_in` */

DROP TABLE IF EXISTS `check_in`;

CREATE TABLE `check_in` (
  `id_checkin` int(11) NOT NULL AUTO_INCREMENT,
  `id_tamu` int(11) NOT NULL,
  `tgl_checkin` date DEFAULT NULL,
  PRIMARY KEY (`id_checkin`),
  KEY `id_tamu` (`id_tamu`),
  CONSTRAINT `check_in_ibfk_1` FOREIGN KEY (`id_tamu`) REFERENCES `tamu` (`id_tamu`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `check_in` */

insert  into `check_in`(`id_checkin`,`id_tamu`,`tgl_checkin`) values 
(1,10,'2026-10-10'),
(2,11,'2026-10-13'),
(3,12,'2026-10-15'),
(4,13,'2026-10-18');

/*Table structure for table `check_out` */

DROP TABLE IF EXISTS `check_out`;

CREATE TABLE `check_out` (
  `id_checkout` int(11) NOT NULL AUTO_INCREMENT,
  `id_checkin` int(11) NOT NULL,
  `tgl_checkout` date DEFAULT NULL,
  PRIMARY KEY (`id_checkout`),
  KEY `id_checkin` (`id_checkin`),
  CONSTRAINT `check_out_ibfk_1` FOREIGN KEY (`id_checkin`) REFERENCES `check_in` (`id_checkin`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `check_out` */

insert  into `check_out`(`id_checkout`,`id_checkin`,`tgl_checkout`) values 
(7,1,'2026-10-12'),
(8,2,'2026-10-15'),
(9,3,'2026-10-18');

/*Table structure for table `kamar` */

DROP TABLE IF EXISTS `kamar`;

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipe` int(11) NOT NULL,
  `no_kamar` int(11) NOT NULL,
  `status_kamar` enum('Available','Occupied','Cleaning','Maintenance','Reserved') NOT NULL DEFAULT 'Available',
  PRIMARY KEY (`id_kamar`),
  KEY `id_tipe` (`id_tipe`),
  CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`id_tipe`) REFERENCES `tipe_kamar` (`id_tipe`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `kamar` */

insert  into `kamar`(`id_kamar`,`id_tipe`,`no_kamar`,`status_kamar`) values 
(12,1,201,'Occupied'),
(13,1,202,'Cleaning'),
(14,1,203,'Available'),
(15,2,204,'Occupied'),
(16,3,205,'Occupied'),
(17,1,301,'Available'),
(18,1,302,'Available'),
(19,1,303,'Available'),
(20,2,304,'Available'),
(21,3,305,'Available');

/*Table structure for table `pembayaran` */

DROP TABLE IF EXISTS `pembayaran`;

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_checkin` int(11) NOT NULL,
  `jumlah_pembayaran` decimal(10,0) NOT NULL,
  `metode_pembayaran` enum('DEBIT','QRIS','CASH') NOT NULL DEFAULT 'DEBIT',
  PRIMARY KEY (`id_pembayaran`),
  KEY `id_checkin` (`id_checkin`),
  CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_checkin`) REFERENCES `check_in` (`id_checkin`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pembayaran` */

insert  into `pembayaran`(`id_pembayaran`,`id_checkin`,`jumlah_pembayaran`,`metode_pembayaran`) values 
(1,1,200000,'CASH'),
(2,2,200000,'DEBIT'),
(3,3,300000,'DEBIT');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `id_pegawai` int(11) NOT NULL AUTO_INCREMENT,
  `nama_staff` varchar(255) NOT NULL,
  `jabatan` varchar(25) NOT NULL,
  `no_telp` varchar(25) NOT NULL,
  PRIMARY KEY (`id_pegawai`),
  UNIQUE KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `staff` */

insert  into `staff`(`id_pegawai`,`nama_staff`,`jabatan`,`no_telp`) values 
(1,'Rabbani','Manager','081398302423'),
(2,'Zessy','Resepsionis','082590501284'),
(3,'Annas','Bellboy','081239153325'),
(4,'Seto','Bellboy','089858585858'),
(5,'Dedeg','Housekeeper','087090807060');

/*Table structure for table `tamu` */

DROP TABLE IF EXISTS `tamu`;

CREATE TABLE `tamu` (
  `id_tamu` int(11) NOT NULL AUTO_INCREMENT,
  `id_kamar` int(11) NOT NULL,
  `nama_tamu` varchar(255) NOT NULL,
  `no_telp` varchar(25) NOT NULL,
  PRIMARY KEY (`id_tamu`),
  UNIQUE KEY `no_telp` (`no_telp`),
  KEY `id_kamar` (`id_kamar`),
  CONSTRAINT `tamu_ibfk_1` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tamu` */

insert  into `tamu`(`id_tamu`,`id_kamar`,`nama_tamu`,`no_telp`) values 
(10,12,'Ravi Farandy','081340348590'),
(11,15,'Febrian SYAH','082390435056'),
(12,16,'Mozza','0825056782354'),
(13,17,'Rian','08982050403');

/*Table structure for table `tipe_kamar` */

DROP TABLE IF EXISTS `tipe_kamar`;

CREATE TABLE `tipe_kamar` (
  `id_tipe` int(11) NOT NULL AUTO_INCREMENT,
  `tipe_kamar` varchar(255) NOT NULL,
  PRIMARY KEY (`id_tipe`),
  UNIQUE KEY `tipe_kamar` (`tipe_kamar`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tipe_kamar` */

insert  into `tipe_kamar`(`id_tipe`,`tipe_kamar`) values 
(2,'Deluxe'),
(1,'Standard'),
(3,'Suite');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
