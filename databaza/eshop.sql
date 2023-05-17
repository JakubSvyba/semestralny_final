-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2023 at 01:04 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `product_amount`) VALUES
(42, 10, 1, 1),
(43, 10, 7, 1),
(44, 10, 52, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `product_id` int(11) NOT NULL,
  `product_amount` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_date`, `product_id`, `product_amount`, `price`) VALUES
(14, 10, '2023-05-18 00:00:00', 1, 1, '29.99'),
(15, 10, '2023-05-18 00:00:00', 2, 1, '59.99'),
(16, 10, '2023-05-18 00:00:00', 6, 1, '149.99');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `category`, `brand`, `image_url`) VALUES
(1, 'Gaming Mouse', 'High-performance gaming mouse with customizable buttons.', '29.99', 'Gaming Accessories', 'Logitech', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(2, 'Gaming Keyboard', 'Mechanical gaming keyboard with RGB backlighting.', '59.99', 'Gaming Accessories', 'Razer', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(3, 'Wireless Headphones', 'Premium wireless headphones with noise cancellation.', '79.99', 'Headphones', 'Sony', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(4, 'Smartphone', 'Latest smartphone model with advanced features.', '699.99', 'Electronics', 'Apple', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(5, 'Gaming Console', 'Next-generation gaming console for immersive gaming experience.', '499.99', 'Gaming Consoles', 'Sony', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(6, 'Smart Watch', 'Advanced smartwatch with fitness tracking capabilities.', '149.99', 'Wearable Technology', 'Samsung', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(7, 'Laptop', 'Powerful laptop for productivity and gaming.', '999.99', 'Computers', 'Dell', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(51, 'SuperWidget Pro', 'The SuperWidget Pro is a powerful and efficient widget for all your needs.', '49.99', 'Electronics', 'SuperCorp', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(52, 'Gizmo X', 'Introducing the Gizmo X, the latest gadget with advanced features and sleek design.', '79.99', 'Electronics', 'Techtronics', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(53, 'Luxury Watch', 'Experience luxury with this elegant and stylish watch, crafted with precision.', '199.99', 'Fashion', 'LuxuryTime', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(54, 'Eco-Friendly Backpack', 'Carry your belongings in style with this eco-friendly and durable backpack.', '39.99', 'Fashion', 'EcoGear', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(55, 'Fitness Tracker', 'Track your fitness goals and stay motivated with this feature-packed fitness tracker.', '59.99', 'Fitness', 'FitTech', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQM0Vzg6Cs3whCRSbW_cAC662UQ9a60L-w8zIr26e52D_ozWjX80OINXwyhrWvz8BPTxlVc38J0OYW5ysfZGLDD7Md4Es3mmXT49-dA2olqHXA1fAJVfVk5fw&usqp=CAE'),
(56, 'Organic Coffee', 'Indulge in the rich aroma and smooth taste of our carefully selected organic coffee.', '12.99', 'Food & Beverages', 'OrganicBeans', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/1200px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg'),
(57, 'Wireless Headphones', 'Immerse yourself in music with these wireless headphones, delivering crystal-clear sound.', '99.99', 'Electronics', 'SoundTech', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/1200px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg'),
(58, 'Designer Sunglasses', 'Make a style statement with these designer sunglasses, offering both protection and elegance.', '149.99', 'Fashion', 'FashionTrends', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/1200px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg'),
(59, 'Portable Bluetooth Speaker', 'Enjoy your favorite tunes anytime, anywhere with this portable Bluetooth speaker.', '29.99', 'Electronics', 'AudioTech', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/1200px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg'),
(60, 'Professional Camera', 'Capture moments like a pro with this high-performance and versatile camera.', '899.99', 'Electronics', 'ProCapture', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/%D0%9C%D1%8B%D1%88%D1%8C_2.jpg/1200px-%D0%9C%D1%8B%D1%88%D1%8C_2.jpg'),
(61, 'Stylish Sneakers', 'Step out in style with these trendy and comfortable sneakers, perfect for any occasion.', '79.99', 'Fashion', 'UrbanKicks', 'sneakers.jpg'),
(62, 'Smart Thermostat', 'Take control of your home temperature with this smart thermostat, saving energy and money.', '129.99', 'Home & Garden', 'SmartHome', 'thermostat.jpg'),
(63, 'Gourmet Chocolate Box', 'Indulge in the heavenly taste of our artisanal gourmet chocolate collection.', '24.99', 'Food & Beverages', 'ChocoDelights', 'chocolatebox.jpg'),
(64, 'Portable Power Bank', 'Never run out of battery again with this compact and powerful portable power bank.', '34.99', 'Electronics', 'PowerTech', 'powerbank.jpg'),
(65, 'Classic Leather Wallet', 'Keep your cards and cash organized in this timeless and durable leather wallet.', '49.99', 'Fashion', 'LeatherGoods', 'leatherwallet.jpg'),
(66, 'Smart Home Security System', 'Protect your home with this advanced smart home security system, ensuring peace of mind.', '299.99', 'Home & Garden', 'SecureHome', 'securitysystem.jpg'),
(67, 'Gaming Mouse', 'Gain the competitive edge with this high-precision gaming mouse, designed for ultimate performance.', '59.99', 'Electronics', 'GameTech', 'gamingmouse.jpg'),
(68, 'Designer Handbag', 'Make a fashion statement with this luxurious and stylish designer handbag.', '299.99', 'Fashion', 'FashionHouse', 'designerhandbag.jpg'),
(69, 'Wireless Earbuds', 'Experience wireless freedom with these compact and comfortable earbuds, delivering exceptional sound.', '79.99', 'Electronics', 'AudioTech', 'wirelessearbuds.jpg'),
(70, 'Cooking Essentials Set', 'Equip your kitchen with this comprehensive cooking essentials set, perfect for aspiring chefs.', '149.99', 'Home & Garden', 'KitchenPro', 'cookingessentials.jpg'),
(71, 'Classic Analog Watch', 'Add a touch of sophistication to your wrist with this classic analog watch.', '99.99', 'Fashion', 'TimelessWatches', 'analogwatch.jpg'),
(72, 'Smart Fitness Scale', 'Track your fitness progress and monitor your body metrics with this smart fitness scale.', '49.99', 'Fitness', 'FitTech', 'fitnessscale.jpg'),
(73, 'Premium Champagne', 'Celebrate special occasions with this exquisite and luxurious bottle of premium champagne.', '99.99', 'Food & Beverages', 'BubblyDelights', 'champagne.jpg'),
(74, 'Wireless Charging Pad', 'Effortlessly charge your devices with this sleek and convenient wireless charging pad.', '29.99', 'Electronics', 'TechCharge', 'wirelesscharging.jpg'),
(75, 'Fashionable Tote Bag', 'Carry your essentials in style with this fashionable and spacious tote bag.', '69.99', 'Fashion', 'TrendyBags', 'totebag.jpg'),
(76, 'Smart LED Light Bulb', 'Create the perfect ambiance with this smart LED light bulb, offering customizable lighting options.', '19.99', 'Home & Garden', 'SmartHome', 'smartbulb.jpg'),
(77, 'High-Performance Laptop', 'Experience unmatched performance and productivity with this high-performance laptop.', '1299.99', 'Electronics', 'TechTech', 'laptop.jpg'),
(78, 'Handcrafted Jewelry Set', 'Adorn yourself with this handcrafted jewelry set, showcasing elegance and beauty.', '79.99', 'Fashion', 'ArtisanJewels', 'jewelryset.jpg'),
(79, 'Fitness Yoga Mat', 'Enhance your yoga practice with this premium and non-slip fitness yoga mat.', '39.99', 'Fitness', 'FitGear', 'yogamat.jpg'),
(80, 'Stylish Sunglasses', 'Protect your eyes in style with these fashionable and UV-protected sunglasses.', '59.99', 'Fashion', 'FashionTrends', 'sunglasses.jpg'),
(81, 'Smart Wi-Fi Router', 'Enjoy seamless and fast internet connectivity with this advanced smart Wi-Fi router.', '79.99', 'Electronics', 'ConnectTech', 'router.jpg'),
(82, 'Luxurious Bath Towel Set', 'Wrap yourself in luxury with this soft and absorbent bath towel set.', '49.99', 'Home & Garden', 'LuxuryLiving', 'bathtowel.jpg'),
(83, 'Gaming Console', 'Immerse yourself in the world of gaming with this powerful and versatile gaming console.', '499.99', 'Electronics', 'GameTech', 'gamingconsole.jpg'),
(84, 'Designer Perfume', 'Experience the allure and elegance with this exquisite and luxurious designer perfume.', '89.99', 'Fashion', 'PerfumeCouture', 'perfume.jpg'),
(85, 'Healthy Cookbook', 'Discover a world of healthy and delicious recipes with this comprehensive and inspiring cookbook.', '29.99', 'Books', 'HealthBooks', 'cookbook.jpg'),
(86, 'Wireless Noise-Canceling Headphones', 'Escape into your own world with these wireless noise-canceling headphones.', '149.99', 'Electronics', 'SoundTech', 'noise-cancelling.jpg'),
(87, 'Designer Leather Belt', 'Complete your outfit with this stylish and durable designer leather belt.', '79.99', 'Fashion', 'LeatherGoods', 'leatherbelt.jpg'),
(88, 'Smart Home Hub', 'Control and automate your home with this smart home hub, connecting all your devices.', '99.99', 'Home & Garden', 'SmartHome', 'smarthub.jpg'),
(89, 'Artisanal Cheese Selection', 'Indulge in a curated selection of artisanal cheeses, handcrafted with care.', '39.99', 'Food & Beverages', 'CheeseDelights', 'cheese.jpg'),
(90, 'Bluetooth Wireless Keyboard', 'Enhance your productivity with this compact and versatile Bluetooth wireless keyboard.', '49.99', 'Electronics', 'Techtronics', 'keyboard.jpg'),
(91, 'Designer Silk Scarf', 'Accessorize with elegance and style using this luxurious designer silk scarf.', '69.99', 'Fashion', 'FashionHouse', 'silkscarf.jpg'),
(92, 'Home Gym Equipment Set', 'Create your personal gym at home with this comprehensive home gym equipment set.', '499.99', 'Fitness', 'FitPro', 'homegym.jpg'),
(93, 'Stainless Steel Cookware Set', 'Upgrade your kitchen with this high-quality and durable stainless steel cookware set.', '199.99', 'Home & Garden', 'KitchenPro', 'cookwareset.jpg'),
(94, 'Designer Men\'s Watch', 'Make a statement with this luxurious and sophisticated designer men\'s watch.', '249.99', 'Fashion', 'TimelessWatches', 'menswatch.jpg'),
(95, 'Smart Security Camera', 'Monitor your home and keep it secure with this advanced smart security camera.', '89.99', 'Home & Garden', 'SecureHome', 'securitycamera.jpg'),
(96, 'Premium Tea Collection', 'Savor the flavors and aromas of our meticulously selected gourmet tea collection.', '24.99', 'Food & Beverages', 'TeaMasters', 'teacollection.jpg'),
(97, 'Wireless Gaming Controller', 'Enhance your gaming experience with this ergonomic and responsive wireless gaming controller.', '69.99', 'Electronics', 'GameTech', 'gamingcontroller.jpg'),
(98, 'Designer Women\'s Handbag', 'Accessorize with this iconic and stylish designer women\'s handbag.', '299.99', 'Fashion', 'FashionHouse', 'womenshandbag.jpg'),
(99, 'Smart Home Lighting System', 'Transform your living space with this smart home lighting system, offering customizable lighting scenes.', '149.99', 'Home & Garden', 'SmartHome', 'lightingsystem.jpg'),
(100, 'Gourmet Wine Selection', 'Savor the flavors and aromas of our meticulously selected gourmet wine collection.', '69.99', 'Food & Beverages', 'WineConnoisseur', 'wine.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `registration_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `is_admin`, `registration_date`) VALUES
(10, 'Jakub', 'jakub.svyba@gmail.com', '$2y$10$rFLl/rsF.4gBDFf.F6nRg.LABzxEEyWANb4P2hVar9AGQRvCjlLgy', 0, '2023-05-18 00:58:56'),
(11, 'Admin', 'kotlar@security.com', '$2y$10$bx.Z9bEuo2TVCm.RNeKynuokvoYo4kwFDvvG3n8HMk9H/5SES5QbO', 1, '2023-05-18 00:59:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
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
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
