SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `gestion_club` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gestion_club`;

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `Email` varchar(100) NOT NULL,
  `password` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `club`;
CREATE TABLE `club` (
  `Id_club` int(11) NOT NULL,
  `nom` varchar(10) NOT NULL,
  `description` varchar(100) NOT NULL,
  `id_compte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `compte`;
CREATE TABLE `compte` (
  `id_compte` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `compte` (`id_compte`, `Email`, `Password`) VALUES
(1, 'ichrakhajri08@gmail.com', 'manager'),
(2, 'imengds@gmail.com', 'imen1'),
(3, 'islemhm@gmail.com', 'imen1'),
(4, 'islemhmss@gmail.com', 'imen1'),
(5, 'nadrahajri@hotmail.com', 'manager');

DROP TABLE IF EXISTS `demande`;
CREATE TABLE `demande` (
  `num_demande` int(11) NOT NULL,
  `discription` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `membre_club`;
CREATE TABLE `membre_club` (
  `Email` varchar(100) NOT NULL,
  `nom` varchar(10) NOT NULL,
  `prenom` varchar(10) NOT NULL,
  `date_N` date NOT NULL,
  `filiere` varchar(10) NOT NULL,
  `id_poste` int(11) NOT NULL,
  `num_demande` int(11) NOT NULL,
  `num_tache` int(11) NOT NULL,
  `id_compte` int(11) NOT NULL,
  `id_club` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `membre_site`;
CREATE TABLE `membre_site` (
  `Nom` varchar(10) NOT NULL,
  `Prenom` varchar(10) NOT NULL,
  `date_N` date NOT NULL,
  `filiere` varchar(100) NOT NULL,
  `id_compte` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `membre_site` (`Nom`, `Prenom`, `date_N`, `filiere`, `id_compte`, `Email`) VALUES
('hajri', 'ichrak', '2003-09-14', 'licence informatique', 1, 'ichrakhajri08@gmail.com'),
('imen', 'gds', '2003-09-06', 'licence informatique', 2, 'imengds@gmail.com'),
('islem', 'hm', '2001-12-18', 'licence mathematique', 3, 'islemhm@gmail.com'),
('islem', 'hm', '2001-12-18', 'licence mathematique', 4, 'islemhmss@gmail.com'),
('hajri', 'NADRA', '2003-09-14', 'preparatoire integre', 5, 'nadrahajri@hotmail.com');

DROP TABLE IF EXISTS `poste`;
CREATE TABLE `poste` (
  `id_poste` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  `description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `président`;
CREATE TABLE `président` (
  `Email` varchar(100) NOT NULL,
  `nom` varchar(10) NOT NULL,
  `prenom` varchar(10) NOT NULL,
  `id_compte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `tache`;
CREATE TABLE `tache` (
  `num_tache` int(11) NOT NULL,
  `discription` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `admin`
  ADD PRIMARY KEY (`Email`);

ALTER TABLE `club`
  ADD PRIMARY KEY (`Id_club`),
  ADD KEY `id_compte` (`id_compte`);

ALTER TABLE `compte`
  ADD PRIMARY KEY (`id_compte`),
  ADD UNIQUE KEY `Email` (`Email`);

ALTER TABLE `demande`
  ADD PRIMARY KEY (`num_demande`);

ALTER TABLE `membre_club`
  ADD PRIMARY KEY (`Email`),
  ADD KEY `id_poste` (`id_poste`),
  ADD KEY `num_demande` (`num_demande`),
  ADD KEY `num_tache` (`num_tache`),
  ADD KEY `id_compte` (`id_compte`),
  ADD KEY `id_club` (`id_club`);

ALTER TABLE `membre_site`
  ADD PRIMARY KEY (`Email`),
  ADD KEY `id_compte` (`id_compte`);

ALTER TABLE `poste`
  ADD PRIMARY KEY (`id_poste`);

ALTER TABLE `président`
  ADD PRIMARY KEY (`Email`),
  ADD KEY `id_compte` (`id_compte`);

ALTER TABLE `tache`
  ADD PRIMARY KEY (`num_tache`);


ALTER TABLE `compte`
  MODIFY `id_compte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `demande`
  MODIFY `num_demande` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `poste`
  MODIFY `id_poste` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tache`
  MODIFY `num_tache` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `club`
  ADD CONSTRAINT `membre_club_ibfk_6` FOREIGN KEY (`id_compte`) REFERENCES `compte` (`id_compte`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `membre_club`
  ADD CONSTRAINT `membre_club_ibfk_1` FOREIGN KEY (`num_demande`) REFERENCES `demande` (`num_demande`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membre_club_ibfk_2` FOREIGN KEY (`num_tache`) REFERENCES `tache` (`num_tache`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membre_club_ibfk_3` FOREIGN KEY (`id_compte`) REFERENCES `compte` (`id_compte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membre_club_ibfk_4` FOREIGN KEY (`id_poste`) REFERENCES `poste` (`id_poste`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membre_club_ibfk_5` FOREIGN KEY (`id_club`) REFERENCES `club` (`Id_club`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `membre_site`
  ADD CONSTRAINT `membre_club_ibfk_8` FOREIGN KEY (`id_compte`) REFERENCES `compte` (`id_compte`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `président`
  ADD CONSTRAINT `membre_club_ibfk_7` FOREIGN KEY (`id_compte`) REFERENCES `compte` (`id_compte`) ON DELETE CASCADE ON UPDATE CASCADE;
USE `phpmyadmin`;

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'gestion_club', 'compte', '{\"sorted_col\":\"`compte`.`Password` ASC\"}', '2024-04-27 18:21:21');
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
