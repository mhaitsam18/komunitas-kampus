-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 21, 2021 at 07:13 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bismillah`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pdelete_pendataan_warga` (IN `v_id` VARCHAR(10))  NO SQL
BEGIN
DELETE FROM pendataan_warga WHERE id_warga = v_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pinsert_registrasi_user` (IN `v_username` VARCHAR(10), IN `v_password` VARCHAR(100), IN `v_no_rumah` VARCHAR(10), IN `v_nama` VARCHAR(50), IN `v_foto` VARCHAR(100), IN `v_status` VARCHAR(20), IN `v_id` VARCHAR(10))  NO SQL
BEGIN
INSERT INTO pendataan_warga (id_warga, no_rumah, nama, username, password, foto_ktp, status) VALUES (v_id, v_no_rumah, v_nama, v_username, v_password, v_foto, v_status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `priwayat_pembayaran_iuran` ()  BEGIN
SELECT id_warga,nama,friwayat_pendataan_warga(id) AS Status FROM riwayat_pendataan_warga;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `priwayat_pendataan_warga` ()  BEGIN
SELECT id_warga,nama,friwayat_pendataan_warga(id_warga) AS Status FROM riwayat_pendataan_warga;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pview_pendataan_warga` ()  NO SQL
BEGIN
SELECT * FROM pendataan_warga;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `friwayat_pembayaran_iuran` (`tagihan` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 BEGIN
DECLARE status VARCHAR(255);
DECLARE hasil VARCHAR(255);
SELECT IF(tanggal_diterima IS NOT NULL, 'Benar', 'Salah') INTO status FROM riwayat_pembayaran_iuran WHERE no_tagihan=tagihan;
IF status = 'Benar' THEN
SET hasil = 'Sudah Bayar Iuran';
ELSE
SET hasil = 'Belum Bayar Iuran';
END IF;
RETURN(hasil);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `friwayat_pendataan_warga` (`id` VARCHAR(20)) RETURNS VARCHAR(255) CHARSET latin1 BEGIN
DECLARE status VARCHAR(255);
DECLARE hasil VARCHAR(255);
SELECT IF(tanggal_ubah IS NOT NULL, 'Benar', 'Salah') INTO status FROM riwayat_pendataan_warga WHERE id_warga = id;
IF status = 'Benar' THEN
SET hasil = 'Terverifikasi';
ELSE
SET hasil = 'Belum Terverifikasi';
END IF;
RETURN(hasil);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fview_total_warga` () RETURNS VARCHAR(100) CHARSET latin1 NO SQL
    DETERMINISTIC
BEGIN
DECLARE total VARCHAR(100);
SELECT COUNT(id_warga) INTO total FROM pendataan_warga;
RETURN total;
END$$

DELIMITER ;

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
(4, 11, 'pleno1', '2021-08-18', '22:10:00', 12, 'Eva sofia', 34, '83062', 'memasak', '2021-08-10 22:57:12', 1),
(5, 14, 'Membahas Struktur', '2021-08-20', '12:28:00', 30, 'Muhammad Haitsam', 36, '12370', 'HMDSI', '2021-08-11 12:35:38', 1);

-- --------------------------------------------------------

--
-- Table structure for table `acara`
--

CREATE TABLE `acara` (
  `id` int(11) NOT NULL,
  `id_organisasi` int(11) NOT NULL,
  `nama_acara` varchar(255) NOT NULL,
  `penyelenggara` varchar(255) NOT NULL,
  `tanggal_dimulai` date NOT NULL,
  `waktu_dimulai` time NOT NULL,
  `tanggal_berakhir` date NOT NULL,
  `waktu_berakhir` time NOT NULL,
  `poster` varchar(255) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `tanggal_dibuat` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acara`
--

INSERT INTO `acara` (`id`, `id_organisasi`, `nama_acara`, `penyelenggara`, `tanggal_dimulai`, `waktu_dimulai`, `tanggal_berakhir`, `waktu_berakhir`, `poster`, `keterangan`, `tanggal_dibuat`) VALUES
(4, 1, 'UKM Fair', 'TelU', '2021-06-16', '00:00:00', '2021-06-16', '00:00:00', 'default.jpg', 'Pameran UKM', '0000-00-00 00:00:00'),
(5, 1, 'Pameran Perhotelan', 'HMPH', '2021-04-16', '00:00:00', '2021-06-16', '00:00:00', 'default.jpg', 'Pameran beserta bazar', '0000-00-00 00:00:00'),
(7, 1, 'OASIS', 'HMDSI', '2021-06-02', '09:10:00', '2021-06-02', '14:10:00', '1200px-Telkom_University_Logo_svg1.png', 'oke', '0000-00-00 00:00:00'),
(8, 1, 'Technovation', 'HMMI', '2021-06-09', '23:59:00', '2021-06-10', '00:00:00', '1200px-Telkom_University_Logo_svg2.png', 'Acara 17 Agustus', '2021-06-09 10:01:26'),
(9, 1, 'OASIS', 'HMDSI', '2021-07-29', '18:26:00', '2021-07-30', '18:28:00', 'resize-pas_1.jpg', 'coba', '2021-07-25 06:25:16');

-- --------------------------------------------------------

--
-- Table structure for table `agama`
--

CREATE TABLE `agama` (
  `id` int(11) NOT NULL,
  `agama` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `agama`
--

INSERT INTO `agama` (`id`, `agama`) VALUES
(1, 'Islam'),
(2, 'Kristen Protestan'),
(3, 'Kristen Katolik'),
(4, 'Budha'),
(5, 'Hindu'),
(6, 'Konghucu');

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
(17, 12, 'Eva sofia', 34, '83062', '2021-08-10 22:55:26', 'Bendahara', 0),
(18, 30, 'Muhammad Haitsam', 36, '12370', '2021-08-11 11:42:27', 'CEO', 1),
(19, 1, 'Alya Putri Maharani', 36, '12370', '2021-08-11 13:22:15', 'Domba Tersesat', 1),
(20, 30, 'Muhammad Haitsam', 37, '16482', '2021-08-11 13:28:18', 'CEO', 1),
(21, 10, 'Arina Rahma Irsyada', 36, '12370', '2021-08-17 22:37:46', 'CFO', 0),
(22, 2, 'Olga Paurenta Simanihuruk', 34, '83062', '2021-08-30 10:39:57', 'Bendahara', 0),
(23, 2, 'Olga Paurenta Simanihuruk', 38, '89723', '2021-08-30 10:53:16', 'CFO', 1);

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
(5, 8, 'Eliza Maharani', 27, '16435', 'Pecinta Biawak', '2021-08-10 15:31:33', 'Pitch Deck', 'b6e9e42d481fae44789085d050444c82.pptx', 'Image'),
(6, 10, 'Arina Rahma Irsyada', 34, '83062', 'memasak', '2021-08-17 23:12:01', 'Dokumen', '5b606aab5c8a3d704f9aa6b4aa77f611.docx', 'Dokumen'),
(7, 30, 'Muhammad Haitsam', 36, '12370', 'HMDSI', '2021-08-17 23:18:58', 'HMDSI itu ya gitu', '5660078e9031dbcbf89e3e0c8d69dfd6.docx', 'Dokumen');

-- --------------------------------------------------------

--
-- Table structure for table `bukti_transfer`
--

CREATE TABLE `bukti_transfer` (
  `id` int(11) NOT NULL,
  `id_invoice` int(11) NOT NULL,
  `id_rekening_tujuan` int(11) NOT NULL,
  `rekening_pengirim` varchar(128) NOT NULL,
  `bank_pengirim` varchar(100) NOT NULL,
  `nama_pengirim` varchar(128) NOT NULL,
  `waktu_transfer` datetime NOT NULL,
  `nominal_transfer` float(14,2) NOT NULL,
  `bukti_pembayaran` varchar(255) NOT NULL,
  `catatan` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bukti_transfer`
--

INSERT INTO `bukti_transfer` (`id`, `id_invoice`, `id_rekening_tujuan`, `rekening_pengirim`, `bank_pengirim`, `nama_pengirim`, `waktu_transfer`, `nominal_transfer`, `bukti_pembayaran`, `catatan`, `status`) VALUES
(1, 1, 2, '0123', 'BNI', 'Olga Paurenta', '2021-04-02 17:57:00', 2000000.00, 'Olga_Paurenta.png', 'makasih yak', 'Pembayaran tidak%20valid'),
(2, 1, 2, '012345', 'BNI', 'Olga Paurenta', '2021-04-02 17:57:00', 2000000.00, 'Olga_Paurenta1.png', 'makasih yak', 'Pembayaran valid'),
(3, 3, 1, '1203129039213', 'BNI', 'Hariadi Arfah', '2021-04-14 23:52:00', 207000.00, '0.jpg', 'makasih ya', 'Pembayaran tidak%20valid'),
(4, 5, 1, '1203129039213', 'BNI', 'Olga Paurenta', '2021-04-15 11:10:00', 12000.00, 'pempek.jpg', 'oke', 'Pembayaran valid'),
(5, 6, 1, '821982173', 'BNI', 'Olga Paurenta', '2021-04-08 17:28:00', 12000.00, 'foto.jpg', '', 'Pembayaran valid'),
(6, 8, 2, '1203129039213', 'BNI', 'Olga Paurenta', '2021-05-28 08:42:00', 12000.00, 'ahaitsam.jpg', 'makasih', 'Pembayaran valid'),
(7, 9, 6, '1203129039213', 'BNI', 'Alya Putri Maharani', '2021-06-10 16:08:00', 30000.00, '1200px-Telkom_University_Logo_svg.png', 'udeh', 'Pembayaran valid'),
(8, 10, 5, '1203129039213', 'BNI', 'Alya Putri Maharani', '2021-06-15 10:25:00', 75000.00, '1200px-Telkom_University_Logo_svg1.png', 'oke', 'Belum dikonfirmasi'),
(9, 11, 5, '1203129039213', 'BNI', 'Akib Dahlan', '2021-06-15 11:10:00', 25000.00, '1200px-Telkom_University_Logo_svg2.png', 'Ambil kembaliannya', 'Belum dikonfirmasi');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `id_user_from` int(11) NOT NULL,
  `id_user_to` int(11) NOT NULL,
  `message` text NOT NULL,
  `time` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `is_read` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`id`, `id_user_from`, `id_user_to`, `message`, `time`, `status`, `is_read`) VALUES
(1, 1, 3, 'Halo, Nama aku Alya, saya ingin berteman dengan kamu :)', '2021-07-22 14:21:00', 1, 1),
(2, 3, 1, 'Halo juga Alya, aku juga mau kok berteman sama kamu :*', '2021-07-23 14:36:00', 1, 1),
(3, 1, 3, 'kib?', '2021-07-25 14:41:29', 1, 1),
(4, 1, 3, 'halo', '2021-07-25 14:42:12', 1, 1),
(5, 1, 3, 'Halo kib? kok ga bales<br />\ntes 123', '2021-07-25 14:43:15', 1, 1),
(6, 1, 3, 'diread doang, parah ih', '2021-07-25 14:44:08', 1, 1),
(7, 1, 3, 'tes', '2021-07-25 14:45:00', 1, 1),
(8, 1, 3, 'oke', '2021-07-25 14:45:23', 1, 1),
(9, 1, 3, 'tes lagi', '2021-07-25 14:46:32', 1, 1),
(10, 1, 3, 'oke deh', '2021-07-25 14:47:17', 1, 1),
(11, 1, 3, 'halo kib<br />\n', '2021-07-25 14:48:51', 1, 1),
(12, 1, 3, 'coba lagi', '2021-07-25 14:49:36', 1, 1),
(13, 3, 1, 'iyaaa,, ini aku bales, ada apa?', '2021-07-25 14:53:14', 1, 1),
(14, 1, 26, 'coba lagi', '2021-07-25 16:50:44', 1, 0),
(15, 1, 26, 'halo firman<br />\r\n', '2021-07-25 16:51:42', 1, 0),
(16, 1, 3, 'tes<br />\n', '2021-07-25 16:52:11', 1, 1),
(17, 1, 3, 'oke', '2021-07-25 16:56:58', 1, 1),
(18, 1, 26, 'man, kok ga jawab?', '2021-07-25 16:57:12', 1, 0),
(19, 1, 26, 'wokkey, berhasil', '2021-07-25 16:58:27', 1, 0),
(20, 1, 3, 'coba<br />\n', '2021-07-25 17:03:28', 1, 1),
(21, 1, 3, 'oke', '2021-07-25 17:03:31', 1, 1),
(22, 1, 2, 'Halo tsay', '2021-07-25 17:53:08', 1, 0),
(23, 1, 3, 'hai', '2021-07-25 19:00:38', 1, 1),
(24, 1, 26, 'maaannn', '2021-07-25 20:17:08', 1, 0),
(25, 1, 26, 'bales doong', '2021-07-25 20:17:12', 1, 0),
(26, 1, 26, ':((', '2021-07-25 20:17:13', 1, 0),
(27, 1, 26, 'okeee', '2021-07-25 20:20:38', 1, 0),
(28, 1, 26, 'okee<br />\n<br />\n<br />\nbalas dong', '2021-07-25 20:20:52', 1, 0),
(29, 1, 3, 'akiiibb', '2021-07-28 15:04:04', 1, 1),
(30, 1, 3, 'kok ga bales2 sihhh', '2021-07-28 15:04:08', 1, 1),
(31, 1, 3, 'halo<br />\nbaris baru', '2021-07-28 15:04:29', 1, 1),
(32, 3, 1, 'iya Al, ada apa sih???', '2021-07-28 15:05:02', 1, 1),
(33, 1, 3, 'ini kib, aku mau ngomong', '2021-07-28 15:06:06', 1, 1),
(34, 3, 1, 'halo', '2021-07-28 23:49:14', 1, 1),
(35, 1, 26, 'halooo', '2021-07-29 19:49:52', 1, 0),
(36, 1, 3, 'iya halo', '2021-09-21 21:55:11', 1, 1),
(37, 3, 1, 'jadi begini', '2021-09-21 21:57:15', 1, 1),
(38, 1, 26, 'ok', '2021-09-21 22:23:09', 1, 0),
(39, 1, 2, 'TES OLGA', '2021-09-21 22:26:55', 1, 0),
(40, 1, 3, 'iya gimana?', '2021-09-21 22:59:19', 1, 1),
(41, 3, 1, 'ya gitu deh', '2021-09-21 23:01:59', 1, 1),
(42, 3, 1, 'kamu lagi apa btw?', '2021-09-21 23:02:07', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `dashboard`
--

CREATE TABLE `dashboard` (
  `id` int(11) NOT NULL,
  `header` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `footer` varchar(256) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `contact` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dashboard`
--

INSERT INTO `dashboard` (`id`, `header`, `title`, `content`, `footer`, `icon`, `contact`) VALUES
(1, 'Dashboard', 'Bismillah', 'Bismillahirrohmanirrohim', 'Bismillah', 'fas fa-user', '+62 869-1223-900');

-- --------------------------------------------------------

--
-- Table structure for table `divisi`
--

CREATE TABLE `divisi` (
  `id` int(11) NOT NULL,
  `id_rekruitasi` int(11) NOT NULL,
  `nama_divisi` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `divisi`
--

INSERT INTO `divisi` (`id`, `id_rekruitasi`, `nama_divisi`) VALUES
(1, 1, 'DISIS'),
(2, 1, 'SCHEPSIS'),
(3, 1, 'ESIS'),
(4, 2, 'Divisi Acara');

-- --------------------------------------------------------

--
-- Table structure for table `ikuti_organisasi`
--

CREATE TABLE `ikuti_organisasi` (
  `id` int(11) NOT NULL,
  `id_organisasi` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ikuti_organisasi`
--

INSERT INTO `ikuti_organisasi` (`id`, `id_organisasi`, `id_user`, `status`) VALUES
(7, 1, 3, 1),
(8, 3, 3, 1),
(9, 1, 26, 1),
(10, 3, 26, 1),
(11, 2, 26, 1),
(25, 1, 25, 0),
(26, 1, 2, 1),
(28, 3, 1, 1),
(31, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `id_member` int(11) NOT NULL,
  `id_tiket` int(11) NOT NULL,
  `kode_bayar` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total_harga` float(14,2) NOT NULL,
  `waktu_pemesanan` datetime NOT NULL,
  `id_metode_bayar` int(11) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`id`, `id_member`, `id_tiket`, `kode_bayar`, `email`, `jumlah`, `total_harga`, `waktu_pemesanan`, `id_metode_bayar`, `status`) VALUES
(1, 1, 1, '8FB93EBCF40943DF5330353E99EF0AF2', '081289182332', 1, 30000.00, '2021-04-02 17:41:04', 1, 'Sudah dibayar'),
(2, 1, 1, '4102FE967A078974F3C1E7E262F35496', '081201232133', 1, 30000.00, '2021-04-02 17:45:59', 1, 'Sudah dibayar'),
(3, 1, 1, '12014315B3CF8568FDA938443AD17EEB', '02130129321', 2, 60000.00, '2021-04-02 23:46:56', 1, 'Sudah dibayar'),
(4, 1, 1, 'F461ACCDCCD98119530336C1264B83DD', '0821312312', 1, 30000.00, '2021-04-04 14:37:21', 1, 'Sudah dibayar'),
(5, 1, 1, 'C8B2FC07CE7D9D56697671F0DADF7E53', '081210231', 3, 90000.00, '2021-04-05 11:04:05', 1, 'Sudah dibayar'),
(6, 3, 1, 'BBADBB7A82E6E8C6011F649A644E1851', '0123456789', 1, 30000.00, '2021-04-06 13:27:37', 1, 'Sudah dibayar'),
(7, 1, 1, '3FCA8A16A43A25A62492938D96C8C21B', '1234', 1, 30000.00, '2021-04-06 13:47:17', 1, 'Sudah dibayar'),
(8, 1, 1, '21E7BFBC9D9361F9358BD5B3921476DC', '082117503125', 1, 30000.00, '2021-05-15 08:39:11', 1, 'Sudah dibayar'),
(9, 1, 1, 'AAF416B3797230FE0E3B9C45A8927C98', '082117503125', 1, 30000.00, '2021-05-15 08:41:54', 1, 'Sudah dibayar'),
(10, 1, 2, '40EF320CB6D2E22AE63D', 'alfiana@gmail.com', 3, 75000.00, '2021-06-15 10:24:48', 1, 'Sudah dibayar'),
(11, 23, 2, '87E2BE75C912B4282992', 'akibdahlan20@gmail.com', 1, 25000.00, '2021-06-15 11:09:54', 1, 'Sudah dibayar'),
(12, 1, 2, '47EFCF81C4FDE1D64405', 'haitsam03@gmail.com', 1, 25000.00, '2021-06-15 11:14:42', 1, 'Pesanan dibatalkan'),
(13, 1, 2, 'B4F327413B9417A7E003', 'haitsam03@gmail.com', 1, 25000.00, '2021-06-18 23:37:16', 1, 'Belum dibayar'),
(14, 1, 3, '52E09AF69AD1C1CED6D3', 'haitsam03@gmail.com', 1, 0.00, '2021-08-30 01:20:42', 1, 'Belum dibayar'),
(15, 1, 2, 'C86076347278F9D862B1', 'haitsam03@gmail.com', 1, 25000.00, '2021-09-01 09:41:20', 1, 'Belum dibayar'),
(16, 33, 2, '408926AA21DF516949ED', 'mhaitsam17@gmail.com', 1, 25000.00, '2021-09-01 09:52:20', 1, 'Belum dibayar'),
(17, 1, 3, 'DA83FFFB615A93F148EC', 'haitsam03@gmail.com', 3, 0.00, '2021-09-22 00:10:10', 1, 'Belum dibayar');

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
(1, '2021-08-11 11:26:59', 0, '25164', 'Joker Telyu', 'Membahas Struktur', 'intinya mah begitu', '2021-08-11', '16:30'),
(6, '2021-08-10 15:54:29', 27, '16435', 'Pecinta Biawak', 'Pleno 1', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2021-08-20', '18:57'),
(8, '2021-08-10 17:42:10', 32, '47581', 'Komunitas Reptil', 'Rapat Pleno 1', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2021-08-13', '17:45'),
(11, '2021-08-10 21:09:21', 34, '83062', 'memasak', 'pleno1', 'pembagian staff dan koor untuk acara lomba', '2021-08-18', '22:10'),
(12, '2021-08-10 21:10:11', 34, '83062', 'memasak', 'pleno1', 'pembagian stafff', '2021-08-26', '14:10'),
(13, '2021-08-10 21:14:02', 34, '83062', 'memasak', 'pleno1', 'pembagian stafff', '2021-08-25', '14:13'),
(14, '2021-08-11 12:22:13', 36, '12370', 'HMDSI', 'Membahas Struktur', 'Oke', '2021-08-20', '12:28');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_notifikasi`
--

CREATE TABLE `kategori_notifikasi` (
  `id` int(11) NOT NULL,
  `kategori_notifikasi` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori_notifikasi`
--

INSERT INTO `kategori_notifikasi` (`id`, `kategori_notifikasi`) VALUES
(1, 'Notifikasi'),
(2, 'Permintaan Teman'),
(3, 'Pembayaran\r\n'),
(4, 'Undangan'),
(5, 'chat');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_organisasi`
--

CREATE TABLE `kategori_organisasi` (
  `id` int(11) NOT NULL,
  `kategori_organisasi` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori_organisasi`
--

INSERT INTO `kategori_organisasi` (`id`, `kategori_organisasi`) VALUES
(1, 'Kepemimpinan'),
(2, 'Penalaran'),
(3, 'Sosial'),
(4, 'Keagamaan'),
(5, 'Kewirausahaan');

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE `komentar` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `id_thread` int(11) NOT NULL,
  `komentar` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `komentar`
--

INSERT INTO `komentar` (`id`, `created_at`, `id_user`, `nama_user`, `id_thread`, `komentar`) VALUES
(1, '0000-00-00 00:00:00', 8, 'Eliza Maharani', 1, 'Sekarang sumber air su dekat, beta sudah tida pernah terlambat lagi'),
(2, '0000-00-00 00:00:00', 30, 'Muhammad Haitsam', 3, 'aku juga ga tau'),
(3, '2021-08-11 12:01:18', 30, 'Muhammad Haitsam', 3, 'halo');

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
  `detail` text NOT NULL,
  `is_valid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `komunitas`
--

INSERT INTO `komunitas` (`id`, `token`, `created_at`, `id_creator`, `nama`, `logo`, `detail`, `is_valid`) VALUES
(27, '16435', '2021-07-28 04:15:50', 8, 'Pecinta Biawak', '217f06554dc40c29d1a2e20c9753b04b.png', 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum', 0),
(32, '47581', '2021-08-10 17:41:34', 11, 'Komunitas Reptil', 'cd9a28b907275a019be16abedce59ef7.png', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 0),
(31, '72963', '2021-08-10 17:35:19', 10, 'memasak', '2598f08263c71440b2af48f913440993.PNG', 'komunitas memasak', 1),
(34, '83062', '2021-08-10 21:07:57', 10, 'memasak', 'ef97c458da84b8cb6c636608b9e8ca2c.PNG', 'kuyyy masak', 1),
(36, '12370', '2021-08-11 11:42:27', 30, 'HMDSI', '7eadcb1e4840de9e7ad619fc64697e6c.png', 'Oke', 1),
(37, '16482', '2021-08-11 13:28:18', 30, 'Pencinta Alam', 'c2d4b495d3444de06b28d066890939d2.png', 'Manjat Tebing', 1),
(38, '89723', '2021-08-30 10:53:16', 2, 'Komunitas Anak D3SI-42-02', 'c0c7be0a59d70249edc0df5fee1d6ddc.png', 'ini komunitas anak 02 only', 1);

-- --------------------------------------------------------

--
-- Table structure for table `metode_bayar`
--

CREATE TABLE `metode_bayar` (
  `id` int(11) NOT NULL,
  `metode_bayar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `metode_bayar`
--

INSERT INTO `metode_bayar` (`id`, `metode_bayar`) VALUES
(1, 'Transfer'),
(2, 'Virtual Account'),
(3, 'OVO'),
(4, 'DANA');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_kategori_notifikasi` int(11) NOT NULL,
  `sub_id` int(11) DEFAULT NULL,
  `waktu_notifikasi` datetime NOT NULL,
  `subjek` varchar(128) NOT NULL,
  `pesan` varchar(255) NOT NULL,
  `is_read` int(11) NOT NULL,
  `id_creator` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifikasi`
--

INSERT INTO `notifikasi` (`id`, `id_user`, `id_kategori_notifikasi`, `sub_id`, `waktu_notifikasi`, `subjek`, `pesan`, `is_read`, `id_creator`) VALUES
(1, 1, 1, 1, '2021-07-04 13:36:00', 'Notification', 'Spending Alert: We\'ve noticed unusually high spending for your account.', 1, 0),
(3, 1, 3, 1, '2021-07-04 14:00:00', 'Anggota Eksekutif Baru	\r\n', 'A new monthly report is ready to download!', 1, NULL),
(4, 1, 1, 4, '2021-07-05 07:47:25', 'Pemesanan dibatalkan', 'Pemesanan Anda dibatalkan', 1, 1),
(5, 1, 1, 5, '2021-07-05 08:31:57', 'Pemesanan dibatalkan', 'Pemesanan Anda dibatalkan', 1, 1),
(8, 2, 4, 13, '2021-07-18 22:05:59', 'Undangan Organisasi', 'Alya Putri Maharani ikuti Organisasi kami', 1, 1),
(14, 25, 4, 19, '2021-07-18 22:31:20', 'Undangan Organisasi', 'Undangan Bismillah', 0, 1),
(15, 25, 4, 20, '2021-07-18 22:32:23', 'Undangan Organisasi', 'Undangan Bismillah', 0, 1),
(16, 25, 4, 21, '2021-07-18 22:32:27', 'Undangan Organisasi', 'Undangan Bismillah', 0, 1),
(17, 25, 4, 22, '2021-07-18 22:33:16', 'Undangan Organisasi', 'Undangan Bismillah', 0, 1),
(18, 25, 4, 23, '2021-07-18 22:36:08', 'Undangan Organisasi', 'Undangan Bismillah', 0, 1),
(19, 25, 4, 24, '2021-07-18 22:38:50', 'Undangan Organisasi', 'Undangan Bismillah', 0, 1),
(20, 25, 4, 25, '2021-07-18 22:40:27', 'Undangan Organisasi', 'Undangan Bismillah', 0, 1),
(22, 2, 2, 8, '2021-07-25 16:25:44', 'Permintaan Teman', 'Alya Putri Maharani ingin menjadi teman Anda', 0, 1),
(23, 2, 2, 9, '2021-07-25 16:28:41', 'Permintaan Teman', 'Alya Putri Maharani ingin menjadi teman Anda', 0, 1),
(25, 25, 2, 11, '2021-07-25 20:19:12', 'Permintaan Teman', 'Alya Putri Maharani ingin menjadi teman Anda', 0, 1),
(26, 1, 5, 34, '2021-07-28 23:49:14', 'Pesan baru', 'halo', 1, 3),
(27, 1, 5, 37, '2021-09-21 21:57:15', 'Pesan baru', 'Jadi begini', 1, 3),
(28, 3, 5, 40, '2021-09-21 22:59:19', 'Pesan baru', 'iya gimana?', 1, 1),
(29, 1, 5, 41, '2021-09-21 23:01:59', 'Pesan baru', 'ya gitu deh', 1, 3),
(30, 1, 5, 42, '2021-09-21 23:02:07', 'Pesan baru', 'kamu lagi apa btw?', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `organisasi`
--

CREATE TABLE `organisasi` (
  `id` int(11) NOT NULL,
  `id_pengurus` int(11) NOT NULL,
  `nama_organisasi` varchar(128) NOT NULL,
  `singkatan` varchar(128) NOT NULL,
  `deskripsi` text NOT NULL,
  `logo` varchar(255) NOT NULL,
  `id_kategori_organisasi` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organisasi`
--

INSERT INTO `organisasi` (`id`, `id_pengurus`, `nama_organisasi`, `singkatan`, `deskripsi`, `logo`, `id_kategori_organisasi`, `status`) VALUES
(1, 1, 'Himpunan Mahasiswa Indonesia', 'HMI', 'Organisasi yang menghimpun Organisasi di Telkom University, sekaligus admin dari Aplikasi ini', '1200px-Telkom_University_Logo_svg.png', 1, 1),
(2, 2, 'Sosmas', 'S', 'Organisasi yang biasa aja', 'default.png', 2, 1),
(3, 25, 'HMI Telkom University', 'Himpunan Mahasiswa Islam', 'Ini Organisasi jadi-jadian', 'scan.jpg', 4, 1),
(4, 30, '', '', '', 'default.png', 0, 0),
(5, 31, '', '', '', 'default.png', 0, 0),
(6, 32, '', '', '', 'default.png', 0, 0),
(7, 10, '', '', '', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `panitia`
--

CREATE TABLE `panitia` (
  `id` int(11) NOT NULL,
  `nim` varchar(128) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `file_cv` varchar(255) NOT NULL,
  `id_pilihan_divisi_1` int(11) NOT NULL,
  `id_pilihan_divisi_2` int(11) NOT NULL,
  `divisi` int(11) NOT NULL,
  `id_rekruitasi` int(11) NOT NULL,
  `status` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `panitia`
--

INSERT INTO `panitia` (`id`, `nim`, `nama_lengkap`, `email`, `file_cv`, `id_pilihan_divisi_1`, `id_pilihan_divisi_2`, `divisi`, `id_rekruitasi`, `status`) VALUES
(1, '6701180090', 'Ardhiani Laura Kusumastuti', '', 'ardhiani.pdf', 1, 2, 0, 1, 'Belum diterima\r\n'),
(2, '6701180023', 'Indah Mayang Sari Sitompul', '', 'AMP_43-03.pdf', 4, 4, 0, 2, 'Sudah diterima'),
(3, '6701190050', 'Alifia Sabila Azzahra.', 'alya.pmaharani@gmail.com', 'Modul-X.pdf', 4, 4, 0, 2, 'Tidak diterima'),
(4, '6701184042', 'Akib Dahlan', 'akibdahlan20@gmail.com', 'MANUAL_PENGGUNA_SIMASPRAK_Rev__1_0.pdf', 4, 4, 0, 2, 'Belum diterima');

-- --------------------------------------------------------

--
-- Table structure for table `pertemanan`
--

CREATE TABLE `pertemanan` (
  `id` int(11) NOT NULL,
  `id_user1` int(11) NOT NULL,
  `id_user2` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `waktu` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pertemanan`
--

INSERT INTO `pertemanan` (`id`, `id_user1`, `id_user2`, `status`, `waktu`) VALUES
(5, 26, 3, 1, '2021-07-09 07:27:27'),
(6, 26, 1, 1, '2021-07-21 03:15:42'),
(7, 1, 3, 1, '2021-07-22 16:26:21'),
(10, 2, 1, 1, '2021-07-25 16:29:34');

-- --------------------------------------------------------

--
-- Table structure for table `rekening`
--

CREATE TABLE `rekening` (
  `id` int(11) NOT NULL,
  `id_tiket` int(11) NOT NULL,
  `bank` varchar(255) NOT NULL,
  `no_rekening` varchar(255) NOT NULL,
  `atas_nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rekening`
--

INSERT INTO `rekening` (`id`, `id_tiket`, `bank`, `no_rekening`, `atas_nama`, `email`) VALUES
(1, 0, 'Mandiri', '1234567890', 'Delvira Nur Zahrah', 'delvira@gmail.com'),
(2, 0, 'BNI', '0987654321', 'Muhammad Haitsam', 'haitsam03@gmail.com'),
(3, 0, 'BCA', '123120491023', 'Muhammad ashraf Hidayat', 'ashraf.muhammad@gmail.com'),
(4, 0, 'BRI', '0128102380912', 'Rini Sarlita', 'riniastkepsarlita@gmail.com'),
(5, 2, 'BCA', '123456', 'Alya Putri Maharani', 'alya.pmaharani@gmail.com'),
(6, 1, 'Mandirii', '1234', 'Nurul Fadhilah', 'nurul@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `rekruitasi`
--

CREATE TABLE `rekruitasi` (
  `id` int(11) NOT NULL,
  `id_acara` int(11) NOT NULL,
  `batas_waktu` datetime NOT NULL,
  `catatan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rekruitasi`
--

INSERT INTO `rekruitasi` (`id`, `id_acara`, `batas_waktu`, `catatan`) VALUES
(1, 7, '2021-06-30 00:00:00', 'Jangan Telat'),
(2, 8, '2022-01-01 23:59:00', '-');

-- --------------------------------------------------------

--
-- Table structure for table `thread`
--

CREATE TABLE `thread` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
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
(2, '0000-00-00 00:00:00', 34, '83062', 'memasak', 'pembagian staff', 'pembagian staff  dibagi sesuai divisi jabatan dikomunitas', 10, 'Arina Rahma Irsyada'),
(3, '0000-00-00 00:00:00', 36, '12370', 'HMDSI', 'oke', 'thread buat apa?', 30, 'Muhammad Haitsam'),
(4, '2021-08-11 12:42:57', 36, '12370', 'HMDSI', 'Anggota Eksekutif Baru', 'Gais, ada anggota baru. belagu', 30, 'Muhammad Haitsam');

-- --------------------------------------------------------

--
-- Table structure for table `tiket`
--

CREATE TABLE `tiket` (
  `id` int(11) NOT NULL,
  `harga` float(15,2) NOT NULL,
  `id_acara` int(11) NOT NULL,
  `stok_tiket` int(11) NOT NULL,
  `jumlah_terjual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiket`
--

INSERT INTO `tiket` (`id`, `harga`, `id_acara`, `stok_tiket`, `jumlah_terjual`) VALUES
(1, 30000.00, 7, 120, 12),
(2, 25000.00, 8, 120, 7),
(3, 0.00, 4, 100, 4);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `gender` varchar(128) NOT NULL,
  `place_of_birth` varchar(128) NOT NULL,
  `birthday` date DEFAULT NULL,
  `phone_number` varchar(128) NOT NULL,
  `address` varchar(255) NOT NULL,
  `religion_id` int(11) NOT NULL,
  `image` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `date_created` int(11) NOT NULL,
  `token` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `gender`, `place_of_birth`, `birthday`, `phone_number`, `address`, `religion_id`, `image`, `password`, `role_id`, `is_active`, `date_created`, `token`, `created_at`) VALUES
(1, 'Alya Putri Maharani', 'alya.pmaharani@gmail.com', 'Perempuan', 'Bandung', '2000-06-25', '089631424631', 'Jl. Sukapura, No. 36, Desa Sukapura, Kec. Dayeuhkolot, Kab. Bandung, Jawa Barat', 1, 'alya.jpeg', '$2y$10$yFaxQ6OR.n8SLvWDdUS6iuq4ukoCz.WGHu6QnjyTnv6vBn3Xc0nbe', 0, 1, 1609656473, 0, '2021-08-11 09:55:06'),
(2, 'Olga Paurenta Simanihuruk', 'olgapaurenta11@gmail.com', 'Perempuan', 'Medan', '2000-11-26', '082169006807', 'Jl Jahe 13 No 3 Simalingkar, Kelurahan Mangga, Kecamatan Medan Tuntungan, Kota Medan  Kode Pos 20141', 2, 'default.jpg', '$2y$10$DLCp6ce7jyHem7q/eNcPbOeYeuU8dp3kwtgZ5lz3aVsDaIJsgjPHu', 2, 1, 1609657135, 0, '2021-08-11 09:55:06'),
(3, 'Akib Dahlan', 'akibdahlan20@gmail.com', 'Laki-laki', 'Palembang', '2000-02-20', '082289412433', 'PGA', 1, 'default.svg', '$2y$10$HVFG5RnAq4MpTWNV6jm0EuPiVy0gfpJmQSuT5WE03uzGIdeMZItV.', 1, 1, 1623729434, 0, '2021-08-11 09:55:06'),
(10, 'Arina Rahma Irsyada', 'arinalina048@gmail.com', 'Perempuan', 'Bandung', '2000-10-11', '082102192012', 'Jl. Cikoneng', 1, 'default.svg', '$2y$10$HVFG5RnAq4MpTWNV6jm0EuPiVy0gfpJmQSuT5WE03uzGIdeMZItV.', 2, 1, 1623729434, 35902, '2021-08-11 10:32:17'),
(25, 'Rini Sarlita', 'riniastkepsarlita@gmail.com', 'Perempuan', 'Duri', '2002-03-25', '0812123123123', 'Jl. Mandau', 1, 'default.svg', '$2y$10$EZU1tpb4VnU8/gaWUnzd2.gIqrNgAlX7bJ7ELMgAdznKQ0Konjbd.', 2, 1, 1626594066, 0, '2021-08-11 09:55:06'),
(26, 'Firman Aldo Saputra', 'fasaldo1998@gmail.com', 'Laki-laki', 'Padang', '1999-09-01', '082102192012', 'Jl. Pariaman', 1, 'default.svg', '$2y$10$HC4FagiE4PTD7TA.lEqca.4X7SFcQnXcb/4HA95RYrqFr3QniCbC6', 3, 1, 1626604588, 0, '2021-08-11 09:55:06'),
(30, 'Muhammad Haitsam', 'haitsam03@gmail.com', 'Laki-laki', 'Madinah', '1999-02-18', '082117503125', 'Jl. Raya Cilamaya', 0, 'default.svg', '$2y$10$gmRS1JFUVWtN4pMDPqv/2eNks.sAetkSMuyUmybOevsvrG2MU4eCu', 0, 1, 0, 30817, '2021-08-11 10:59:03'),
(31, 'Muhammad Haitsam', 'mhaitsam18@gmail.com', 'Laki-laki', 'Madinah', '1999-02-18', '082117503125', 'Jl Raya Cilamaya', 1, 'default.svg', '$2y$10$7jE02Ev3yUG18RSfGpLM8uSO0GgE6AKqlIHrX92TTvXKZ2LKc0pv6', 2, 0, 1628673004, 0, '2021-08-11 16:10:04'),
(32, 'Slamet Setiadi Ryanto', 'amermrcl@gmail.com', 'Laki-laki', 'Indramayu', '2021-08-11', '0123123123', 'Indramayu', 1, 'default.svg', '$2y$10$oxgIHypfQXVf2hN1XaZqKOnXmOW99jnFwEvKBhkWg4zSp5ro53vjO', 2, 0, 1628673556, 0, '2021-08-11 16:19:16'),
(33, 'Haitsam', 'mhaitsam17@gmail.com', 'Laki-laki', 'Madinah', '1999-02-18', '082117503125', 'Cilamaya', 1, 'default.svg', '$2y$10$Cg.YrRpCpxlXW2.pfOG98us1ys1MhAbzB0dMZ7KNn6PsFzAxMuJpq', 3, 1, 1630464234, 0, '2021-09-01 09:43:54');

-- --------------------------------------------------------

--
-- Table structure for table `user_access_menu`
--

CREATE TABLE `user_access_menu` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_access_menu`
--

INSERT INTO `user_access_menu` (`id`, `role_id`, `menu_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(4, 1, 3),
(5, 1, 5),
(6, 1, 6),
(7, 1, 8),
(8, 1, 14),
(9, 1, 15),
(10, 2, 8),
(11, 2, 15),
(12, 3, 2),
(13, 3, 15),
(14, 1, 4),
(15, 1, 7),
(16, 1, 9),
(17, 1, 10),
(18, 2, 9),
(19, 1, 11),
(20, 1, 12),
(21, 1, 13),
(31, 0, 1),
(32, 0, 2),
(33, 0, 3),
(34, 0, 4),
(35, 0, 5),
(36, 0, 6),
(37, 0, 15),
(38, 0, 14),
(39, 0, 7),
(40, 2, 4),
(41, 2, 6),
(42, 3, 5),
(43, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_menu`
--

CREATE TABLE `user_menu` (
  `id` int(11) NOT NULL,
  `menu` varchar(128) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_menu`
--

INSERT INTO `user_menu` (`id`, `menu`, `active`) VALUES
(0, 'developer', 1),
(1, 'Admin', 1),
(2, 'User', 1),
(3, 'Menu', 1),
(4, 'Pengurus', 1),
(5, 'Member', 1),
(6, 'Transaksi', 1),
(14, 'DataMaster', 1),
(15, 'Lainnya', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`id`, `role`) VALUES
(0, 'Developer'),
(1, 'administrator'),
(2, 'pengurus'),
(3, 'member');

-- --------------------------------------------------------

--
-- Table structure for table `user_sub_menu`
--

CREATE TABLE `user_sub_menu` (
  `id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `url` varchar(128) NOT NULL,
  `icon` varchar(128) NOT NULL,
  `is_active` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_sub_menu`
--

INSERT INTO `user_sub_menu` (`id`, `menu_id`, `title`, `url`, `icon`, `is_active`) VALUES
(1, 1, 'Dashboard', 'admin/', 'fas fa-fw fa-tachometer-alt', 0),
(2, 2, 'My Profile', 'user/', 'fas fa-fw fa-user', 1),
(3, 2, 'Edit Profile', 'user/edit', 'fas fa-fw fa-user-edit', 1),
(4, 3, 'Menu Management', 'menu/', 'fas fa-fw fa-folder', 1),
(5, 3, 'Submenu Management', 'menu/subMenu', 'fas fa-fw fa-folder-open', 1),
(6, 0, 'Role Management', 'admin/role', 'fas fa-fw fa-user-tie', 1),
(7, 2, 'Change Password', 'user/changePassword', 'fas fa-fw fa-key', 0),
(8, 1, 'Data User', 'admin/dataUser/', 'fas fa-fw fa-user-tie', 1),
(9, 5, 'Beranda', 'member/', 'fas fa-fw fa-home', 1),
(10, 5, 'Organisasi', 'Member/organisasi', 'fas fa-fa fa-users', 1),
(11, 5, 'Event', 'member/event', 'fas fa-fw fa-ticket-alt', 1),
(12, 6, 'Pemesanan', 'Transaksi/', 'fas fa-fw fa-handshake', 1),
(13, 4, 'Profil Organisasi', 'Pengurus/organisasi', 'fas fa-fw fa-users', 1),
(14, 4, 'Data Acara', 'Pengurus/acara', 'fas fa-fw fa-user-tie', 1),
(15, 4, 'Data Rekruitasi', 'Pengurus/rekruitasi', 'fas fa-fw fa-user-tie', 1),
(16, 4, 'Data Tiket', 'Pengurus/Tiket', 'fas fa-fw fa-ticket-alt', 1),
(17, 4, 'Data Panitia', 'Pengurus/panitia', 'fas fa-fw fa-user-tie', 1),
(18, 6, 'Pembayaran', 'Transaksi/pembayaran/', 'fas fa-fw fa-money-bill-wave', 1),
(19, 5, 'Kepanitiaan', 'member/kepanitiaan', 'fas fa-fw fa-users', 1),
(20, 5, 'List Rekruitasi', 'Member/rekruitasi', 'fas fa-fw fa-list', 1),
(21, 5, 'Tiket Saya', 'Member/tiketSaya', 'fas fa-fw fa-shopping-basket', 1),
(22, 5, 'Bayar TIket', 'Member/pembayaran', 'fab fa-fw fa-shopify', 0),
(23, 14, 'Data Master', 'DataMaster/', 'fas fa-fw fa-database', 1),
(24, 14, 'Data Agama', 'DataMaster/agama/', 'fas fa-fw fa-pray', 1),
(25, 14, 'Data Dashboard', 'DataMaster/dashboard/', 'fas fa-fw fa-edit', 1),
(26, 15, 'Tentang Aplikasi', 'Lainnya/tentang', 'fas fa-fw fa-address-card', 0),
(27, 15, 'Pengaturan', 'Lainnya/pengaturan', 'fas fa-fw fa-wrench', 0),
(28, 15, 'Hubungi Kami', 'Lainnya/hubungi', 'fas fa-fw fa-address-book', 0),
(29, 15, 'Bantuan', 'Lainnya/bantuan', 'far fa-fw fa-question-circle', 0),
(30, 15, 'FAQ', 'Lainnya/faq', 'fas fa-fw fa-question', 0),
(31, 5, 'Riwayat Pembayaran', 'Member/riwayatPembayaran/', 'fas fa-fw fa-history', 1),
(32, 14, 'Data Metode Bayar', 'DataMaster/metodeBayar', 'fas fa-fw fa-money-check', 1),
(33, 14, 'Data Kategori Organisasi', 'DataMaster/kategoriOrganisasi/', 'fas fa-fw fa-users', 1),
(78, 1, 'Data Organisasi', 'Admin/organisasi', 'fas fa-fw fa-users', 1),
(79, 2, 'Daftar Teman', 'User/pertemanan', 'fas fa-fw fa-user-plus', 1),
(80, 2, 'Chat', 'user/chat', 'fas fa-fw fa-comments', 1),
(81, 1, 'Data Komunitas', 'admin/komunitas', 'fas fa-fw fa-users', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_token`
--

CREATE TABLE `user_token` (
  `id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `token` varchar(255) NOT NULL,
  `date_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_token`
--

INSERT INTO `user_token` (`id`, `email`, `token`, `date_created`) VALUES
(27, 'riniastkepsarlita@gmail.com', 'cVcA5s1hIsu/NQaPOwwJWz5hJvZDyRdxi2jpqn4qqUY=', 1626593770),
(28, 'riniastkepsarlita@gmail.com', 'ZcZRz3bgSpFxzkq0SZMYOgz42YSXrILCDB1SrjTbxCI=', 1626594066),
(29, 'fasaldo1998@gmail.com', 'uKLX6D0n1hsCjYwFGLjo2wbgAtaZlw+pYIJEjl+Ln7k=', 1626604588),
(30, 'mhaitsam18@gmail.com', 'MS2O7+DgVS3uoEu59r9IaLvRMjMZ4QDyPX+yRMmTfF0=', 1628673004),
(31, 'amermrcl@gmail.com', 'NWSQCAgPs2tzOFVhhPutNyyc8asrhrsdpNdO7gdXXNI=', 1628673556),
(32, 'mhaitsam17@gmail.com', 'sycPplJvZwRWWQuqZlfOI1j4HEBvsprUrP5mEdHGBDY=', 1630464234);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `acara`
--
ALTER TABLE `acara`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agama`
--
ALTER TABLE `agama`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `bukti_transfer`
--
ALTER TABLE `bukti_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dashboard`
--
ALTER TABLE `dashboard`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `divisi`
--
ALTER TABLE `divisi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ikuti_organisasi`
--
ALTER TABLE `ikuti_organisasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_bayar` (`kode_bayar`);

--
-- Indexes for table `jadwal_rapat`
--
ALTER TABLE `jadwal_rapat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori_notifikasi`
--
ALTER TABLE `kategori_notifikasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori_organisasi`
--
ALTER TABLE `kategori_organisasi`
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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `metode_bayar`
--
ALTER TABLE `metode_bayar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organisasi`
--
ALTER TABLE `organisasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `panitia`
--
ALTER TABLE `panitia`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pertemanan`
--
ALTER TABLE `pertemanan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rekening`
--
ALTER TABLE `rekening`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rekruitasi`
--
ALTER TABLE `rekruitasi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_acara` (`id_acara`);

--
-- Indexes for table `thread`
--
ALTER TABLE `thread`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tiket`
--
ALTER TABLE `tiket`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_acara` (`id_acara`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_access_menu`
--
ALTER TABLE `user_access_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_menu`
--
ALTER TABLE `user_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_token`
--
ALTER TABLE `user_token`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `acara`
--
ALTER TABLE `acara`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `agama`
--
ALTER TABLE `agama`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `anggota`
--
ALTER TABLE `anggota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `arsip`
--
ALTER TABLE `arsip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `bukti_transfer`
--
ALTER TABLE `bukti_transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `dashboard`
--
ALTER TABLE `dashboard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `divisi`
--
ALTER TABLE `divisi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ikuti_organisasi`
--
ALTER TABLE `ikuti_organisasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `jadwal_rapat`
--
ALTER TABLE `jadwal_rapat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `kategori_notifikasi`
--
ALTER TABLE `kategori_notifikasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `kategori_organisasi`
--
ALTER TABLE `kategori_organisasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `komunitas`
--
ALTER TABLE `komunitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `metode_bayar`
--
ALTER TABLE `metode_bayar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `organisasi`
--
ALTER TABLE `organisasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `panitia`
--
ALTER TABLE `panitia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pertemanan`
--
ALTER TABLE `pertemanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `rekening`
--
ALTER TABLE `rekening`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rekruitasi`
--
ALTER TABLE `rekruitasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `thread`
--
ALTER TABLE `thread`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tiket`
--
ALTER TABLE `tiket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user_access_menu`
--
ALTER TABLE `user_access_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `user_menu`
--
ALTER TABLE `user_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
