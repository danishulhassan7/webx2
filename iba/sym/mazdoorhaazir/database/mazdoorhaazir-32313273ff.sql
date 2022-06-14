-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: sdb-v.hosting.stackcp.net
-- Generation Time: May 27, 2022 at 05:17 PM
-- Server version: 10.4.25-MariaDB-log
-- PHP Version: 7.1.25

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
(15, '', 'dani56', '12345', 'danishulhassan', 'CS Geek', '', 'avatar.png', '');

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
(33, 'August 14, 2020 21:27:50', 'The Iconic Drama of Turkey \"Regetf ARCET\"', 'Movies', 'De Silva', 'mov7.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(34, 'August 14, 2020 21:29:12', 'Thor will be live on Twitter Today', 'Movies', 'Kraig Braithwaite', 'movie.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(35, 'August 14, 2020 21:30:03', 'Politics is more dangerous than?', 'News', 'Kraig Braithwaite', 'politics.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(36, 'August 14, 2020 21:31:04', 'Fruits and Vegetgables are necessary for good Health.', 'Food', 'Kraig Braithwaite', 'food.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(37, 'August 14, 2020 21:33:25', 'Databases needs to be upgraded !', 'Technology', 'joe Root', 'sqlconcepts.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(38, 'August 14, 2020 21:33:54', 'Artificial Intelligence is the Future !', 'Technology', 'joe Root', 'ss.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(39, 'August 14, 2020 21:34:44', 'New Technology Companies in Pakistan', 'Technology', 'joe Root', 'tec13.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(40, 'August 14, 2020 21:35:17', 'Maths > Machine Learning ?', 'Technology', 'joe Root', 'tech2.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(41, 'August 14, 2020 21:36:32', 'Web Development Jobs in Pakistan', 'Technology', 'Steven Smith', 'tech7.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(42, 'August 14, 2020 21:39:20', 'Best places to visit in PAKISTAN <3 !', 'News', 'Steven Smith', 'travelBlogger.jpg', '    Lorem ipsum dolor sit amet consectetur adipisicing elit. Nesciunt laudantium, velit nisi quasi, quaerat atque culpa facere unde placeat debitis hic eveniet totam iure repellendus deleniti sapiente ab cupiditate similique minima voluptates vero alias. Aspernatur impedit provident ea. Itaque, veniam?'),
(43, 'August 19, 2020 18:46:25', 'The Beautiful Amazon Forest', 'Nature', 'Kraig Braithwaite', 'nat4.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultrices felis. '),
(44, 'August 19, 2020 18:47:07', 'The underground life !', 'Nature', 'Kraig Braithwaite', 'nat3.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(45, 'August 19, 2020 18:50:24', 'The early morning cat', 'Animals', 'Kraig Braithwaite', 'an8.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(46, 'August 19, 2020 18:52:29', 'Balochistan\'s Story', 'News', 'Kraig Braithwaite', 'gas.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(47, 'August 19, 2020 18:54:09', 'The cute egyptian eyes cats <3', 'Animals', 'Steven Smith', 'an7.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(50, 'August 19, 2020 18:59:36', 'Nature is always beautiful', 'Nature', 'Steven Smith', 'an5.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(51, 'August 19, 2020 19:01:52', 'Nature in Night is Damn !', 'Nature', 'Steven Smith', 'an6.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(52, 'August 19, 2020 19:03:29', 'Imagination > Nature', 'Nature', 'joe Root', 'an4.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(53, 'August 19, 2020 19:03:55', 'The Angry FOX!!!!!', 'Nature', 'joe Root', 'an3.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. Sed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. Pellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.\r\n\r\nMaecenas porttitor lobortis tortor cursus scelerisque. In mattis augue ante, vel ultricies nulla eleifend in. Integer massa ante, pellentesque at justo sed, auctor dictum nunc. Sed non orci dignissim, tincidunt est sit amet, ultricestie. Nulla ullamcorper mi eros. Cras fringilla accumsan quam eu facilisis. Suspendisse potenti.'),
(54, 'August 20, 2020 15:39:08', 'The New Found in ANDROID !!', 'Technology', 'Danish Ul Hassan (XPF)', 'tech9.jpg', 'In hac habitasse platea dictumst. Etiam at lacus maximus, lacinia tellus sit amet, volutpat dui. Ut quis ornare leo, nec volutpat neque. Sed varius massa sed nibh facilisis ultrices. Donec at arcu malesuada, elementum nibh suscipit, laoreet mi. \r\n\r\nSed eget purus sed nisl elementum tempor id ut libero. Sed iaculis sem tellus, sit amet maximus sapien egestas et. Nunc imperdiet nulla id urna luctus commodo. \r\n\r\nPellentesque ac erat sed sapien dictum molestie. Proin lacinia, justo a fermentum fringilla, velit odio pretium metus, ut aliquam augue nibh id dui.');

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
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

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
