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
-- Copiando estrutura para tabela hoteldb.customers
-- Copiando dados para a tabela hoteldb.customers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`id`, `customer_cod`, `issuer_id`, `company_name`, `trade_name`, `cnpj`, `cpf`, `cep`, `address`, `number`, `phone`, `is_customer`, `is_driver`, `is_supplier`, `active`, `created_at`, `updated_at`) VALUES

	(2, 2, 1, 'Sgbr Sistemas', NULL, '17089484000190', NULL, '89710300', 'Estrada Primo Daniele Chiossi', '180', NULL, 1, 0, 0, 0, '2025-06-23 10:48:07', '2025-06-24 15:26:29'),
	(3, 3, 1, 'teste', NULL, '41390805000176', NULL, '88090305', 'Rua João Evangelista da Costa', '68', NULL, 1, 0, 0, 0, '2025-06-23 10:54:24', '2025-06-24 13:07:47'),
	(4, 4, 1, 'Teste2 aaaa', NULL, '49478610000194', NULL, '89711226', 'Rua Alexandre Lorenzet', '135', NULL, 1, 0, 0, 1, '2025-06-23 10:54:52', '2025-06-24 13:35:51');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
