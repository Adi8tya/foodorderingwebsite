-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2021 at 09:14 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food_ordering`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`email`, `password`, `name`, `type`) VALUES
('admin2@gmail.com', 'richa', 'Richa', 'admin'),
('admin@yahoo.com', '123123', 'Subhrato', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `billid` int(11) NOT NULL,
  `dateofbill` date NOT NULL,
  `grandtotal` float NOT NULL,
  `customerid` int(11) NOT NULL,
  `paymentmode` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `mobileno` varchar(10) NOT NULL,
  `address` varchar(200) NOT NULL,
  `deliveryboyid` int(11) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`billid`, `dateofbill`, `grandtotal`, `customerid`, `paymentmode`, `status`, `name`, `mobileno`, `address`, `deliveryboyid`, `remarks`) VALUES
(23, '2019-04-25', 304, 1, 'COD', 'Delivered', 'Monika', '8054922174', 'Amritsar', 7, 'no'),
(24, '2019-04-25', 50, 1, 'Online', 'Confirmed', 'Monika', '8054922174', 'Amritsar', 9, 'no'),
(25, '2019-04-25', 80, 1, 'Online', 'Confirmed', 'Monika', '8054922174', 'Amritsar', NULL, NULL),
(26, '2019-04-25', 200, 5, 'Online', 'Delivered', 'Richa', '7814381842', 'basant avenue', 7, 'no'),
(27, '2019-04-25', 260, 4, 'Online', 'Delivered', 'kaushal shukla', '8054922174', 'amritsar punjab', 19, 'no'),
(28, '2019-04-26', 186, 6, 'Online', 'Delivered', 'Twinkle', '8847074362', 'Nehru colony', 5, 'no'),
(29, '2019-04-26', 186, 5, 'Online', 'Delivered', 'Richa', '7814381842', 'basant avenue', 5, 'no'),
(30, '2019-04-26', 186, 6, 'Online', 'Dispatched', 'Twinkle', '8847074362', 'Nehru colony', NULL, 'no'),
(31, '2019-04-26', 128, 5, 'Online', 'Confirmed', 'Richa', '7814381842', 'basant avenue', NULL, 'no'),
(32, '2019-04-26', 50, 5, 'COD', 'Confirmed', 'Richa', '7814381842', 'basant avenue', 8, 'no'),
(33, '2019-05-22', 194, 5, 'Online', 'Pending', 'Richa', '7814381842', 'basant avenue', 5, 'no'),
(34, '2021-05-12', 186, 6, 'Online', 'Dispatched', 'Twinkle', '8847074362', 'Nehru colony', 5, 'no'),
(35, '2021-05-12', 120, 6, 'Online', 'Delivered', 'Twinkle', '8847074362', 'Nehru colony', 5, 'no'),
(36, '2021-05-12', 599, 7, 'Online', 'Pending', 'tanya', '7087958847', 'majitha road', NULL, 'na'),
(38, '2021-05-20', 259, 8, 'Online', 'Pending', 'Dom', '12345', 'Ranjit Avenue', NULL, NULL),
(41, '2021-05-21', 760, 8, 'Online', 'Confirmed', 'Dom', '8198850602', 'qq', 7, 'qq'),
(42, '2021-05-21', 533, 8, 'COD', 'Delivered', 'Dom', '8198850602', 'dd', 5, 'dd');

-- --------------------------------------------------------

--
-- Table structure for table `bill_details`
--

CREATE TABLE `bill_details` (
  `id` int(11) NOT NULL,
  `billid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `partnerid` int(11) NOT NULL,
  `price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `amount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill_details`
--

INSERT INTO `bill_details` (`id`, `billid`, `itemid`, `partnerid`, `price`, `quantity`, `amount`) VALUES
(32, 23, 6, 7, 104, 1, 104),
(33, 23, 9, 7, 200, 1, 200),
(34, 24, 69, 9, 50, 1, 50),
(35, 25, 50, 7, 80, 1, 80),
(36, 26, 32, 9, 24, 3, 72),
(37, 26, 10, 7, 104, 1, 104),
(38, 26, 40, 8, 24, 1, 24),
(39, 27, 87, 11, 260, 1, 260),
(40, 28, 50, 7, 80, 1, 80),
(41, 28, 51, 7, 71, 1, 71),
(42, 28, 52, 7, 35, 1, 35),
(43, 29, 50, 7, 80, 1, 80),
(44, 29, 51, 7, 71, 1, 71),
(45, 29, 52, 7, 35, 1, 35),
(46, 30, 50, 7, 80, 1, 80),
(47, 30, 51, 7, 71, 1, 71),
(48, 30, 52, 7, 35, 1, 35),
(49, 31, 10, 7, 104, 1, 104),
(50, 31, 32, 9, 24, 1, 24),
(51, 32, 52, 7, 35, 1, 35),
(52, 32, 53, 7, 15, 1, 15),
(53, 33, 10, 7, 104, 1, 104),
(54, 33, 40, 8, 24, 1, 24),
(55, 33, 33, 7, 66, 1, 66),
(56, 34, 50, 7, 80, 1, 80),
(57, 34, 51, 7, 71, 1, 71),
(58, 34, 52, 7, 35, 1, 35),
(59, 35, 53, 7, 15, 1, 15),
(60, 35, 52, 7, 35, 1, 35),
(61, 35, 12, 7, 70, 1, 70),
(62, 36, 78, 8, 150, 3, 450),
(63, 36, 84, 8, 104, 1, 104),
(64, 36, 62, 8, 45, 1, 45),
(65, 38, 127, 20, 99, 1, 99),
(66, 38, 104, 12, 160, 1, 160),
(67, 41, 96, 11, 50, 4, 200),
(68, 41, 5, 7, 180, 2, 360),
(69, 41, 125, 20, 200, 1, 200),
(70, 42, 18, 7, 119, 3, 357),
(71, 42, 75, 7, 75, 2, 150),
(72, 42, 30, 9, 26, 1, 26);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categoryid` int(11) NOT NULL,
  `categoryname` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categoryid`, `categoryname`, `description`) VALUES
(9, 'Thaali and Meals', 'Thaali is popular in Punjab.  It offer all the 6 different flavors of sweet, salt, bitter, sour, astringent and spicy on one single plate. A proper meal should be a perfect balance of all these 6 flav'),
(10, 'Breakfast', 'A full breakfast is a breakfast meal that typically includes omelete, eggs and a beverage such as coffee or tea. It comes in different regional variants and is referred to by different names depending'),
(11, 'Soups', 'We make a delicious homemade soup for lunch or dinner, with this collection of our best ever soup recipes such as Veg Sweet Corn Soup,Veg Tomato Soup,Hot and Sour Soup.'),
(12, 'Lunch and Dinner', 'Lunch is commonly the second meal of the day after breakfast.Dinner usually refers to the most significant and important meal of the day, which can be the noon or the evening meal.It includes thaali w'),
(13, 'Breads', 'Naan is made of only maida, while Roti is made of both wheat flour and maida or just wheat flour.It is one of the most popular breakfast dishes . Parantha is usually served with butter, chutney, or In'),
(14, 'Rice', 'In Rice, we have Fried Rice,Plain Rice,Veg Biryaani,Veg Pulao and Jeera Rice.We can take rice at lunch and dinner with some sabji or daal.'),
(15, 'Punjabi Specialities', 'Punjabi Specialities include Amritsari Kulcha,Lachha Paratha,Saag with Makki D Roti,Missi Roti,Kadi Pakoda,Daal Makhani,Special Lassi and Chole(Chana) with Poori.'),
(16, 'Noodles', 'Noodles include Veg Chowmein,Veg Chopsuey,Veg Chinese Chopsuey and Veg Hakka Noodles.These are basically made from wheat, buckwheat, rice and mung bean.'),
(17, 'Chinese Dishes', 'We can provide Chinese Dishes that includes Veg Manchurian,Cheese Chilli,Chilli potato,Thai Paneer,Cheese Crispy Dry and Crispy Corn so that people can enjoy chinese dishes serviced from home. '),
(18, 'Burgers and Sandwitches', 'Burgers and sandwitches can be eaten at any time.We can have it at breakfast,lunch or at dinner.But we prefer it during meals.People can enjoy Veg Burger, Veg and Cheese Burger,Cheese and salad Burger'),
(19, 'Snacks', 'Snacks are the Delicious Dishes which includes Atta Samosa,Spring Roll,Special French Fries,Paneer Pakoda and Vegetable Pakoda.'),
(20, 'Accompaniments', ' Accompaniments are highly flavoured seasonings of various kinds offered with certain dishes like Pineapple Raita,Mixed Raita,Green Salad,Plain Curd and Papad.'),
(21, 'Desserts', 'Dessert recipes will end your meal on a high note.Desserts include Gulab Jamun,Rasgulla,Kheer Badam and Amritsari Firni.'),
(22, 'Beverages', 'Beverages include Vanilla Ice Cream Shake,Strawberry Ice Cream Shake,Chocolate Ice Cream Shake,Mango Ice Cream Shake, Butterscotch Ice Cream Shake,Cold Coffee and Fresh Lime Soda.'),
(24, 'italian cuisine', 'Italian cuisine has a tradition of dishes based on wheat products (such as bread and pasta), vegetables, cheese, fish, and meat, usually prepared in such a manner as to preserve their ingredients natu'),
(27, 'sandwiches', 'A sandwich is a food typically consisting of vegetables, sliced cheese or meat, placed on or between slices of bread, or more generally any dish wherein bread serves as a container or wrapper for anot'),
(28, 'Pizza', 'Pizza is a type of food that was created in Italy. It is made by putting \"toppings\" (such as cheese, sausages, pepperoni, vegetables, tomatoes, spices and herbs and basil and fries) over a piece of br'),
(29, 'Pasta', 'Pasta  is a type of food that was created in Italy. It is made by adding cheese, sausages, pepperoni, vegetables, tomatoes, spices and herbs and basil and fries with a piece of garlic bread.');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `mobileno` varchar(50) NOT NULL,
  `address` varchar(200) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `otp` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `name`, `mobileno`, `address`, `photo`, `city`, `email`, `password`, `status`, `otp`) VALUES
(1, 'Monika', '8054922174', 'Amritsar', '20180702_105920.jpg', 'Amritsar', 'monika4499@gmail.com', '123', '1', NULL),
(2, 'priya', '8054266784', 'amritsar', '20180702_165532.jpg', 'Amritsar', 'priya@gmail.com', 'priya', '1', NULL),
(3, 'kaushal', '8948169194', 'amritsar', 'IMG-20190223-WA0008.jpg', 'Amritsar', 'kaushal@gmail.com', 'richa', '1', NULL),
(4, 'kaushal shukla', '8054922174', 'amritsar punjab', 'IMG-20190223-WA0008.jpg', 'Amritsar', 'kaushals@gmail.com', 'richa', '1', NULL),
(5, 'Richa', '7814381842', 'basant avenue', '20180622_154657_2.jpg', 'amritsar', 'john@yahoo.com', '123123', '1', NULL),
(6, 'Twinkle', '8847074362', 'Nehru colony', 'IMG_20160527_171530.JPG', 'Amritsar', 'twinklesharma4499@gmail.com', 'twinkle', '1', NULL),
(7, 'tanya', '7087958847', 'majitha road', 'C:Usersshubh vinayakDocumentssmiley.jpg', 'amritsar', 'tanya@gmail.com', 'vinayak', '1', NULL),
(8, 'Dom', '12345', 'Ranjit Avenue', 'photos/user.jpg', 'Amritsar', 'user@yahoo.com', '123123', '1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deliveryboy`
--

CREATE TABLE `deliveryboy` (
  `deliveryid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `mobileno` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `partnerid` int(11) NOT NULL,
  `starttime` time NOT NULL,
  `endtime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deliveryboy`
--

INSERT INTO `deliveryboy` (`deliveryid`, `name`, `mobileno`, `address`, `photo`, `partnerid`, `starttime`, `endtime`) VALUES
(1, 'Self Take Away', '0000000000', 'Local', 'delivery_boy/3.jpg', 8, '09:00:00', '00:00:00'),
(2, 'Rakul Mehta', '8877665546', 'House No:26 ,Lane no:5 ,Nehru Colony ,Majitha Road ,Amritsar.', 'delivery_boy/1.png', 8, '11:00:00', '21:00:00'),
(3, 'Manik Sharma', '9988099880', 'House No:34 ,Lane No:20 ,Jagdamba Colony ,Amritsar.', 'delivery_boy/1.png', 8, '10:00:00', '22:00:00'),
(4, 'Sourabh Kumar', '8880077660', 'House NO:11 ,Lane No:50 ,Vijay Nagar ,Batala road ,Amritsar.', 'delivery_boy/3.jpg', 8, '11:00:00', '23:00:00'),
(5, 'Sumit Sharma', '8054922174', 'House No:34 ,Lane No:20 ,Near Model Town ,Amritsar.', 'delivery_boy/3.jpg', 7, '09:00:00', '22:00:00'),
(7, 'Karan Kapoor', '9803886594', 'House No:34 ,Lane No:20 ,Near Model Town ,Amritsar.', 'delivery_boy/1.png', 7, '10:00:00', '22:00:00'),
(8, 'Kartar Singh', '9780076766', 'House No:34 ,Lane No:20 ,Near Model Town ,Amritsar.', 'delivery_boy/3.jpg', 7, '09:30:00', '22:30:00'),
(9, 'Self Service', '0000000000', 'Local', 'delivery_boy/1.png', 9, '09:00:00', '23:00:00'),
(10, 'Akhil ', '8880077666', 'House No:44 ,Lane No:2 ,Near Trilium Mall ,Amritsar.', 'delivery_boy/3.jpg', 9, '11:00:00', '22:00:00'),
(11, 'Ankit Bhatt', '9988099990', 'House No:34 ,Lane No:20 ,Queens Road,Amritsar.', 'delivery_boy/1.png', 9, '09:00:00', '21:00:00'),
(12, 'Aman Khanna', '8847675987', 'House No:34 ,Lane No:20 ,Grand trunk Road ,Amritsar.', 'delivery_boy/1.png', 9, '09:00:00', '20:00:00'),
(13, 'SelfService', '0000000000', 'Local', 'delivery_boy/2.jpg', 10, '09:00:00', '21:00:00'),
(14, 'Vijay Kataria', '8882377669', 'House No:34 ,Lane No:20 Near Guru Nanak Park ,Ranjit Avenue ,Amritsar.', 'delivery_boy/3.jpg', 10, '10:30:00', '20:30:00'),
(15, 'Vikram Mahajan', '9900889987', 'House No:34 ,Lane No:20 ,Kashmir Avenue ,Amritsar.', 'delivery_boy/2.jpg', 10, '09:00:00', '21:00:00'),
(16, 'Pankaj Kapoor', '9780076543', 'House No:34 ,Lane No:20 , Rishi Vihaar ,Amritsar.', 'delivery_boy/1.png', 10, '10:00:00', '21:00:00'),
(17, 'SelfTakeAway', '0000000000', 'Local', 'delivery_boy/2.jpg', 11, '09:00:00', '21:00:00'),
(18, 'Tarun Sharma', '8877669946', 'House No:34 ,Lane No:20 ,Guru Arjun Nagar ,Putlighar ,Amritsar.', 'delivery_boy/1.png', 11, '09:00:00', '20:30:00'),
(19, 'Suraj', '8054922174', 'House No:34 ,Lane No:20 ,Sultanvind Road ,Amritsar.', 'delivery_boy/2.jpg', 11, '09:00:00', '19:00:00'),
(20, 'Vicky Khanna', '9988099880', 'House No:4 ,Lane No:2 ,Kapoor Nagar ,Amritsar.', 'delivery_boy/1.png', 11, '09:00:00', '21:00:00'),
(21, 'CollectFoodByYourself', '0000000000', 'Local', 'delivery_boy/2.jpg', 12, '09:00:00', '21:00:00'),
(22, 'Vikas Gupta', '9780997800', 'House No:34 ,Lane No:20 ,Near Celebration Mall ,Amritsar.', 'delivery_boy/1.png', 12, '10:00:00', '20:00:00'),
(23, 'Mankirat', '8877665549', 'House No:9 ,Lane No:40 ,Batala Road ,Amritsar.', 'delivery_boy/2.jpg', 12, '09:00:00', '21:00:00'),
(24, 'Puneet Sharma', '9975665343', 'House No:7 ,Lane No:20 ,Mehta Road,Amritsar.', 'delivery_boy/1.png', 12, '09:00:00', '09:00:00'),
(25, 'Mr. Sumesh', '7745633221', 'House No:34 ,Lane No:20 ,Near Model Town ,Amritsar.', 'delivery_boy/2.jpg', 7, '12:01:00', '11:20:00'),
(28, 'Deadpool', '214 146-1566', 'USA', 'delivery_boy/3.jpg', 20, '22:14:00', '16:14:00'),
(29, 'Venom', '214 146-1566', 'USA', 'delivery_boy/2.jpg', 20, '22:18:00', '15:18:00');

-- --------------------------------------------------------

--
-- Table structure for table `deliveryboywork`
--

CREATE TABLE `deliveryboywork` (
  `id` int(11) NOT NULL,
  `boyid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deliveryboywork`
--

INSERT INTO `deliveryboywork` (`id`, `boyid`, `orderid`, `status`, `date`, `time`) VALUES
(1, 7, 26, 'Dispatched', '2019-04-26', '12:03:26'),
(2, 7, 26, 'Delivered', '2019-04-26', '12:03:49'),
(3, 0, 25, 'Dispatched', '2019-04-26', '12:05:19'),
(4, 19, 27, 'Dispatched', '2019-04-26', '12:13:28'),
(5, 19, 27, 'Delivered', '2019-04-26', '12:14:42'),
(6, 5, 28, 'Dispatched', '2019-04-26', '10:49:28'),
(7, 5, 28, 'Delivered', '2019-04-26', '10:51:18'),
(8, 5, 29, 'Dispatched', '2019-04-26', '11:01:45'),
(9, 5, 29, 'Delivered', '2019-04-26', '11:03:38'),
(10, 8, 32, 'Dispatched', '2019-04-26', '11:52:44'),
(11, 5, 34, 'Dispatched', '2021-05-14', '02:54:26'),
(15, 7, 23, 'Delivered', '2021-05-20', '13:49:35'),
(16, 5, 33, 'Delivered', '2021-05-20', '13:53:26'),
(17, 5, 35, 'Delivered', '2021-05-20', '15:28:35'),
(18, 0, 30, 'Dispatched', '2021-05-21', '16:15:46'),
(19, 5, 42, 'Delivered', '2021-05-21', '21:28:50');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `itemid` int(11) NOT NULL,
  `itemname` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `description` varchar(200) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `partnerid` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `availabledays` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`itemid`, `itemname`, `price`, `description`, `categoryid`, `photo`, `partnerid`, `status`, `availabledays`) VALUES
(5, 'Veg Special Thali', 180, 'Dal makhani paneer chana masala mixed raita rice salad papad butter naan/ parantha/3 chapati', 9, 'item_pics/1.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(6, 'Mini Thali', 104, 'Dal+chana+ raita+ 2 parantha', 9, 'item_pics/1.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri'),
(7, 'Parantha Thali', 70, 'Dal makhani+paneer+chana masala+ raita+rice+salad+papd+2 parantha', 9, 'item_pics/1.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(8, 'Mini South Indian Thali', 150, 'Yellow Dal+Plain rice+Plain Curd+Mixed Veg+2 chapati', 9, 'item_pics/1.jpg', 7, '1', 'Tue,Wed,Fri'),
(9, 'Mini Special Thali', 200, 'Dal+ Shahi paneer+ raita+2 parantha', 9, 'item_pics/1.jpg', 7, '1', 'Thu,Fri,Sat,Sun'),
(10, 'Roti and Rice Thali', 104, 'Dal makhani+chana+ raita+rice+ 2 chapati', 9, 'item_pics/1.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(11, 'Special Amritsari Kulcha', 50, 'Served with special Channe.', 10, 'item_pics/1.jpg', 7, '1', 'Fri,Sat,Sun'),
(12, '2 Poori Chane', 70, '2 poori chane is serviced with pickle.It is the speciality of Punjab.', 10, 'item_pics/1.jpg', 7, '1', 'Mon,Wed,Fri,Sat,Sun'),
(13, 'Butter Toast', 30, 'Butter toast includes 2 Jumbo Bread with butter.', 10, 'item_pics/1.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri'),
(14, 'Sweet Lassi', 40, 'Lassi is  made from curd.It is specially served with Chole poori.', 10, 'item_pics/1.jpg', 7, '1', 'Thu,Fri,Sat,Sun'),
(15, 'Salted lassi', 40, 'Salted Lassi is made from Curd have some salt in it.', 10, 'item_pics/2.jpg', 7, '1', 'Mon,Tue,Wed'),
(16, 'Tea ', 20, 'We can service you special breakfast tea.', 10, 'item_pics/2.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(17, 'Coffee', 30, 'Coffee provides a complex blend of different flavours.', 10, 'item_pics/2.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(18, 'Daal Makhani', 119, 'Dal Makhani is a delicacy from Punjab in India.More moderate amounts of cream or butter are used. Dollops of fresh cream and butter lend the rich finishing touch. ', 12, 'item_pics/2.jpg', 7, '1', 'Mon,Tue,Thu,Fri,Sat,Sun'),
(19, 'Dal Fry', 114, 'Dal Fry is made by adding boiled and softened Dal to a seasoning of onion, tomato and spices which have been fried in ghee or oil.', 12, 'item_pics/2.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri'),
(20, 'Kadhai Paneer', 166, 'Kadai Paneer is a very quick stir fried dish cooked on high flame. you will find chopped/ sliced onions, bell pepper, other veggies, fresh greens, paneer lightly fried.', 12, 'item_pics/2.jpg', 7, '1', 'Mon,Wed,Fri'),
(21, 'Palak Paneer', 166, 'This is a simple homemade and healthy palak paneer, Enjoy it with naan, roti or plain rice. Cream is added to cut down on the bitterness of the spinach leaves but you can also use milk or yogurt inste', 12, 'item_pics/2.jpg', 8, '1', 'Sat,Sun'),
(22, 'Yellow Fry Dal', 114, 'Dal fry and rice is like comfort in a bowl.  I make the dal only with tomatoes and ginger with cumin seeds, salt, and turmeric seasoning. No onion, no garlic cooking .', 12, 'item_pics/2.jpg', 8, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(23, 'Malai Kofta', 160, 'Malai Kofta is a popular as well as most sought after vegetarian indian dish. Malai means cream and Kofta are fried dumpling balls. Usually they are made up of mashed potatoes, mix vegetables or panee', 12, 'item_pics/2.jpg', 8, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(24, 'Aaloo Matar', 119, 'Aloo matar is a punjabi authentic curry which is widely served with roti and rice.\r\n\r\nAaloo Matar is a traditional curry where aloo and matar are combined together and made like a curry. It uses onion', 12, 'item_pics/2.jpg', 8, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(25, 'Aaloo gobi', 114, ' Aaloo Gobi is a classic dry vegetable dish with aloo (potatoes) and gobi (cauliflower). This simple dry curry goes wonderfully with roti if you have some dal tadka.You can have it with rice for a sim', 12, 'item_pics/2.jpg', 9, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(26, 'Karhi Pakoda', 95, 'Kadi Pakoda is often eaten with boiled rice or roti.Dahi (yogurt) is added to give it a bit of sour taste. We can also enjoy this with Plain Boiled White Rice or Chapati with ghee on top!!', 12, 'item_pics/2.jpg', 9, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(27, 'Chana Masala', 128, 'This punjabi chole tastes like the chana masala you get in the streets of delhi and punjab.It is served with Rice or Indian FlatBread.', 12, 'item_pics/2.jpg', 9, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(28, 'Butter Naan', 30, 'I always add some butter in the dough and then spread some butter on the top of the naan, while serving. ', 13, 'item_pics/2.jpg', 9, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(29, 'Plain Naan', 24, 'Naan is served very hot and is brushed with ghee (clarified butter) or butter. It can be used to scoop other foods, or is also often served stuffed with a filling.', 13, 'item_pics/2.jpg', 9, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(30, 'Lachedaar Parantha', 26, 'Ideally served along with any main dish of your choice at lunch or dinner.It is a multi layered indian flat bread prepared with wheat and plain flour.', 13, 'item_pics/2.jpg', 9, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(31, 'Makki Ki Roti', 24, ' Makki ki Roti is a traditional Indian recipe made with corn meal or maize flour and is usually eaten with Sarson ka saag and a piece of jaggery. ', 13, 'item_pics/2.jpg', 9, '1', 'Sat,Sun'),
(32, 'Missi Roti', 24, 'Missi roti is soft, round Indian flatbread made with a combination of whole wheat flour and gram/chickpea flour and seasoned with Indian spices. \r\n', 13, 'item_pics/2.jpg', 9, '1', 'Tue,Wed,Thu,Fri'),
(33, 'Plain Rice', 66, 'Plain rice is served with lentils, dal, or a gravy-based dish.', 14, 'item_pics/2.jpg', 7, '1', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun'),
(34, 'Jeera Rice', 85, 'Jeera Rice is an Indian style Rice dish flavoured with cumin. This Indian restaurant style rice recipe goes very well with indian curries and lentils.', 14, 'item_pics/2.jpg', 7, '1', 'Mon,Tue,Thu,Fri'),
(35, 'Veg Pulao', 85, 'Veg Pulao is delicious medley of rice, spices and vegetables.) It is a spicy rice dish prepared by cooking rice with various vegetables and spices. ', 14, 'item_pics/2.jpg', 7, '1', 'Wed,Thu'),
(36, 'Veg Biryani', 103, 'Vegetable biryani is light, a bit spicy and super delicious. The subtle flavors of the garam masala, onions and curd are so infused in the vegetables. Each bite of the vegetable had the taste, flavor ', 14, 'item_pics/2.jpg', 8, '1', 'Tue,Wed,Thu,Fri,Sat,Sun'),
(37, 'Rajma', 123, 'Indian kidney beans curry cooked with onions, tomatoes and a special blend of spices. It consists of red kidney beans in a thick gravy with lots of Indian whole spices and usually served with rice and', 15, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(38, 'Dal Makhani', 119, 'Dal Makhani is a delicacy from Punjab in India.More moderate amounts of cream or butter are used. Dollops of fresh cream and butter lend the rich finishing touch. ', 15, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(39, 'Amritsari Kulcha', 80, 'Served with spacial Channe.It is the Punjabi Speciality.', 15, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(40, 'Makki D Roti', 24, ' Makki ki Roti is a traditional Indian recipe made with corn meal or maize flour and is usually eaten with Sarson ka saag and a piece of jaggery. ', 15, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(41, 'Special Lassi', 40, 'Lassi is  made from curd.It is specially served with Chole poori.', 15, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(42, 'Amritsari papad', 15, 'Papads are typically served as an accompaniment to a meal or as an appetizer or snack, sometimes with toppings such as chopped onions, chopped carrots, chutneys or other dips, and condiments.', 15, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(43, 'Veg Burger', 52, 'A fresh Vegetable Burger made at home is a healthier option than the ones available at fast food outlets. The homemade burgers can be loaded with more vegetables and is low in sodium.', 18, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(44, 'Veg and Cheese Burger', 61, 'Vegetable Burger is one of the most popular fast food, loved and adored by kids and elders. This homemade burger is truly filled with lots of fresh vegetables and cheese. A simple and kidâ€™s favorite', 18, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(45, 'Cheese and Salad Burger', 52, 'Cheeseburger salad is the perfect option on busy summer nights! Tastes like biting into a big, juicy cheeseburger and the homemade salad dressing is out of this world amazing! \r\n\r\n', 18, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(46, 'Veg Grilled Burger', 60, 'Easy, grillable veggie burgers with just 10 ingredients (give or take a spice)! Flavorful, hearty and perfect for summertime grilling. Hearty enough to please meat-eaters and vegans alike.', 18, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(47, 'Veg Grilled Sandwitch', 60, 'Veg Grilled Cheese Sandwich is a savory sandwich made using fresh vegetables and paneer (Indian Cottage Cheese) and flavored with spices.We serve them along with Tomato Ketchup or Coriander Chutney.', 18, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(48, 'Veg Cheese Sandwitch', 57, 'Veg Cheese sandwitch is a very easy simple plain cheese sandwich with slices of apple and flavor of black pepper powder. An ideal healthy kids lunch box  which can also be served as snack and breakfas', 18, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(49, 'Mixed Raita', 71, 'Raita, also known as yogurt sauce, is used as side dishes in everyday Indian cuisine. It can be eaten with rice or any bread type.We also garnish it with chili powder .', 20, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(50, 'Pineapple Raita', 80, 'Pineapple Raita or Ananas Raita â€“ is an absolutely yummy creamy Indian Raita Recipe of fresh pineapple in yogurt and spices. Served with variety of delicacies from Curries to Pulao to Biryani .', 20, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Thu,Fri,Sat,Sun'),
(51, 'Plain Curd', 71, 'Homemade curd is very good for your budget and for your health. Itâ€™s an excellent source of calcium, vitamin B, and protein.You can have it with Rice or biryani or pulao or fry rice.', 20, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Thu,Fri,Sat,Sun'),
(52, 'Green salad', 35, 'Green salad are the perfect co-star for any main dish. You can add a splash of color to dinner tonight.', 20, 'item_pics/1.jpg', 7, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(53, 'Papad ', 15, 'Papads are thin wafers made of urad dal. It is served as an accompaniment to an Indian meal, as a snack and as croutons in soups.', 20, 'item_pics/1.jpg', 7, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(55, 'Sweet Corn Soup', 30, 'Sweet Corn Soup is a easy and healthy creamy soup made with sweet corn kernels and indo chinese sauces. it is a great party starter or party appetizer and can be served just before the meals.', 11, 'item_pics/1.jpg', 7, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(56, 'Hot and Sour Soup', 35, 'Hot and Sour soup is extremely flavorful and can be served with or without noodles. This soup is not only filling for your stomach but also satiates your soul.', 11, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(57, 'Tomato Soup', 30, 'The three ingredients that are butter, onion, and tomato can come together to make such a velvety and delicious tomato soup.This is the winter dish but available in summers also.', 11, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(58, 'Lemon Coriander Soup', 35, ' Lemon and Coriander Soup is made with vitamin C rich ingredients like lemon, coriander, carrots and cabbage. Enjoy this comforting soup piping hot on days you feel down, or any cool winterâ€™s day fo', 11, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(59, 'Vanilla Ice Cream', 30, 'Thereâ€™s nothing better than handcrafted, rich, sweet cream vanilla ice cream made from scratch, using only the freshest ingredients. We are talking ultra simple ingredients â€“ heavy cream, whole mi', 21, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(60, 'Strawberry Ice Cream', 30, 'Once whipped cream, condensed milk, and vanilla are combined together, we can add in a cup fresh strawberry puree. Strawberries are perfect for a summer day and will surely keep you refreshed.', 21, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(61, 'Butterscotch Ice Cream', 40, 'This rich ice-cream has a mellow flavour balanced wonderfully by the sweet crunch of the crushed praline. The praline, made with cashews and sugar, gives a delectable texture and rich flavour to the i', 21, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(62, 'Kesar Pista Ice Cream', 45, 'The beautiful aroma of Kesar and the richness of Pistachios, this combination is loved by all. Its one of the rich ice creams which we serve during weddings or on special occassions. ', 21, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(63, '2 Special Gulab Jamun', 30, 'Itâ€™s my favorite sweet for a long, long time.There are many ready-made Instant mixes available in market but no one comes even close to the taste of homemade gulab jamuns.', 21, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(64, 'Special Kheer Badam', 30, 'Badam Kheer is a delicious Indian dessert where milk is cooked with almond paste and saffron. We make it for festivities or for your house party, it will please everyone. ', 21, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(65, 'Special Firni Amritsari', 20, ' A dessert served in most Indian households on various festivals. Milk thickened with rice flour and flavored with cardamom, almonds and pistachios. ', 21, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(66, 'Vanilla Milkshake', 45, 'Vanilla milkshake is probably the most-loved milkshake in the world. This is the best homemade vanilla milkshake and enjoy it any time of the year.\r\n\r\n', 22, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(67, 'Strawberry Milkshake', 45, 'This easy strawberry milkshake is made with just 3 wholesome ingredients. This rich and creamy treat is perfect for spring!', 22, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(68, 'Chocolate Milkshake', 45, ' It always taste good if you are a chocolate lover. We serve up this chilled drink topped with marshmallows, cream and a drizzle of chocolate spread.', 22, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(69, 'Mango Milkshake', 50, 'Mango Shake (Mango Milkshake) is a cool and tempting fruit drink prepared by simply blending ripe mango pieces, milk and sugar.', 22, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(70, 'Cold Coffee', 55, 'As someone who is 100% not a morning person, cold coffee is a total game changer.', 22, 'item_pics/2.jpg', 9, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(71, 'Fresh Lime Water', 30, 'Fresh Lime Water is very important during summers as we need to refresh ourselves from very hot sun.', 22, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(72, 'French Fries', 71, 'Homemade French fries are crazy delicious. The best fries are double-fried, first at a lower temperature to cook them through, then drained and allowed to cool before being dipped into hotter oil to c', 19, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(73, 'Atta Samosa', 25, 'Here I am introducing WHEAT SAMOSA where no refined flour or Maida is included.A Samosa is a Indian snack,fried or baked pastry with savory filling. As it is made up of Atta,so it is very health.', 19, 'item_pics/2.jpg', 7, '1', 'Mon,Thu,Fri,Sat,Sun'),
(74, 'Veg Spring Roll', 25, 'Veg Spring Rolls is one of the most popular snack recipe, prepared with fresh vegetables .We also add  twist of ingredients to make this recipe interesting, if you love a particular seasonal veggie. ', 19, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(75, 'Paneer Pakoda', 75, 'Pakoras are the prefect high tea snacks.It is made with paneer, gram flour, ginger paste, garlic paste and a melange of spices.It is served hot with chutney of your choice or ketchup. ', 19, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Thu,Fri,Sat,Sun'),
(76, 'Vegetable Pakoda', 70, ' Veg Pakora is made with a mix of vegetables held together with besan and spiced up with chillies and spice powders. The combination of vegetables too is really wonderful, as they all have a good flav', 19, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Thu,Fri,Sat,Sun'),
(77, 'Veg Manchurian', 100, 'Veg Manchurian is a widely popular Indo-Chinese dish across India. This dish is made of deep fried mixed vegetable dumplings tossed in Chinese sauces.', 17, 'item_pics/2.jpg', 7, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(78, 'Cheese Chilli', 150, 'Cheese Chilli makes a spicy flavorful starter especially for many of my friends who enjoy the spicy food. It can also be served as a side dish. This is absolutely delicious.', 17, 'item_pics/2.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(80, 'Thai Paneer', 150, 'Thai style paneer is an intriguing dish that takes a healthier and more flavorful twist to everyoneâ€™s favorite good old paneer chilli.', 17, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat'),
(81, 'Cheese Garlic', 130, 'With three kinds of cheese, herbs and tons of garlic, this is the homemade garlic bread.You will love our cheesy homemade garlic bread served with delicious Italian dishes.', 17, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(82, 'Veg Chowmein', 104, 'Loaded with veggies and spices, this recipe boasts of glossy noodles tossed with vegetables like onion and celery along with all the classic condiments like soya sauce, celery, vinegar and chilli sauc', 16, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(83, 'Veg Chopsuey', 120, 'Chopsuey is a dish in Chinese cuisine and other forms of overseas Chinese cuisine, consisting of meat (often chicken, fish, beef, shrimp, or pork) and eggs, cooked quickly with vegetables such as bean', 16, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(84, 'Veg Hakka Noodles', 104, 'Veg Hakka Noodles is a famous Chinese recipe. It is made with fresh noodles, it has a strong flavour of soy sauce and garlic, which makes it an apt dish for kitty parties and celebrations.', 16, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(85, 'Mushroom Matar', 114, 'Matar mushroom is a Indian side dish made of green peas & mushrooms.It is a dry stir fry dish made of green peas and mushrooms.', 12, 'item_pics/1.jpg', 8, '1', 'Mon,Tues,Wed,Thu,Fri,Sat,Sun'),
(86, 'Veg Thaali', 210, '', 9, 'item_pics/1.jpg', 11, '1', 'Mon,Tue,Wed,Thu'),
(87, 'Golden Route Special Thali', 260, 'Dal+kadai paneer+chana+mixed raita+ jeera rice+salad+papad+butter naan/ parantha/3 chapati+ice cream', 9, 'item_pics/1.jpg', 11, '1', 'Wed,Fri'),
(88, 'Bundi Rayta', 50, 'Curd', 20, 'item_pics/1.jpg', 12, '1', 'Mon,Tue'),
(90, 'kulcha', 40, '', 10, 'item_pics/1.jpg', 17, '1', 'Mon,Wed'),
(91, 'fried noodles', 100, 'Vegetable noodles are a popular Indo-Chinese recipe with plenty of vegetables and sauce. With a touch of spicy peppers, these noodles can easily be made ahead and taken with you for lunch or a picnic.', 17, 'item_pics/1.jpg', 10, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(92, 'schezwan noodles', 120, ' it is popular street food in india which can be served as a party starter or even as a meal for lunch and dinner. the recipe is made similar to any other noodles recipe but is made with generous amou', 17, 'item_pics/1.jpg', 10, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(93, 'soy sauce noodles', 80, 'a basic soy sauce and chicken broth based noodle dish, is a popular Chinese snack. It uses a minimalist approach to bring out the best flavor from a bowl of noodles.', 17, 'item_pics/1.jpg', 10, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(94, 'chilli garlic noodles', 170, 'If you are looking for a spicy yet flavourful dish that will linger in your mouth, then your search stops here. Chilli Garlic Noodles are one of the most popular dishes of Indo-Chinese cuisine and can', 17, 'item_pics/1.jpg', 10, '1', 'Mon,Tue,Wed,Thu,Fri'),
(95, 'sarson ka saag', 60, 'Palak, bathua and sarson saag come together to create a sensation with hearty makke ki roti. Simple, savoury and full of rustic flavours.', 15, 'item_pics/1.jpg', 10, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(96, 'special Amritsar Kulcha', 50, 'served with special channe', 9, 'item_pics/1.jpg', 11, '1', 'Mon,Tue,Wed,Thu,Fri'),
(97, 'special tea', 20, 'We can service you special breakfast tea.', 20, 'item_pics/1.jpg', 11, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(98, 'curd', 60, 'Homemade curd is very good for your budget and for your health. Itâ€™s an excellent source of calcium, vitamin B, and protein.You can have it with Rice or biryani or pulao or fry rice.', 20, 'item_pics/1.jpg', 11, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(99, 'salad', 40, 'Green salad are the perfect co-star for any main dish. You can add a splash of color to dinner tonight.', 20, 'item_pics/1.jpg', 11, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(100, 'Masala Papad', 20, 'Papads are thin wafers made of urad dal. It is served as an accompaniment to an Indian meal, as a snack and as croutons in soups.', 20, 'item_pics/1.jpg', 11, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(101, 'veg pakora', 80, 'Veg Pakora is made with a mix of vegetables held together with besan and spiced up with chillies and spice powders. The combination of vegetables too is really wonderful, as they all have a good flavo', 19, 'item_pics/1.jpg', 11, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(102, 'hot n sour soup', 45, 'Hot and Sour soup is extremely flavorful and can be served with or without noodles. This soup is not only filling for your stomach but also satisfies your soul.	', 11, 'item_pics/1.jpg', 12, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(103, 'lachha parantha', 35, 'Ideally served along with any main dish of your choice at lunch or dinner.It is a multi layered indian flat bread prepared with wheat and plain flour.', 12, 'item_pics/1.jpg', 12, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(104, 'South indian Thali', 160, 'Yellow Dal, Plain rice, Plain Curd ,Mixed Veg with 2 chapati', 12, 'item_pics/1.jpg', 12, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(105, 'kadhi pakora', 60, 'Kadhi Pakora is often eaten with boiled rice or roti. Dahi (yogurt) is added to give it a bit of sour taste. We can also enjoy this with Plain Boiled White Rice or Chapati with ghee on top!!', 12, 'item_pics/1.jpg', 12, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(106, 'Poori Cholle', 45, ' Poori cholle is serviced with pickle.It is the speciality of Punjab.', 9, 'item_pics/1.jpg', 12, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(107, 'Veg Green Salad', 30, 'Green salad are the perfect co-star for any main dish. You can add a splash of color to dinner tonight.', 20, 'item_pics/1.jpg', 12, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(108, 'Masaledar Papad', 30, 'Masala Papads are thin wafers made of urad dal. It is served as an accompaniment to an Indian meal, as a snack and as croutons in soups.', 20, 'item_pics/1.jpg', 12, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(109, 'schezwan noodle', 120, 'it is popular street food in india which can be served as a party starter or even as a meal for lunch and dinner. the recipe is made similar to any other noodles recipe but is made with generous amoun', 16, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(110, 'soy sauce noodle', 110, 'a basic soy sauce and chicken broth based noodle dish, is a popular Chinese snack. It uses a minimalist approach to bring out the best flavor from a bowl of noodles.', 16, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(111, 'Fried noodle', 120, 'Vegetable noodles are a popular Indo-Chinese recipe with plenty of vegetables and sauce. With a touch of spicy peppers, these noodles can easily be made ahead and taken with you for lunch or a picnic.', 16, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(112, 'Veg haka noodle', 150, 'it is a special chinese noodles made with the goodness of vegetables.', 16, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(113, 'French fry', 60, ' French fries are crazy delicious. The best fries are double-fried, first at a lower temperature to cook them through, then drained and allowed to cool before being dipped into hotter oil', 19, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(114, 'Sweet Tomato Pasta', 120, 'Made with purest tomato sauce that gives you sweet tangy flavor.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(115, 'Cheese Marine Pasta', 140, 'gives you a cheesy smoky flavor.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(116, 'Creamy Cheesy pasta', 170, 'made with mozerella cheese and fresh green having green toppings on it.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(118, 'Masala Pasta', 120, 'pasta with masala such as black pepper, pasta special masala and special sauce.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(119, 'Pasta Salad', 110, 'taste of pasta with the goodness of vegetable salad', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(120, 'Sphaggetti pasta', 145, 'italian special pasta with a piece of garlic bread.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(121, 'Twisted Red Sauce Pasta', 125, 'having mixed herb flavor made with some amount of schezwan sauce.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(122, 'Zesty Italian Pasta', 160, 'special italian pasta consisted with some vegetable having garlic bread with it.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(123, 'White Sauce Pasta', 175, 'made with cheese and vegetables like capsicum, mushrooms and sweet corns.', 29, 'item_pics/1.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(124, 'Vegan Mushroom Pasta', 180, 'Full with the goodness of mushrooms and having some other vegies.', 29, 'item_pics/2.jpg', 18, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(125, 'Cheese Bread', 200, 'Full with the goodness of mushrooms and having some other vegies.', 22, 'item_pics/d1.jpg', 20, '1', 'Mon,Wed,Fri'),
(126, 'Gulab Jamun', 50, 'Full with the goodness of mushrooms and having some other vegies.', 21, 'item_pics/jamun.jpg', 20, '1', 'Mon,Tue,Wed,Thu,Fri,Sat'),
(127, 'Kulcha', 99, 'Full with the goodness of mushrooms and having some other vegies.', 10, 'item_pics/corn.jpg', 20, '1', 'Mon,Tue,Thu,Fri');

-- --------------------------------------------------------

--
-- Table structure for table `partnertable`
--

CREATE TABLE `partnertable` (
  `partnerid` int(11) NOT NULL,
  `companyname` varchar(100) NOT NULL,
  `ownername` varchar(100) NOT NULL,
  `photo` varchar(200) NOT NULL,
  `mobileno` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `city` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `location` text NOT NULL,
  `status` int(11) NOT NULL,
  `opentime` time NOT NULL,
  `closetime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partnertable`
--

INSERT INTO `partnertable` (`partnerid`, `companyname`, `ownername`, `photo`, `mobileno`, `address`, `city`, `email`, `password`, `location`, `status`, `opentime`, `closetime`) VALUES
(7, 'Savita Food Hub', 'Savita Bhalla   ', 'partner_signup/team-1.jpg', '7814381842', 'House No:3,Lane NO:4,Kamla Devi Avenue.', 'Amritsar          ', 'savitafood@gmail.com', '123   ', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3395.641849211809!2d74.87697038316648!3d31.671016954898786!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3919637f4e190be3%3A0x3234e7713d5d2fc5!2sKamla+Devi+Avenue+Park!5e0!3m2!1sen!2sin!4v1554960039555!5m2!1sen!2sin', 1, '09:00:00', '23:00:00'),
(8, 'Radhika Food Club', 'Radhika Tiwari ', 'partner_signup/team-2.jpg', '9888765432', '75 A,, 68, Majitha Rd, Co-operative Colony, Sehaj Avenue.', 'Amritsar     ', 'radhika@gmail.com', '1234 ', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3396.8086744486704!2d74.88310435654677!3d31.63908848133054!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3919635a74f5e2f7%3A0xb161fa54223ae7bc!2sMilap+Avenue!5e0!3m2!1sen!2sin!4v1554960761981!5m2!1sen!2sin', 1, '09:00:00', '20:00:00'),
(9, 'RichaFoodLand', 'Richa', 'partner_signup/team-3.jpg', '8054922145  ', 'House No:16,Lane No:21,Batala Rd, Near Bus Stand, Verka, Amritsar', 'Amritsar  ', 'richa@gmail.com', '1111', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3395.908091097397!2d74.93229447303294!3d31.663734173874815!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x391962ef65901f57%3A0x2f806dfeaf9d6d56!2sBabbu+Confectionery!5e0!3m2!1sen!2sin!4v1554961387983!5m2!1sen!2sin', 1, '07:00:00', '21:00:00'),
(10, 'RamanCuisine hub', 'Raman Shukla ', 'partner_signup/team-4.jpg', '89481591961 ', 'House No:2,Gali no:3,Gumtala.', 'Amritsar', 'raman@gmail.com', '1234', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3396.0012972416293!2d74.84482070556399!3d31.661184258109863!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x391965449ae14c43%3A0x225ba9550ff30cad!2sAjit+Enclave+Park!5e0!3m2!1sen!2sin!4v1554962709288!5m2!1sen!2sin', 1, '08:00:00', '20:00:00'),
(11, 'TonyFreshFood', 'Tony Singh', 'partner_signup/team-5.jpg', '7789656666', 'House no:21, Lane no:25, New Partap Nagar, Sant Nagar', 'Amritsar', 'tonysingh12@gmail.com', '4455', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3396.206909263862!2d74.88993496836456!3d31.655558513105767!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3919636a38db3ab5%3A0x3e0d11e1bd667bd9!2sGaura+Market!5e0!3m2!1sen!2sin!4v1554964599254!5m2!1sen!2sin', 1, '07:00:00', '22:00:00'),
(12, 'MallikaHealthyFood', 'Mallika', 'partner_signup/team-6.jpg', '8787875544', 'House No:40,Lane No:20,Baba Jeevan Singh Maarg, Friends Colony.', 'Amritsar', 'mallika12@gmail.com', '999', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3396.206909263862!2d74.88993496836456!3d31.655558513105767!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3919636a38db3ab5%3A0x3e0d11e1bd667bd9!2sGaura+Market!5e0!3m2!1sen!2sin!4v1554964599254!5m2!1sen!2sin', 1, '10:00:00', '21:00:00'),
(13, 'Priyafoodclub', 'Priya', 'partner_signup/team-7.jpg', '7894561234', 'Tara encalve', 'amritsar', 'priya@gmail.com', '1234', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3396.127039005038!2d74.87447811448665!3d31.657743947514746!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3919636231553e51%3A0xaaa37a43772f711!2sTARA+ENCLAVE!5e0!3m2!1sen!2sin!4v1558521645388!5m2!1sen!2sin\" width=\"600\" height=\"450\" frameborder=\"0\" style=\"border:0\" ', 1, '10:00:00', '23:00:00'),
(17, 'Food Court', 'shubh  ', 'partner_signup/team-8.jpg', '7087958847 ', 'lawrence road', 'amritsar ', 'raj@gmail.com', '123456789', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3396.577154571886!2d74.87585131510879!3d31.645425981328422!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3919635eccbf39e1%3A0x1993e014f9d56b44!2sSanjha%20Chulha%20(Lawrence%20Road)!5e0!3m2!1sen!2sin!4v1586327257889!5m2!1sen!2sin ', 0, '01:00:00', '21:00:00'),
(18, 'Pasta fiesta', 'Mr. Sameer chauhan  ', 'partner_signup/team-9.jpg', '8989898989  ', 'Ghala Mala Chownk , Majitha road, Amritsar', 'Amritsar  ', 'pastafiesta@yahoo.com', 'pastafiesta', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d849.1351227871071!2d74.8853084072326!3d31.64642948174762!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3919635cb12e301f%3A0xbb4288697632b385!2sLos%20Fiesta!5e0!3m2!1sen!2sin!4v1586410865398!5m2!1sen!2sin  ', 1, '11:00:00', '23:00:00'),
(19, 'food food', 'mansukh', 'partner_signup/team-10.jpg', '9988001742', 'majitha road', 'amritsar', 'mansukh@gmail.com', 'mansukh', 'rtrtrtrtrtr', 0, '10:00:00', '12:00:00'),
(20, 'Food Heaven', 'Obama', 'partner_signup/team-11.jpg', '8198010102', 'Adipisicing lorem es', 'Adipisicing lorem es', 'admin@yahoo.com', '123123', 'Adipisicing lorem es', 1, '19:03:00', '19:03:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`billid`),
  ADD KEY `customerid` (`customerid`);

--
-- Indexes for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billid` (`billid`),
  ADD KEY `itemid` (`itemid`),
  ADD KEY `partnerid` (`partnerid`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryid`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveryboy`
--
ALTER TABLE `deliveryboy`
  ADD PRIMARY KEY (`deliveryid`),
  ADD KEY `partnerid` (`partnerid`);

--
-- Indexes for table `deliveryboywork`
--
ALTER TABLE `deliveryboywork`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`itemid`),
  ADD KEY `categoryid` (`categoryid`),
  ADD KEY `partnerid` (`partnerid`);

--
-- Indexes for table `partnertable`
--
ALTER TABLE `partnertable`
  ADD PRIMARY KEY (`partnerid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `billid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `bill_details`
--
ALTER TABLE `bill_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `deliveryboy`
--
ALTER TABLE `deliveryboy`
  MODIFY `deliveryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `deliveryboywork`
--
ALTER TABLE `deliveryboywork`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `itemid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `partnertable`
--
ALTER TABLE `partnertable`
  MODIFY `partnerid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customer` (`id`);

--
-- Constraints for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD CONSTRAINT `bill_details_ibfk_1` FOREIGN KEY (`billid`) REFERENCES `bill` (`billid`),
  ADD CONSTRAINT `bill_details_ibfk_2` FOREIGN KEY (`itemid`) REFERENCES `item` (`itemid`),
  ADD CONSTRAINT `bill_details_ibfk_3` FOREIGN KEY (`partnerid`) REFERENCES `partnertable` (`partnerid`);

--
-- Constraints for table `deliveryboy`
--
ALTER TABLE `deliveryboy`
  ADD CONSTRAINT `deliveryboy_ibfk_1` FOREIGN KEY (`partnerid`) REFERENCES `partnertable` (`partnerid`);

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `categories` (`categoryid`),
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`partnerid`) REFERENCES `partnertable` (`partnerid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
