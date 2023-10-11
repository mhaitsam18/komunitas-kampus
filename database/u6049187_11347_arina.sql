-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 11, 2021 at 04:24 AM
-- Server version: 10.3.29-MariaDB-cll-lve
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u6049187_11347_arina`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id` int(11) NOT NULL,
  `id_rapat` int(11) NOT NULL,
  `judul_rapat` text NOT NULL,
  `tgl_rapat` date NOT NULL,
  `waktu_rapat` time NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `id_komunitas` int(11) NOT NULL,
  `token_komunitas` varchar(100) NOT NULL,
  `nama_komunitas` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `kehadiran` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `absensi`
--

INSERT INTO `absensi` (`id`, `id_rapat`, `judul_rapat`, `tgl_rapat`, `waktu_rapat`, `id_user`, `nama_user`, `id_komunitas`, `token_komunitas`, `nama_komunitas`, `created_at`, `kehadiran`) VALUES
(2, 6, 'Pleno 1', '2021-08-20', '18:57:00', 8, 'Eliza Maharani', 27, '16435', 'Pecinta Biawak', '2021-08-10 18:07:33', 2),
(3, 11, 'pleno1', '2021-08-18', '22:10:00', 10, 'Arina Rahma Irsyada', 34, '83062', 'memasak', '2021-08-10 22:57:12', NULL),
(4, 11, 'pleno1', '2021-08-18', '22:10:00', 12, 'Eva sofia', 34, '83062', 'memasak', '2021-08-10 22:57:12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `anggota`
--

CREATE TABLE `anggota` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `id_komunitas` int(11) NOT NULL,
  `token_komunitas` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `jabatan` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `anggota`
--

INSERT INTO `anggota` (`id`, `id_user`, `nama_user`, `id_komunitas`, `token_komunitas`, `created_at`, `jabatan`, `is_admin`) VALUES
(7, 8, 'Eliza Maharani', 27, '16435', '2021-07-28 04:15:50', 'Kordinator Pusat', 1),
(10, 8, 'Eliza Maharani', 29, '40257', '2021-08-10 17:12:58', 'CEO', 1),
(9, 8, 'Eliza Maharani', 28, '79361', '2021-08-10 16:45:50', 'sadasdsadsad', 0),
(11, 11, 'Fardan Adharizal', 30, '34697', '2021-08-10 17:31:53', 'CEO', 1),
(14, 11, 'Fardan Adharizal', 32, '47581', '2021-08-10 17:41:34', 'CEO', 1),
(15, 10, 'Arina Rahma Irsyada', 33, '19074', '2021-08-10 21:06:21', 'Bendahara', 1),
(16, 10, 'Arina Rahma Irsyada', 34, '83062', '2021-08-10 21:07:57', 'Bendahara', 1),
(17, 12, 'Eva sofia', 34, '83062', '2021-08-10 22:55:26', 'Bendahara', 0);

-- --------------------------------------------------------

--
-- Table structure for table `arsip`
--

CREATE TABLE `arsip` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `id_komunitas` int(11) NOT NULL,
  `token_komunitas` varchar(100) NOT NULL,
  `nama_komunitas` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `nama` text NOT NULL,
  `file` text NOT NULL,
  `tipe` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `arsip`
--

INSERT INTO `arsip` (`id`, `id_user`, `nama_user`, `id_komunitas`, `token_komunitas`, `nama_komunitas`, `created_at`, `nama`, `file`, `tipe`) VALUES
(5, 8, 'Eliza Maharani', 27, '16435', 'Pecinta Biawak', '2021-08-10 15:31:33', 'Pitch Deck', 'b6e9e42d481fae44789085d050444c82.pptx', 'Image');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_rapat`
--

CREATE TABLE `jadwal_rapat` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `id_komunitas` int(11) NOT NULL,
  `token_komunitas` varchar(100) NOT NULL,
  `nama_komunitas` varchar(100) NOT NULL,
  `judul_rapat` varchar(500) NOT NULL,
  `isi` text NOT NULL,
  `tanggal` varchar(100) NOT NULL,
  `waktu` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jadwal_rapat`
--

INSERT INTO `jadwal_rapat` (`id`, `created_at`, `id_komunitas`, `token_komunitas`, `nama_komunitas`, `judul_rapat`, `isi`, `tanggal`, `waktu`) VALUES
(6, '2021-08-10 15:54:29', 27, '16435', 'Pecinta Biawak', 'Pleno 1', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2021-08-20', '18:57'),
(8, '2021-08-10 17:42:10', 32, '47581', 'Komunitas Reptil', 'Rapat Pleno 1', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2021-08-13', '17:45'),
(11, '2021-08-10 21:09:21', 34, '83062', 'memasak', 'pleno1', 'pembagian staff dan koor untuk acara lomba', '2021-08-18', '22:10'),
(12, '2021-08-10 21:10:11', 34, '83062', 'memasak', 'pleno1', 'pembagian stafff', '2021-08-26', '14:10'),
(13, '2021-08-10 21:14:02', 34, '83062', 'memasak', 'pleno1', 'pembagian stafff', '2021-08-25', '14:13');

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE `komentar` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `id_thread` int(11) NOT NULL,
  `komentar` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `komentar`
--

INSERT INTO `komentar` (`id`, `created_at`, `id_user`, `nama_user`, `id_thread`, `komentar`) VALUES
(1, '0000-00-00 00:00:00', 8, 'Eliza Maharani', 1, 'Sekarang sumber air su dekat, beta sudah tida pernah terlambat lagi');

-- --------------------------------------------------------

--
-- Table structure for table `komunitas`
--

CREATE TABLE `komunitas` (
  `id` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `id_creator` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `logo` varchar(300) NOT NULL,
  `detail` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `komunitas`
--

INSERT INTO `komunitas` (`id`, `token`, `created_at`, `id_creator`, `nama`, `logo`, `detail`) VALUES
(27, '16435', '2021-07-28 04:15:50', 8, 'Pecinta Biawak', '217f06554dc40c29d1a2e20c9753b04b.png', 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
(32, '47581', '2021-08-10 17:41:34', 11, 'Komunitas Reptil', 'cd9a28b907275a019be16abedce59ef7.png', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
(31, '72963', '2021-08-10 17:35:19', 10, 'memasak', '2598f08263c71440b2af48f913440993.PNG', 'komunitas memasak'),
(34, '83062', '2021-08-10 21:07:57', 10, 'memasak', 'ef97c458da84b8cb6c636608b9e8ca2c.PNG', 'kuyyy masak');

-- --------------------------------------------------------

--
-- Table structure for table `thread`
--

CREATE TABLE `thread` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `id_komunitas` int(11) NOT NULL,
  `token_komunitas` varchar(100) NOT NULL,
  `nama_komunitas` varchar(100) NOT NULL,
  `judul` text NOT NULL,
  `isi` text NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `thread`
--

INSERT INTO `thread` (`id`, `created_at`, `id_komunitas`, `token_komunitas`, `nama_komunitas`, `judul`, `isi`, `id_user`, `nama_user`) VALUES
(1, '0000-00-00 00:00:00', 27, '16435', 'Pecinta Biawak', 'Ide Skirpsi Teknologi Untuk Mahasiswa Teknik Mesin', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 8, 'Eliza Maharani'),
(2, '0000-00-00 00:00:00', 34, '83062', 'memasak', 'pembagian staff', 'pembagian staff  dibagi sesuai divisi jabatan dikomunitas', 10, 'Arina Rahma Irsyada');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `email` varchar(100) NOT NULL,
  `password` varchar(500) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `tempat_lahir` varchar(100) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `created_at`, `email`, `password`, `nama`, `token`, `phone`, `tempat_lahir`, `tgl_lahir`, `alamat`) VALUES
(8, '2021-07-12 04:19:33', 'eliza@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Eliza Maharani', '86207', '1234567891', 'Jakarta', '2021-08-19', 'Jalan Tak Sampai'),
(9, '2021-07-12 06:39:56', 'ramsi@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Ramsi Alamsyah', '46185', '1234556', '', '0000-00-00', ''),
(10, '2021-08-10 17:25:47', 'arinalina048@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Arina Rahma Irsyada', '35902', '081234567892', '', '0000-00-00', ''),
(11, '2021-08-10 17:31:04', 'fardan@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Fardan Adharizal', '26783', '1234', '', '0000-00-00', ''),
(12, '2021-08-10 22:54:38', 'evasofia243@gmail.com', '5bd2026f128662763c532f2f4b6f2476', 'Eva sofia', '73251', '081378786548', '', '0000-00-00', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `arsip`
--
ALTER TABLE `arsip`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jadwal_rapat`
--
ALTER TABLE `jadwal_rapat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `komentar`
--
ALTER TABLE `komentar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `komunitas`
--
ALTER TABLE `komunitas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id` (`token`);

--
-- Indexes for table `thread`
--
ALTER TABLE `thread`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `token` (`token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `anggota`
--
ALTER TABLE `anggota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `arsip`
--
ALTER TABLE `arsip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `jadwal_rapat`
--
ALTER TABLE `jadwal_rapat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `komunitas`
--
ALTER TABLE `komunitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `thread`
--
ALTER TABLE `thread`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
