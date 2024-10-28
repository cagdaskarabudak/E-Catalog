/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80300 (8.3.0)
 Source Host           : localhost:3306
 Source Schema         : e_catalog

 Target Server Type    : MySQL
 Target Server Version : 80300 (8.3.0)
 File Encoding         : 65001

 Date: 28/10/2024 08:45:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cache
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for catalog_items
-- ----------------------------
DROP TABLE IF EXISTS `catalog_items`;
CREATE TABLE `catalog_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `catalog_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type` enum('html','product') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'product',
  `product_id` bigint unsigned DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `catalog_items_catalog_id_foreign` (`catalog_id`),
  KEY `catalog_items_product_id_foreign` (`product_id`),
  CONSTRAINT `catalog_items_catalog_id_foreign` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of catalog_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for catalogs
-- ----------------------------
DROP TABLE IF EXISTS `catalogs`;
CREATE TABLE `catalogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `store_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `catalogs_user_id_foreign` (`user_id`),
  KEY `catalogs_store_id_foreign` (`store_id`),
  CONSTRAINT `catalogs_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalogs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of catalogs
-- ----------------------------
BEGIN;
INSERT INTO `catalogs` (`id`, `user_id`, `store_id`, `title`, `description`, `created_at`, `updated_at`) VALUES (30, 1, 2, 'Deneme katalog', 'abcdefgh', '2024-10-28 04:12:17', '2024-10-28 04:12:17');
COMMIT;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `store_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_store_id_foreign` (`store_id`),
  CONSTRAINT `categories_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of categories
-- ----------------------------
BEGIN;
INSERT INTO `categories` (`id`, `store_id`, `name`) VALUES (1, 2, 'Kolye');
INSERT INTO `categories` (`id`, `store_id`, `name`) VALUES (2, 2, 'Küpe');
INSERT INTO `categories` (`id`, `store_id`, `name`) VALUES (3, 2, 'Bileklik');
INSERT INTO `categories` (`id`, `store_id`, `name`) VALUES (4, 2, 'Toka');
COMMIT;

-- ----------------------------
-- Table structure for category_product
-- ----------------------------
DROP TABLE IF EXISTS `category_product`;
CREATE TABLE `category_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_product_category_id_foreign` (`category_id`),
  KEY `category_product_product_id_foreign` (`product_id`),
  CONSTRAINT `category_product_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of category_product
-- ----------------------------
BEGIN;
INSERT INTO `category_product` (`id`, `category_id`, `product_id`) VALUES (91, 1, 62);
INSERT INTO `category_product` (`id`, `category_id`, `product_id`) VALUES (92, 2, 62);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of job_batches
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (6, '0001_01_01_000000_create_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (7, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (8, '0001_01_01_000002_create_roles_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (9, '0001_01_01_000002_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (10, '2024_10_21_182706_create_stores_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (11, '2024_10_23_212021_create_products_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (12, '2024_10_23_212451_create_categories_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (13, '2024_10_23_220340_create_product_images_table', 4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (14, '2024_10_23_220454_create_category_product_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (15, '2024_10_24_141838_create_user_store_table', 6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (16, '2024_10_26_192550_create_wholesale_prices_table', 7);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (17, '2024_10_27_185336_create_catalogs_table', 8);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (18, '2024_10_27_185643_create_catalog_items_table', 8);
COMMIT;

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_images_product_id_foreign` (`product_id`),
  CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of product_images
-- ----------------------------
BEGIN;
INSERT INTO `product_images` (`id`, `product_id`, `name`) VALUES (100, 62, '7zasKeg0V4w6pujaQy1sWOdQu7FtPfBdeUYbxDK6.png');
COMMIT;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `store_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `retail_price` decimal(11,2) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_store_id_foreign` (`store_id`),
  CONSTRAINT `products_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of products
-- ----------------------------
BEGIN;
INSERT INTO `products` (`id`, `store_id`, `name`, `retail_price`, `description`, `created_at`, `updated_at`) VALUES (62, 2, 'Deneme Ürün', 100.00, 'asklghmsakdmhaasgadgag', '2024-10-28 04:13:13', '2024-10-28 04:13:13');
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tr_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` (`id`, `name`, `tr_name`, `color`, `created_at`, `updated_at`) VALUES (1, 'Administrator', 'Yönetici', 'info', NULL, NULL);
INSERT INTO `roles` (`id`, `name`, `tr_name`, `color`, `created_at`, `updated_at`) VALUES (2, 'Store Manager', 'Mağaza Müdürü', 'primary', NULL, NULL);
INSERT INTO `roles` (`id`, `name`, `tr_name`, `color`, `created_at`, `updated_at`) VALUES (3, 'Store Personal', 'Mağaza Personeli', 'warning', NULL, NULL);
INSERT INTO `roles` (`id`, `name`, `tr_name`, `color`, `created_at`, `updated_at`) VALUES (4, 'Validated User', 'Doğrulanmış Kullanıcı', 'success', NULL, NULL);
INSERT INTO `roles` (`id`, `name`, `tr_name`, `color`, `created_at`, `updated_at`) VALUES (5, 'Guest', 'Misafir', 'secondary', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of sessions
-- ----------------------------
BEGIN;
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES ('vAruTQGBOFv4cbwet6kwg7v5OjWAfurmfEFaQBwf', NULL, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUDcyODJleHFBQ2xMM0ZYREpxT3VQbzIxWWJ1V0s2cXlyWnkwaDA2MiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1730093933);
COMMIT;

-- ----------------------------
-- Table structure for stores
-- ----------------------------
DROP TABLE IF EXISTS `stores`;
CREATE TABLE `stores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of stores
-- ----------------------------
BEGIN;
INSERT INTO `stores` (`id`, `name`, `short_name`, `logo`, `address`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Karevle Pazarlama A.Ş.', 'Karevle', NULL, NULL, NULL, NULL, '2024-10-28 03:48:49');
INSERT INTO `stores` (`id`, `name`, `short_name`, `logo`, `address`, `phone`, `created_at`, `updated_at`) VALUES (2, 'Oğuzmert Ticaret A.Ş.', 'OĞUZMERT', NULL, NULL, NULL, NULL, '2024-10-28 03:48:49');
INSERT INTO `stores` (`id`, `name`, `short_name`, `logo`, `address`, `phone`, `created_at`, `updated_at`) VALUES (3, 'Deneme Mağaza', 'Deneme', NULL, NULL, NULL, NULL, '2024-10-28 03:48:26');
COMMIT;

-- ----------------------------
-- Table structure for user_store
-- ----------------------------
DROP TABLE IF EXISTS `user_store`;
CREATE TABLE `user_store` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `store_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  `is_active` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_store_user_id_foreign` (`user_id`),
  KEY `user_store_store_id_foreign` (`store_id`),
  KEY `user_store_role_id_foreign` (`role_id`),
  CONSTRAINT `user_store_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_store_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_store_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user_store
-- ----------------------------
BEGIN;
INSERT INTO `user_store` (`id`, `user_id`, `store_id`, `role_id`, `is_active`) VALUES (1, 1, 1, 2, 1);
INSERT INTO `user_store` (`id`, `user_id`, `store_id`, `role_id`, `is_active`) VALUES (2, 1, 2, 3, 0);
INSERT INTO `user_store` (`id`, `user_id`, `store_id`, `role_id`, `is_active`) VALUES (3, 1, 3, 2, 0);
INSERT INTO `user_store` (`id`, `user_id`, `store_id`, `role_id`, `is_active`) VALUES (4, 6, 2, 2, 0);
INSERT INTO `user_store` (`id`, `user_id`, `store_id`, `role_id`, `is_active`) VALUES (5, 6, 1, 2, 1);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `role_id`, `created_at`, `updated_at`) VALUES (1, 'Çağdaş Karabudak', 'cagdaskarabudak@outlook.com', '$2y$12$S.cDGqOcjnRPluGW6awLWOSYSmJ67Gh30XzJxDKMc.lcGKAboUqYi', 1, '2024-10-21 18:38:47', '2024-10-22 16:06:41');
INSERT INTO `users` (`id`, `name`, `email`, `password`, `role_id`, `created_at`, `updated_at`) VALUES (5, 'Guest Account', 'guest@account.com', '$2y$12$U/p.D7rN2Ac2nWSNoIIoou3E/UBJX5QOBqh5o75PAV/Gn1Kr7vrGG', 5, '2024-10-28 02:45:49', '2024-10-28 02:54:41');
INSERT INTO `users` (`id`, `name`, `email`, `password`, `role_id`, `created_at`, `updated_at`) VALUES (6, 'Validated User', 'validated@user.com', '$2y$12$MMCg61SfM/PpzyzQrN1yDOWrMB6Ne3eLxqL5UslknKG6yNYj1dxDi', 4, '2024-10-28 02:55:47', '2024-10-28 02:55:47');
COMMIT;

-- ----------------------------
-- Table structure for wholesale_prices
-- ----------------------------
DROP TABLE IF EXISTS `wholesale_prices`;
CREATE TABLE `wholesale_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `min_count` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wholesale_prices_product_id_foreign` (`product_id`),
  CONSTRAINT `wholesale_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of wholesale_prices
-- ----------------------------
BEGIN;
INSERT INTO `wholesale_prices` (`id`, `product_id`, `price`, `min_count`, `created_at`, `updated_at`) VALUES (99, 62, 100.00, 100, '2024-10-28 04:13:13', '2024-10-28 04:13:13');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
