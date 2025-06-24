-- --------------------------------------------------------
-- Servidor:                     localhost
-- Versão do servidor:           10.4.13-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para hoteldb
CREATE DATABASE IF NOT EXISTS `hoteldb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hoteldb`;

-- Copiando estrutura para tabela hoteldb.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_cod` bigint(20) unsigned NOT NULL,
  `issuer_id` bigint(20) unsigned NOT NULL,
  `product` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_internal` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` blob DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `group` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL,
  `cost_price` decimal(16,2) NOT NULL,
  `sale_price` decimal(16,2) NOT NULL,
  `profit_percentage` decimal(16,2) NOT NULL,
  `cfop` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ncm` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cest` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UN',
  `csosncst` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cod_origem_icms` int(11) NOT NULL,
  `origem_icms` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icms_ecf` float NOT NULL,
  `taxable_amount` float NOT NULL,
  `taxable_unit` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_benefit` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cod_ipi` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aliquot_ipi` float NOT NULL,
  `cod_pis` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aliquot_pis` float NOT NULL,
  `cod_cofins` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aliquot_cofins` float NOT NULL,
  `cod_use_type` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `use_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_issuer_id_product_cod_unique` (`issuer_id`,`product_cod`),
  UNIQUE KEY `products_issuer_id_barcode_unique` (`issuer_id`,`barcode`),
  UNIQUE KEY `products_issuer_id_barcode_internal_unique` (`issuer_id`,`barcode_internal`),
  KEY `products_group_id_foreign` (`group_id`),
  KEY `products_product_cod_index` (`product_cod`),
  CONSTRAINT `products_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_issuer_id_foreign` FOREIGN KEY (`issuer_id`) REFERENCES `issuers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela hoteldb.products: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `product_cod`, `issuer_id`, `product`, `barcode`, `barcode_internal`, `image`, `group_id`, `group`, `amount`, `cost_price`, `sale_price`, `profit_percentage`, `cfop`, `ncm`, `cest`, `unit`, `csosncst`, `cod_origem_icms`, `origem_icms`, `icms_ecf`, `taxable_amount`, `taxable_unit`, `tax_benefit`, `cod_ipi`, `aliquot_ipi`, `cod_pis`, `aliquot_pis`, `cod_cofins`, `aliquot_cofins`, `cod_use_type`, `use_type`, `active`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 'teste 1', '11111111111111', '5608533164232870', _binary 0x6E756C6C, NULL, NULL, 6, 11.00, 22.00, 100.00, '1111', '01022990', '1111111', 'UN', '111', 6, '6 - ESTRANGEIRA - IMPORTAÇÃO DIRETA SEM SIMILAR NACIONAL', 11.11, 1, '1111', '1', '52', 11.1, '49', 11.1, '4', 11.1, '1', '1', 1, '2025-06-12 16:38:11', '2025-06-13 16:32:09'),
	(2, 2, 1, 'teste 2', '22222222222222', '5608533164232871', _binary 0x6E756C6C, NULL, NULL, 4, 11.00, 22.00, 100.00, '1111', '01022990', '1111111', 'UN', '111', 6, '6 - ESTRANGEIRA - IMPORTAÇÃO DIRETA SEM SIMILAR NACIONAL', 11.11, 1, '1111', '1', '52', 11.1, '49', 11.1, '4', 11.1, '1', '1', 1, '2025-06-12 16:38:12', '2025-06-20 18:31:30');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
