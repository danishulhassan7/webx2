-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2022 at 03:42 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mazdoorhaazir-32313273ff`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) NOT NULL,
  `datetime` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `aname` varchar(30) NOT NULL,
  `aheadline` varchar(30) NOT NULL,
  `abio` varchar(1500) NOT NULL,
  `aimage` varchar(60) NOT NULL DEFAULT 'avatar.png',
  `addedby` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `datetime`, `username`, `password`, `aname`, `aheadline`, `abio`, `aimage`, `addedby`) VALUES
(15, '', 'dani56', '12345', 'Danish Malik', ' Web Designer & Dev.', 'Learn. Grow & Connect', 'admin2.png', ''),
(16, 'June 08, 2022 01:26:30', 'hammad56', '12345', 'Hammad', 'Web Designer & Dev.', 'An aspiring web developer.', 'admin1.png', 'danishulhassan');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `datetime` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `title`, `author`, `datetime`) VALUES
(12, 'Homes', 'danishulhassan', 'June 08, 2022 01:10:24'),
(13, 'Lawns', 'danishulhassan', 'June 08, 2022 01:10:31'),
(14, 'Buildings', 'danishulhassan', 'June 08, 2022 01:10:38'),
(15, 'Gardens', 'danishulhassan', 'June 08, 2022 01:10:45'),
(16, 'Tile & Marble', 'Hammad', 'June 08, 2022 10:22:25');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) NOT NULL,
  `datetime` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(60) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `approvedby` varchar(50) NOT NULL,
  `status` varchar(3) NOT NULL,
  `post_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `datetime`, `name`, `email`, `comment`, `approvedby`, `status`, `post_id`) VALUES
(28, 'June 08, 2022 01:41:59', 'Rehmat Khan', 'rehmat45@gmail.com', 'Are you available to start working?', 'DanishUlHassan', 'ON', 66),
(29, 'June 08, 2022 01:42:46', 'Malik Tajin', 'malikt@gmail.com', 'Available?', 'Hammad', 'ON', 66),
(30, 'June 08, 2022 01:43:11', 'Khan Malik', 'kmalik@gmail.com', 'Are you available to start working?', 'DanishUlHassan', 'ON', 64),
(31, 'June 08, 2022 01:43:39', 'Hamza Khan', 'khamza565@gmail.com', 'Kam kroge?', 'Hammad', 'ON', 64),
(32, 'June 08, 2022 09:52:08', 'irfaf', 'ifran@gmail.com', 'are you availabe', 'Pending', 'OFF', 70),
(33, 'June 08, 2022 09:53:12', 'junaid', 'junaid@hotmail.com', 'your team available', 'Pending', 'OFF', 68),
(34, 'June 08, 2022 09:54:20', 'kabeer', 'kabeer@gmail.com', 'available?', 'Hammad', 'ON', 63),
(35, 'June 08, 2022 09:55:19', 'yasir', 'yasir@gmail.com', 'are you available?\r\n', 'Pending', 'OFF', 69),
(36, 'June 08, 2022 09:57:06', 'haris', 'haris@gmail.com', 'available for tommorow?', 'Hammad', 'ON', 71),
(37, 'June 08, 2022 09:58:14', 'amir', 'amir@gmail.com', 'your team is available?', 'Hammad', 'ON', 61),
(38, 'June 08, 2022 09:59:26', 'faizan', 'fiazan@gmai.com', 'i want to hire you?', 'Hammad', 'ON', 56),
(39, 'June 08, 2022 10:00:41', 'azhar', 'azhar@gmail.com', 'i want hire you?', 'Hammad', 'ON', 63),
(40, 'June 08, 2022 10:01:31', 'younus', 'younus@gmail.com', 'currently available?', 'Hammad', 'ON', 61),
(41, 'June 08, 2022 10:02:20', 'ibad', 'ibad@gmail.com', 'i want hire you?', 'Pending', 'OFF', 56),
(42, 'June 08, 2022 10:03:20', 'kashif', 'kashif@gmail.com', 'i want hire you?', 'Hammad', 'ON', 59),
(43, 'June 08, 2022 10:04:29', 'faisal', 'faisal@gmail.com', 'i want hire you?', 'Hammad', 'ON', 67),
(44, 'June 08, 2022 10:06:28', 'emaan', 'emaan@hotmail.com', 'currently available?', 'Hammad', 'ON', 68),
(45, 'June 08, 2022 10:07:51', 'hamid', 'hamid@live.com', 'i want hire your team', 'Hammad', 'ON', 63),
(46, 'June 08, 2022 10:08:39', 'hammad', 'hamamdrathore@gmail.com', 'i want hire you', 'Pending', 'OFF', 56),
(47, 'June 08, 2022 10:13:08', 'yasir', 'yasir@hotmail.com', 'are you available?', 'Danish Malik', 'ON', 55),
(48, 'June 08, 2022 10:13:36', 'junaid', 'junadi@live.com', 'i want hire yo', 'Hammad', 'ON', 55),
(49, 'June 08, 2022 10:14:29', 'ibad', 'ibad@gmail.com', 'i want hire you', 'Hammad', 'ON', 55),
(50, 'June 08, 2022 10:15:36', 'junaid', 'junaid@live.com', 'i want hire you', 'Hammad', 'ON', 58),
(51, 'June 08, 2022 10:16:06', 'anis ', 'anis@hotmail.com', 'i want hire you', 'Hammad', 'ON', 58),
(52, 'June 08, 2022 10:16:56', 'haris', 'haris@gmail.com', 'currently available?', 'Danish Malik', 'ON', 58),
(53, 'June 08, 2022 10:17:48', 'saif', 'saif@gmail.com', 'are you availabe?', 'Hammad', 'ON', 57),
(54, 'June 08, 2022 10:18:31', 'hamza', 'hamza@hotmail.com', 'i want hire you', 'Hammad', 'ON', 57),
(55, 'June 08, 2022 10:19:07', 'younus', 'younus@gmail.com', 'currently available?', 'Danish Malik', 'ON', 57);

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(10) NOT NULL,
  `datetime` varchar(50) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `mobnum` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `feedback` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) NOT NULL,
  `datetime` varchar(50) NOT NULL,
  `title` varchar(300) NOT NULL,
  `category` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `post` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `datetime`, `title`, `category`, `author`, `image`, `post`) VALUES
(55, 'June 08, 2022 01:30:17', 'Umar Akmal', 'Homes', 'Hammad Rathore', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Orangi Town, Karachi\r\nContact: 03082157220'),
(56, 'June 08, 2022 01:31:57', 'Shan Masood', 'Homes', 'Hammad Rathore', 'mhp.jpeg', 'Experienced Team.\r\nMembers: 04\r\nLocation: Mehmood a bad, Karachi\r\nContact: 03082157220'),
(57, 'June 08, 2022 01:35:44', 'Junaid Khan', 'Buildings', 'DanishUlHassan', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 07\r\nLocation: Garden East, Karachi\r\nContact: 03082157220'),
(58, 'June 08, 2022 01:36:22', 'Nadeem Khan', 'Homes', 'DanishUlHassan', 'mhp.jpeg', '                            Experienced Team.\r\nMembers: 03\r\nLocation: Baldia Town, Karachi\r\nContact: 03082157220                            '),
(59, 'June 08, 2022 01:37:06', 'Abdul Razzaq', 'Buildings', 'DanishUlHassan', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Bahadurabad, Karachi\r\nContact: 03082157220'),
(60, 'June 08, 2022 01:37:52', 'Shahid Nazeer', 'Gardens', 'DanishUlHassan', 'mhp.jpeg', 'Experienced Team.\r\nMembers: 04\r\nLocation: Nazimbad no7, Karachi\r\nContact: 03082157220'),
(61, 'June 08, 2022 01:38:18', 'Imran Razzaq', 'Homes', 'DanishUlHassan', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 12\r\nLocation: Lasbella, Karachi\r\nContact: 03082157220'),
(62, 'June 08, 2022 01:38:46', 'Kami Mistri', 'Lawns', 'DanishUlHassan', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Purana GoliMar, Karachi\r\nContact: 03082157220'),
(63, 'June 08, 2022 01:39:16', 'Rehman Saeen', 'Buildings', 'DanishUlHassan', 'mhp.jpeg', 'Experienced Team.\r\nMembers: 06\r\nLocation: Pak Colony, Karachi\r\nContact: 03082157220'),
(64, 'June 08, 2022 01:39:49', 'Rao Sahab', 'Buildings', 'DanishUlHassan', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Liaqutabad no 4, Karachi\r\nContact: 03082157220'),
(65, 'June 08, 2022 01:40:21', 'Ameer Saqib', 'Buildings', 'DanishUlHassan', 'mhp.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Gulshan e Iqbal, Karachi\r\nContact: 03082157220'),
(66, 'June 08, 2022 01:40:53', 'Umar Aqib', 'Homes', 'DanishUlHassan', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Board Office, Karachi\r\nContact: 03082157220'),
(67, 'June 08, 2022 09:47:33', 'Hamid Khan', 'Lawns', 'Hammad', 'mhp.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Orangi Town, Karachi\r\nContact: 03082157220'),
(68, 'June 08, 2022 09:48:44', 'Anis Tai', 'Gardens', 'Hammad', 'mhp.jpeg', 'Experienced Team.\r\nMembers: 06\r\nLocation: saddar, Karachi\r\nContact: 03082157220'),
(69, 'June 08, 2022 09:49:32', 'Ibad', 'Homes', 'Hammad', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Mehmoodabad,Karachi\r\nContact: 03082157220'),
(70, 'June 08, 2022 09:50:01', 'Haseeb', 'Lawns', 'Hammad', 'mh-title.jpeg', 'Experienced Team.\r\nMembers: 05\r\nLocation: Orangi Town, Karachi\r\nContact: 03082157220'),
(71, 'June 08, 2022 09:50:31', 'Irfan', 'Lawns', 'Hammad', 'mhp.jpeg', 'Experienced Team.\r\nMembers: 03\r\nLocation: Orangi Town, Karachi\r\nContact: 03082157220');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `datetime` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `Foreign_Relation` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
