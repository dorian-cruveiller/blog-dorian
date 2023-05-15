-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 15, 2023 at 06:15 AM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `classicmodels`
--

-- --------------------------------------------------------

--
-- Table structure for table `Author`
--

CREATE TABLE `Author` (
  `Id` tinyint(3) UNSIGNED NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Author`
--

INSERT INTO `Author` (`Id`, `FirstName`, `LastName`) VALUES
(1, 'John', 'Doe'),
(2, 'Dorian', 'Cruveiller');

-- --------------------------------------------------------

--
-- Table structure for table `Category`
--

CREATE TABLE `Category` (
  `Id` tinyint(3) UNSIGNED NOT NULL,
  `Name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Category`
--

INSERT INTO `Category` (`Id`, `Name`) VALUES
(8, 'Cuisine'),
(2, 'Jeux-Vidéos'),
(1, 'Voyages');

-- --------------------------------------------------------

--
-- Table structure for table `Comment`
--

CREATE TABLE `Comment` (
  `Id` mediumint(8) UNSIGNED NOT NULL,
  `NickName` varchar(30) DEFAULT NULL,
  `Contents` text NOT NULL,
  `CreationTimestamp` datetime NOT NULL,
  `Post_Id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Comment`
--

INSERT INTO `Comment` (`Id`, `NickName`, `Contents`, `CreationTimestamp`, `Post_Id`) VALUES
(2, 'patate', 'Une super poste di donc', '2023-05-11 20:31:28', 1),
(3, 'carotte', 'Un super commentaire', '2023-05-11 23:26:48', 1),
(5, 'theau debureau', 'Et avec des bons amis c\'est encore mieux', '2023-05-11 23:46:41', 10),
(6, 'Le nain de jardin', 'c\'est mieux que les petits poids carottes quand même', '2023-05-11 23:49:01', 10),
(7, 'Le nazi', 'j\'aime le latin', '2023-05-11 23:49:37', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Post`
--

CREATE TABLE `Post` (
  `Id` smallint(5) UNSIGNED NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Contents` text NOT NULL,
  `CreationTimestamp` datetime NOT NULL,
  `Author_Id` tinyint(3) UNSIGNED DEFAULT NULL,
  `Category_Id` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Post`
--

INSERT INTO `Post` (`Id`, `Title`, `Contents`, `CreationTimestamp`, `Author_Id`, `Category_Id`) VALUES
(1, 'Un super post', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2023-04-24 08:37:03', 1, 2),
(10, 'Comment faire une raclette', 'Pour vous faire une bonne petite raclette il vous faut du fromage', '2023-05-11 23:45:27', 2, 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Author`
--
ALTER TABLE `Author`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `Comment`
--
ALTER TABLE `Comment`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `CreationTimestamp` (`CreationTimestamp`),
  ADD KEY `Post_Id` (`Post_Id`);

--
-- Indexes for table `Post`
--
ALTER TABLE `Post`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Title` (`Title`),
  ADD KEY `CreationTimestamp` (`CreationTimestamp`),
  ADD KEY `Author_Id` (`Author_Id`),
  ADD KEY `Category_Id` (`Category_Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Author`
--
ALTER TABLE `Author`
  MODIFY `Id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Category`
--
ALTER TABLE `Category`
  MODIFY `Id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Comment`
--
ALTER TABLE `Comment`
  MODIFY `Id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Post`
--
ALTER TABLE `Post`
  MODIFY `Id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Comment`
--
ALTER TABLE `Comment`
  ADD CONSTRAINT `Comment_ibfk_1` FOREIGN KEY (`Post_Id`) REFERENCES `Post` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Post`
--
ALTER TABLE `Post`
  ADD CONSTRAINT `Post_ibfk_1` FOREIGN KEY (`Author_Id`) REFERENCES `Author` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Post_ibfk_2` FOREIGN KEY (`Category_Id`) REFERENCES `Category` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
