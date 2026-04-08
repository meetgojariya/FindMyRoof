-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2026 at 06:54 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `findmyroof_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'Admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `username`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES
(1, 'meet_gojariya', 'meetgojariya214@gmail.com', 'scrypt:32768:8:1$AApAy4tlHe1UIzpw$b9af45c314abd6b4caafe536b28231f6b772c3755aadd470940437c7ca792fb08b16f4b9d2e1ad8f763aac8b2abb16c15966443cf3d9b1f6cd84694af9c99a49', 'admin', '2026-02-03 14:08:34', '2026-02-23 07:01:44'),
(2, 'krish_tarpara', 'tarparakrish0903@gmail.com', 'scrypt:32768:8:1$lIFDhOwLgveIWypg$8b7ccf69b1286e25943ad7e0cd20f54eae544eefbafc46c654895bf57601ee5fce40bb3b1ef4c41e1dad975eb01a26fc7a90e2aedc5714181cdd0623e46257f1', 'admin', '2026-02-03 14:11:04', '2026-02-08 18:25:14'),
(3, 'meet_senjaliya', 'meetsenjaliya@gmail.com', 'scrypt:32768:8:1$5GhZtTzIQnoJxTg3$af931634bacc04f5a2afc19458b3403f65722e9b52591fff42f54d63e30c4aa5138e898612a17c26fdff6bfe6419dabab0cd8420dd8d98cd0343f713c31e903b', 'admin', '2026-02-03 14:11:04', '2026-02-07 17:50:10');

-- --------------------------------------------------------

--
-- Table structure for table `amenities`
--

CREATE TABLE `amenities` (
  `amenity_id` int(11) NOT NULL,
  `amenity_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `amenities`
--

INSERT INTO `amenities` (`amenity_id`, `amenity_name`) VALUES
(1, '24/7 Security'),
(18, 'Borewell Water'),
(16, 'CCTV Surveillance'),
(6, 'Children Play Area'),
(3, 'Clubhouse'),
(9, 'Covered Parking'),
(11, 'Fire Safety'),
(2, 'Gated Community'),
(4, 'Gymnasium'),
(7, 'Landscaped Garden'),
(10, 'Lift'),
(8, 'Power Backup'),
(5, 'Swimming Pool'),
(13, 'Yoga Deck');

-- --------------------------------------------------------

--
-- Table structure for table `contacted_properties`
--

CREATE TABLE `contacted_properties` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `contacted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacted_properties`
--

INSERT INTO `contacted_properties` (`id`, `user_id`, `property_id`, `contacted_at`) VALUES
(1, 23, 170, '2026-02-20 16:13:15'),
(2, 23, 126, '2026-02-20 16:20:16'),
(3, 23, 181, '2026-02-20 16:44:55'),
(4, 23, 189, '2026-02-21 03:22:44'),
(5, 4, 151, '2026-02-21 03:57:17'),
(6, 4, 181, '2026-02-23 06:49:38'),
(7, 24, 170, '2026-02-23 15:52:16');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `status` enum('new','read','replied','archived') DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `phone`, `subject`, `message`, `status`, `created_at`, `updated_at`) VALUES
(5, 'Rahul Sharma', 'rahul.sharma@gmail.com', '9876543210', 'Property viewing request', 'I am interested in viewing the 3 BHK apartment in Vastrapur. Could you please arrange a visit this weekend?', 'replied', '2026-02-08 14:42:41', '2026-02-23 15:55:59'),
(6, 'Priya Patel', 'priya.patel@yahoo.com', '8765432109', 'Question about property documentation', 'What documents are required for property registration? Also, is there any legal verification service provided?', 'replied', '2026-02-20 09:28:41', '2026-02-20 14:27:41'),
(7, 'Amit Kumar', 'amit.k@hotmail.com', '7654321098', 'Loan assistance inquiry', 'Do you provide home loan assistance? I need help with the financing process for purchasing a property.', 'read', '2026-02-14 13:30:41', '2026-02-20 14:28:52'),
(8, 'Sneha Desai', 'sneha.desai@outlook.com', '9988776655', 'Commercial property availability', 'Looking for commercial space in SG Highway area. Do you have any shops or office spaces available for rent?', 'read', '2026-02-15 23:34:41', '2026-02-20 14:27:41'),
(9, 'Vikram Singh', 'vikram.singh@gmail.com', '8877665544', 'Property price negotiation', 'I visited the property yesterday and found it suitable. Can we discuss the price? Is there any scope for negotiation?', 'replied', '2026-02-17 11:32:41', '2026-02-20 14:27:41'),
(10, 'Neha Mehta', 'neha.mehta22@gmail.com', '7766554433', 'Rent agreement query', 'What is the lock-in period for rental properties? Also, who bears the maintenance charges?', 'replied', '2026-02-09 16:03:41', '2026-02-20 16:03:55'),
(11, 'Karan Joshi', 'karan.joshi@rediffmail.com', '9654321087', 'Property verification', 'I want to verify the ownership and legal status of the property listed on your website. Can you help with this?', 'archived', '2026-02-15 11:52:41', '2026-02-20 14:27:41'),
(12, 'Divya Shah', 'divya.shah@gmail.com', '8543210976', 'Home inspection services', 'Do you provide home inspection services before finalizing the purchase? I want to ensure there are no structural issues.', 'replied', '2026-02-13 22:40:41', '2026-02-23 07:04:50'),
(13, 'Rohan Trivedi', 'rohan.trivedi99@yahoo.com', '7432109865', 'Property tax information', 'What are the annual property tax charges for residential properties in Ahmedabad? Is it included in the price?', 'replied', '2026-02-16 22:48:41', '2026-02-20 16:08:23'),
(14, 'Anjali Gupta', 'anjali.gupta@gmail.com', '6321098754', 'Urgent: Need property urgently', 'I need to relocate to Ahmedabad within 2 weeks. Do you have any ready-to-move 2 BHK properties available immediately?', 'replied', '2026-02-20 07:53:41', '2026-02-20 14:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `enquiries`
--

CREATE TABLE `enquiries` (
  `enquiry_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enquiries`
--

INSERT INTO `enquiries` (`enquiry_id`, `property_id`, `name`, `email`, `phone`, `message`, `created_at`) VALUES
(1, 189, 'Fenil Koyani', 'fenilkoyani7@gmail.com', '9313475926', 'Amenities are not being listed by the owner.', '2026-02-20 14:24:27'),
(2, 1, 'Mihir Shah', 'mihir.shah@gmail.com', '9876543211', 'I am interested in this property. Please share more details about the amenities and parking availability.', '2026-02-12 10:13:03'),
(3, 2, 'Pooja Rao', 'pooja.rao@yahoo.com', '8765432198', 'Is this property available for immediate possession? Also, what is the maintenance cost per month?', '2026-02-12 12:52:03'),
(4, 1, 'Harsh Patel', 'harsh.patel88@gmail.com', '7654321087', 'Can I schedule a property visit this Saturday? I would like to see the property with my family.', '2026-02-15 13:07:03'),
(5, 3, 'Riya Jain', 'riya.jain@outlook.com', '9988776644', 'What is the age of this property? Is there any scope for price negotiation? I am a serious buyer.', '2026-02-17 09:17:03'),
(6, 2, 'Aditya Mehta', 'aditya.mehta@hotmail.com', '8877665533', 'I noticed this property is furnished. Can I get the list of furnishings included? Also, is pet-friendly?', '2026-02-19 17:05:03');

-- --------------------------------------------------------

--
-- Table structure for table `owners`
--

CREATE TABLE `owners` (
  `owner_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('Owner','Agent') DEFAULT 'Owner'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `owners`
--

INSERT INTO `owners` (`owner_id`, `name`, `phone`, `email`, `role`) VALUES
(1, 'Raj Patel', '9876543210', 'raj@gmail.com', 'Owner'),
(2, 'Amit Shah', '9876543211', 'amit@gmail.com', 'Owner'),
(3, 'Neha Mehta', '9876543212', 'neha@gmail.com', 'Agent'),
(4, 'Vikas Jain', '9876543213', 'vikas@gmail.com', 'Agent'),
(5, 'Pooja Desai', '9876543214', 'pooja@gmail.com', 'Owner'),
(6, 'Vikram Singh', '9898012345', 'vikram.singh@gmail.com', 'Owner'),
(7, 'Anjali Desai', '9925067890', 'anjali.desai@yahoo.com', 'Agent'),
(8, 'Rahul Khanna', '9824054321', 'rahul.realty@gmail.com', 'Agent'),
(9, 'Sneha Patel', '9428011223', 'sneha.patel88@gmail.com', 'Owner'),
(10, 'Manish Gupta', '9909033445', 'manish.gupta@gmail.com', 'Owner'),
(11, 'Priya Sharma', '9879055667', 'priya.sharma@outlook.com', 'Owner'),
(12, 'Rohan Mehta', '7600077889', 'rohan.properties@gmail.com', 'Agent'),
(13, 'Suresh Reddy', '9978099001', 'suresh.reddy@gmail.com', 'Owner'),
(14, 'Kavita Joshi', '9662012312', 'kavita.j@gmail.com', 'Owner'),
(15, 'Arjun Nair', '9725045645', 'arjun.nair@gmail.com', 'Agent'),
(16, 'Deepak Verma', '9825178978', 'deepak.verma@gmail.com', 'Owner'),
(17, 'Meera Iyer', '9924123423', 'meera.iyer@gmail.com', 'Owner'),
(18, 'Sameer Khan', '9898567867', 'sameer.khan@gmail.com', 'Agent'),
(19, 'Nita Shah', '9712089089', 'nita.shah@gmail.com', 'Owner'),
(20, 'Varun Chopra', '9904012121', 'varun.chopra@gmail.com', 'Owner'),
(21, 'Sanjay Rathod', '9824434343', 'sanjay.rathod@gmail.com', 'Agent'),
(22, 'Pooja Malhotra', '9979956565', 'pooja.m@gmail.com', 'Owner'),
(23, 'Kiran Yadav', '9601078787', 'kiran.yadav@gmail.com', 'Owner'),
(24, 'Vivek Agarwal', '9426090909', 'vivek.agarwal@gmail.com', 'Agent'),
(25, 'Ritu Saxena', '9898211211', 'ritu.saxena@gmail.com', 'Owner'),
(26, 'Alok Mishra', '9925333433', 'alok.mishra@gmail.com', 'Owner'),
(27, 'Neha Kapoor', '9879455655', 'neha.kapoor@gmail.com', 'Agent'),
(28, 'Rajeev Menon', '9724577877', 'rajeev.menon@gmail.com', 'Owner'),
(29, 'Simran Kaur', '9825699099', 'simran.kaur@gmail.com', 'Owner'),
(30, 'Aditya Roy', '9909712312', 'aditya.roy@gmail.com', 'Agent'),
(31, 'Siddharth Malhotra', '9825012344', 'sid.malhotra@gmail.com', 'Owner'),
(32, 'Karan Adani', '9909011223', 'karan.realty@outlook.com', 'Agent'),
(33, 'Ishani Trivedi', '9724055661', 'ishani.t@yahoo.com', 'Owner'),
(34, 'Manan Zaveri', '9428077882', 'manan.zaveri@gmail.com', 'Owner'),
(35, 'Riya Choksi', '7600012123', 'riya.properties@gmail.com', 'Agent'),
(36, 'Harshil Shah', '9978054321', 'harshil.s89@gmail.com', 'Owner'),
(37, 'Tanvi Parekh', '9662098765', 'tanvi.parekh@gmail.com', 'Owner'),
(38, 'Abhishek Goel', '9725011122', 'abhishek.agent@gmail.com', 'Agent'),
(39, 'Nidhi Kothari', '9825133445', 'nidhi.kothari@gmail.com', 'Owner'),
(40, 'Yashwardhan Rana', '9924155667', 'yash.rana@gmail.com', 'Owner'),
(41, 'Bhavik Joshi', '9898599001', 'bhavik.j@gmail.com', 'Agent'),
(42, 'Esha Gadhvi', '9712012312', 'esha.gadhvi@gmail.com', 'Owner'),
(43, 'Pratik Sanghavi', '9904045645', 'pratik.s@gmail.com', 'Owner'),
(44, 'Mahesh Prajapati', '9824478978', 'mahesh.prajapati@gmail.com', 'Agent'),
(45, 'Shalini Varma', '9979912345', 'shalini.v@gmail.com', 'Owner'),
(46, 'Rahul Deshmukh', '9601067890', 'rahul.d@gmail.com', 'Owner'),
(47, 'Ayush Bansal', '9426054321', 'ayush.realty@gmail.com', 'Agent'),
(48, 'Deepa Pillai', '9898211333', 'deepa.pillai@gmail.com', 'Owner'),
(49, 'Gaurav Taneja', '9925344556', 'gaurav.t@gmail.com', 'Owner'),
(50, 'Kavya Marathe', '9879466778', 'kavya.m@gmail.com', 'Agent');

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `property_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `property_category` enum('Residential','Commercial') NOT NULL DEFAULT 'Residential',
  `property_type` enum('Flat','Villa','Plot','Office','Shop','Showroom','Warehouse') NOT NULL,
  `listing_type` enum('Buy','Rent') NOT NULL,
  `sale_type` enum('New','Resale') NOT NULL DEFAULT 'New',
  `price` decimal(12,2) NOT NULL,
  `area_sqft` int(11) NOT NULL,
  `bedrooms` tinyint(4) DEFAULT NULL,
  `bathrooms` tinyint(4) DEFAULT NULL,
  `balconies` tinyint(4) DEFAULT NULL,
  `furnishing_status` enum('Unfurnished','Semi-Furnished','Fully-Furnished') DEFAULT NULL,
  `floor_number` tinyint(4) DEFAULT NULL,
  `total_floors` tinyint(4) DEFAULT NULL,
  `property_age` varchar(30) DEFAULT NULL,
  `facing` enum('North','South','East','West','North-East','North-West','South-East','South-West') DEFAULT NULL,
  `covered_parking` tinyint(1) NOT NULL DEFAULT 0,
  `availability_status` enum('Available','Sold','Rented') DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`property_id`, `title`, `description`, `property_category`, `property_type`, `listing_type`, `sale_type`, `price`, `area_sqft`, `bedrooms`, `bathrooms`, `balconies`, `furnishing_status`, `floor_number`, `total_floors`, `property_age`, `facing`, `covered_parking`, `availability_status`, `created_at`, `updated_at`) VALUES
(1, 'The Emerald Heights', 'Luxury 3BHK with panoramic city views and Italian marble flooring.', 'Residential', 'Flat', 'Buy', 'New', 11500000.00, 1850, 3, 3, 2, 'Semi-Furnished', 8, 15, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(2, 'Casa Ultima', 'A sprawling 5BHK Mediterranean style villa with a private lap pool.', 'Residential', 'Villa', 'Buy', 'New', 48000000.00, 5200, 5, 5, 3, 'Fully-Furnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(3, 'Corporate Monolith', 'Grade-A office space with high-speed elevators and glass facade.', 'Commercial', 'Office', 'Rent', 'New', 75000.00, 1600, NULL, NULL, NULL, 'Unfurnished', 12, 20, '1-3 Years', 'West', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(4, 'The Signature Pavilion', 'Prime corner showroom with 40ft frontage on a main arterial road.', 'Commercial', 'Showroom', 'Buy', 'New', 22000000.00, 1100, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(5, 'Blue Bell Residency', 'Family-centric 2BHK located near top-tier schools and parks.', 'Residential', 'Flat', 'Buy', 'Resale', 5500000.00, 1250, 2, 2, 1, 'Unfurnished', 3, 7, '5-10 Years', 'North-East', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(6, 'Stellar Workspace', 'Co-working friendly office layout with centralized AC.', 'Commercial', 'Office', 'Rent', 'New', 42000.00, 900, NULL, NULL, NULL, 'Semi-Furnished', 4, 10, '0-1 Years', 'South', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(7, 'Eldorado Estates', 'Spacious residential plot in a gated community with club access.', 'Residential', 'Plot', 'Buy', 'New', 8500000.00, 3000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'West', 0, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(8, 'The Imperial Suites', 'Ultra-modern 4BHK penthouse with private terrace and jacuzzi.', 'Residential', 'Flat', 'Buy', 'New', 32000000.00, 4100, 4, 4, 4, 'Fully-Furnished', 14, 14, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(9, 'Urban Square Retail', 'High footfall shop ideal for a pharmacy or boutique.', 'Commercial', 'Shop', 'Rent', 'Resale', 35000.00, 500, NULL, NULL, NULL, 'Unfurnished', 0, 2, '3-5 Years', 'North', 0, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(10, 'The Haven Bungalows', 'Quiet 4BHK bungalow away from city noise with a lush backyard.', 'Residential', 'Villa', 'Buy', 'Resale', 21000000.00, 3600, 4, 3, 2, 'Semi-Furnished', 0, 2, '10+ Years', 'West', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(11, 'Summit Logistics Hub', 'State-of-the-art warehouse with 30ft ceiling height and dock levelers.', 'Commercial', 'Warehouse', 'Rent', 'New', 180000.00, 12000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(12, 'Orchid Terraces', 'Boutique 3BHK apartments with only two flats per floor.', 'Residential', 'Flat', 'Buy', 'New', 14500000.00, 2400, 3, 3, 3, 'Semi-Furnished', 5, 12, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(13, 'Nexus Point Plaza', 'A sleek commercial shop in the heart of the business district.', 'Commercial', 'Shop', 'Buy', 'New', 11000000.00, 750, NULL, NULL, NULL, 'Unfurnished', 1, 5, '0-1 Years', 'South', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(14, 'Willow Woods', 'Modern 3BHK villa featuring sustainable architecture and solar power.', 'Residential', 'Villa', 'Buy', 'New', 27500000.00, 3800, 3, 4, 2, 'Unfurnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(15, 'Zenith Tower', 'Premium office floor with 360-degree views of the skyline.', 'Commercial', 'Office', 'Rent', 'New', 110000.00, 3200, NULL, NULL, NULL, 'Unfurnished', 18, 22, '1-3 Years', 'North-West', 1, 'Available', '2026-02-08 12:38:57', '2026-02-08 12:38:57'),
(16, 'The Platinum Axis', 'Premium business suite with conference facility.', 'Commercial', 'Office', 'Buy', 'New', 18500000.00, 2100, NULL, NULL, NULL, 'Unfurnished', 9, 15, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(17, 'Marigold Villas', 'Luxury 4BHK villa with a private garden and gazebo.', 'Residential', 'Villa', 'Buy', 'New', 31000000.00, 4200, 4, 4, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(18, 'Vertex Plaza', 'Corner shop with maximum visibility in high-traffic zone.', 'Commercial', 'Shop', 'Rent', 'New', 55000.00, 950, NULL, NULL, NULL, 'Unfurnished', 0, 4, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(19, 'Skyview Penthouse', 'Duplex penthouse with a private plunge pool.', 'Residential', 'Flat', 'Buy', 'New', 45000000.00, 5800, 5, 5, 4, 'Fully-Furnished', 22, 22, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(20, 'The Industrial Grid', 'Large-scale warehouse with heavy-duty flooring.', 'Commercial', 'Warehouse', 'Rent', 'New', 250000.00, 15000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(21, 'Crystal Enclave', 'Modern 3BHK flat near metro connectivity.', 'Residential', 'Flat', 'Buy', 'New', 8800000.00, 1650, 3, 3, 2, 'Unfurnished', 4, 12, '0-1 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(22, 'Heritage Manor', 'Bungalow with traditional architecture and modern tech.', 'Residential', 'Villa', 'Buy', 'Resale', 29000000.00, 3900, 4, 4, 2, 'Semi-Furnished', 0, 2, '5-10 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(23, 'Orchid Terraces', '3BHK apartment with huge wrap-around balconies.', 'Residential', 'Flat', 'Buy', 'New', 13500000.00, 2200, 3, 3, 3, 'Semi-Furnished', 7, 14, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(24, 'The Grand Atrium', 'Commercial showroom with double-height ceiling.', 'Commercial', 'Showroom', 'Rent', 'New', 350000.00, 4500, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(25, 'Maple Leaf Residency', 'Budget friendly 2BHK for young professionals.', 'Residential', 'Flat', 'Buy', 'Resale', 4200000.00, 1050, 2, 2, 1, 'Unfurnished', 2, 5, '3-5 Years', 'East', 0, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(26, 'Solitaire Business Hub', 'Glass-fronted office ideal for IT firms.', 'Commercial', 'Office', 'Buy', 'New', 14000000.00, 1800, NULL, NULL, NULL, 'Unfurnished', 11, 25, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(27, 'The Arches', 'Designer 4BHK villa with courtyard architecture.', 'Residential', 'Villa', 'Buy', 'New', 38000000.00, 4800, 4, 5, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(28, 'Prism Retail Space', 'Ground floor shop in a premium shopping arcade.', 'Commercial', 'Shop', 'Buy', 'New', 12500000.00, 800, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(29, 'Silver Oak Apartments', '3BHK flat with park-facing views.', 'Residential', 'Flat', 'Buy', 'Resale', 7500000.00, 1550, 3, 3, 2, 'Semi-Furnished', 5, 10, '5-10 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(30, 'Vector Logistics Park', 'Modern warehouse with temperature control zones.', 'Commercial', 'Warehouse', 'Rent', 'New', 320000.00, 20000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(31, 'The Icon Tower', 'Ultra-premium 4BHK with designer lobby.', 'Residential', 'Flat', 'Buy', 'New', 19500000.00, 2900, 4, 4, 3, 'Semi-Furnished', 18, 22, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(32, 'Elysian Bungalows', 'Minimalist 5BHK bungalow with private gym.', 'Residential', 'Villa', 'Buy', 'New', 52000000.00, 6500, 5, 6, 3, 'Fully-Furnished', 0, 2, '0-1 Years', 'North-East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(33, 'Corporate Edge', 'Compact office space for startups.', 'Commercial', 'Office', 'Rent', 'New', 28000.00, 750, NULL, NULL, NULL, 'Unfurnished', 3, 10, '1-3 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(34, 'Nova Square', 'High-visibility corner showroom.', 'Commercial', 'Showroom', 'Buy', 'New', 28000000.00, 1500, NULL, NULL, NULL, 'Unfurnished', 0, 4, '0-1 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(35, 'Green Park Residency', 'Affordable 2BHK in a lush green township.', 'Residential', 'Flat', 'Buy', 'Resale', 4800000.00, 1150, 2, 2, 1, 'Unfurnished', 4, 12, '3-5 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(36, 'The Apex Corporate', 'Entire floor plate office for MNCs.', 'Commercial', 'Office', 'Rent', 'New', 450000.00, 6500, NULL, NULL, NULL, 'Unfurnished', 15, 15, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(37, 'Magnolia Estates', 'Luxury villas in a secure gated community.', 'Residential', 'Villa', 'Buy', 'New', 41000000.00, 5500, 5, 5, 4, 'Semi-Furnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(38, 'Alpha Commercial Center', 'Spacious shop for supermarket or bank.', 'Commercial', 'Shop', 'Buy', 'New', 18000000.00, 1200, NULL, NULL, NULL, 'Unfurnished', 0, 5, '1-3 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(39, 'Skyline Residency', 'Modern 3BHK flat near SG Highway.', 'Residential', 'Flat', 'Buy', 'New', 9200000.00, 1750, 3, 3, 2, 'Semi-Furnished', 10, 14, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(40, 'Fortuna Warehouse', 'E-commerce fulfillment center ready.', 'Commercial', 'Warehouse', 'Rent', 'New', 150000.00, 10000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(41, 'Imperial Heights', 'Gilded 4BHK apartment with smart home features.', 'Residential', 'Flat', 'Buy', 'New', 22500000.00, 3100, 4, 4, 3, 'Fully-Furnished', 12, 18, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(42, 'The Boulevard Villa', 'Independent 4BHK with private home theatre.', 'Residential', 'Villa', 'Buy', 'New', 35000000.00, 4600, 4, 5, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(43, 'Nexus One Office', 'Glass-clad office with terrace garden.', 'Commercial', 'Office', 'Rent', 'New', 85000.00, 2200, NULL, NULL, NULL, 'Unfurnished', 6, 12, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(44, 'Urban Vogue Showroom', 'Prime space for luxury fashion brands.', 'Commercial', 'Showroom', 'Rent', 'New', 220000.00, 2800, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(45, 'Oakwood Flat', 'Comfortable 3BHK in a family-friendly area.', 'Residential', 'Flat', 'Buy', 'Resale', 6800000.00, 1450, 3, 2, 2, 'Semi-Furnished', 2, 7, '5-10 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(46, 'Titanium Park', 'Scalable office space in a business park.', 'Commercial', 'Office', 'Buy', 'New', 11000000.00, 1500, NULL, NULL, NULL, 'Unfurnished', 8, 15, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(47, 'Palm Jumeirah Villa', 'Resort-style 5BHK villa with private pool.', 'Residential', 'Villa', 'Buy', 'New', 65000000.00, 7200, 5, 6, 4, 'Fully-Furnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(48, 'Midtown Shop', 'Busy street shop for retail business.', 'Commercial', 'Shop', 'Rent', 'Resale', 42000.00, 650, NULL, NULL, NULL, 'Unfurnished', 0, 2, '5-10 Years', 'West', 0, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(49, 'Azure Towers', '3BHK apartment with infinity pool access.', 'Residential', 'Flat', 'Buy', 'New', 15500000.00, 2400, 3, 3, 2, 'Semi-Furnished', 14, 25, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(50, 'The Cargo Base', 'Logistics hub with ample truck parking.', 'Commercial', 'Warehouse', 'Buy', 'New', 55000000.00, 25000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(51, 'Summit Suites', 'Executive 2BHK flat for corporate employees.', 'Residential', 'Flat', 'Rent', 'New', 35000.00, 1300, 2, 2, 1, 'Fully-Furnished', 6, 12, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(52, 'Gardenia Bungalow', 'Traditional 4BHK bungalow with mango orchard.', 'Residential', 'Villa', 'Buy', 'Resale', 24000000.00, 4200, 4, 4, 1, 'Semi-Furnished', 0, 2, '10+ Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(53, 'Insignia Office', 'Premium office space with high-speed internet.', 'Commercial', 'Office', 'Buy', 'New', 12500000.00, 1700, NULL, NULL, NULL, 'Unfurnished', 10, 20, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(54, 'The Galleria Shop', 'Shopping mall retail space with AC.', 'Commercial', 'Shop', 'Rent', 'New', 75000.00, 850, NULL, NULL, NULL, 'Unfurnished', 1, 4, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(55, 'Lotus Residency', 'Affordable 3BHK flat with temple view.', 'Residential', 'Flat', 'Buy', 'New', 6200000.00, 1400, 3, 3, 2, 'Unfurnished', 3, 7, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(56, 'Emerald Commercial', 'Corporate office with grand lobby entrance.', 'Commercial', 'Office', 'Rent', 'New', 120000.00, 2800, NULL, NULL, NULL, 'Semi-Furnished', 4, 12, '1-3 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(57, 'The Retreat Villa', 'Secluded 3BHK villa for weekend getaways.', 'Residential', 'Villa', 'Buy', 'New', 18000000.00, 3500, 3, 3, 2, 'Fully-Furnished', 0, 2, '3-5 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(58, 'Main Street Store', 'High visibility shop for mobile store or café.', 'Commercial', 'Shop', 'Buy', 'New', 9500000.00, 500, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'West', 0, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(59, 'The Sapphire', 'Elite 4BHK penthouse with city-scape deck.', 'Residential', 'Flat', 'Buy', 'New', 38000000.00, 4500, 4, 5, 4, 'Fully-Furnished', 25, 25, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(60, 'Stellar Warehouse', 'Automated warehouse with racking systems.', 'Commercial', 'Warehouse', 'Rent', 'New', 400000.00, 35000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(61, 'Royal Court', 'Gated 3BHK flat with children play area.', 'Residential', 'Flat', 'Buy', 'Resale', 8500000.00, 1650, 3, 3, 2, 'Semi-Furnished', 2, 10, '5-10 Years', 'South', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(62, 'Villa Verde', 'Eco-friendly 4BHK villa with solar roof.', 'Residential', 'Villa', 'Buy', 'New', 33000000.00, 4400, 4, 4, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(63, 'Pinnacle Office Hub', 'Serviced offices for small businesses.', 'Commercial', 'Office', 'Rent', 'New', 45000.00, 1200, NULL, NULL, NULL, 'Fully-Furnished', 5, 15, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(64, 'Elite Showroom', 'Two-level showroom with glass elevator.', 'Commercial', 'Showroom', 'Buy', 'New', 45000000.00, 5500, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(65, 'Sunrise Apartments', 'Compact 2BHK flat near railway station.', 'Residential', 'Flat', 'Buy', 'Resale', 3800000.00, 950, 2, 2, 1, 'Unfurnished', 1, 5, '10+ Years', 'East', 0, 'Available', '2026-02-08 12:46:46', '2026-02-08 12:46:46'),
(66, 'The Zenith Corporate', 'Iconic glass-facade office tower with LEED certification.', 'Commercial', 'Office', 'Buy', 'New', 21000000.00, 2400, NULL, NULL, NULL, 'Unfurnished', 14, 25, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(67, 'Serene Enclave Villas', 'Tuscan-inspired 4BHK villas with private backyard orchards.', 'Residential', 'Villa', 'Buy', 'New', 34000000.00, 4800, 4, 4, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(68, 'Avenue Retail Square', 'Prime ground-floor shop with double-height storefront.', 'Commercial', 'Shop', 'Rent', 'New', 65000.00, 1100, NULL, NULL, NULL, 'Unfurnished', 0, 4, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(69, 'Skyline Hub', 'High-speed elevator access office for tech startups.', 'Commercial', 'Office', 'Rent', 'New', 48000.00, 1300, NULL, NULL, NULL, 'Semi-Furnished', 8, 12, '1-3 Years', 'North-East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(70, 'The Marigold Suites', 'Luxury 3BHK flat with a dedicated home office room.', 'Residential', 'Flat', 'Buy', 'New', 12500000.00, 2100, 3, 3, 2, 'Semi-Furnished', 5, 14, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(71, 'Grand Central Showroom', 'Spacious corner showroom ideal for automobile brands.', 'Commercial', 'Showroom', 'Buy', 'New', 52000000.00, 6000, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(72, 'Willow Creek Residency', 'Affordable 2BHK with smart storage solutions.', 'Residential', 'Flat', 'Buy', 'Resale', 4500000.00, 1150, 2, 2, 1, 'Unfurnished', 3, 7, '5-10 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(73, 'The Logistic Corridor', 'High-capacity warehouse with 40ft ceiling height.', 'Commercial', 'Warehouse', 'Rent', 'New', 280000.00, 18000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(74, 'Imperial Garden Villa', '5BHK manor with a private home theatre and lift.', 'Residential', 'Villa', 'Buy', 'New', 58000000.00, 7200, 5, 6, 4, 'Fully-Furnished', 0, 3, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(75, 'Vantage Point Office', 'Modern office floor with 360-degree views of the city.', 'Commercial', 'Office', 'Rent', 'New', 95000.00, 2500, NULL, NULL, NULL, 'Unfurnished', 10, 20, '1-3 Years', 'South', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(76, 'The Urban Nest', 'Compact studio apartment for working professionals.', 'Residential', 'Flat', 'Rent', 'New', 18000.00, 850, 1, 1, 1, 'Fully-Furnished', 6, 12, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(77, 'Opaline Towers', '4BHK residential apartment with infinity pool deck.', 'Residential', 'Flat', 'Buy', 'New', 18500000.00, 2800, 4, 4, 3, 'Semi-Furnished', 15, 22, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(78, 'Capital Trade Center', 'Mid-sized shop in a high-density commercial zone.', 'Commercial', 'Shop', 'Buy', 'New', 14500000.00, 950, NULL, NULL, NULL, 'Unfurnished', 0, 5, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(79, 'The Green Leaf Villa', 'Eco-conscious 3BHK villa with rainwater harvesting.', 'Residential', 'Villa', 'Buy', 'Resale', 19500000.00, 3200, 3, 3, 2, 'Semi-Furnished', 0, 2, '5-10 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(80, 'Summit Industrial Park', 'Industrial warehouse with heavy machinery provisions.', 'Commercial', 'Warehouse', 'Buy', 'New', 65000000.00, 30000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'South', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(81, 'Azure Heights', 'Contemporary 3BHK flat near the central park.', 'Residential', 'Flat', 'Buy', 'New', 9800000.00, 1750, 3, 3, 2, 'Unfurnished', 4, 15, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(82, 'The Sovereign Bungalow', 'Traditional bungalow with wide teak-wood verandas.', 'Residential', 'Villa', 'Buy', 'Resale', 27000000.00, 4500, 4, 4, 2, 'Fully-Furnished', 0, 2, '10+ Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(83, 'Nexus Plaza Office', 'Shared office space with modern pantry facilities.', 'Commercial', 'Office', 'Rent', 'New', 32000.00, 1100, NULL, NULL, NULL, 'Fully-Furnished', 2, 8, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(84, 'Mainline Retail Shop', 'Busy street shop ideal for showroom or café.', 'Commercial', 'Shop', 'Rent', 'Resale', 45000.00, 700, NULL, NULL, NULL, 'Unfurnished', 0, 2, '5-10 Years', 'South', 0, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(85, 'Blue Sky Penthouse', 'Top-floor penthouse with private garden and BBQ area.', 'Residential', 'Flat', 'Buy', 'New', 41000000.00, 5200, 5, 5, 4, 'Fully-Furnished', 18, 18, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(86, 'Platinum Workspace', 'Executive office cabins for law firms or CA firms.', 'Commercial', 'Office', 'Buy', 'New', 15000000.00, 1900, NULL, NULL, NULL, 'Unfurnished', 7, 12, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(87, 'The Orchard Villa', '4BHK villa featuring a glass-enclosed atrium.', 'Residential', 'Villa', 'Buy', 'New', 38000000.00, 5100, 4, 5, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(88, 'Vista Commercial', 'Sleek showroom with extensive frontage on Ring Road.', 'Commercial', 'Showroom', 'Rent', 'New', 280000.00, 3500, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(89, 'Maple Court Apartments', 'Spacious 3BHK flat in a gated family community.', 'Residential', 'Flat', 'Buy', 'Resale', 7800000.00, 1600, 3, 3, 2, 'Semi-Furnished', 3, 10, '3-5 Years', 'South', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(90, 'Swift Logistics Base', 'E-commerce cross-docking warehouse facility.', 'Commercial', 'Warehouse', 'Rent', 'New', 180000.00, 14000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(91, 'The Icon Residence', 'Designer 4BHK apartment with walk-in closets.', 'Residential', 'Flat', 'Buy', 'New', 23000000.00, 3400, 4, 4, 3, 'Semi-Furnished', 12, 20, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(92, 'Royal Palm Bungalow', 'Stately 5BHK bungalow with a large portico.', 'Residential', 'Villa', 'Buy', 'Resale', 32000000.00, 5500, 5, 5, 2, 'Fully-Furnished', 0, 2, '10+ Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(93, 'Edge Business Suites', 'Flexible office units for small enterprises.', 'Commercial', 'Office', 'Rent', 'New', 38000.00, 1000, NULL, NULL, NULL, 'Semi-Furnished', 5, 10, '1-3 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(94, 'Galleria Boutique Shop', 'Fashion-focused shop in a premium retail wing.', 'Commercial', 'Shop', 'Buy', 'New', 11000000.00, 650, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(95, 'Riverview Residency', '3BHK flat with balconies overlooking the riverfront.', 'Residential', 'Flat', 'Buy', 'New', 14500000.00, 2300, 3, 3, 2, 'Unfurnished', 9, 24, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(96, 'Sterling Corporate Park', 'Standalone office building for a single corporate entity.', 'Commercial', 'Office', 'Rent', 'New', 850000.00, 12000, NULL, NULL, NULL, 'Unfurnished', 0, 4, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(97, 'The Haven Estate', 'Modern 4BHK villa with a dedicated library floor.', 'Residential', 'Villa', 'Buy', 'New', 42000000.00, 5800, 4, 4, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'South', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(98, 'Alpha Retail Hub', 'Supermarket-sized shop with loading bay access.', 'Commercial', 'Shop', 'Buy', 'New', 26000000.00, 2800, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(99, 'Crimson Towers', 'Family-friendly 2BHK flat with multiple park views.', 'Residential', 'Flat', 'Buy', 'Resale', 5200000.00, 1300, 2, 2, 1, 'Semi-Furnished', 5, 14, '5-10 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(100, 'Titan Warehouse', 'Automated logistics facility with dock levelers.', 'Commercial', 'Warehouse', 'Rent', 'New', 350000.00, 25000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(101, 'Regal Heights', '4BHK luxury floor with private lift access.', 'Residential', 'Flat', 'Buy', 'New', 26000000.00, 3800, 4, 4, 3, 'Fully-Furnished', 10, 12, '1-3 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(102, 'Emerald Villa', 'Garden-facing 3BHK villa in a peaceful suburb.', 'Residential', 'Villa', 'Buy', 'New', 22000000.00, 3600, 3, 3, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'South', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(103, 'Global Trade Center', 'Modern office space with fiber-optic connectivity.', 'Commercial', 'Office', 'Rent', 'New', 55000.00, 1500, NULL, NULL, NULL, 'Unfurnished', 12, 25, '0-1 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(104, 'Cornerstone Shop', 'Highly visible shop on a major intersection.', 'Commercial', 'Shop', 'Buy', 'New', 17000000.00, 850, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(105, 'Orchid Residency', 'Comfortable 3BHK near major hospitals and schools.', 'Residential', 'Flat', 'Buy', 'Resale', 8200000.00, 1700, 3, 3, 2, 'Semi-Furnished', 4, 11, '3-5 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(106, 'The Cube Office', 'Sleek, cubic architecture office for creative agencies.', 'Commercial', 'Office', 'Rent', 'New', 65000.00, 1800, NULL, NULL, NULL, 'Semi-Furnished', 6, 15, '1-3 Years', 'South', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(107, 'Tuscan Manor', '4BHK villa with stone-cladding and rustic interiors.', 'Residential', 'Villa', 'Buy', 'New', 36000000.00, 4900, 4, 4, 2, 'Fully-Furnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(108, 'Market Square Store', 'Perfect shop for retail franchise or pharmacy.', 'Commercial', 'Shop', 'Rent', 'New', 32000.00, 600, NULL, NULL, NULL, 'Unfurnished', 0, 2, '1-3 Years', 'North', 0, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(109, 'Nova Penthouse', 'Exclusive 5BHK penthouse with glass observatory.', 'Residential', 'Flat', 'Buy', 'New', 52000000.00, 6500, 5, 6, 5, 'Fully-Furnished', 30, 30, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(110, 'Cargo Port Warehouse', 'Large warehouse near the industrial bypass.', 'Commercial', 'Warehouse', 'Buy', 'New', 48000000.00, 20000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '3-5 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(111, 'Sky Garden Flats', '3BHK apartment with its own landscaped terrace balcony.', 'Residential', 'Flat', 'Buy', 'New', 15800000.00, 2500, 3, 3, 3, 'Semi-Furnished', 11, 20, '1-3 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(112, 'Victorian Bungalow', 'Classic heritage-style bungalow with high ceilings.', 'Residential', 'Villa', 'Buy', 'Resale', 31000000.00, 5000, 5, 4, 2, 'Fully-Furnished', 0, 2, '10+ Years', 'South', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(113, 'Apex Business Plaza', 'Premium office suites with 24/7 power backup.', 'Commercial', 'Office', 'Buy', 'New', 18000000.00, 2200, NULL, NULL, NULL, 'Unfurnished', 8, 18, '0-1 Years', 'East', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(114, 'Uptown Showroom', 'Designer showroom in a high-street location.', 'Commercial', 'Showroom', 'Rent', 'New', 240000.00, 3000, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'West', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(115, 'Pearl Apartments', 'Affordable 2BHK flat in a quiet residential area.', 'Residential', 'Flat', 'Buy', 'Resale', 4100000.00, 1050, 2, 2, 1, 'Unfurnished', 2, 6, '8-10 Years', 'North', 1, 'Available', '2026-02-08 12:48:55', '2026-02-08 12:48:55'),
(116, 'The Onyx Corporate', 'Grade-A office space with high-speed elevators and a sky lounge.', 'Commercial', 'Office', 'Buy', 'New', 19500000.00, 2150, NULL, NULL, NULL, 'Unfurnished', 11, 20, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(117, 'Lavender Luxury Villas', 'Elegant 4BHK villas with private backyard decks and glass railings.', 'Residential', 'Villa', 'Buy', 'New', 38000000.00, 5200, 4, 4, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(118, 'Pavilion Retail Hub', 'Corner retail shop with massive glass frontage on a high-street.', 'Commercial', 'Shop', 'Rent', 'New', 72000.00, 1250, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(119, 'Prism Business Suites', 'Ergonomic office spaces designed for maximum natural light.', 'Commercial', 'Office', 'Rent', 'New', 52000.00, 1450, NULL, NULL, NULL, 'Semi-Furnished', 7, 12, '1-3 Years', 'North-East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(120, 'The Rosewood Manor', 'Spacious 3BHK flat with a sprawling balcony and park view.', 'Residential', 'Flat', 'Buy', 'New', 11800000.00, 1950, 3, 3, 2, 'Semi-Furnished', 4, 15, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(121, 'Empire Auto Showroom', 'Expansive showroom floor with a dedicated service bay area.', 'Commercial', 'Showroom', 'Buy', 'New', 48000000.00, 5500, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(122, 'Cypress Court Residency', 'Budget-friendly 2BHK with modular kitchen and smart layout.', 'Residential', 'Flat', 'Buy', 'Resale', 4800000.00, 1200, 2, 2, 1, 'Unfurnished', 2, 7, '5-10 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(123, 'Terminal Logistics Center', 'Heavy-duty warehouse with reinforced flooring and 24/7 security.', 'Commercial', 'Warehouse', 'Rent', 'New', 260000.00, 16000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(124, 'The Sovereign Estate', 'Ultra-luxury 5BHK villa with home automation and private theater.', 'Residential', 'Villa', 'Buy', 'New', 62000000.00, 8000, 5, 6, 4, 'Fully-Furnished', 0, 3, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(125, 'Signature Point Office', 'Executive office floor with premium soundproofing and pantry.', 'Commercial', 'Office', 'Rent', 'New', 88000.00, 2300, NULL, NULL, NULL, 'Unfurnished', 9, 18, '1-3 Years', 'South', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(126, 'The Loft Studio', 'Modern studio apartment with industrial decor and high ceilings.', 'Residential', 'Flat', 'Rent', 'New', 22000.00, 950, 1, 1, 1, 'Fully-Furnished', 10, 14, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(127, 'Aquamarine Towers', 'Luxury 4BHK apartment with a deck-mounted private jacuzzi.', 'Residential', 'Flat', 'Buy', 'New', 21000000.00, 3100, 4, 4, 3, 'Semi-Furnished', 12, 25, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(128, 'Bazaar Square Store', 'Centrally located shop ideal for a supermarket or clothing brand.', 'Commercial', 'Shop', 'Buy', 'New', 15500000.00, 1050, NULL, NULL, NULL, 'Unfurnished', 0, 4, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(129, 'The Sandalwood Villa', 'Boutique 3BHK villa with an open-air central courtyard.', 'Residential', 'Villa', 'Buy', 'Resale', 21500000.00, 3400, 3, 3, 2, 'Semi-Furnished', 0, 2, '5-10 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(130, 'Pinnacle Industrial Park', 'Industrial-grade warehouse with heavy power and crane support.', 'Commercial', 'Warehouse', 'Buy', 'New', 72000000.00, 35000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'South', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(131, 'Veridian Heights', 'Energy-efficient 3BHK flat near the new botanical gardens.', 'Residential', 'Flat', 'Buy', 'New', 10500000.00, 1800, 3, 3, 2, 'Unfurnished', 5, 12, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(132, 'The Regency Bungalow', 'Colonial-style bungalow with stone pathways and a rose garden.', 'Residential', 'Villa', 'Buy', 'Resale', 29000000.00, 4800, 4, 4, 2, 'Fully-Furnished', 0, 2, '10+ Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(133, 'Corporate Nest Office', 'Flexible coworking desks and private office cabins.', 'Commercial', 'Office', 'Rent', 'New', 35000.00, 1200, NULL, NULL, NULL, 'Fully-Furnished', 4, 10, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(134, 'Main Avenue Retail', 'Premium retail frontage ideal for a flagship jewelry store.', 'Commercial', 'Shop', 'Rent', 'Resale', 55000.00, 850, NULL, NULL, NULL, 'Unfurnished', 0, 2, '5-10 Years', 'South', 0, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(135, 'Diamond Penthouse', 'Bi-level penthouse with an glass-bottom infinity pool.', 'Residential', 'Flat', 'Buy', 'New', 48000000.00, 5600, 5, 5, 4, 'Fully-Furnished', 25, 25, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(136, 'Titan Workspace', 'Secure office units for financial consultants and banks.', 'Commercial', 'Office', 'Buy', 'New', 17000000.00, 2050, NULL, NULL, NULL, 'Unfurnished', 8, 15, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(137, 'Magnolia Luxury Villa', '4BHK villa featuring a double-height living room and skylights.', 'Residential', 'Villa', 'Buy', 'New', 41000000.00, 5400, 4, 5, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(138, 'Broadwalk Commercial', 'Retail showroom with dedicated valet parking and LED signage.', 'Commercial', 'Showroom', 'Rent', 'New', 310000.00, 3800, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(139, 'Cedar Court Apartments', 'Well-ventilated 3BHK flat with three-side open views.', 'Residential', 'Flat', 'Buy', 'Resale', 8400000.00, 1700, 3, 3, 3, 'Semi-Furnished', 6, 11, '3-5 Years', 'South', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(140, 'Gateway Logistics Base', 'Strategic warehouse location near the national highway.', 'Commercial', 'Warehouse', 'Rent', 'New', 195000.00, 15000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(141, 'The Noble Residence', 'Boutique 4BHK apartment with Italian kitchen fittings.', 'Residential', 'Flat', 'Buy', 'New', 24500000.00, 3550, 4, 4, 3, 'Semi-Furnished', 14, 18, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(142, 'Palm Grove Bungalow', 'Elegant 5BHK bungalow with a wrap-around wooden deck.', 'Residential', 'Villa', 'Buy', 'Resale', 34500000.00, 5800, 5, 5, 3, 'Fully-Furnished', 0, 2, '10+ Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(143, 'Summit Business Suites', 'Smart office units with app-controlled lighting and HVAC.', 'Commercial', 'Office', 'Rent', 'New', 42000.00, 1150, NULL, NULL, NULL, 'Semi-Furnished', 3, 9, '1-3 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(144, 'Elite Couture Shop', 'Curated boutique space in a premium luxury mall.', 'Commercial', 'Shop', 'Buy', 'New', 12500000.00, 700, NULL, NULL, NULL, 'Unfurnished', 1, 4, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(145, 'Parkview Heights', '3BHK flat with floor-to-ceiling windows and sun deck.', 'Residential', 'Flat', 'Buy', 'New', 15200000.00, 2450, 3, 3, 2, 'Unfurnished', 11, 22, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(146, 'Ironwood Corporate Park', 'Campus-style office building with cafeteria and gym.', 'Commercial', 'Office', 'Rent', 'New', 920000.00, 14000, NULL, NULL, NULL, 'Unfurnished', 0, 5, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(147, 'The Oasis Villa', 'Contemporary 4BHK villa with a waterfall feature in the garden.', 'Residential', 'Villa', 'Buy', 'New', 45000000.00, 6000, 4, 4, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'South', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(148, 'Beta Retail Hub', 'Massive floor-plate shop ideal for an electronics superstore.', 'Commercial', 'Shop', 'Buy', 'New', 28000000.00, 3200, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(149, 'Silverstone Flats', 'Modern 2BHK flat with piped gas and dedicated EV charging.', 'Residential', 'Flat', 'Buy', 'Resale', 5600000.00, 1350, 2, 2, 1, 'Semi-Furnished', 6, 12, '5-10 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(150, 'Goliath Warehouse', 'High-security warehouse for valuable goods and pharma.', 'Commercial', 'Warehouse', 'Rent', 'New', 380000.00, 28000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(151, 'Imperial Skyfloor', 'Entire 4BHK floor with private lift and 4-car parking.', 'Residential', 'Flat', 'Buy', 'New', 27500000.00, 4000, 4, 4, 3, 'Fully-Furnished', 8, 10, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(152, 'Jade Villa', 'Zen-style 3BHK villa with a rock garden and meditation room.', 'Residential', 'Villa', 'Buy', 'New', 23500000.00, 3800, 3, 3, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'South', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(153, 'Universal Trade Center', 'Business tower with a grand atrium and reception service.', 'Commercial', 'Office', 'Rent', 'New', 58000.00, 1650, NULL, NULL, NULL, 'Unfurnished', 15, 30, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(154, 'Focus Retail Point', 'Sleek retail shop in a high-density student area.', 'Commercial', 'Shop', 'Buy', 'New', 18500000.00, 900, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(155, 'Garden Court Residency', 'Lush green 3BHK apartment with low-density living.', 'Residential', 'Flat', 'Buy', 'Resale', 8500000.00, 1800, 3, 3, 2, 'Semi-Furnished', 3, 9, '3-5 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(156, 'The Prism Office', 'Geometric glass office for branding and advertising firms.', 'Commercial', 'Office', 'Rent', 'New', 68000.00, 1900, NULL, NULL, NULL, 'Semi-Furnished', 5, 12, '1-3 Years', 'South', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(157, 'Mediterranean Manor', 'Villa with terracotta tiling and archway architecture.', 'Residential', 'Villa', 'Buy', 'New', 37500000.00, 5100, 4, 4, 2, 'Fully-Furnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(158, 'Pulse Market Store', 'Strategically located shop for a high-end salon or spa.', 'Commercial', 'Shop', 'Rent', 'New', 35000.00, 700, NULL, NULL, NULL, 'Unfurnished', 0, 2, '1-3 Years', 'North', 0, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(159, 'The Stellar Penthouse', 'Triple-aspect 5BHK penthouse with private cinema.', 'Residential', 'Flat', 'Buy', 'New', 55000000.00, 6800, 5, 6, 5, 'Fully-Furnished', 28, 28, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(160, 'Logistics Hub Pro', 'Large-scale warehouse with multi-level mezzanine floors.', 'Commercial', 'Warehouse', 'Buy', 'New', 52000000.00, 22000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '3-5 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(161, 'The Sky Gardenia', '3BHK apartment with private deck and vertical garden.', 'Residential', 'Flat', 'Buy', 'New', 16500000.00, 2600, 3, 3, 3, 'Semi-Furnished', 9, 18, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(162, 'Edwardian Bungalow', 'Exquisite 5BHK bungalow with marble columns and porticos.', 'Residential', 'Villa', 'Buy', 'Resale', 34000000.00, 5300, 5, 5, 2, 'Fully-Furnished', 0, 2, '10+ Years', 'South', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(163, 'Zen Business Plaza', 'Quiet, minimalist office suites with a central zen garden.', 'Commercial', 'Office', 'Buy', 'New', 19000000.00, 2300, NULL, NULL, NULL, 'Unfurnished', 6, 15, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(164, 'Elite Drive Showroom', 'Double-height showroom for high-end automotive brands.', 'Commercial', 'Showroom', 'Rent', 'New', 260000.00, 3200, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(165, 'Velvet Apartments', 'Boutique 2BHK flat with premium finishing and lighting.', 'Residential', 'Flat', 'Buy', 'Resale', 4300000.00, 1100, 2, 2, 1, 'Unfurnished', 3, 8, '8-10 Years', 'North', 1, 'Available', '2026-02-08 13:06:19', '2026-02-08 13:06:19'),
(166, 'Titanium Square Office', 'Premium corporate suite with glass partitions and server room.', 'Commercial', 'Office', 'Buy', 'New', 14500000.00, 1850, NULL, NULL, NULL, 'Unfurnished', 14, 22, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(167, 'The Palm Residency', 'Tropical themed 4BHK villa with a private swimming pool.', 'Residential', 'Villa', 'Buy', 'New', 42000000.00, 5500, 4, 5, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(168, 'Signature Street Retail', 'High-footfall shop located in the primary fashion district.', 'Commercial', 'Shop', 'Rent', 'New', 85000.00, 1100, NULL, NULL, NULL, 'Unfurnished', 0, 3, '1-3 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(169, 'Skyline Corporate Hub', 'Modern office space with a 180-degree view of the skyline.', 'Commercial', 'Office', 'Rent', 'New', 65000.00, 1600, NULL, NULL, NULL, 'Semi-Furnished', 18, 25, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(170, 'Bluebell Luxury Flat', 'Designer 3BHK flat with smart lighting and voice control.', 'Residential', 'Flat', 'Buy', 'New', 13500000.00, 2200, 3, 3, 2, 'Semi-Furnished', 5, 12, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(171, 'Grandeur Showroom', 'Expansive showroom with 50ft frontage on SG Highway.', 'Commercial', 'Showroom', 'Buy', 'New', 55000000.00, 6500, NULL, NULL, NULL, 'Unfurnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(172, 'Meadow View Residency', 'Eco-friendly 2BHK flat with a dedicated organic garden space.', 'Residential', 'Flat', 'Buy', 'Resale', 5200000.00, 1250, 2, 2, 1, 'Unfurnished', 3, 8, '5-10 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(173, 'The Logistic Port', 'A-Grade warehouse with automated docking and sorting bay.', 'Commercial', 'Warehouse', 'Rent', 'New', 310000.00, 18000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(174, 'Imperial Heritage Villa', 'Heritage-inspired 5BHK villa with a massive front courtyard.', 'Residential', 'Villa', 'Buy', 'New', 68000000.00, 8500, 5, 6, 3, 'Fully-Furnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(175, 'Vertex Business Point', 'Sleek office floor with biometric security and lounge area.', 'Commercial', 'Office', 'Rent', 'New', 92000.00, 2400, NULL, NULL, NULL, 'Unfurnished', 10, 15, '1-3 Years', 'South', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(176, 'Artisan Studio Loft', 'Chic studio apartment with exposed brick and skylights.', 'Residential', 'Flat', 'Rent', 'New', 25000.00, 1050, 1, 1, 1, 'Fully-Furnished', 4, 4, '1-3 Years', 'North', 0, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(177, 'Oceanic Blue Towers', 'High-rise 4BHK with floor-to-ceiling glass and sea-blue glass work.', 'Residential', 'Flat', 'Buy', 'New', 24000000.00, 3200, 4, 4, 3, 'Semi-Furnished', 22, 30, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(178, 'Capital Retail Point', 'Shop located inside a premium mixed-use development.', 'Commercial', 'Shop', 'Buy', 'New', 16500000.00, 1150, NULL, NULL, NULL, 'Unfurnished', 0, 20, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(179, 'The Cedar Villa', 'Modern 3BHK bungalow with a contemporary wooden facade.', 'Residential', 'Villa', 'Buy', 'Resale', 22500000.00, 3600, 3, 3, 2, 'Semi-Furnished', 0, 2, '3-5 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(180, 'Core Industrial Hub', 'Heavy manufacturing warehouse with gantry crane provisions.', 'Commercial', 'Warehouse', 'Buy', 'New', 78000000.00, 42000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'South', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(181, 'Elysian Heights', 'Sustainable 3BHK apartment with private terrace garden.', 'Residential', 'Flat', 'Buy', 'New', 11500000.00, 1900, 3, 3, 2, 'Unfurnished', 6, 14, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(182, 'The Victorian Manor', 'Bungalow with classic European architecture and marble porch.', 'Residential', 'Villa', 'Buy', 'Resale', 36000000.00, 5200, 4, 5, 2, 'Fully-Furnished', 0, 2, '10+ Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(183, 'Workspace Collective', 'Shared office center with soundproof meeting pods.', 'Commercial', 'Office', 'Rent', 'New', 40000.00, 1300, NULL, NULL, NULL, 'Fully-Furnished', 2, 10, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(184, 'Mainline Boutique', 'Exclusive store space in a high-street shopping boulevard.', 'Commercial', 'Shop', 'Rent', 'Resale', 62000.00, 950, NULL, NULL, NULL, 'Unfurnished', 0, 2, '5-10 Years', 'South', 0, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(185, 'Galaxy Penthouse', 'Triple-story penthouse with private glass elevator.', 'Residential', 'Flat', 'Buy', 'New', 58000000.00, 7200, 5, 7, 5, 'Fully-Furnished', 35, 35, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(186, 'Quantum Corporate', 'Office space with LEED certification and solar windows.', 'Commercial', 'Office', 'Buy', 'New', 19000000.00, 2100, NULL, NULL, NULL, 'Unfurnished', 12, 18, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(187, 'The Haven Villa', 'Modern 4BHK villa with a detached guest house.', 'Residential', 'Villa', 'Buy', 'New', 48000000.00, 6000, 5, 5, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(188, 'Boulevard Showroom', 'Prime corner showroom with 3-side glass visibility.', 'Commercial', 'Showroom', 'Rent', 'New', 340000.00, 4200, NULL, NULL, NULL, 'Unfurnished', 0, 3, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(189, 'Maple Leaf Flats', 'Spacious 3BHK with cross-ventilation and city views.', 'Residential', 'Flat', 'Buy', 'Resale', 8900000.00, 1850, 3, 3, 3, 'Semi-Furnished', 8, 12, '3-5 Years', 'South', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(190, 'Strategic Cargo Hub', 'Warehouse with dedicated customs clearing bay area.', 'Commercial', 'Warehouse', 'Rent', 'New', 210000.00, 16000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(191, 'The Noble Crest', 'Boutique 4BHK with a private art gallery hall.', 'Residential', 'Flat', 'Buy', 'New', 26500000.00, 3800, 4, 4, 3, 'Semi-Furnished', 16, 20, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29');
INSERT INTO `properties` (`property_id`, `title`, `description`, `property_category`, `property_type`, `listing_type`, `sale_type`, `price`, `area_sqft`, `bedrooms`, `bathrooms`, `balconies`, `furnishing_status`, `floor_number`, `total_floors`, `property_age`, `facing`, `covered_parking`, `availability_status`, `created_at`, `updated_at`) VALUES
(192, 'Sun-Kissed Bungalow', 'Villa designed for natural light with wide floor-to-ceiling windows.', 'Residential', 'Villa', 'Buy', 'Resale', 38000000.00, 6200, 5, 5, 4, 'Fully-Furnished', 0, 2, '5-10 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(193, 'Aura Business Park', 'Commercial floor with smart building management system.', 'Commercial', 'Office', 'Rent', 'New', 45000.00, 1250, NULL, NULL, NULL, 'Semi-Furnished', 5, 12, '1-3 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(194, 'Regal Retail', 'Exclusive shop space in a gold-souk themed development.', 'Commercial', 'Shop', 'Buy', 'New', 14500000.00, 800, NULL, NULL, NULL, 'Unfurnished', 1, 5, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(195, 'Panorama Heights', 'Luxury 3BHK with a 100ft long balcony deck.', 'Residential', 'Flat', 'Buy', 'New', 16800000.00, 2700, 3, 3, 2, 'Unfurnished', 14, 25, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(196, 'Blackwood Corporate', 'Minimalist black-glass office tower in CBD.', 'Commercial', 'Office', 'Rent', 'New', 980000.00, 15000, NULL, NULL, NULL, 'Unfurnished', 0, 6, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(197, 'The Sanctuary Villa', '4BHK villa with a private forest-garden concept.', 'Residential', 'Villa', 'Buy', 'New', 49000000.00, 6500, 4, 5, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'South', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(198, 'Omega Retail Point', 'Large format store space for furniture or home decor.', 'Commercial', 'Shop', 'Buy', 'New', 31000000.00, 3500, NULL, NULL, NULL, 'Unfurnished', 0, 1, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(199, 'Glacier Flats', 'Modern 2BHK with centralized cooling and water treatment.', 'Residential', 'Flat', 'Buy', 'Resale', 5900000.00, 1400, 2, 2, 1, 'Semi-Furnished', 4, 10, '5-10 Years', 'North', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(200, 'Ironclad Warehouse', 'High-security pharma warehouse with cold storage vault.', 'Commercial', 'Warehouse', 'Rent', 'New', 420000.00, 30000, NULL, NULL, NULL, 'Unfurnished', 0, 1, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:07:29', '2026-02-08 13:07:29'),
(201, 'The Sky-High Rental', 'Luxury 3BHK flat for rent with a view of the SG Highway.', 'Residential', 'Flat', 'Rent', 'New', 45000.00, 1850, 3, 3, 2, 'Fully-Furnished', 12, 20, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(202, 'Elysian Green Plot', 'Premium residential plot in a gated community with golf access.', 'Residential', 'Plot', 'Buy', 'New', 12000000.00, 3500, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(203, 'The Courtyard Villa', 'Stunning 4BHK villa available for lease in a quiet lane.', 'Residential', 'Villa', 'Rent', 'New', 120000.00, 4500, 4, 4, 2, 'Semi-Furnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(204, 'Urban Living Apartment', 'Cozy 2BHK flat for rent near major tech parks.', 'Residential', 'Flat', 'Rent', 'Resale', 22000.00, 1100, 2, 2, 1, 'Semi-Furnished', 3, 10, '3-5 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(205, 'Heritage Plot 51', 'Large corner plot for independent bungalow construction.', 'Residential', 'Plot', 'Buy', 'New', 8500000.00, 2800, NULL, NULL, NULL, NULL, 0, 0, 'New', 'South', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(206, 'The Mansion Hire', 'Palatial 5BHK villa for rent with home theater and private lift.', 'Residential', 'Villa', 'Rent', 'New', 250000.00, 6500, 5, 5, 3, 'Fully-Furnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(207, 'Silver Oak Flat', 'Well-ventilated 3BHK for rent in a family-friendly society.', 'Residential', 'Flat', 'Rent', 'Resale', 32000.00, 1600, 3, 3, 2, 'Unfurnished', 5, 12, '5-10 Years', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(208, 'Zenith Plot Vista', 'Residential land in a fast-developing neighborhood.', 'Residential', 'Plot', 'Buy', 'New', 6000000.00, 2100, NULL, NULL, NULL, NULL, 0, 0, 'New', 'West', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(209, 'Modern Minimalist Villa', 'Architect-designed 3BHK villa for rent with sleek interiors.', 'Residential', 'Villa', 'Rent', 'New', 85000.00, 3800, 3, 3, 2, 'Fully-Furnished', 0, 2, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(210, 'Executive Rental Suites', '2BHK apartment for rent for corporate professionals.', 'Residential', 'Flat', 'Rent', 'New', 38000.00, 1350, 2, 2, 1, 'Fully-Furnished', 8, 15, '0-1 Years', 'South', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(211, 'Science City Plot', 'Prime plot near the new science park extension.', 'Residential', 'Plot', 'Buy', 'New', 9800000.00, 3000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(212, 'The Lakeview Rental', '3BHK flat for rent overlooking Vastrapur Lake.', 'Residential', 'Flat', 'Rent', 'Resale', 35000.00, 1750, 3, 3, 2, 'Semi-Furnished', 6, 10, '5-10 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(213, 'Riverfront Plot', 'Exclusive plot with direct views of the Sabarmati riverfront.', 'Residential', 'Plot', 'Buy', 'New', 25000000.00, 4500, NULL, NULL, NULL, NULL, 0, 0, 'New', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(214, 'Orchard Villa Lease', 'Rustic 4BHK villa for rent in the green belt of Ahmedabad.', 'Residential', 'Villa', 'Rent', 'New', 95000.00, 4200, 4, 4, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(215, 'Sunrise Rental Apartment', 'Affordable 2BHK flat for rent near metro connectivity.', 'Residential', 'Flat', 'Rent', 'New', 18000.00, 1050, 2, 2, 1, 'Unfurnished', 2, 5, '0-1 Years', 'South', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(216, 'Titanium Plot Circle', 'Commercial-cum-residential plot in a high-demand area.', 'Residential', 'Plot', 'Buy', 'New', 18000000.00, 5000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(217, 'The Glass House Villa', 'Modern 4BHK villa for rent with floor-to-ceiling windows.', 'Residential', 'Villa', 'Rent', 'New', 150000.00, 4800, 4, 4, 3, 'Fully-Furnished', 0, 2, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(218, 'Penthouse For Rent', 'Luxurious 4BHK penthouse for rent with a private terrace garden.', 'Residential', 'Flat', 'Rent', 'New', 75000.00, 3200, 4, 4, 3, 'Semi-Furnished', 14, 14, '1-3 Years', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(219, 'Bopal Central Plot', 'Small residential plot ideal for a compact 3BHK house.', 'Residential', 'Plot', 'Buy', 'New', 4500000.00, 1500, NULL, NULL, NULL, NULL, 0, 0, 'New', 'South', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(220, 'Parkside Rental Villa', 'Gated community 3BHK villa for rent with shared amenities.', 'Residential', 'Villa', 'Rent', 'Resale', 55000.00, 3200, 3, 3, 2, 'Semi-Furnished', 0, 2, '5-10 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(221, 'Metropolitan Flat Rent', 'Contemporary 3BHK in the city center for lease.', 'Residential', 'Flat', 'Rent', 'New', 42000.00, 1900, 3, 3, 2, 'Fully-Furnished', 10, 25, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(222, 'The Grand Plot', 'Expansive 1000 sq yd plot for a luxury estate.', 'Residential', 'Plot', 'Buy', 'New', 35000000.00, 9000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(223, 'Luxe Rental Villa', 'High-end 5BHK villa for rent near International Schools.', 'Residential', 'Villa', 'Rent', 'New', 200000.00, 5800, 5, 6, 3, 'Fully-Furnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(224, 'Skyline Rental 2BHK', 'Compact 2BHK flat for rent in a high-rise tower.', 'Residential', 'Flat', 'Rent', 'New', 25000.00, 1150, 2, 2, 1, 'Semi-Furnished', 18, 22, '1-3 Years', 'South', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(225, 'Cornerstone Plot', 'Prime corner plot in a luxury township.', 'Residential', 'Plot', 'Buy', 'New', 11000000.00, 3200, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North-East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(226, 'The Suburban Rental', 'Quiet 3BHK flat for rent in a green neighborhood.', 'Residential', 'Flat', 'Rent', 'Resale', 28000.00, 1500, 3, 3, 2, 'Unfurnished', 4, 10, '3-5 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(227, 'The Heritage Plot', 'Plot with old-world charm in a historic society.', 'Residential', 'Plot', 'Buy', 'Resale', 7500000.00, 2500, NULL, NULL, NULL, NULL, 0, 0, '10+ Years', 'West', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(228, 'Poolside Villa Rent', 'Modern villa with a common pool view for rent.', 'Residential', 'Villa', 'Rent', 'New', 80000.00, 3500, 4, 4, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'South', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(229, 'Studio Rental Hub', 'Fully-furnished studio for rent near the university.', 'Residential', 'Flat', 'Rent', 'New', 15000.00, 750, 1, 1, 1, 'Fully-Furnished', 2, 5, '0-1 Years', 'East', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(230, 'The Vista Plot', 'Sloping plot ideal for a split-level designer home.', 'Residential', 'Plot', 'Buy', 'New', 9200000.00, 3800, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(231, 'Premium 4BHK Rent', 'Spacious 4BHK flat for rent with servant quarter.', 'Residential', 'Flat', 'Rent', 'New', 65000.00, 2800, 4, 4, 3, 'Semi-Furnished', 9, 14, '0-1 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(232, 'Gated Villa Lease', '4BHK villa for rent in a strictly residential gated community.', 'Residential', 'Villa', 'Rent', 'Resale', 110000.00, 4300, 4, 4, 2, 'Fully-Furnished', 0, 2, '5-10 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(233, 'The Square Plot', 'Perfectly square plot for easy construction.', 'Residential', 'Plot', 'Buy', 'New', 5000000.00, 1800, NULL, NULL, NULL, NULL, 0, 0, 'New', 'South', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(234, 'Budget Rental Flat', '2BHK flat for rent in a safe, affordable locality.', 'Residential', 'Flat', 'Rent', 'Resale', 16000.00, 950, 2, 2, 1, 'Unfurnished', 1, 4, '10+ Years', 'North', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(235, 'Exclusive Plot X', 'The last remaining plot in a sold-out luxury project.', 'Residential', 'Plot', 'Buy', 'New', 14000000.00, 4000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(236, 'Modern 3BHK For Rent', 'High-end 3BHK flat for rent with Bosch appliances.', 'Residential', 'Flat', 'Rent', 'New', 50000.00, 2100, 3, 3, 2, 'Fully-Furnished', 11, 20, '1-3 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(237, 'Villa For Corporate Lease', 'Large villa for rent ideal for guest houses.', 'Residential', 'Villa', 'Rent', 'New', 180000.00, 5500, 5, 5, 3, 'Semi-Furnished', 0, 2, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(238, 'The Green Plot', 'Land for sale in a location with high tree density.', 'Residential', 'Plot', 'Buy', 'New', 8800000.00, 3200, NULL, NULL, NULL, NULL, 0, 0, 'New', 'South', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(239, 'Townhouse For Rent', 'Newly built 3BHK townhouse available for rent.', 'Residential', 'Villa', 'Rent', 'New', 45000.00, 2800, 3, 3, 2, 'Unfurnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(240, 'Elite Rental Flat', 'Exclusive 4BHK apartment for rent in Bodakdev.', 'Residential', 'Flat', 'Rent', 'New', 85000.00, 3500, 4, 4, 3, 'Fully-Furnished', 15, 25, '1-3 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(241, 'Plot Near Ring Road', 'Great investment plot near the future industrial corridor.', 'Residential', 'Plot', 'Buy', 'New', 5200000.00, 2000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(242, 'Garden Villa For Rent', 'Quaint 3BHK villa available for lease with a front lawn.', 'Residential', 'Villa', 'Rent', 'Resale', 40000.00, 3000, 3, 3, 1, 'Semi-Furnished', 0, 2, '5-10 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(243, 'Flat For Rent Near Mall', '3BHK apartment for rent walking distance from Alpha One Mall.', 'Residential', 'Flat', 'Rent', 'Resale', 38000.00, 1700, 3, 3, 2, 'Fully-Furnished', 4, 12, '3-5 Years', 'South', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(244, 'Premium Plot Shilaj', 'Land for sale in a highly desirable residential pocket.', 'Residential', 'Plot', 'Buy', 'New', 12500000.00, 3800, NULL, NULL, NULL, NULL, 0, 0, 'New', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(245, 'Duplex Villa For Rent', 'Modern 4BHK duplex villa available for lease.', 'Residential', 'Villa', 'Rent', 'New', 70000.00, 3600, 4, 4, 2, 'Semi-Furnished', 0, 2, '1-3 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(246, 'Modern 2BHK Rental', 'Sleek 2BHK flat for rent with glass balconies.', 'Residential', 'Flat', 'Rent', 'New', 28000.00, 1250, 2, 2, 1, 'Fully-Furnished', 10, 18, '0-1 Years', 'North', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(247, 'The Sanctuary Plot', 'Secluded plot in a niche community for maximum privacy.', 'Residential', 'Plot', 'Buy', 'New', 15000000.00, 4200, NULL, NULL, NULL, NULL, 0, 0, 'New', 'South', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(248, 'Executive Villa Rent', 'Villa available for rent with private office room and gym.', 'Residential', 'Villa', 'Rent', 'New', 130000.00, 5000, 4, 4, 2, 'Fully-Furnished', 0, 2, '0-1 Years', 'East', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(249, '3BHK Rent Satellite', 'Spacious flat for rent in the heart of Satellite.', 'Residential', 'Flat', 'Rent', 'Resale', 42000.00, 1800, 3, 3, 2, 'Semi-Furnished', 5, 10, '5-10 Years', 'West', 1, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(250, 'Plot For Custom Build', 'Levelled land ready for construction with all permissions.', 'Residential', 'Plot', 'Buy', 'New', 7800000.00, 2600, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 0, 'Available', '2026-02-08 13:12:03', '2026-02-08 13:12:03'),
(251, 'Summit Commercial Lands', 'Prime corner plot with 4.0 FSI, ideal for a multi-story corporate headquarters.', 'Commercial', 'Plot', 'Buy', 'New', 185000000.00, 18000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'East', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(252, 'The Grand Retail Plot', 'Massive frontage on the main SG Highway corridor, perfect for luxury car showrooms.', 'Commercial', 'Plot', 'Buy', 'New', 240000000.00, 25000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(253, 'Logistics Industrial Park', 'Strategically located plot near the Sanand bypass for warehousing and cold storage.', 'Commercial', 'Plot', 'Buy', 'New', 55000000.00, 55000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'West', 0, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(254, 'CBD Business Square', 'N.A. cleared commercial land in Prahlad Nagar for high-rise development.', 'Commercial', 'Plot', 'Buy', 'New', 95000000.00, 12000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'East', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(255, 'The Metro Commercial Strip', 'Plot located directly adjacent to the upcoming Metro station with heavy footfall potential.', 'Commercial', 'Plot', 'Buy', 'New', 120000000.00, 15000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'South', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(256, 'Sindhu Bhavan Elite Plot', 'Exclusive commercial plot on Ahmedabad’s most premium road (SBR).', 'Commercial', 'Plot', 'Buy', 'New', 350000000.00, 10000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North-West', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(257, 'Changodar Trade Link', 'Vast commercial land ideal for industrial manufacturing or heavy equipment yard.', 'Commercial', 'Plot', 'Buy', 'New', 42000000.00, 75000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'North', 0, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(258, 'Science City IT Plot', 'IT/ITeS zoned land with pre-approved building plans for a tech park.', 'Commercial', 'Plot', 'Buy', 'New', 105000000.00, 28000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'East', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(259, 'Nikol Commercial Hub', 'Corner plot in a rapidly growing commercial area, suitable for a private hospital.', 'Commercial', 'Plot', 'Buy', 'New', 78000000.00, 22000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'West', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(260, 'Bopal Junction Land', 'Premium commercial plot at the junction, ideal for a retail mall or supermarket.', 'Commercial', 'Plot', 'Buy', 'New', 88000000.00, 16000, NULL, NULL, NULL, NULL, 0, 0, 'New', 'South', 1, 'Available', '2026-02-08 13:43:23', '2026-02-08 13:43:23'),
(261, 'XYZ', 'ABC', 'Residential', 'Flat', 'Rent', 'New', 20000.00, 0, 2, 2, 2, NULL, 4, 10, '5', 'East', 1, 'Available', '2026-02-21 06:08:41', '2026-02-21 06:08:41');

-- --------------------------------------------------------

--
-- Table structure for table `property_amenities`
--

CREATE TABLE `property_amenities` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `amenity_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_amenities`
--

INSERT INTO `property_amenities` (`id`, `property_id`, `amenity_id`) VALUES
(1, 1, 4),
(2, 1, 5),
(3, 1, 10),
(4, 2, 5),
(5, 2, 2),
(6, 2, 13),
(7, 3, 8),
(8, 3, 11),
(9, 8, 4),
(10, 8, 5),
(11, 12, 10),
(12, 14, 2),
(13, 15, 1),
(14, 16, 8),
(15, 16, 11),
(16, 17, 5),
(17, 17, 7),
(18, 19, 5),
(19, 19, 13),
(20, 21, 1),
(21, 21, 10),
(22, 23, 10),
(23, 24, 11),
(24, 26, 10),
(25, 26, 16),
(26, 27, 2),
(27, 27, 7),
(28, 31, 4),
(29, 31, 5),
(30, 32, 4),
(31, 32, 13),
(32, 39, 10),
(33, 41, 1),
(34, 41, 4),
(35, 47, 5),
(36, 49, 10),
(37, 53, 8),
(38, 56, 1),
(39, 59, 13),
(40, 62, 2),
(41, 64, 11),
(42, 66, 8),
(43, 66, 11),
(44, 66, 16),
(45, 67, 2),
(46, 67, 7),
(47, 70, 10),
(48, 74, 4),
(49, 74, 5),
(50, 74, 13),
(51, 77, 5),
(52, 77, 4),
(53, 85, 3),
(54, 85, 13),
(55, 91, 10),
(56, 97, 2),
(57, 103, 16),
(58, 109, 5),
(59, 109, 4),
(60, 113, 8),
(61, 116, 8),
(62, 116, 11),
(63, 116, 16),
(64, 117, 2),
(65, 117, 7),
(66, 120, 10),
(67, 124, 4),
(68, 124, 5),
(69, 124, 13),
(70, 127, 5),
(71, 127, 4),
(72, 135, 3),
(73, 135, 13),
(74, 141, 10),
(75, 147, 2),
(76, 153, 16),
(77, 159, 5),
(78, 159, 4),
(79, 163, 8),
(80, 166, 8),
(81, 166, 11),
(82, 167, 5),
(83, 167, 7),
(84, 170, 10),
(85, 174, 4),
(86, 174, 5),
(87, 177, 10),
(88, 185, 3),
(89, 185, 13),
(90, 191, 1),
(91, 197, 2),
(92, 200, 11),
(93, 201, 1),
(94, 201, 4),
(95, 201, 10),
(96, 203, 5),
(97, 203, 2),
(98, 206, 11),
(99, 206, 4),
(100, 206, 5),
(101, 210, 8),
(102, 210, 16),
(103, 214, 2),
(104, 217, 5),
(105, 217, 13),
(106, 218, 10),
(107, 223, 4),
(108, 223, 5),
(109, 228, 5),
(110, 232, 1),
(111, 237, 13),
(112, 240, 4),
(113, 240, 5),
(114, 245, 10),
(115, 248, 4),
(116, 248, 13);

-- --------------------------------------------------------

--
-- Table structure for table `property_images`
--

CREATE TABLE `property_images` (
  `image_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_images`
--

INSERT INTO `property_images` (`image_id`, `property_id`, `image_url`, `is_primary`) VALUES
(1, 1, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80', 1),
(2, 2, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800', 1),
(3, 3, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(4, 4, 'https://images.unsplash.com/photo-1582037928769-181f2644ecb7?q=80&w=800', 1),
(5, 5, 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=800', 1),
(6, 6, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(7, 7, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(8, 8, 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?q=80&w=800', 1),
(9, 9, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(10, 10, 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=800', 1),
(11, 11, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=800', 1),
(12, 12, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=800', 1),
(13, 13, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1200', 1),
(14, 14, 'https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?q=80&w=800', 1),
(15, 15, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(16, 16, 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?q=80&w=800', 1),
(17, 17, 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=800', 1),
(18, 18, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=800', 1),
(19, 19, 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?q=80&w=800', 1),
(20, 20, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=800', 1),
(21, 21, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80', 1),
(22, 22, 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=800', 1),
(23, 23, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=800', 1),
(24, 24, 'https://images.unsplash.com/photo-1582037928769-181f2644ecb7?q=80&w=800', 1),
(25, 25, 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=800', 1),
(26, 26, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(27, 27, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800', 1),
(28, 28, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(29, 29, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=800', 1),
(30, 30, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(31, 31, 'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?q=80&w=800', 1),
(32, 32, 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?q=80&w=800', 1),
(33, 33, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(34, 34, 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?q=80&w=800', 1),
(35, 35, 'https://images.unsplash.com/photo-1574362848149-11496d93a7c7?q=80&w=800', 1),
(36, 36, 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?q=80&w=800', 1),
(37, 37, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=800', 1),
(38, 38, 'https://images.unsplash.com/photo-1590274853856-f22d5ee3d228?q=80&w=800', 1),
(39, 39, 'https://images.unsplash.com/photo-1484154218962-a197022b5858?q=80&w=800', 1),
(40, 40, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200', 1),
(41, 41, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80', 1),
(42, 42, 'https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?q=80&w=800', 1),
(43, 43, 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=800', 1),
(44, 44, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(45, 45, 'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=800', 1),
(46, 46, 'https://images.unsplash.com/photo-1431540015161-0bf868a2d407?q=80&w=800', 1),
(47, 47, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=800', 1),
(48, 48, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(49, 49, 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?q=80&w=800', 1),
(50, 50, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200', 1),
(51, 51, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=800', 1),
(52, 52, 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800', 1),
(53, 53, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(54, 54, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(55, 55, 'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=800', 1),
(56, 56, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(57, 57, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=800', 1),
(58, 58, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(59, 59, 'https://images.unsplash.com/photo-1512914890251-2f96a9b0bbe2?q=80&w=800', 1),
(60, 60, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(61, 61, 'https://images.unsplash.com/photo-1484154218962-a197022b5858?q=80&w=800', 1),
(62, 62, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=1200', 1),
(63, 63, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(64, 64, 'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?q=80&w=800', 1),
(65, 65, 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=800', 1),
(66, 66, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(67, 67, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800', 1),
(68, 68, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(69, 69, 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=800', 1),
(70, 70, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80', 1),
(71, 71, 'https://images.unsplash.com/photo-1582037928769-181f2644ecb7?q=80&w=800', 1),
(72, 72, 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=800', 1),
(73, 73, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=800', 1),
(74, 74, 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?q=80&w=800', 1),
(75, 75, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(76, 76, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=800', 1),
(77, 77, 'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?q=80&w=800', 1),
(78, 78, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1200', 1),
(79, 79, 'https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?q=80&w=800', 1),
(80, 80, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(81, 81, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=800', 1),
(82, 82, 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=800', 1),
(83, 83, 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?q=80&w=800', 1),
(84, 84, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(85, 85, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80', 1),
(86, 86, 'https://images.unsplash.com/photo-1431540015161-0bf868a2d407?q=80&w=800', 1),
(87, 87, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=800', 1),
(88, 88, 'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?q=80&w=800', 1),
(89, 89, 'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=800', 1),
(90, 90, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200', 1),
(91, 91, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=800', 1),
(92, 92, 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800', 1),
(93, 93, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(94, 94, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(95, 95, 'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=800', 1),
(96, 96, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(97, 97, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=800', 1),
(98, 98, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(99, 99, 'https://images.unsplash.com/photo-1512914890251-2f96a9b0bbe2?q=80&w=800', 1),
(100, 100, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(101, 101, 'https://images.unsplash.com/photo-1484154218962-a197022b5858?q=80&w=800', 1),
(102, 102, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=1200', 1),
(103, 103, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(104, 104, 'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?q=80&w=800', 1),
(105, 105, 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=800', 1),
(106, 106, 'https://images.unsplash.com/photo-1431540015161-0bf868a2d407?q=80&w=800', 1),
(107, 107, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=800', 1),
(108, 108, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(109, 109, 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?q=80&w=800', 1),
(110, 110, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200', 1),
(111, 111, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=800', 1),
(112, 112, 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800', 1),
(113, 113, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(114, 114, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(115, 115, 'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=800', 1),
(116, 116, 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?q=80&w=800', 1),
(117, 117, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=800', 1),
(118, 118, 'https://images.unsplash.com/photo-1590274853856-f22d5ee3d228?q=80&w=800', 1),
(119, 119, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(120, 120, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80', 1),
(121, 121, 'https://images.unsplash.com/photo-1582037928769-181f2644ecb7?q=80&w=800', 1),
(122, 122, 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=800', 1),
(123, 123, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=800', 1),
(124, 124, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800', 1),
(125, 125, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(126, 126, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=800', 1),
(127, 127, 'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?q=80&w=800', 1),
(128, 128, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(129, 129, 'https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?q=80&w=800', 1),
(130, 130, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(131, 131, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(132, 132, 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=800', 1),
(133, 133, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(134, 134, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(135, 135, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80', 1),
(136, 136, 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=800', 1),
(137, 137, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(138, 138, 'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?q=80&w=800', 1),
(139, 139, 'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=800', 1),
(140, 140, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(141, 141, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=800', 1),
(142, 142, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(143, 143, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(144, 144, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(145, 145, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(146, 146, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(147, 147, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=800', 1),
(148, 148, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(149, 149, 'https://images.unsplash.com/photo-1512914890251-2f96a9b0bbe2?q=80&w=800', 1),
(150, 150, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(151, 151, 'https://images.unsplash.com/photo-1484154218962-a197022b5858?q=80&w=800', 1),
(152, 152, 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1200', 1),
(153, 153, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=800', 1),
(154, 154, 'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?q=80&w=800', 1),
(155, 155, 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=800', 1),
(156, 156, 'https://images.unsplash.com/photo-1431540015161-0bf868a2d407?q=80&w=800', 1),
(157, 157, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=800', 1),
(158, 158, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(159, 159, 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?q=80&w=800', 1),
(160, 160, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200', 1),
(161, 161, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=800', 1),
(162, 162, 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800', 1),
(163, 163, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(164, 164, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(165, 165, 'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=800', 1),
(166, 166, 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?q=80&w=800', 1),
(167, 167, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800', 1),
(168, 168, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(169, 169, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(170, 170, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=800', 1),
(171, 171, 'https://images.unsplash.com/photo-1582037928769-181f2644ecb7?q=80&w=800', 1),
(172, 172, 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=800', 1),
(173, 173, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=800', 1),
(174, 174, 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?q=80&w=800', 1),
(175, 175, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(176, 176, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=800', 1),
(177, 177, 'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?q=80&w=800', 1),
(178, 178, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(179, 179, 'https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?q=80&w=800', 1),
(180, 180, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(181, 181, 'https://images.unsplash.com/photo-1512914890251-2f96a9b0bbe2?q=80&w=800', 1),
(182, 182, 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=800', 1),
(183, 183, 'https://images.unsplash.com/photo-1431540015161-0bf868a2d407?q=80&w=800', 1),
(184, 184, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80', 1),
(185, 185, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80', 1),
(186, 186, 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=800', 1),
(187, 187, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=800', 1),
(188, 188, 'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?q=80&w=800', 1),
(189, 189, 'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=800', 1),
(190, 190, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200', 1),
(191, 191, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=800', 1),
(192, 192, 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800', 1),
(193, 193, 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=800', 1),
(194, 194, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(195, 195, 'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=800', 1),
(196, 196, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800', 1),
(197, 197, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=800', 1),
(198, 198, 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1200', 1),
(199, 199, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80', 1),
(200, 200, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=800', 1),
(201, 201, 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?q=80&w=1200&auto=format&fit=crop', 1),
(202, 202, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(203, 203, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800', 1),
(204, 204, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=800', 1),
(205, 205, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(206, 206, 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?q=80&w=800', 1),
(207, 207, 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=800', 1),
(208, 208, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(209, 209, 'https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?q=80&w=800', 1),
(210, 210, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=800', 1),
(211, 211, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(212, 212, 'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=800', 1),
(213, 213, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(214, 214, 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=800', 1),
(215, 215, 'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=800', 1),
(216, 216, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(217, 217, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=800', 1),
(218, 218, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80', 1),
(219, 219, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(220, 220, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=800', 1),
(221, 221, 'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?q=80&w=800', 1),
(222, 222, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(223, 223, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=800', 1),
(224, 224, 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?q=80&w=800', 1),
(225, 225, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(226, 226, 'https://images.unsplash.com/photo-1512914890251-2f96a9b0bbe2?q=80&w=800', 1),
(227, 227, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(228, 228, 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800', 1),
(229, 229, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=800', 1),
(230, 230, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(231, 231, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=800', 1),
(232, 232, 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=800', 1),
(233, 233, 'https://images.unsplash.com/photo-1555529669-e69e7303164a?auto=format&fit=crop&w=1200&q=80', 1),
(234, 234, 'https://images.unsplash.com/photo-1460317442991-0ec209397118?q=80&w=800', 1),
(235, 235, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(236, 236, 'https://images.unsplash.com/photo-1484154218962-a197022b5858?q=80&w=800', 1),
(237, 237, 'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=800', 1),
(238, 238, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(239, 239, 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1200', 1),
(240, 240, 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?q=80&w=800', 1),
(241, 241, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(242, 242, 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800', 1),
(243, 243, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80', 1),
(244, 244, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(245, 245, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=800', 1),
(246, 246, 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?q=80&w=800', 1),
(247, 247, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(248, 248, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=800', 1),
(249, 249, 'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=800', 1),
(250, 250, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=800', 1),
(261, 251, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=1200', 1),
(262, 252, 'https://images.unsplash.com/photo-1590274853856-f22d5ee3d228?q=80&w=1200', 1),
(263, 253, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200', 1),
(264, 254, 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1200', 1),
(265, 255, 'https://images.unsplash.com/photo-1560448204-603b3fc33ddc?q=80&w=1200', 1),
(266, 256, 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?q=80&w=1200', 1),
(267, 257, 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1200&auto=format&fit=crop', 1),
(268, 258, 'https://images.unsplash.com/photo-1497215842964-222b430dc094?q=80&w=1200', 1),
(269, 259, 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?q=80&w=1200&auto=format&fit=crop', 1),
(270, 260, 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?q=80&w=1200', 1);

-- --------------------------------------------------------

--
-- Table structure for table `property_location`
--

CREATE TABLE `property_location` (
  `location_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `city` varchar(100) DEFAULT 'Ahmedabad',
  `area` varchar(100) NOT NULL,
  `locality` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_location`
--

INSERT INTO `property_location` (`location_id`, `property_id`, `city`, `area`, `locality`, `pincode`, `address`) VALUES
(1, 1, 'Ahmedabad', 'Satellite', 'Ramdevnagar', '380015', 'Flat 802, The Emerald, Behind ISRO'),
(2, 2, 'Ahmedabad', 'Ambli', 'Bopal Road', '380058', 'Villa No. 12, Casa Ultima Society'),
(3, 3, 'Ahmedabad', 'Prahladnagar', 'Corporate Road', '380015', 'Suite 1205, Corporate Monolith'),
(4, 4, 'Ahmedabad', 'Sindhu Bhavan', 'Bodakdev', '380054', 'Ground Floor, Signature Pavilion'),
(5, 5, 'Ahmedabad', 'Chandkheda', 'New CG Road', '382424', 'A-304, Blue Bell Residency'),
(6, 6, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', '4th Floor, Stellar Workspace'),
(7, 7, 'Ahmedabad', 'Shilaj', 'Science City Road', '380059', 'Plot 45, Eldorado Estates'),
(8, 8, 'Ahmedabad', 'Thaltej', 'Hebatpur Road', '380059', 'PH-1, Imperial Suites'),
(9, 9, 'Ahmedabad', 'Vastrapur', 'Mansis Circle', '380015', 'Shop 12, Urban Square Retail'),
(10, 10, 'Ahmedabad', 'Naranpura', 'Shastrinagar', '380013', 'The Haven, 12 Pragati Society'),
(11, 11, 'Ahmedabad', 'Aslali', 'Indore Highway', '382427', 'Godown 5, Summit Logistics'),
(12, 12, 'Ahmedabad', 'Bodakdev', 'Judges Bungalow Road', '380054', '501 Orchid Terraces'),
(13, 13, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'F-102, Nexus Point'),
(14, 14, 'Ahmedabad', 'Shela', 'Club O7 Road', '380058', 'Villa 8, Willow Woods'),
(15, 15, 'Ahmedabad', 'SG Highway', 'Near YMCA', '380051', 'Level 18, Zenith Tower'),
(16, 16, 'Ahmedabad', 'Prahlad Nagar', 'Corporate Road', '380015', 'Suite 901, The Platinum Axis'),
(17, 17, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 22, Marigold Villas'),
(18, 18, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', 'Shop 104, Vertex Plaza'),
(19, 19, 'Ahmedabad', 'Satellite', 'Ramdevnagar', '380015', 'PH-12, Skyview Penthouse'),
(20, 20, 'Ahmedabad', 'Aslali', 'Highway Estate', '382427', 'Plot 501, The Industrial Grid'),
(21, 21, 'Ahmedabad', 'Motera', 'Stadium Road', '380005', 'C-402, Crystal Enclave'),
(22, 22, 'Ahmedabad', 'Navrangpura', 'Mithakhali', '380009', 'Heritage Manor, 14 Jain Society'),
(23, 23, 'Ahmedabad', 'Bodakdev', 'Judges Bungalow Road', '380054', 'B-702, Orchid Terraces'),
(24, 24, 'Ahmedabad', 'Thaltej', 'Sindhu Bhavan Road', '380059', 'GF-1, The Grand Atrium'),
(25, 25, 'Ahmedabad', 'Vastral', 'Metro Station Road', '382418', '204 Maple Leaf'),
(26, 26, 'Ahmedabad', 'SG Highway', 'Thaltej Crossroad', '380054', 'Floor 11, Solitaire Hub'),
(27, 27, 'Ahmedabad', 'Shela', 'Club O7 Road', '380058', 'Villa 4, The Arches'),
(28, 28, 'Ahmedabad', 'Bopal', 'TRP Mall Road', '380058', 'Shop 12, Prism Retail'),
(29, 29, 'Ahmedabad', 'Chandkheda', 'IOC Road', '382424', 'D-501, Silver Oak'),
(30, 30, 'Ahmedabad', 'Sanand', 'GIDC', '382110', 'Block B, Vector Logistics'),
(31, 31, 'Ahmedabad', 'Satellite', 'Jodhpur Crossroad', '380015', 'Floor 18, The Icon'),
(32, 32, 'Ahmedabad', 'Ambali', 'Main Road', '380058', 'Villa 1, Elysian Bungalows'),
(33, 33, 'Ahmedabad', 'Memnagar', 'Drive-in Road', '380052', '302 Corporate Edge'),
(34, 34, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', 'Nova Square, Ground Floor'),
(35, 35, 'Ahmedabad', 'Nikol', 'Kathwada Road', '382350', 'L-401, Green Park'),
(36, 36, 'Ahmedabad', 'SG Highway', 'Sola', '380060', 'Floor 15, The Apex'),
(37, 37, 'Ahmedabad', 'Shilaj', 'Science City Road', '380059', 'Villa 15, Magnolia Estates'),
(38, 38, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', 'GF-10, Alpha Commercial'),
(39, 39, 'Ahmedabad', 'Sola', 'Science City', '380060', '1001 Skyline Residency'),
(40, 40, 'Ahmedabad', 'Bawla', 'Industrial Hub', '382220', 'Fortuna Warehouse, Shed 5'),
(41, 41, 'Ahmedabad', 'Vastrapur', 'Lake Road', '380015', '1202 Imperial Heights'),
(42, 42, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 7, The Boulevard'),
(43, 43, 'Ahmedabad', 'Prahlad Nagar', 'Corporate Road', '380015', 'Level 6, Nexus One'),
(44, 44, 'Ahmedabad', 'C G Road', 'Navrangpura', '380009', 'Urban Vogue, Ground Floor'),
(45, 45, 'Ahmedabad', 'Maninagar', 'Station Road', '380008', '201 Oakwood Flat'),
(46, 46, 'Ahmedabad', 'Makarba', 'SG Highway', '380051', '8th Floor, Titanium Park'),
(47, 47, 'Ahmedabad', 'Ambali', 'Bopal Crossroad', '380058', 'Villa 9, Palm Jumeirah'),
(48, 48, 'Ahmedabad', 'Usmanpura', 'Riverfront Road', '380013', 'Shop 5, Midtown Center'),
(49, 49, 'Ahmedabad', 'Bodakdev', 'Rajpath Club Road', '380054', '1402 Azure Towers'),
(50, 50, 'Ahmedabad', 'Kathwada', 'GIDC', '382430', 'The Cargo Base, Main Gate'),
(51, 51, 'Ahmedabad', 'Mithakhali', 'Ellisbridge', '380006', '601 Summit Suites'),
(52, 52, 'Ahmedabad', 'Paldi', 'Bhatta Road', '380007', 'Gardenia Bungalow, 12 Society'),
(53, 53, 'Ahmedabad', 'SG Highway', 'Gota', '382481', 'Floor 10, Insignia Office'),
(54, 54, 'Ahmedabad', 'Chandkheda', 'New CG Road', '382424', 'Shop 102, The Galleria'),
(55, 55, 'Ahmedabad', 'Vatva', 'GIDC Road', '382440', '304 Lotus Residency'),
(56, 56, 'Ahmedabad', 'Gulbai Tekra', 'Panjrapole', '380015', 'Level 4, Emerald Commercial'),
(57, 57, 'Ahmedabad', 'Rancharda', 'Quiet Lane', '382721', 'Villa 5, The Retreat'),
(58, 58, 'Ahmedabad', 'Naranpura', 'Main Market', '380013', 'GF-2, Main Street Store'),
(59, 59, 'Ahmedabad', 'Ambawadi', 'Panchvati', '380006', 'PH-25, The Sapphire'),
(60, 60, 'Ahmedabad', 'Changodar', 'Industrial Belt', '382213', 'Stellar Warehouse, Unit 1'),
(61, 61, 'Ahmedabad', 'Ranip', 'New Ranip', '382480', 'B-201, Royal Court'),
(62, 62, 'Ahmedabad', 'Hebatpur', 'Thaltej', '380059', 'Villa Verde, 45 Enclave'),
(63, 63, 'Ahmedabad', 'Law Garden', 'Navrangpura', '380009', '502 Pinnacle Office'),
(64, 64, 'Ahmedabad', 'Satellite', 'Shivranjani', '380015', 'Elite Showroom, GF'),
(65, 65, 'Ahmedabad', 'Kalupur', 'Station Road', '380002', '101 Sunrise Apartments'),
(66, 66, 'Ahmedabad', 'SG Highway', 'Near Iscon', '380015', 'Level 14, The Zenith'),
(67, 67, 'Ahmedabad', 'Shilaj', 'Science City Road', '380059', 'Villa 14, Serene Enclave'),
(68, 68, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Shop G-2, Avenue Retail'),
(69, 69, 'Ahmedabad', 'Memnagar', 'Drive-in Road', '380052', '802 Skyline Hub'),
(70, 70, 'Ahmedabad', 'Satellite', 'Ramdevnagar', '380015', '501 The Marigold Suites'),
(71, 71, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', 'GF-1, Grand Central'),
(72, 72, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', '304 Willow Creek'),
(73, 73, 'Ahmedabad', 'Aslali', 'Bypass Road', '382427', 'Shed 8, The Logistic Corridor'),
(74, 74, 'Ahmedabad', 'Ambli', 'Bopal Crossroad', '380058', 'Villa 5, Imperial Garden'),
(75, 75, 'Ahmedabad', 'Prahlad Nagar', 'Corporate Road', '380015', 'Floor 10, Vantage Point'),
(76, 76, 'Ahmedabad', 'Navrangpura', 'Mithakhali', '380009', '602 The Urban Nest'),
(77, 77, 'Ahmedabad', 'Bodakdev', 'Judges Bungalow', '380054', '1501 Opaline Towers'),
(78, 78, 'Ahmedabad', 'C G Road', 'Ellisbridge', '380006', 'Shop 15, Capital Trade'),
(79, 79, 'Ahmedabad', 'Thaltej', 'Hebatpur Road', '380059', 'Villa 22, Green Leaf'),
(80, 80, 'Ahmedabad', 'Changodar', 'Industrial Belt', '382213', 'Unit 40, Summit Park'),
(81, 81, 'Ahmedabad', 'Sola', 'Science City', '380060', '402 Azure Heights'),
(82, 82, 'Ahmedabad', 'Naranpura', 'Shastrinagar', '380013', 'Bungalow 7, Sovereign Society'),
(83, 83, 'Ahmedabad', 'Vastrapur', 'Mansi Circle', '380015', '201 Nexus Plaza'),
(84, 84, 'Ahmedabad', 'Maninagar', 'Station Road', '380008', 'Shop 1, Mainline Retail'),
(85, 85, 'Ahmedabad', 'Satellite', 'Jodhpur', '380015', 'PH-18, Blue Sky Towers'),
(86, 86, 'Ahmedabad', 'Makarba', 'SG Highway', '380051', '702 Platinum Workspace'),
(87, 87, 'Ahmedabad', 'Shela', 'Club O7 Road', '380058', 'Villa 11, The Orchard'),
(88, 88, 'Ahmedabad', 'Sarkhej', 'Sanand Circle', '382210', 'Showroom 2, Vista Commercial'),
(89, 89, 'Ahmedabad', 'Chandkheda', 'IOC Road', '382424', '301 Maple Court'),
(90, 90, 'Ahmedabad', 'Kathwada', 'GIDC Phase 2', '382430', 'Shed 12, Swift Logistics'),
(91, 91, 'Ahmedabad', 'Ambawadi', 'Panchvati', '380006', '1201 The Icon'),
(92, 92, 'Ahmedabad', 'Navrangpura', 'Gulbai Tekra', '380015', 'Royal Palm, 18 Society'),
(93, 93, 'Ahmedabad', 'Usmanpura', 'Ashram Road', '380013', '501 Edge Suites'),
(94, 94, 'Ahmedabad', 'Satellite', 'Shivranjani', '380015', 'Shop 10, Galleria Boutique'),
(95, 95, 'Ahmedabad', 'Riverfront', 'Westside', '380001', '902 Riverview Residency'),
(96, 96, 'Ahmedabad', 'Science City', 'Main Road', '380060', 'Sterling Corporate, Plot 5'),
(97, 97, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 4, The Haven'),
(98, 98, 'Ahmedabad', 'Gota', 'Vasantnagar', '382481', 'GF-1, Alpha Retail Hub'),
(99, 99, 'Ahmedabad', 'Nikol', 'Kathwada Road', '382350', '504 Crimson Towers'),
(100, 100, 'Ahmedabad', 'Sanand', 'GIDC', '382110', 'Block 5, Titan Warehouse'),
(101, 101, 'Ahmedabad', 'Thaltej', 'Shilaj Road', '380059', '1002 Regal Heights'),
(102, 102, 'Ahmedabad', 'Vatva', 'GIDC Bypass', '382440', 'Villa 9, Emerald Enclave'),
(103, 103, 'Ahmedabad', 'SG Highway', 'Near YMCA', '380051', 'Level 12, Global Trade'),
(104, 104, 'Ahmedabad', 'Naranpura', 'Main Market', '380013', 'Shop 1, Cornerstone'),
(105, 105, 'Ahmedabad', 'Bopal', 'Iscon Ambli Road', '380058', '401 Orchid Residency'),
(106, 106, 'Ahmedabad', 'Prahlad Nagar', 'Garden Road', '380015', '6th Floor, The Cube'),
(107, 107, 'Ahmedabad', 'Ambali', 'Main Road', '380058', 'Villa 2, Tuscan Manor'),
(108, 108, 'Ahmedabad', 'Chandkheda', 'New CG Road', '382424', 'Shop G-4, Market Square'),
(109, 109, 'Ahmedabad', 'Bodakdev', 'Rajpath Club', '380054', 'PH-30, Nova Penthouse'),
(110, 110, 'Ahmedabad', 'Narol', 'Industrial Bypass', '382405', 'Cargo Port, Shed 10'),
(111, 111, 'Ahmedabad', 'Vastrapur', 'Lake View', '380015', '1102 Sky Garden'),
(112, 112, 'Ahmedabad', 'Paldi', 'Bhatta Road', '380007', 'Victorian Bungalow, 12'),
(113, 113, 'Ahmedabad', 'Makarba', 'Near SG', '380051', '801 Apex Business'),
(114, 114, 'Ahmedabad', 'C G Road', 'Municipal Market', '380009', 'GF-1, Uptown Showroom'),
(115, 115, 'Ahmedabad', 'Ranip', 'New Ranip', '382480', '201 Pearl Apartments'),
(116, 116, 'Ahmedabad', 'SG Highway', 'Thaltej', '380054', 'Level 11, The Onyx'),
(117, 117, 'Ahmedabad', 'Shilaj', 'Science City Road', '380059', 'Villa 18, Lavender Lane'),
(118, 118, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Shop G-1, Pavilion Hub'),
(119, 119, 'Ahmedabad', 'Satellite', 'Ramdevnagar', '380015', '702 Prism Suites'),
(120, 120, 'Ahmedabad', 'Bodakdev', 'Judges Bungalow', '380054', '401 Rosewood Manor'),
(121, 121, 'Ahmedabad', 'SG Highway', 'Gota', '382481', 'Showroom 5, Empire Hub'),
(122, 122, 'Ahmedabad', 'Chandkheda', 'New CG Road', '382424', '202 Cypress Court'),
(123, 123, 'Ahmedabad', 'Aslali', 'National Highway', '382427', 'Shed 12, Terminal Logistics'),
(124, 124, 'Ahmedabad', 'Ambali', 'Main Road', '380058', 'Villa 1, Sovereign Estate'),
(125, 125, 'Ahmedabad', 'Prahlad Nagar', 'Corporate Road', '380015', 'Level 9, Signature Point'),
(126, 126, 'Ahmedabad', 'Vastrapur', 'IIM Road', '380015', '1001 The Loft Studio'),
(127, 127, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', '1201 Aquamarine Towers'),
(128, 128, 'Ahmedabad', 'Navrangpura', 'C G Road', '380009', 'Shop 10, Bazaar Square'),
(129, 129, 'Ahmedabad', 'Thaltej', 'Hebatpur Road', '380059', 'Villa 9, Sandalwood Society'),
(130, 130, 'Ahmedabad', 'Changodar', 'Industrial Belt', '382213', 'Unit 10, Pinnacle Industrial'),
(131, 131, 'Ahmedabad', 'Sola', 'Science City', '380060', '502 Veridian Heights'),
(132, 132, 'Ahmedabad', 'Naranpura', 'Shastrinagar', '380013', 'Bungalow 5, Regency Enclave'),
(133, 133, 'Ahmedabad', 'Memnagar', 'Drive-in Road', '380052', '401 Corporate Nest'),
(134, 134, 'Ahmedabad', 'Satellite', 'Shivranjani', '380015', 'Shop 2, Main Avenue'),
(135, 135, 'Ahmedabad', 'Satellite', 'Jodhpur', '380015', 'PH-25, Diamond Towers'),
(136, 136, 'Ahmedabad', 'Makarba', 'SG Highway', '380051', '801 Titan Workspace'),
(137, 137, 'Ahmedabad', 'Shela', 'Club O7 Road', '380058', 'Villa 15, Magnolia Lane'),
(138, 138, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', 'GF-2, Broadwalk Commercial'),
(139, 139, 'Ahmedabad', 'Nikol', 'Kathwada Road', '382350', '601 Cedar Court'),
(140, 140, 'Ahmedabad', 'Narol', 'Industrial Bypass', '382405', 'Shed 4, Gateway Logistics'),
(141, 141, 'Ahmedabad', 'Ambawadi', 'Panchvati', '380006', '1401 The Noble Residence'),
(142, 142, 'Ahmedabad', 'Navrangpura', 'Ellisbridge', '380006', 'Palm Grove, 22 Society'),
(143, 143, 'Ahmedabad', 'Usmanpura', 'Ashram Road', '380013', '302 Summit Business'),
(144, 144, 'Ahmedabad', 'SG Highway', 'Near Iscon', '380015', 'Shop 105, Elite Couture'),
(145, 145, 'Ahmedabad', 'Vastrapur', 'Lake View', '380015', '1101 Parkview Heights'),
(146, 146, 'Ahmedabad', 'Science City', 'Main Road', '380060', 'Ironwood Corporate, Plot 8'),
(147, 147, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 10, The Oasis'),
(148, 148, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', 'GF-2, Beta Retail Hub'),
(149, 149, 'Ahmedabad', 'Vastral', 'Metro Station Road', '382418', '602 Silverstone Flats'),
(150, 150, 'Ahmedabad', 'Sanand', 'GIDC Phase 1', '382110', 'Block 12, Goliath Warehouse'),
(151, 151, 'Ahmedabad', 'Thaltej', 'Shilaj Road', '380059', '801 Imperial Skyfloor'),
(152, 152, 'Ahmedabad', 'Vatva', 'GIDC Bypass', '382440', 'Villa 3, Jade Enclave'),
(153, 153, 'Ahmedabad', 'SG Highway', 'Near YMCA', '380051', 'Level 15, Universal Trade'),
(154, 154, 'Ahmedabad', 'Navrangpura', 'St. Xaviers Road', '380009', 'Shop G-3, Focus Retail'),
(155, 155, 'Ahmedabad', 'Bopal', 'Bopal-Ambli Road', '380058', '302 Garden Court'),
(156, 156, 'Ahmedabad', 'Prahlad Nagar', 'Garden Road', '380015', '5th Floor, The Prism Office'),
(157, 157, 'Ahmedabad', 'Ambali', 'Main Road', '380058', 'Villa 11, Mediterranean Manor'),
(158, 158, 'Ahmedabad', 'Chandkheda', 'New CG Road', '382424', 'Shop G-1, Pulse Market'),
(159, 159, 'Ahmedabad', 'Bodakdev', 'Rajpath Club Road', '380054', 'PH-28, Stellar Penthouse'),
(160, 160, 'Ahmedabad', 'Kathwada', 'GIDC Road', '382430', 'Logistics Pro, Shed 15'),
(161, 161, 'Ahmedabad', 'Vastrapur', 'IIM-A Road', '380015', '902 Sky Gardenia'),
(162, 162, 'Ahmedabad', 'Paldi', 'Bhatta Road', '380007', 'Edwardian Bungalow, 10'),
(163, 163, 'Ahmedabad', 'Makarba', 'Near SG', '380051', '601 Zen Business Plaza'),
(164, 164, 'Ahmedabad', 'C G Road', 'Navrangpura', '380009', 'GF-1, Elite Drive Showroom'),
(165, 165, 'Ahmedabad', 'Ranip', 'New Ranip', '382480', '302 Velvet Apartments'),
(166, 166, 'Ahmedabad', 'Makarba', 'Corporate Road', '380051', '802 Titanium Square'),
(167, 167, 'Ahmedabad', 'Ambali', 'Main Road', '380058', 'Villa 5, The Palm Residency'),
(168, 168, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', 'Shop 101, Signature Street'),
(169, 169, 'Ahmedabad', 'SG Highway', 'Thaltej Cross', '380054', 'Floor 18, Skyline Hub'),
(170, 170, 'Ahmedabad', 'Satellite', 'Ramdevnagar', '380015', '501 Bluebell Luxury'),
(171, 171, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', 'Showroom GF, Grandeur'),
(172, 172, 'Ahmedabad', 'Chandkheda', 'IOC Road', '382424', '304 Meadow View'),
(173, 173, 'Ahmedabad', 'Aslali', 'National Highway', '382427', 'Port Shed 10, The Logistic Port'),
(174, 174, 'Ahmedabad', 'Ambli', 'Bopal Crossroad', '380058', 'Villa 1, Imperial Heritage'),
(175, 175, 'Ahmedabad', 'Prahlad Nagar', 'Corporate Road', '380015', 'Level 10, Vertex Business'),
(176, 176, 'Ahmedabad', 'Navrangpura', 'Mithakhali', '380009', 'L-4 Artisan Studios'),
(177, 177, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', '2201 Oceanic Blue'),
(178, 178, 'Ahmedabad', 'C G Road', 'Municipal Market', '380009', 'Shop 12, Capital Retail'),
(179, 179, 'Ahmedabad', 'Thaltej', 'Hebatpur Road', '380059', 'Villa 7, The Cedar'),
(180, 180, 'Ahmedabad', 'Changodar', 'Industrial Belt', '382213', 'Unit 15, Core Hub'),
(181, 181, 'Ahmedabad', 'Sola', 'Science City', '380060', '602 Elysian Heights'),
(182, 182, 'Ahmedabad', 'Naranpura', 'Shastrinagar', '380013', 'Bungalow 12, Victorian Manor'),
(183, 183, 'Ahmedabad', 'Vastrapur', 'IIM Road', '380015', '201 Workspace Collective'),
(184, 184, 'Ahmedabad', 'Maninagar', 'Station Road', '380008', 'Shop G-2, Mainline Boutique'),
(185, 185, 'Ahmedabad', 'Satellite', 'Jodhpur', '380015', 'PH-35, Galaxy Towers'),
(186, 186, 'Ahmedabad', 'Makarba', 'Near SG Highway', '380051', '1201 Quantum Corporate'),
(187, 187, 'Ahmedabad', 'Shela', 'Club O7 Road', '380058', 'Villa 20, The Haven'),
(188, 188, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', 'Showroom GF, Boulevard'),
(189, 189, 'Ahmedabad', 'Nikol', 'Kathwada Road', '382350', '801 Maple Leaf'),
(190, 190, 'Ahmedabad', 'Narol', 'Industrial Bypass', '382405', 'Bay 4, Strategic Cargo'),
(191, 191, 'Ahmedabad', 'Ambawadi', 'Panchvati', '380006', '1601 The Noble Crest'),
(192, 192, 'Ahmedabad', 'Navrangpura', 'Ellisbridge', '380006', 'Sun-Kissed Bungalow, 15'),
(193, 193, 'Ahmedabad', 'Usmanpura', 'Ashram Road', '380013', '502 Aura Business Park'),
(194, 194, 'Ahmedabad', 'SG Highway', 'Near Iscon', '380015', 'Shop 104, Regal Retail'),
(195, 195, 'Ahmedabad', 'Vastrapur', 'Lake View', '380015', '1401 Panorama Heights'),
(196, 196, 'Ahmedabad', 'Science City', 'Main Road', '380060', 'Blackwood Corp, Plot 10'),
(197, 197, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 12, The Sanctuary'),
(198, 198, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', 'GF Omega Retail'),
(199, 199, 'Ahmedabad', 'Vastral', 'Metro Station Road', '382418', '402 Glacier Flats'),
(200, 200, 'Ahmedabad', 'Sanand', 'GIDC Phase 1', '382110', 'Block 15, Ironclad Vault'),
(201, 201, 'Ahmedabad', 'SG Highway', 'Thaltej', '380054', 'A-1201, Sky-High Towers'),
(202, 202, 'Ahmedabad', 'Ambali', 'Main Road', '380058', 'Plot 4, Elysian Green Estate'),
(203, 203, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 12, The Courtyard Society'),
(204, 204, 'Ahmedabad', 'Makarba', 'Corporate Road', '380051', '302 Urban Living'),
(205, 205, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', 'Plot 51, Heritage Society'),
(206, 206, 'Ahmedabad', 'Shilaj', 'Science City Road', '380059', 'Villa 1, The Mansion'),
(207, 207, 'Ahmedabad', 'Satellite', 'Ramdevnagar', '380015', '504 Silver Oak Flats'),
(208, 208, 'Ahmedabad', 'Chandkheda', 'New CG Road', '382424', 'Plot 10, Zenith Vista'),
(209, 209, 'Ahmedabad', 'Prahlad Nagar', 'Garden Road', '380015', 'Villa 5, Minimalist Enclave'),
(210, 210, 'Ahmedabad', 'Bodakdev', 'Judges Bungalow', '380054', '802 Executive Suites'),
(211, 211, 'Ahmedabad', 'Science City', 'Main Road', '380060', 'Plot 89, Science Park Lane'),
(212, 212, 'Ahmedabad', 'Vastrapur', 'Lake Side', '380015', '601 Lakeview Rental'),
(213, 213, 'Ahmedabad', 'Riverfront', 'Westside', '380001', 'Plot 1, Riverview Estate'),
(214, 214, 'Ahmedabad', 'Shilaj', 'Green Belt', '380059', 'Villa 22, Orchard Lane'),
(215, 215, 'Ahmedabad', 'Vastral', 'Metro Station Road', '382418', '201 Sunrise Apartments'),
(216, 216, 'Ahmedabad', 'Thaltej', 'SG Highway Circle', '380054', 'Plot 15, Titanium Point'),
(217, 217, 'Ahmedabad', 'Ambali', 'Ambali Road', '380058', 'Villa 8, Glass House'),
(218, 218, 'Ahmedabad', 'Satellite', 'Jodhpur', '380015', 'PH-14, Parkview Towers'),
(219, 219, 'Ahmedabad', 'Bopal', 'Main Market', '380058', 'Plot 4, Bopal Central'),
(220, 220, 'Ahmedabad', 'Gota', 'Vasantnagar', '382481', 'Villa 7, Parkside Society'),
(221, 221, 'Ahmedabad', 'Navrangpura', 'Mithakhali', '380009', '1001 Metropolitan Flats'),
(222, 222, 'Ahmedabad', 'Shilaj', 'Near Science City', '380059', 'Plot 1, The Grand Estate'),
(223, 223, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan', '380054', 'Villa 15, Luxe Rental'),
(224, 224, 'Ahmedabad', 'Memnagar', 'Drive-in Road', '380052', '1802 Skyline Rental'),
(225, 225, 'Ahmedabad', 'Sola', 'Science City Road', '380060', 'Plot 12, Cornerstone Township'),
(226, 226, 'Ahmedabad', 'Chandkheda', 'IOC Road', '382424', '401 The Suburban Rental'),
(227, 227, 'Ahmedabad', 'Navrangpura', 'Ellisbridge', '380006', 'Plot 5, Heritage Lane'),
(228, 228, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 4, Poolside Society'),
(229, 229, 'Ahmedabad', 'Navrangpura', 'St. Xaviers Road', '380009', '201 Studio Rental'),
(230, 230, 'Ahmedabad', 'Thaltej', 'Hebatpur', '380059', 'Plot 2, The Vista'),
(231, 231, 'Ahmedabad', 'Satellite', 'Shivranjani', '380015', '902 Premium 4BHK'),
(232, 232, 'Ahmedabad', 'Gota', 'Main Road', '382481', 'Villa 9, Gated Enclave'),
(233, 233, 'Ahmedabad', 'Nikol', 'Kathwada Road', '382350', 'Plot 88, The Square'),
(234, 234, 'Ahmedabad', 'Vatva', 'GIDC Bypass', '382440', '101 Budget Rental'),
(235, 235, 'Ahmedabad', 'Ambali', 'Club O7 Road', '380058', 'Plot 25, Exclusive X'),
(236, 236, 'Ahmedabad', 'Bodakdev', 'Rajpath Club Road', '380054', '1102 Modern 3BHK'),
(237, 237, 'Ahmedabad', 'SG Highway', 'Near YMCA', '380051', 'Villa 11, Corporate Lease'),
(238, 238, 'Ahmedabad', 'Shilaj', 'Science City Area', '380059', 'Plot 15, The Green Plot'),
(239, 239, 'Ahmedabad', 'Bopal', 'South Bopal', '380058', 'Villa 6, Townhouse Rental'),
(240, 240, 'Ahmedabad', 'Bodakdev', 'Judges Bungalow', '380054', '1501 Elite Rental'),
(241, 241, 'Ahmedabad', 'Narol', 'Industrial Bypass', '382405', 'Plot 4, Ring Road Land'),
(242, 242, 'Ahmedabad', 'Paldi', 'Bhatta Road', '380007', 'Villa 10, Garden Villa'),
(243, 243, 'Ahmedabad', 'Vastrapur', 'Alpha One Mall Road', '380015', '402 Flat Near Mall'),
(244, 244, 'Ahmedabad', 'Shilaj', 'Main Road', '380059', 'Plot 1, Premium Shilaj'),
(245, 245, 'Ahmedabad', 'Satellite', 'Ramdevnagar', '380015', 'Villa 3, Duplex Rental'),
(246, 246, 'Ahmedabad', 'Makarba', 'Near SG Highway', '380051', '1002 Modern 2BHK'),
(247, 247, 'Ahmedabad', 'Gota', 'Satyamev Road', '382481', 'Plot 22, The Sanctuary'),
(248, 248, 'Ahmedabad', 'Ambali', 'Bopal Crossroad', '380058', 'Villa 4, Executive Rent'),
(249, 249, 'Ahmedabad', 'Satellite', 'Main Road', '380015', '501 3BHK Satellite'),
(250, 250, 'Ahmedabad', 'Chandkheda', 'New CG Road', '382424', 'Plot 12, Custom Build Land'),
(261, 251, 'Ahmedabad', 'Makarba', 'Corporate Road', '380051', 'Commercial Plot 8, Behind Titanium Square'),
(262, 252, 'Ahmedabad', 'SG Highway', 'Thaltej', '380054', 'Plot 4, Main Highway Road'),
(263, 253, 'Ahmedabad', 'Sanand', 'GIDC', '382110', 'Industrial Plot 112, Phase 2'),
(264, 254, 'Ahmedabad', 'Prahlad Nagar', 'Garden Road', '380015', 'N.A. Land, Opposite Corporate Towers'),
(265, 255, 'Ahmedabad', 'Gota', 'New SG Highway', '382481', 'Metro Block 5, Vasantnagar'),
(266, 256, 'Ahmedabad', 'Bodakdev', 'Sindhu Bhavan Road', '380054', 'SBR Plot 1, Near Taj Skyline'),
(267, 257, 'Ahmedabad', 'Changodar', 'Industrial Belt', '382213', 'Shed Area 40, Trade Link Park'),
(268, 258, 'Ahmedabad', 'Science City', 'Sola', '380060', 'IT Park Plot 12, Science City Road'),
(269, 259, 'Ahmedabad', 'Nikol', 'Kathwada Road', '382350', 'Block 22, Nikol Commercial Zone'),
(270, 260, 'Ahmedabad', 'Bopal', 'Bopal-Ambli Road', '380058', 'Plot 101, Main Junction'),
(271, 261, 'Ahmedabad', 'Bopal', NULL, '', 'XYZ');

-- --------------------------------------------------------

--
-- Table structure for table `property_owner`
--

CREATE TABLE `property_owner` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_owner`
--

INSERT INTO `property_owner` (`id`, `property_id`, `owner_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 13),
(14, 14, 14),
(15, 15, 15),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20),
(21, 21, 21),
(22, 22, 22),
(23, 23, 23),
(24, 24, 24),
(25, 25, 25),
(26, 26, 26),
(27, 27, 27),
(28, 28, 28),
(29, 29, 29),
(30, 30, 30),
(31, 31, 31),
(32, 32, 32),
(33, 33, 33),
(34, 34, 34),
(35, 35, 35),
(36, 36, 36),
(37, 37, 37),
(38, 38, 38),
(39, 39, 39),
(40, 40, 40),
(41, 41, 41),
(42, 42, 42),
(43, 43, 43),
(44, 44, 44),
(45, 45, 45),
(46, 46, 46),
(47, 47, 47),
(48, 48, 48),
(49, 49, 49),
(50, 50, 50),
(51, 51, 1),
(52, 52, 2),
(53, 53, 3),
(54, 54, 4),
(55, 55, 5),
(56, 56, 6),
(57, 57, 7),
(58, 58, 8),
(59, 59, 9),
(60, 60, 10),
(61, 61, 11),
(62, 62, 12),
(63, 63, 13),
(64, 64, 14),
(65, 65, 15),
(66, 66, 16),
(67, 67, 17),
(68, 68, 18),
(69, 69, 19),
(70, 70, 20),
(71, 71, 21),
(72, 72, 22),
(73, 73, 23),
(74, 74, 24),
(75, 75, 25),
(76, 76, 26),
(77, 77, 27),
(78, 78, 28),
(79, 79, 29),
(80, 80, 30),
(81, 81, 31),
(82, 82, 32),
(83, 83, 33),
(84, 84, 34),
(85, 85, 35),
(86, 86, 36),
(87, 87, 37),
(88, 88, 38),
(89, 89, 39),
(90, 90, 40),
(91, 91, 41),
(92, 92, 42),
(93, 93, 43),
(94, 94, 44),
(95, 95, 45),
(96, 96, 46),
(97, 97, 47),
(98, 98, 48),
(99, 99, 49),
(100, 100, 50),
(101, 101, 1),
(102, 102, 2),
(103, 103, 3),
(104, 104, 4),
(105, 105, 5),
(106, 106, 6),
(107, 107, 7),
(108, 108, 8),
(109, 109, 9),
(110, 110, 10),
(111, 111, 11),
(112, 112, 12),
(113, 113, 13),
(114, 114, 14),
(115, 115, 15),
(116, 116, 16),
(117, 117, 17),
(118, 118, 18),
(119, 119, 19),
(120, 120, 20),
(121, 121, 21),
(122, 122, 22),
(123, 123, 23),
(124, 124, 24),
(125, 125, 25),
(126, 126, 26),
(127, 127, 27),
(128, 128, 28),
(129, 129, 29),
(130, 130, 30),
(131, 131, 31),
(132, 132, 32),
(133, 133, 33),
(134, 134, 34),
(135, 135, 35),
(136, 136, 36),
(137, 137, 37),
(138, 138, 38),
(139, 139, 39),
(140, 140, 40),
(141, 141, 41),
(142, 142, 42),
(143, 143, 43),
(144, 144, 44),
(145, 145, 45),
(146, 146, 46),
(147, 147, 47),
(148, 148, 48),
(149, 149, 49),
(150, 150, 50),
(151, 151, 1),
(152, 152, 2),
(153, 153, 3),
(154, 154, 4),
(155, 155, 5),
(156, 156, 6),
(157, 157, 7),
(158, 158, 8),
(159, 159, 9),
(160, 160, 10),
(161, 161, 11),
(162, 162, 12),
(163, 163, 13),
(164, 164, 14),
(165, 165, 15),
(166, 166, 16),
(167, 167, 17),
(168, 168, 18),
(169, 169, 19),
(170, 170, 20),
(171, 171, 21),
(172, 172, 22),
(173, 173, 23),
(174, 174, 24),
(175, 175, 25),
(176, 176, 26),
(177, 177, 27),
(178, 178, 28),
(179, 179, 29),
(180, 180, 30),
(181, 181, 31),
(182, 182, 32),
(183, 183, 33),
(184, 184, 34),
(185, 185, 35),
(186, 186, 36),
(187, 187, 37),
(188, 188, 38),
(189, 189, 39),
(190, 190, 40),
(191, 191, 41),
(192, 192, 42),
(193, 193, 43),
(194, 194, 44),
(195, 195, 45),
(196, 196, 46),
(197, 197, 47),
(198, 198, 48),
(199, 199, 49),
(200, 200, 50),
(201, 201, 1),
(202, 202, 2),
(203, 203, 3),
(204, 204, 4),
(205, 205, 5),
(206, 206, 6),
(207, 207, 7),
(208, 208, 8),
(209, 209, 9),
(210, 210, 10),
(211, 211, 11),
(212, 212, 12),
(213, 213, 13),
(214, 214, 14),
(215, 215, 15),
(216, 216, 16),
(217, 217, 17),
(218, 218, 18),
(219, 219, 19),
(220, 220, 20),
(221, 221, 21),
(222, 222, 22),
(223, 223, 23),
(224, 224, 24),
(225, 225, 25),
(226, 226, 26),
(227, 227, 27),
(228, 228, 28),
(229, 229, 29),
(230, 230, 30),
(231, 231, 31),
(232, 232, 32),
(233, 233, 33),
(234, 234, 34),
(235, 235, 35),
(236, 236, 36),
(237, 237, 37),
(238, 238, 38),
(239, 239, 39),
(240, 240, 40),
(241, 241, 41),
(242, 242, 42),
(243, 243, 43),
(244, 244, 44),
(245, 245, 45),
(246, 246, 46),
(247, 247, 47),
(248, 248, 48),
(249, 249, 49),
(250, 250, 50),
(261, 251, 30),
(262, 252, 32),
(263, 253, 35),
(264, 254, 38),
(265, 255, 41),
(266, 256, 44),
(267, 257, 47),
(268, 258, 50),
(269, 259, 12),
(270, 260, 15),
(271, 261, 1);

-- --------------------------------------------------------

--
-- Table structure for table `recently_viewed`
--

CREATE TABLE `recently_viewed` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recently_viewed`
--

INSERT INTO `recently_viewed` (`id`, `user_id`, `property_id`, `viewed_at`) VALUES
(9, 22, 206, '2026-02-20 15:18:20'),
(10, 22, 260, '2026-02-20 15:18:24'),
(11, 23, 177, '2026-02-21 03:25:51'),
(12, 23, 126, '2026-02-20 16:20:10'),
(14, 23, 170, '2026-02-21 03:25:39'),
(15, 23, 172, '2026-02-21 03:25:44'),
(16, 23, 185, '2026-02-21 03:25:55'),
(20, 23, 181, '2026-02-21 03:22:00'),
(22, 23, 189, '2026-02-21 03:26:01'),
(30, 23, 191, '2026-02-21 03:26:07'),
(31, 4, 172, '2026-02-21 03:55:59'),
(32, 4, 185, '2026-02-23 06:54:00'),
(33, 4, 65, '2026-02-21 03:56:55'),
(34, 4, 227, '2026-02-21 04:10:38'),
(35, 4, 258, '2026-02-21 04:10:53'),
(36, 4, 189, '2026-02-21 06:04:46'),
(37, 4, 261, '2026-02-21 06:09:40'),
(38, 4, 201, '2026-02-21 06:09:53'),
(39, 4, 181, '2026-02-23 06:49:27'),
(41, 24, 175, '2026-02-23 06:56:58'),
(42, 24, 251, '2026-02-23 06:59:11'),
(44, 24, 256, '2026-02-23 07:00:20'),
(45, 24, 170, '2026-02-23 15:52:14'),
(47, 25, 205, '2026-02-23 15:59:11'),
(48, 4, 170, '2026-02-23 16:01:54');

-- --------------------------------------------------------

--
-- Table structure for table `saved_properties`
--

CREATE TABLE `saved_properties` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `saved_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_properties`
--

INSERT INTO `saved_properties` (`id`, `user_id`, `property_id`, `saved_at`) VALUES
(11, 22, 181, '2026-02-20 15:22:07'),
(12, 23, 170, '2026-02-20 16:13:30'),
(13, 23, 177, '2026-02-20 16:13:33'),
(14, 23, 204, '2026-02-20 16:19:58'),
(15, 23, 212, '2026-02-20 16:20:06'),
(16, 4, 185, '2026-02-21 03:56:15'),
(17, 4, 151, '2026-02-21 03:57:17'),
(18, 4, 170, '2026-02-23 06:50:16'),
(19, 24, 170, '2026-02-23 15:52:22');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_expires_at` datetime DEFAULT NULL,
  `otp_last_sent_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone`, `password_hash`, `role`, `otp_code`, `otp_expires_at`, `otp_last_sent_at`, `created_at`) VALUES
(4, 'Meet Gojariya', 'meetgojariya214@gmail.com', '9825057315', 'scrypt:32768:8:1$ISFUSCqDmrnai0Jq$d57973d8e3418315f4102f2c6b70579426bfa4a3daf44368bd567402718ef32987c3fd1653bdddd0b8a5b9d6a863a8fd3c5905881aec82351a9972f34c339db1', 'user', NULL, NULL, '2026-02-23 15:59:45', '2026-01-26 11:04:01'),
(15, 'Meet Parsana', 'meetparsana211@gmail.com', '7211199976', 'scrypt:32768:8:1$D3Yoq8v1Hi7pqpf7$cd877afcec626b59fafcd42c925538f1ba1158eb33e043d2f01c3fe5c304cad3faee991f0cdd7859454c0b821470a066cb1276736d2449e7f9f5c2fe34877d2f', 'user', NULL, NULL, '2026-01-26 16:22:21', '2026-01-26 16:03:02'),
(20, 'Khush Borsania', 'khushborsania1276@gmail.com', '7984491631', 'scrypt:32768:8:1$RpcMzxvdDNeta2RN$f8ecad0ca5c9658006d66f378a069b684c6fd3842b52d59d4f807f924788826835ef881b6e18f1b201b64db6b6e2329fe5b059f543871bb4877ec8c2752c1de9', 'user', NULL, NULL, NULL, '2026-01-26 16:59:31'),
(21, 'Krish Tarpara', 'tarparakrish0903@gmail.com', '7201036881', 'scrypt:32768:8:1$ubr6CVKrte9aCq8u$eb8a1728c27ba47bb5a396a896544c0ef3dcdfb19f3cc9df894cbc0b8f94f3e05f763e5cf21c48df60d3cdbca242f60dad6d62132fd3e0bca565274ece445cdd', 'user', NULL, NULL, '2026-02-20 09:38:25', '2026-01-29 12:58:34'),
(22, 'Fenil Koyani', 'fenilkoyani7@gmail.com', '9313475926', 'scrypt:32768:8:1$41AQr60S0ptnvfnJ$6507517d460ee38115841414ae8e67f097bdea62843bc96b5fd9bc2af98c889c8d0a63c51d55ac530f03c1e9f3ab307f64c4ad807cf114611cc82de6fec7f409', 'user', NULL, NULL, NULL, '2026-02-20 14:14:52'),
(23, 'manan kaba', 'manankaba2007@gmail.com', '9558892237', 'scrypt:32768:8:1$OuEsDT9YoYJRKwX4$9c7d08ecee52c659da84273463158c352902eec28917913373d091f324cebeaf0229aaf3d76e7442e61afe91c3e2756de7784b9918b329b5ae9622bd899dd027', 'user', NULL, NULL, NULL, '2026-02-20 16:12:33'),
(24, 'Foram Gojariya', 'foramgojariya24@gmail.com', '9923622248', 'scrypt:32768:8:1$t0Bu3gFFgAAqIbCf$f3e95d062ba898b052e75d942a79735ca5481c4803cdec01c8af8a3f569524539f3e4eb8854397ffc4158916756a9652ba07738efa201ab3d6e9dccbd6b1051d', 'user', NULL, NULL, NULL, '2026-02-23 06:55:58'),
(25, 'Vipulbhai Gojariya', 'vipulgojariya@gmail.com', '9923622236', 'scrypt:32768:8:1$Tv0PAz8VplUk7v3f$87d9d29ab9a53e546b8dc8bccef4095691118cccb1bd171d03729522b8be070b8583c472d5874849bd3287fa9986ab6af7ede18567c9949592252f447d19a203', 'user', NULL, NULL, NULL, '2026-02-23 15:53:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `amenities`
--
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`amenity_id`),
  ADD UNIQUE KEY `amenity_name` (`amenity_name`);

--
-- Indexes for table `contacted_properties`
--
ALTER TABLE `contacted_properties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_property_contact` (`user_id`,`property_id`),
  ADD KEY `idx_user_id_contacted` (`user_id`),
  ADD KEY `idx_property_id_contacted` (`property_id`),
  ADD KEY `idx_contacted_at` (`contacted_at`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `enquiries`
--
ALTER TABLE `enquiries`
  ADD PRIMARY KEY (`enquiry_id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`owner_id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`property_id`);

--
-- Indexes for table `property_amenities`
--
ALTER TABLE `property_amenities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `amenity_id` (`amenity_id`);

--
-- Indexes for table `property_images`
--
ALTER TABLE `property_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `property_location`
--
ALTER TABLE `property_location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `property_owner`
--
ALTER TABLE `property_owner`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `recently_viewed`
--
ALTER TABLE `recently_viewed`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_property_view` (`user_id`,`property_id`),
  ADD KEY `idx_user_id_viewed` (`user_id`),
  ADD KEY `idx_property_id_viewed` (`property_id`),
  ADD KEY `idx_viewed_at` (`viewed_at`);

--
-- Indexes for table `saved_properties`
--
ALTER TABLE `saved_properties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_property` (`user_id`,`property_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_property_id` (`property_id`),
  ADD KEY `idx_saved_at` (`saved_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email_unique` (`email`),
  ADD UNIQUE KEY `phone_unique` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `amenities`
--
ALTER TABLE `amenities`
  MODIFY `amenity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `contacted_properties`
--
ALTER TABLE `contacted_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `enquiries`
--
ALTER TABLE `enquiries`
  MODIFY `enquiry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `owners`
--
ALTER TABLE `owners`
  MODIFY `owner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `property_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;

--
-- AUTO_INCREMENT for table `property_amenities`
--
ALTER TABLE `property_amenities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `property_images`
--
ALTER TABLE `property_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT for table `property_location`
--
ALTER TABLE `property_location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=272;

--
-- AUTO_INCREMENT for table `property_owner`
--
ALTER TABLE `property_owner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=272;

--
-- AUTO_INCREMENT for table `recently_viewed`
--
ALTER TABLE `recently_viewed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `saved_properties`
--
ALTER TABLE `saved_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacted_properties`
--
ALTER TABLE `contacted_properties`
  ADD CONSTRAINT `fk_contacted_property` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_contacted_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `enquiries`
--
ALTER TABLE `enquiries`
  ADD CONSTRAINT `enquiries_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE;

--
-- Constraints for table `property_amenities`
--
ALTER TABLE `property_amenities`
  ADD CONSTRAINT `property_amenities_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `property_amenities_ibfk_2` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`amenity_id`) ON DELETE CASCADE;

--
-- Constraints for table `property_images`
--
ALTER TABLE `property_images`
  ADD CONSTRAINT `property_images_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE;

--
-- Constraints for table `property_location`
--
ALTER TABLE `property_location`
  ADD CONSTRAINT `property_location_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE;

--
-- Constraints for table `property_owner`
--
ALTER TABLE `property_owner`
  ADD CONSTRAINT `property_owner_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `property_owner_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`owner_id`) ON DELETE CASCADE;

--
-- Constraints for table `recently_viewed`
--
ALTER TABLE `recently_viewed`
  ADD CONSTRAINT `fk_viewed_property` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_viewed_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `saved_properties`
--
ALTER TABLE `saved_properties`
  ADD CONSTRAINT `fk_saved_property` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_saved_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
