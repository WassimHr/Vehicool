-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 16, 2023 at 04:37 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agenceLoc`
--

-- --------------------------------------------------------

--
-- Table structure for table `commande`
--

CREATE TABLE `commande` (
  `id` int(11) NOT NULL,
  `vehicule_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_heure_depart` datetime NOT NULL,
  `date_heure_fin` datetime NOT NULL,
  `prix_total` int(11) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commande`
--

INSERT INTO `commande` (`id`, `vehicule_id`, `user_id`, `date_heure_depart`, `date_heure_fin`, `prix_total`, `date_enregistrement`) VALUES
(1, 1, 5, '2023-06-17 14:32:00', '2023-06-29 14:32:00', 300, '2023-06-16 12:32:33'),
(2, 1, 5, '2023-06-17 14:32:00', '2023-06-29 14:32:00', 300, '2023-06-16 12:32:58'),
(3, 1, 5, '2023-06-17 14:32:00', '2023-06-29 14:32:00', 300, '2023-06-16 12:33:09'),
(4, 1, 5, '2023-06-17 14:32:00', '2023-06-29 14:32:00', 300, '2023-06-16 12:33:27'),
(5, 3, 5, '2023-06-30 06:36:00', '2023-06-22 14:39:00', 35, '2023-06-16 12:34:52'),
(6, 1, 6, '2023-06-29 19:44:00', '2023-07-27 14:44:00', 675, '2023-06-16 12:44:54');

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230614095314', '2023-06-14 09:53:35', 71),
('DoctrineMigrations\\Version20230614125506', '2023-06-14 12:55:13', 10),
('DoctrineMigrations\\Version20230614131948', '2023-06-14 13:19:52', 19);

-- --------------------------------------------------------

--
-- Table structure for table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `pseudo` varchar(20) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `civilite` varchar(255) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `pseudo`, `nom`, `prenom`, `civilite`, `date_enregistrement`) VALUES
(1, 'wassim.horri96@gmail.com', '[\"ROLE_USER\"]', 'dsqqf', 'dsqfq', 'Horri', 'Wassim', 'macogneur', '2023-06-14 14:37:59'),
(2, 'test@test.com', '[\"ROLE_USER\"]', 'blabbajsbd', 'testo', 'Letest', 'testeur', 'Test', '2023-06-14 14:08:56'),
(3, 'fantomm@fantomm.com', '[\"ROLE_USER\"]', 'fantomm', 'fantomm', 'fuga', 'filipp', 'Cacatoes', '2023-06-14 14:11:08'),
(5, 'wassim.horri@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$U8KQ0W/0k1pNlkSQHy8U5OKolrYKwvHR/6qPd3Pubrc8pWkS0fbwG', 'Wawa', 'Horri', 'Wassim', 'dsqdsq', '2023-06-15 11:45:46'),
(6, 'fil@fil.com', '[\"ROLE_USER\"]', '$2y$13$vP5qB3l1pMXLfnG67LsGkue1OvNB893LxztA9nI4OpdHpnShQf4jy', 'fantomm', 'fuga', 'filipp', 'Cacatoes', '2023-06-15 13:06:22'),
(7, 'max@max.com', '[\"ROLE_USER\"]', '$2y$13$UI5TSnWPtvRiLng42hOWrepU2WmmjrH5Af.dF9irJTvm/nQT7LtzG', 'Leboss', 'Maxime', 'LeGoat', 'max', '2023-06-15 13:11:14');

-- --------------------------------------------------------

--
-- Table structure for table `vehicule`
--

CREATE TABLE `vehicule` (
  `id` int(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `marque` varchar(50) NOT NULL,
  `modele` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `photo` varchar(200) NOT NULL,
  `prix_journalier` int(11) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicule`
--

INSERT INTO `vehicule` (`id`, `titre`, `marque`, `modele`, `description`, `photo`, `prix_journalier`, `date_enregistrement`) VALUES
(1, 'Voiture vendu', 'Mercedes', 'baldbad', 'qsdqsldshqdflq', 'sddsd', 25, '2023-06-15 10:07:23'),
(2, 'Voiture de luxe', 'Bentley', 'Bentley', 'Voiture avec chauffeur', 'balblabla', 200, '2023-06-15 14:53:40'),
(3, 'Cacatohess', 'BirdEngine', 'FilMobile', 'Habitacle tracté des oiseaux multicolores', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fdornob.com%2F300-helium-balloons-float-real-up-house-10000-feet-high%2F&psig=AOvVaw2uBm8AlCOXa11u1BSgmZxe&ust=1686993115287000&source=images&cd=vfe&ve', 5, '2023-06-16 09:14:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6EEAA67D4A4A3511` (`vehicule_id`),
  ADD KEY `IDX_6EEAA67DA76ED395` (`user_id`);

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- Indexes for table `vehicule`
--
ALTER TABLE `vehicule`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `commande`
--
ALTER TABLE `commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `vehicule`
--
ALTER TABLE `vehicule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `FK_6EEAA67D4A4A3511` FOREIGN KEY (`vehicule_id`) REFERENCES `vehicule` (`id`),
  ADD CONSTRAINT `FK_6EEAA67DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
