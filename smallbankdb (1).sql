-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 09, 2019 at 09:30 AM
-- Server version: 5.7.25-0ubuntu0.16.04.2
-- PHP Version: 7.0.33-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smallbankdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `nome_admin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nascimento_admin` date DEFAULT NULL,
  `cpf_admin` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_admin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `senha_admin` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_admin` int(11) DEFAULT NULL,
  `permissao_admin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `nome_admin`, `nascimento_admin`, `cpf_admin`, `email_admin`, `senha_admin`, `status_admin`, `permissao_admin`) VALUES
('123456789', 'Paulo Brizolar', '2019-03-01', '12456789', 'paulo@gm.com', '202cb962ac59075b964b07152d234b70', 1, 1),
('1e570e8529deaadba8aaee0fb50e82eb', 'admin', '2019-04-04', '528.248.740-31', 'adm@adm.com', '25d55ad283aa400af464c76d713c07ad', 1, 1),
('2c7c7b3a1892876ee5dd2f2d84cef056', 'Leker', '2019-03-14', '452.572.340-84', 'test2@gm.com', '202cb962ac59075b964b07152d234b70', 1, 0),
('3c7e085761a028865c01f0fcc5bcffdc', 'Tester', '2004-03-11', '525.849.650-38', 'test@gm.com', '16d7a4fca7442dda3ad93c9a726597e4', 1, 1),
('ab2994c2281a9f8fb97c9f2477bae04c', 'hy', '2019-03-19', '514.096.310-87', 'hy@hy.com', '16d7a4fca7442dda3ad93c9a726597e4', 1, 1),
('bc7ba742be2c911a041daa273d805c82', 'Barber', '2019-04-11', '332.502.390-89', 'tx@tx.com', '25d55ad283aa400af464c76d713c07ad', 1, 1),
('d58bf90367c81492921943e5618eb4f7', 'paulo brizolar', '2019-03-06', '556.076.344-69', 'pauu@gm.com', 'adcebeafbb16fc1ac715d06e0d66b986', 1, 2),
('e0496e5f63ea2a6c690c55e65ec39a9', 'Admin Uno', '1998-12-17', '200.873.320-35', 'uno@gm.com', '202cb962ac59075b964b07152d234b70', 1, 1),
('eadaa8e778968afb327ed8837aab345e', 'Louper', '2019-03-14', '022.759.510-67', 'test1@gm.com', '16d7a4fca7442dda3ad93c9a726597e4', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `boletos`
--

CREATE TABLE `boletos` (
  `id_bol` int(11) NOT NULL,
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `data_vencimento_bol` date NOT NULL,
  `data_pagamento_bol` date NOT NULL,
  `valor_total_bol` double NOT NULL,
  `valor_pago_bol` double NOT NULL,
  `linha_bol` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `codigo_bol` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_bol` int(11) NOT NULL,
  `tipo_bol` int(11) NOT NULL,
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `data_confirmacao_pg_bol` datetime DEFAULT NULL,
  `autenticacao_pg_bol` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `protocolo_pg_bol` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ocorrencia_pg_bol` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `juros_bol` double NOT NULL DEFAULT '0',
  `abatimento_bol` double NOT NULL DEFAULT '0',
  `desconto_bol` double NOT NULL DEFAULT '0',
  `outros_valores_bol` double NOT NULL DEFAULT '0',
  `id_admin` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_admin_pagamento` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_cnab_bol` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_cnab` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `boletos`
--

INSERT INTO `boletos` (`id_bol`, `id_acbknt`, `data_vencimento_bol`, `data_pagamento_bol`, `valor_total_bol`, `valor_pago_bol`, `linha_bol`, `codigo_bol`, `status_bol`, `tipo_bol`, `id_trans`, `data_confirmacao_pg_bol`, `autenticacao_pg_bol`, `protocolo_pg_bol`, `ocorrencia_pg_bol`, `juros_bol`, `abatimento_bol`, `desconto_bol`, `outros_valores_bol`, `id_admin`, `id_admin_pagamento`, `status_cnab_bol`, `id_cnab`) VALUES
(1, 'c371cb388cad4237f9f2b4f027c05d1f', '2019-06-28', '2019-03-24', 7743, 7743, '81650000000-4 77433659201-9 90628469103-5 41035993516-1', '81650000000774336592019062846910341035993516', 1, 2, 'c838d67744ba89f23882b2a3052dacaa', '2019-03-22 15:00:59', '87fh643h7843gfy279hf2974yg', '', '', 0, 0, 0, 0, '2c7c7b3a1892876ee5dd2f2d84cef056', '123456789', NULL, NULL),
(2, 'c371cb388cad4237f9f2b4f027c05d1f', '2019-03-27', '2019-03-24', 33229, 33229, '84630000003-7 32290296201-6 90205038000-2 00233488706-0', '84630000003322902962019020503800000233488706', 1, 2, 'c84beb7cc8d4f51fa3a08e4043f6aa4e', '2019-03-24 15:10:45', '984yu23r94uy984u58324yr92u3408ur9823ur8u2834u20ur248u238ru2r2', '', '', 0, 0, 0, 0, '2c7c7b3a1892876ee5dd2f2d84cef056', '123456789', NULL, NULL),
(3, 'c371cb388cad4237f9f2b4f027c05d1f', '2019-03-27', '2019-03-24', 33229, 33229, '84630000003-7 32290296201-6 90205038000-2 00233488706-0', '84630000003322902962019020503800000233488706', 2, 2, 'c6e6a5dc6023b4135be4b01f01e8a930', NULL, NULL, NULL, NULL, 0, 0, 0, 0, '2c7c7b3a1892876ee5dd2f2d84cef056', NULL, NULL, NULL),
(4, '233f5824263d3ac76952187cf3c8478e', '2019-12-12', '2019-04-04', 7743, 7743, '81650000000-4 77433659201-9 90628469103-5 41035993516-1', '81650000000774336592019062846910341035993516', 2, 2, '3012f95521659f845ca7249bc6a82bb5', NULL, NULL, NULL, NULL, 0, 0, 0, 0, '2c7c7b3a1892876ee5dd2f2d84cef056', NULL, NULL, NULL),
(5, '3eef59dbce464eec4aac4440de62e022', '2019-12-12', '2019-04-04', 7743, 7743, '81650000000-4 77433659201-9 90628469103-5 41035993516-1', '81650000000774336592019062846910341035993516', 1, 2, '44d9d3f551b4e988dc4e852a878b45ad', '2019-04-04 23:58:13', '7trh388ir3je88ej3jh7hf3uhh83ruhr83h3j84h8', '', '', 0, 0, 0, 0, '2c7c7b3a1892876ee5dd2f2d84cef056', '123456789', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `id_card` int(11) NOT NULL,
  `card_name` varchar(45) NOT NULL,
  `card_status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `card_account_transfer`
--

CREATE TABLE `card_account_transfer` (
  `id_card_transfer` varchar(60) NOT NULL,
  `id_card_wallet` varchar(60) NOT NULL,
  `id_trans` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `card_transfer_value` double NOT NULL,
  `backend_card_transfer_return_code` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `card_contracts`
--

CREATE TABLE `card_contracts` (
  `id_contract` varchar(45) NOT NULL,
  `id_card_proposal` varchar(45) NOT NULL,
  `id_card` int(11) NOT NULL,
  `id_dcc` int(11) NOT NULL,
  `card_expiration_date` datetime DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `contract_status` smallint(5) NOT NULL,
  `card_number` varchar(45) DEFAULT NULL,
  `card_holder_name` varchar(100) DEFAULT NULL,
  `card_delivery_date` date DEFAULT NULL,
  `delivery_document` varchar(100) DEFAULT NULL,
  `amout` double DEFAULT NULL,
  `card_account_number` int(10) DEFAULT NULL,
  `card_digit` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `card_proposal`
--

CREATE TABLE `card_proposal` (
  `id_card_proposal` varchar(45) NOT NULL,
  `id_card` int(11) NOT NULL,
  `id_dcc` int(11) NOT NULL,
  `proposal_status` smallint(5) NOT NULL,
  `proposal_comments` varchar(200) DEFAULT NULL,
  `proposal_date` date NOT NULL,
  `proposal_expiration_date` datetime DEFAULT NULL,
  `proposal_acceptance_date` datetime DEFAULT NULL,
  `codigo_pedido_confirmation_backend` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `card_wallet`
--

CREATE TABLE `card_wallet` (
  `id_card_wallet` varchar(60) NOT NULL,
  `id_contract` varchar(45) NOT NULL,
  `operation_date` datetime NOT NULL,
  `operation_type` smallint(5) NOT NULL,
  `operation_value` double NOT NULL,
  `shop_name` varchar(200) DEFAULT NULL,
  `transasction_description` varchar(100) DEFAULT NULL,
  `operation_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `client_password_change_token`
--

CREATE TABLE `client_password_change_token` (
  `id_token` varchar(45) NOT NULL,
  `token` int(4) NOT NULL,
  `creation_date` date NOT NULL,
  `token_status` smallint(5) NOT NULL,
  `id_dcc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client_password_change_token`
--

INSERT INTO `client_password_change_token` (`id_token`, `token`, `creation_date`, `token_status`, `id_dcc`) VALUES
('725d91ea-03a6-4609-aa5d-096dbcff5e73', 6485, '2019-03-24', 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `cnab_file`
--

CREATE TABLE `cnab_file` (
  `id_cnab` int(11) NOT NULL,
  `url_arquivo_cnab` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `url_arquivo_cnab_retorno` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_geracao_arquivo` datetime NOT NULL,
  `data_arquivo_retorno` datetime DEFAULT NULL,
  `status_cnab` int(11) NOT NULL DEFAULT '1',
  `id_admin` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_admin_retorno` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_arquivo_comprovantes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cnab_file`
--

INSERT INTO `cnab_file` (`id_cnab`, `url_arquivo_cnab`, `url_arquivo_cnab_retorno`, `data_geracao_arquivo`, `data_arquivo_retorno`, `status_cnab`, `id_admin`, `id_admin_retorno`, `url_arquivo_comprovantes`) VALUES
(1, 'https://s3.amazonaws.com/multiledgers-mare-storage/cnab/arquivo-cnab-25-03-2019-16-22-32.cnab', NULL, '2019-03-25 16:22:32', NULL, 1, '123456789', NULL, NULL),
(2, 'https://s3.amazonaws.com/multiledgers-mare-storage/cnab/arquivo-cnab-29-03-2019-20-06-10.cnab', NULL, '2019-03-29 20:06:11', NULL, 1, '123456789', NULL, NULL),
(3, 'https://s3.amazonaws.com/multiledgers-mare-storage/cnab/arquivo-cnab-04-04-2019-21-57-45.cnab', NULL, '2019-04-04 21:57:46', NULL, 1, 'bc7ba742be2c911a041daa273d805c82', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ConfigAccountServices`
--

CREATE TABLE `ConfigAccountServices` (
  `BonusTargetAccount` int(11) NOT NULL,
  `BonusTargetAccountDigit` varchar(45) NOT NULL,
  `Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `data_client`
--

CREATE TABLE `data_client` (
  `id_dcc` int(11) NOT NULL,
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name_dcc` varchar(90) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_dcc` varchar(90) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `bithday_dcc` date DEFAULT NULL,
  `cpf_dcc` varchar(18) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel1_dcc` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel2_dcc` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_dcc` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_dcc` int(11) DEFAULT NULL,
  `date_dcc` timestamp NULL DEFAULT NULL,
  `tipo_dcc` int(11) NOT NULL,
  `comercio_dcc` varchar(90) COLLATE latin1_general_cs DEFAULT NULL,
  `tipo_comercio_dcc` varchar(90) COLLATE latin1_general_cs DEFAULT NULL,
  `profile_pic_dcc` varchar(150) COLLATE latin1_general_cs DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

--
-- Dumping data for table `data_client`
--

INSERT INTO `data_client` (`id_dcc`, `id_acbknt`, `name_dcc`, `last_dcc`, `bithday_dcc`, `cpf_dcc`, `tel1_dcc`, `tel2_dcc`, `email_dcc`, `status_dcc`, `date_dcc`, `tipo_dcc`, `comercio_dcc`, `tipo_comercio_dcc`, `profile_pic_dcc`) VALUES
(2, '449016bee8f865645cfc65573fc5ed4', 'paulo Super change', 'brizolar', '1111-11-11', '008.651.173-49', '(44) 66444-3344', NULL, 'pau@gm.com', 1, '2019-03-24 16:27:00', 1, NULL, NULL, NULL),
(3, '9bdf8956174c9a62b34ef3f13cd6b2c6', 'Lizard', 'Gump', '0988-01-09', '504.467.190-80', '(21) 96854-2818', NULL, 'kk@kk.com', 0, '2019-03-24 16:36:15', 1, '', '', NULL),
(4, 'c371cb388cad4237f9f2b4f027c05d1f', 'Paulo Second Change', 'Soares', '1988-10-10', '084.406.670-27', '(21) 96358-5266', NULL, 'cleverpixels@gmail.com', 1, '2019-03-24 16:43:17', 1, NULL, NULL, NULL),
(5, 'aa2cfd1cd8ca0c249aa1d5de9023d439', 'paulo', 'brizolwr', '1990-11-11', '688.248.247-06', '(44) 66444-4433', NULL, 'paull@gm.com', 0, '2019-04-04 07:21:54', 1, '', '', NULL),
(6, 'a56867281f8f0c5f80bb6328c8c0a6e9', 'djdhs', 'bdjs', '1111-11-11', '238.405.187-33', '(44) 44666-4466', NULL, 'gsgsgss@fh.com', 0, '2019-04-04 08:57:46', 1, '', '', NULL),
(7, '49d5dd0e075cdf55903a4d075b417c0', 'Paulo', 'Brizola', '1981-10-17', '794.039.200-09', '(21) 98280-4515', NULL, 'paulo@multiledgers.com', 0, '2019-04-04 17:43:50', 1, '', '', NULL),
(8, '6d397e51efe1fd8519dc81cce786fc48', 'Teste', 'Teste', '1999-12-15', '447.106.760-54', '(21) 98280-4515', NULL, 'paulo@multilesgers.com', 0, '2019-04-04 18:14:24', 1, '', '', NULL),
(9, 'eb7dc934be7cf667ef7b196cf7de849', 'phong', 'test', '1111-11-11', '267.612.834-50', '(14) 44556-6336', NULL, 'po@gm.com', 0, '2019-04-04 18:24:18', 1, '', '', NULL),
(10, '53e88ee663ece785f2a63bb7b75ae42b', 'Mac', 'Teste', '1999-12-12', '144.468.340-37', '(21) 98280-4515', NULL, 'paulo00011@hotmail.com', 0, '2019-04-04 18:50:24', 1, '', '', NULL),
(11, '233f5824263d3ac76952187cf3c8478e', 'User', 'One', '1999-12-12', '739.721.040-65', '(21) 98280-4515', NULL, 'cesarbrizola@gmail.com', 0, '2019-04-04 19:00:39', 1, '', '', NULL),
(12, '170290ddde54fb1b663c012b3ced963a', 'Augusto', 'Teste', '1999-12-12', '653.197.980-16', '(21) 98280-4515', NULL, 'multiledgersdev@gmail.com.br', 1, '2019-04-04 21:19:41', 1, NULL, NULL, NULL),
(13, '176e422a638dd3dd63668ec3dd586d8c', 'Jj', 'Teste', '2019-04-04', '717.215.750-81', '(21) 98280-4515', NULL, 'multiledgersdev@gmail.com.es', 1, '2019-04-04 21:33:11', 1, NULL, NULL, NULL),
(14, '3eef59dbce464eec4aac4440de62e022', 'Bruno', 'Teste', '1999-12-12', '515.697.430-96', '(21) 98280-4515', NULL, 'multiledgersdevq@gmail.com', 1, '2019-04-04 21:42:14', 1, NULL, NULL, NULL),
(15, 'a5128880644821905c1822da93e7cec', 'paaaa', 'loooo', '1111-11-11', '085.023.660-68', '(14) 99664-6345', NULL, 'ajajs@fj.com', 0, '2019-04-06 09:19:22', 1, '', '', NULL),
(16, 'cb136d785960d4d87596e270df7fd13b', 'hshsgs', 'gshdyd', '1111-11-11', '677.517.116-12', '(64) 66644-6644', NULL, 'hshsj@fd.com', 0, '2019-04-06 09:25:40', 1, '', '', NULL),
(17, '49fde3020d1af7ceb4abfe2116007e8c', 'pong', 'nguyen', '1111-11-11', '443.842.305-83', '(64) 47466-4454', NULL, 'pooong@gm.com', 0, '2019-04-06 09:30:30', 1, '', '', NULL),
(18, '60276bff8a3662ec16e1e02b50adcf2c', 'paulo', 'brizzolar', '1111-11-11', '016.356.564-35', '(44) 46444-4466', NULL, 'paaas@gm.com', 0, '2019-04-06 09:34:43', 1, '', '', NULL),
(19, 'c1e6ee34bf9cb09a244040793e169b69', 'hshs', 'nshshw', '1111-11-11', '882.703.740-32', '(16) 66666-6666', NULL, 'hehsiws@rjd.com', 0, '2019-04-06 16:48:30', 1, '', '', NULL),
(20, '327304a36270074e65c01c92100a8c56', 'hshsee', 'snsheje', '1111-11-11', '422.437.788-82', '(56) 66166-5654', NULL, 'ydydyeueu@djdr.com', 0, '2019-04-06 16:56:23', 1, '', '', NULL),
(21, '4671d84d74b7f5c5840bbee750815ce1', 'hsgs', 'hwjww', '1111-11-11', '407.205.813-03', '(11) 94464-6444', NULL, 'gsgwh@jww.com', 0, '2019-04-06 16:58:23', 1, '', '', NULL),
(22, 'c6521a3818984ce3ede564bb025002b', 'hwuedf', 'hwhshe', '1111-11-11', '464.610.520-97', '(66) 64446-4866', NULL, 'gwusu@jwjaiw.com', 0, '2019-04-07 07:56:04', 1, '', '', NULL),
(23, '3d5492abf084d1fee2f968072639426a', 'hshsuw', 'bshwiw', '1111-11-11', '276.732.141-56', '(44) 49644-4444', NULL, 'hauwuw@ews.com', 0, '2019-04-07 08:13:22', 1, '', '', NULL),
(24, '91e82979927ebe82d5d8d64bc14f1144', 'Luis', 'Teste', '1999-12-12', '715.371.240-21', '(21) 98280-4515', NULL, 'multiledgersdev@gmail.com', 0, '2019-04-09 01:27:43', 1, '', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deposito`
--

CREATE TABLE `deposito` (
  `id_dep` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_dest` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `title_dep` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `desc_dep` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `valor_dep` double DEFAULT NULL,
  `date_dep` datetime NOT NULL,
  `status_dep` int(11) NOT NULL DEFAULT '1',
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `id_admin` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `deposito`
--

INSERT INTO `deposito` (`id_dep`, `id_acbknt_dest`, `title_dep`, `desc_dep`, `valor_dep`, `date_dep`, `status_dep`, `id_trans`, `id_admin`) VALUES
('1193801bb2913541fa464cc6a8b930b5', '3d5492abf084d1fee2f968072639426a', 'Deposito em Conta BDM', '', 500, '2019-04-09 02:21:27', 1, 'd4a5b06d35f758362a14e0476f60731a', '123456789'),
('26cea4bcee68237d62c3abb1021d519c', '3eef59dbce464eec4aac4440de62e022', 'Deposito em Conta BDM', '', 100000, '2019-04-04 23:45:08', 1, 'c794222ba275a381e58465c906cd87b0', '123456789'),
('31f9e64d54eaf014b0b48491890a1b7f', 'c371cb388cad4237f9f2b4f027c05d1f', 'Deposito em Conta BDM', '', 1000, '2019-04-04 00:51:24', 1, '2172a6934d05d3b87c58da41f83ce408', '123456789'),
('591121a7b2126a96e0497ea6d4ab0c4b', '91e82979927ebe82d5d8d64bc14f1144', 'Deposito em Conta BDM', '', 12000, '2019-04-09 10:27:34', 1, '67289576b983a9dcae1977e36de800bd', '123456789'),
('6c43717a35d3285066dd244224cc3be7', '170290ddde54fb1b663c012b3ced963a', 'Deposito em Conta BDM', '', 100000, '2019-04-04 23:20:40', 1, '3ed0aecdc6af065f2f092fa7d8d4ee98', '123456789'),
('8a075357a80a64e6fcd4ecefbb616e15', 'c371cb388cad4237f9f2b4f027c05d1f', 'Mais testes', '', 10000, '2019-03-24 14:41:19', 1, '58940dd4abb077ed23a651316688da24', '123456789'),
('90968efa850c110720e90e83a6d0d7ce', 'c371cb388cad4237f9f2b4f027c05d1f', 'Deposito em Conta BDM', '', 721, '2019-03-24 13:58:13', 1, '4f9dac2d3eccee629b18f98303910abb', '123456789'),
('9e11b7210403e040e643610a36caa1c1', '3d5492abf084d1fee2f968072639426a', 'Deposito em Conta BDM', '', 10000, '2019-04-09 02:06:43', 1, 'a33e969a525c25b479b7c9e694c6a434', '123456789'),
('c8ab7bbaa1cee679795364fbbf12673a', '449016bee8f865645cfc65573fc5ed4', 'Teste de OP', '', 199, '2019-03-24 13:29:48', 1, '82c92eb2f8e1657589cf919437dd13fa', '123456789'),
('e10a605edf25ec337b55c535e458b324', '3d5492abf084d1fee2f968072639426a', 'Deposito em Conta BDM', '', 1000, '2019-04-09 02:18:55', 1, 'd89ffd78d6c94d96ef4d7e81b4ac4751', '123456789'),
('edce37eee53ba525f682e06c3edfdfbb', 'c371cb388cad4237f9f2b4f027c05d1f', 'Deposito em Conta BDM', '', 100000, '2019-03-24 15:08:14', 1, '6ec34e93779fa9dd58dcf19388a272e0', '123456789'),
('ee476f9228a0e3a4961dbccfdd6d0ec0', 'c371cb388cad4237f9f2b4f027c05d1f', 'teste', '', 1000, '2019-03-24 13:50:53', 1, '61fb046f6930cbd83493c66fb107fb69', '123456789'),
('fbdc819e42412bd38a663127c771bba0', '233f5824263d3ac76952187cf3c8478e', 'Deposito em Conta BDM', '', 100000, '2019-04-04 16:05:21', 1, '65a89380bc98d8a57d3879f90eab46df', '123456789'),
('ff25ee486cf0abccd5b383167a692dbe', 'c371cb388cad4237f9f2b4f027c05d1f', 'Just some changes', '', 10000, '2019-03-24 18:27:46', -1, 'e7a170a1f9b8324903e72610784077df', '123456789');

-- --------------------------------------------------------

--
-- Table structure for table `digital_certificate`
--

CREATE TABLE `digital_certificate` (
  `id_certificate` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type_operation` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `key_certificate` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_certificate` datetime DEFAULT NULL,
  `validate_certificate` timestamp NULL DEFAULT NULL,
  `hash_certificate` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_certificate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

-- --------------------------------------------------------

--
-- Table structure for table `feriados`
--

CREATE TABLE `feriados` (
  `mes` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `nome` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `local` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `integrations`
--

CREATE TABLE `integrations` (
  `id_integration` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `key` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `hash_log` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `code_lc` int(11) NOT NULL,
  `id_admin` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `date_log` datetime NOT NULL,
  `message_log` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`hash_log`, `code_lc`, `id_admin`, `date_log`, `message_log`) VALUES
('1bc06e62e2f311c2b06e595904604777', 6, '123456789', '2019-03-24 17:42:01', 'Deposito: 10000.0'),
('293b92b97e3bf6305c2f7cb9354f6fe1', 6, '123456789', '2019-03-24 16:30:05', 'Deposito: 199.0'),
('2e3ddf2741bcb4bb3ec8a4e0e6c100c7', 6, '123456789', '2019-03-24 18:08:30', 'Deposito: 100000.0'),
('34692b36d45e0415bc3f5b6f4f86df32', 6, '123456789', '2019-03-24 16:58:39', 'Deposito: 721.0'),
('37bbac36e775d9eb0473712f49358a83', 6, '123456789', '2019-04-09 03:27:46', 'Deposito: 12000.0'),
('3cee0506a0892ea3574e3d053f389be', 6, '123456789', '2019-04-04 19:05:36', 'Deposito: 100000.0'),
('5fc0e4d53c76bb8338a5aa945f5a8b35', 6, '123456789', '2019-03-24 21:28:25', 'Deposito: 10000.0'),
('64546c16f62905d45c82476dbad66b0c', 4, '123456789', '2019-03-24 18:04:30', 'Boleto: 81650000000-4 77433659201-9 90628469103-5 41035993516-1'),
('67d16fd9238e6819e626dae54ea6764f', 6, '123456789', '2019-04-03 17:52:04', 'Deposito: 1000.0'),
('75622b41ba77f6209e90d5c8ca374f16', 6, '123456789', '2019-04-04 21:45:18', 'Deposito: 100000.0'),
('a08426b2a0f0ddfde61116aa3929606c', 6, '123456789', '2019-03-24 16:51:18', 'Deposito: 1000.0'),
('a44f406b03ba5eb1121e405a6284a96d', 4, '123456789', '2019-03-24 21:35:58', 'Boleto: 84630000003-7 32290296201-6 90205038000-2 00233488706-0'),
('ba78821ba1c8fc1c0cac524068428a0f', 6, '123456789', '2019-04-04 21:20:58', 'Deposito: 100000.0'),
('c13d998b09a9ce3ad0d1497a17a15502', 5, '123456789', '2019-03-24 21:30:26', 'Estorno: id transacaoe7a170a1f9b8324903e72610784077df'),
('d3d95e5755027833c82904a41880c617', 4, '123456789', '2019-04-04 21:56:42', 'Boleto: 81650000000-4 77433659201-9 90628469103-5 41035993516-1'),
('d4c8f20a3fd42baeb8857cf677778edf', 6, '123456789', '2019-04-08 19:19:07', 'Deposito: 1000.0'),
('d8b7e09f18264bc2016b23d2ba152f09', 6, '123456789', '2019-04-08 19:21:39', 'Deposito: 500.0'),
('ec639aaa894f5ecf6538498859dd0926', 6, '123456789', '2019-04-08 19:06:53', 'Deposito: 10000.0');

-- --------------------------------------------------------

--
-- Table structure for table `monthly_tax`
--

CREATE TABLE `monthly_tax` (
  `id_mt` int(11) NOT NULL,
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `data_pagamento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plano`
--

CREATE TABLE `plano` (
  `id_plano` int(11) NOT NULL,
  `nome_plano` varchar(45) NOT NULL,
  `tipo_plano` int(11) NOT NULL,
  `valor_plano` decimal(10,2) NOT NULL,
  `recorrencia_dias` int(11) NOT NULL,
  `tem_cartao` tinyint(4) NOT NULL DEFAULT '0',
  `ativo` tinyint(4) NOT NULL DEFAULT '1',
  `duracao_dias` int(11) NOT NULL,
  `data_criacao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plano`
--

INSERT INTO `plano` (`id_plano`, `nome_plano`, `tipo_plano`, `valor_plano`, `recorrencia_dias`, `tem_cartao`, `ativo`, `duracao_dias`, `data_criacao`, `data_alteracao`) VALUES
(1, 'Plano Grátis', 1, '0.00', 99, 0, 1, 99, '2019-03-23 00:00:00', '2019-03-24 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `plano_conta`
--

CREATE TABLE `plano_conta` (
  `id_plano_conta` int(11) NOT NULL,
  `id_plano` int(11) NOT NULL,
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_plano` int(11) NOT NULL,
  `data_cobranca` datetime DEFAULT NULL,
  `data_criacao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL,
  `data_contratacao_plano` datetime NOT NULL,
  `data_proxima_recorrencia` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plano_conta`
--

INSERT INTO `plano_conta` (`id_plano_conta`, `id_plano`, `id_acbknt`, `status_plano`, `data_cobranca`, `data_criacao`, `data_alteracao`, `data_contratacao_plano`, `data_proxima_recorrencia`) VALUES
(1, 1, '449016bee8f865645cfc65573fc5ed4', 1, NULL, '2019-03-24 16:27:00', '2019-03-24 16:27:00', '2019-03-24 16:27:00', NULL),
(2, 1, '9bdf8956174c9a62b34ef3f13cd6b2c6', 1, NULL, '2019-03-24 16:36:15', '2019-03-24 16:36:15', '2019-03-24 16:36:15', NULL),
(3, 1, 'c371cb388cad4237f9f2b4f027c05d1f', 1, NULL, '2019-03-24 16:43:17', '2019-03-24 16:43:17', '2019-03-24 16:43:17', NULL),
(4, 1, 'aa2cfd1cd8ca0c249aa1d5de9023d439', 1, NULL, '2019-04-04 07:21:55', '2019-04-04 07:21:55', '2019-04-04 07:21:55', NULL),
(5, 1, 'a56867281f8f0c5f80bb6328c8c0a6e9', 1, NULL, '2019-04-04 08:57:46', '2019-04-04 08:57:46', '2019-04-04 08:57:46', NULL),
(6, 1, '49d5dd0e075cdf55903a4d075b417c0', 1, NULL, '2019-04-04 17:43:50', '2019-04-04 17:43:50', '2019-04-04 17:43:50', NULL),
(7, 1, '6d397e51efe1fd8519dc81cce786fc48', 1, NULL, '2019-04-04 18:14:24', '2019-04-04 18:14:24', '2019-04-04 18:14:24', NULL),
(8, 1, 'eb7dc934be7cf667ef7b196cf7de849', 1, NULL, '2019-04-04 18:24:18', '2019-04-04 18:24:18', '2019-04-04 18:24:18', NULL),
(9, 1, '53e88ee663ece785f2a63bb7b75ae42b', 1, NULL, '2019-04-04 18:50:24', '2019-04-04 18:50:24', '2019-04-04 18:50:24', NULL),
(10, 1, '233f5824263d3ac76952187cf3c8478e', 1, NULL, '2019-04-04 19:00:39', '2019-04-04 19:00:39', '2019-04-04 19:00:39', NULL),
(11, 1, '170290ddde54fb1b663c012b3ced963a', 1, NULL, '2019-04-04 21:19:42', '2019-04-04 21:19:42', '2019-04-04 21:19:42', NULL),
(12, 1, '176e422a638dd3dd63668ec3dd586d8c', 1, NULL, '2019-04-04 21:33:11', '2019-04-04 21:33:11', '2019-04-04 21:33:11', NULL),
(13, 1, '3eef59dbce464eec4aac4440de62e022', 1, NULL, '2019-04-04 21:42:14', '2019-04-04 21:42:14', '2019-04-04 21:42:14', NULL),
(14, 1, 'a5128880644821905c1822da93e7cec', 1, NULL, '2019-04-06 09:19:22', '2019-04-06 09:19:22', '2019-04-06 09:19:22', NULL),
(15, 1, 'cb136d785960d4d87596e270df7fd13b', 1, NULL, '2019-04-06 09:25:40', '2019-04-06 09:25:40', '2019-04-06 09:25:40', NULL),
(16, 1, '49fde3020d1af7ceb4abfe2116007e8c', 1, NULL, '2019-04-06 09:30:30', '2019-04-06 09:30:30', '2019-04-06 09:30:30', NULL),
(17, 1, '60276bff8a3662ec16e1e02b50adcf2c', 1, NULL, '2019-04-06 09:34:43', '2019-04-06 09:34:43', '2019-04-06 09:34:43', NULL),
(18, 1, 'c1e6ee34bf9cb09a244040793e169b69', 1, NULL, '2019-04-06 16:48:30', '2019-04-06 16:48:30', '2019-04-06 16:48:30', NULL),
(19, 1, '327304a36270074e65c01c92100a8c56', 1, NULL, '2019-04-06 16:56:23', '2019-04-06 16:56:23', '2019-04-06 16:56:23', NULL),
(20, 1, '4671d84d74b7f5c5840bbee750815ce1', 1, NULL, '2019-04-06 16:58:23', '2019-04-06 16:58:23', '2019-04-06 16:58:23', NULL),
(21, 1, 'c6521a3818984ce3ede564bb025002b', 1, NULL, '2019-04-07 07:56:05', '2019-04-07 07:56:05', '2019-04-07 07:56:05', NULL),
(22, 1, '3d5492abf084d1fee2f968072639426a', 1, NULL, '2019-04-07 08:13:22', '2019-04-07 08:13:22', '2019-04-07 08:13:22', NULL),
(23, 1, '91e82979927ebe82d5d8d64bc14f1144', 1, NULL, '2019-04-09 01:27:43', '2019-04-09 01:27:43', '2019-04-09 01:27:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `plano_conta_minutrade`
--

CREATE TABLE `plano_conta_minutrade` (
  `id_plano_conta_minutrade` int(11) NOT NULL,
  `id_plano_conta` int(11) DEFAULT NULL,
  `id_trigger` varchar(45) DEFAULT NULL,
  `erro_minutrade` varchar(100) DEFAULT NULL,
  `status_minutrade` int(11) NOT NULL,
  `data_bonus_solicitado` datetime DEFAULT NULL,
  `data_bonus_liberado` datetime DEFAULT NULL,
  `data_criacao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `set_account`
--

CREATE TABLE `set_account` (
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `id_agbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_acbknt` int(11) DEFAULT NULL,
  `digit_acbknt` int(11) DEFAULT NULL,
  `type_acbknt` int(11) DEFAULT NULL,
  `key_to_acc` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `status_acbknt` int(11) DEFAULT NULL,
  `date_create_acbknt` datetime DEFAULT NULL,
  `max_devices` int(11) NOT NULL DEFAULT '4',
  `tax_day` int(11) NOT NULL DEFAULT '5',
  `first_tax_payd` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

--
-- Dumping data for table `set_account`
--

INSERT INTO `set_account` (`id_acbknt`, `id_agbknt`, `num_acbknt`, `digit_acbknt`, `type_acbknt`, `key_to_acc`, `status_acbknt`, `date_create_acbknt`, `max_devices`, `tax_day`, `first_tax_payd`) VALUES
('170290ddde54fb1b663c012b3ced963a', '1643fcd150aae86e7f2c842d17246bea', 906242, 3, 1, '6ae4b7e3b6c2349a33c05ea971783f0f', 2, '2019-04-04 00:00:00', 4, 5, 0),
('176e422a638dd3dd63668ec3dd586d8c', '1643fcd150aae86e7f2c842d17246bea', 881417, 0, 1, '909643f155c8d7f38a69cd1d4e8074a7', 2, '2019-04-04 00:00:00', 4, 5, 0),
('233f5824263d3ac76952187cf3c8478e', '1643fcd150aae86e7f2c842d17246bea', 580717, 7, 1, 'f09a22c85a667dc3331338c1b8a7fdec', 2, '2019-04-04 00:00:00', 4, 5, 0),
('327304a36270074e65c01c92100a8c56', '1643fcd150aae86e7f2c842d17246bea', 324288, 0, 1, '834df5e35c04bd0145c3ac44fff66215', 2, '2019-04-06 00:00:00', 4, 5, 0),
('3d5492abf084d1fee2f968072639426a', '1643fcd150aae86e7f2c842d17246bea', 181314, 6, 1, '2adea1bb8476a6dc71e2d24c84425742', 2, '2019-04-07 00:00:00', 4, 5, 0),
('3eef59dbce464eec4aac4440de62e022', '1643fcd150aae86e7f2c842d17246bea', 529140, 6, 1, '6622e3d0a79c1ecbb2ec4bd46549040e', 2, '2019-04-04 00:00:00', 4, 5, 0),
('449016bee8f865645cfc65573fc5ed4', '1643fcd150aae86e7f2c842d17246bea', 921189, 7, 1, 'da42808a81629b4ff3fefef2a79491c7', 2, '2019-03-24 00:00:00', 4, 5, 0),
('4671d84d74b7f5c5840bbee750815ce1', '1643fcd150aae86e7f2c842d17246bea', 991789, 9, 1, '9cb18d5a2eb1842fffdf331fd24d0a24', 2, '2019-04-06 00:00:00', 4, 5, 0),
('49d5dd0e075cdf55903a4d075b417c0', '1643fcd150aae86e7f2c842d17246bea', 891153, 9, 1, '302ea6cd080727f6bdba87c997275b7', 2, '2019-04-04 00:00:00', 4, 5, 0),
('49fde3020d1af7ceb4abfe2116007e8c', '1643fcd150aae86e7f2c842d17246bea', 526014, 6, 1, 'b3dbb5b71492ccd00c7806ca7990745e', 2, '2019-04-06 00:00:00', 4, 5, 0),
('53e88ee663ece785f2a63bb7b75ae42b', '1643fcd150aae86e7f2c842d17246bea', 126942, 2, 1, 'a073801fcc2a4926908dd20c7d0a4dbe', 2, '2019-04-04 00:00:00', 4, 5, 0),
('60276bff8a3662ec16e1e02b50adcf2c', '1643fcd150aae86e7f2c842d17246bea', 976426, 7, 1, '18ce275686d75728a72313edadfdafec', 2, '2019-04-06 00:00:00', 4, 5, 0),
('6d397e51efe1fd8519dc81cce786fc48', '1643fcd150aae86e7f2c842d17246bea', 380879, 7, 1, 'a8af735b67116c40eee3f94a35923eb2', 2, '2019-04-04 00:00:00', 4, 5, 0),
('91e82979927ebe82d5d8d64bc14f1144', '1643fcd150aae86e7f2c842d17246bea', 4926, 2, 1, 'a44282fd4fa096032df97098e9d16ca', 2, '2019-04-09 00:00:00', 4, 5, 0),
('9bdf8956174c9a62b34ef3f13cd6b2c6', '1643fcd150aae86e7f2c842d17246bea', 733433, 7, 1, '89618735848ecd77eeff5b09cd1846c7', 2, '2019-03-24 00:00:00', 4, 5, 0),
('a5128880644821905c1822da93e7cec', '1643fcd150aae86e7f2c842d17246bea', 245398, 3, 1, 'b279731bacce35fec729e8f5e7da25f8', 2, '2019-04-06 00:00:00', 4, 5, 0),
('a56867281f8f0c5f80bb6328c8c0a6e9', '1643fcd150aae86e7f2c842d17246bea', 272424, 3, 1, '39a3dd4ade5991d0e63ce18c309883b', 2, '2019-04-04 00:00:00', 4, 5, 0),
('aa2cfd1cd8ca0c249aa1d5de9023d439', '1643fcd150aae86e7f2c842d17246bea', 11273, 0, 1, '63ddda62ffba99d69f4478013cd640c8', 2, '2019-04-04 00:00:00', 4, 5, 0),
('c1e6ee34bf9cb09a244040793e169b69', '1643fcd150aae86e7f2c842d17246bea', 861016, 4, 1, '1789443ad4b35bb81ecb9d8dbf18c125', 2, '2019-04-06 00:00:00', 4, 5, 0),
('c371cb388cad4237f9f2b4f027c05d1f', '1643fcd150aae86e7f2c842d17246bea', 380587, 6, 1, '7849d719bf9d5187dfd512e555d6bab8', 2, '2019-03-24 00:00:00', 4, 5, 0),
('c6521a3818984ce3ede564bb025002b', '1643fcd150aae86e7f2c842d17246bea', 697864, 7, 1, '738ab4d5b82e2dc0d2c67ecae9125dfb', 2, '2019-04-07 00:00:00', 4, 5, 0),
('cb136d785960d4d87596e270df7fd13b', '1643fcd150aae86e7f2c842d17246bea', 896350, 6, 1, '889c23c1cb17dd479ef2a1a2994f56d5', 2, '2019-04-06 00:00:00', 4, 5, 0),
('eb7dc934be7cf667ef7b196cf7de849', '1643fcd150aae86e7f2c842d17246bea', 962452, 9, 1, 'da59d2c62f476c727380c5c8917bf6a5', 2, '2019-04-04 00:00:00', 4, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `set_agence`
--

CREATE TABLE `set_agence` (
  `id_agbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `agencia_agbknt` varchar(4) COLLATE latin1_general_cs NOT NULL,
  `nome_agbknt` varchar(255) COLLATE latin1_general_cs DEFAULT NULL,
  `cnpj_agbknt` varchar(45) COLLATE latin1_general_cs DEFAULT NULL,
  `latitude_agbknt` double(10,8) DEFAULT '0.00000000',
  `logradouro_agbknt` varchar(255) COLLATE latin1_general_cs NOT NULL,
  `numero_agbknt` varchar(45) COLLATE latin1_general_cs NOT NULL,
  `cep_agbknt` varchar(45) COLLATE latin1_general_cs NOT NULL,
  `bairro_agbknt` varchar(80) COLLATE latin1_general_cs NOT NULL,
  `cidade_agbknt` varchar(80) COLLATE latin1_general_cs NOT NULL,
  `uf_agbknt` varchar(2) COLLATE latin1_general_cs NOT NULL,
  `longitude_agbknt` double(11,8) DEFAULT '0.00000000',
  `status_agbknt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

--
-- Dumping data for table `set_agence`
--

INSERT INTO `set_agence` (`id_agbknt`, `agencia_agbknt`, `nome_agbknt`, `cnpj_agbknt`, `latitude_agbknt`, `logradouro_agbknt`, `numero_agbknt`, `cep_agbknt`, `bairro_agbknt`, `cidade_agbknt`, `uf_agbknt`, `longitude_agbknt`, `status_agbknt`) VALUES
('1643fcd150aae86e7f2c842d17246bea', '1001', 'MARE', NULL, 0.00000000, '', '', '', '', '', '', 0.00000000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `simple_sell`
--

CREATE TABLE `simple_sell` (
  `id_sell` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `date_sell` datetime NOT NULL,
  `price_sell` double NOT NULL,
  `title_sell` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_payment_sell` datetime DEFAULT NULL,
  `status_sell` int(11) NOT NULL DEFAULT '1',
  `id_trans` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_acbknt_cli` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tax_sell` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `id_token` int(11) NOT NULL,
  `hash` varchar(66) NOT NULL,
  `id_admin` varchar(45) DEFAULT NULL,
  `id_conta` varchar(45) DEFAULT NULL,
  `id_device` varchar(45) DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT '1',
  `data_criacao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`id_token`, `hash`, `id_admin`, `id_conta`, `id_device`, `ativo`, `data_criacao`) VALUES
(1, '10707841409B0309B9AB756355FBD3B83935821D3AD568AD14A880F60843BF8E', '123456789', NULL, NULL, 0, '2019-03-21 16:51:02'),
(2, 'D96E2E07FCC47543BDB1490704AA89F25F88C3BF15E2EF5EF09AA439C7E82475', '123456789', NULL, NULL, 0, '2019-03-21 17:47:59'),
(3, '3638C408F11A1271C8674FA8DEF82F90DA77E5882E0D78E6D6E7A24FF2AFB2A1', '123456789', NULL, NULL, 0, '2019-03-21 17:49:46'),
(4, 'D5F6E1354463067010D46C5BD4A19FB1C67A97F96F2B320C16B28DBA4C89C802', '123456789', NULL, NULL, 0, '2019-03-22 13:10:56'),
(5, 'E3D5B85DCF0D2B2E6185E9BBA4D2D7A7EA2CBA68471A6837CB004AE06A18CD61', '123456789', NULL, NULL, 0, '2019-03-22 14:22:20'),
(6, '4D1B8E83D39339E16ECEC9D1C4F1DF2BC8A10AD8E105E434D98FEF810D5B18BD', '123456789', NULL, NULL, 0, '2019-03-22 14:37:11'),
(7, '55F510540F4F13667953975235E66CD5DDAC88F6FAA54C24F2B2932A0C6A082A', '123456789', NULL, NULL, 0, '2019-03-22 17:20:44'),
(8, 'A7D285CB30F38593BE3A602FBC295679C76FDC05540A680C1812CA3FE87C28C9', '123456789', NULL, NULL, 0, '2019-03-22 17:31:08'),
(9, '55D5C5E2374443438ACAE7F365E95DAF84492646D56D11AA0572CA556AC97D28', '123456789', NULL, NULL, 0, '2019-03-22 17:44:43'),
(10, 'E2B94A0EFC7B143CC9C05F2DD7D8CA3545EBC05C183777EE9F1F1812A753778E', '123456789', NULL, NULL, 0, '2019-03-22 17:53:19'),
(11, '65DCAB3BCB45537B5AB34E37E0DB6170F7AFCB763E09B359D34BF9488EB63BB9', '123456789', NULL, NULL, 0, '2019-03-22 17:58:16'),
(12, '93AF40D0A37647A664ECDABC3ADE5FB5616F3444C53570B8AC9618D535DBC9B6', '123456789', NULL, NULL, 0, '2019-03-22 18:46:47'),
(13, '61EE142DC7B3CABC280AEEC6C6671FB1AFD640E1773FB68ACDCC5F8467A06972', '3c7e085761a028865c01f0fcc5bcffdc', NULL, NULL, 0, '2019-03-22 18:47:59'),
(14, 'E897197A00B742A2D98C02EDF46883D062954E38354A6D9CD8855761B7494B73', '3c7e085761a028865c01f0fcc5bcffdc', NULL, NULL, 0, '2019-03-22 19:09:40'),
(15, '28607B4C8C59311F86F573CECBEC20B6A52234AAD820317BCA09E0CF727F903D', 'eadaa8e778968afb327ed8837aab345e', NULL, NULL, 1, '2019-03-22 19:11:04'),
(16, 'BE4EA87EFD7D3B5ADFE029EFA636B491E84F88AA4322D1180E786FE19C8BEDE5', '3c7e085761a028865c01f0fcc5bcffdc', NULL, NULL, 1, '2019-03-22 19:12:28'),
(17, '0AFED99456B962F0E45D43696788E1685F5EC7836E3439F1290FC958225F7E1A', '2c7c7b3a1892876ee5dd2f2d84cef056', NULL, NULL, 0, '2019-03-22 19:13:33'),
(18, '55A4E0AC4C8A672349149B758A6538A086EBDCCE28D20A0C1ADA5CAC86130105', '123456789', NULL, NULL, 0, '2019-03-23 02:30:43'),
(19, '8F3DCE2CE004494EAEF4C5B00CBE4852C43ED41D79CD61719200E0307D632830', '123456789', NULL, NULL, 0, '2019-03-23 03:03:38'),
(20, 'B6484492D9A08A7474A854B2956111B5894EB78207B3563FC7766FF4D8EDC45E', '123456789', NULL, NULL, 0, '2019-03-23 03:12:41'),
(21, 'B4FF77783C661799B1341EAED86E306BC7AB53BCCA8E198EBEDA96E9DD420727', '123456789', NULL, NULL, 0, '2019-03-23 04:17:59'),
(22, 'CEDF7EAA1CB7EED618977D08A766A0887121E3A6493F481E172801E752E88F70', '123456789', NULL, NULL, 0, '2019-03-23 04:34:24'),
(23, '7A8BDAFA2D26C369E2148F8C8522BF90E4EC372F9929E6E66DC2E3F3A4994D1E', '123456789', NULL, NULL, 0, '2019-03-23 04:39:06'),
(24, '8CFB75EB64C5BDDC8861A81C06C011A8C967EB241D3A6025A5684726DB6B672F', '123456789', NULL, NULL, 0, '2019-03-23 15:49:34'),
(25, '27151A5E45C83EE24198023CC5C5D3D59E4A769138A87FAC800273155D0888A2', '123456789', NULL, NULL, 0, '2019-03-23 16:15:11'),
(26, '8075236BF5F47065B50E09EB9DF49631BF8FF800A1E0AB3C5DCCAE808B08B955', '123456789', NULL, NULL, 0, '2019-03-23 16:20:27'),
(27, 'C3AB74F0FC1927E38D010EEBFAB846B4FF561A6DB03077C774448140691F1D8C', '123456789', NULL, NULL, 0, '2019-03-23 16:22:46'),
(28, '5F90ABCDBC56820763B0708FF753D23343C4DE50C70EEE125CB539F74B71BAE5', '123456789', NULL, NULL, 0, '2019-03-23 16:32:42'),
(29, '3F993D5B69FD5A7FCA18720512FC13B6E963C8C17EBC9C8CC2F0C067CD46D584', '123456789', NULL, NULL, 0, '2019-03-23 16:48:11'),
(30, '0966D348EE2350DA117B9A5946683001DA8DE0F289F40ED16ED18F018EB2E6F0', '123456789', NULL, NULL, 0, '2019-03-23 17:07:57'),
(31, '57F4DAF6E3B8E487941D6B04441950BBCE93B25F72541F9866A634DC9CE1BAFE', '123456789', NULL, NULL, 0, '2019-03-23 17:25:45'),
(32, '63A157A62CF20553C633741C52B0FEC4E15A3569C378317294B650ABBC6D1A7B', '123456789', NULL, NULL, 0, '2019-03-23 17:27:18'),
(33, 'D4CDD4631F544C5F020B1C8922D926AFA196B0F04402C4B50B4A11DAA8AB2EAA', '123456789', NULL, NULL, 0, '2019-03-23 17:27:57'),
(34, 'F5B1F1B5D500EE05B83CADDC5D9A2E1F694F38332C8DCA520C33AFC12D0C5F04', '123456789', NULL, NULL, 0, '2019-03-23 17:53:04'),
(35, '9EA5A661D241C8DB8E0335B0510DAE8FC758FEF462516E4C390D883775C7DB80', '123456789', NULL, NULL, 0, '2019-03-23 17:55:01'),
(36, '1B517BE8FC8783C7215C761149F679B08DF90BA3CFB81E8AE9268D4A70069AAA', '123456789', NULL, NULL, 0, '2019-03-24 02:35:52'),
(37, '48567340F660A1A86B926CCE47646B4BE394DE6B6239A6F3C85D4C20938ADCB6', '123456789', NULL, NULL, 0, '2019-03-24 02:47:22'),
(38, '4CA5F786AF43ACAA6FEFAF86A98F08D57D4050F7FC69BB596E84BBAABBAFC5CF', '123456789', NULL, NULL, 0, '2019-03-24 02:52:53'),
(39, 'DB4064D42085252AAE506F3A336A1F793946AD18ABA00C3B11538C9572CBE00A', '123456789', NULL, NULL, 0, '2019-03-24 03:00:54'),
(40, 'D1463B5E16FFA9CB2804C9E5312C754669FAB138F89AA18E6C25EC3699438594', '123456789', NULL, NULL, 0, '2019-03-24 03:06:59'),
(41, 'CB832D5779E25FC53635C73C697E83DCF0D7537AABB7F1453429A3E0F20BD27A', '123456789', NULL, NULL, 0, '2019-03-24 03:10:08'),
(42, '8BDA8C2F60CDF0D8AC1BEC6F5CC8223B664A312315BB5EAB2C53223B2A7E5A3A', '123456789', NULL, NULL, 0, '2019-03-24 03:14:24'),
(43, 'C62CE631229F5093416B8F16F562701E2CD9D6A896F2DA34296DF95414DC9F9D', '123456789', NULL, NULL, 0, '2019-03-24 03:16:44'),
(44, 'CE234804E8D2E73754B42D053BC917C19D6FE1432018DD6F28B7E63AC9B87DE5', '123456789', NULL, NULL, 0, '2019-03-24 03:25:24'),
(45, '792B2B679F7132CCEC00EA70E836ACAC8E9913671CC26AD5D966FD13E4ECB8C7', '123456789', NULL, NULL, 0, '2019-03-24 03:29:41'),
(46, 'BFBD4839EDA6F07343449DB0633F52A4D91A518DA5EDE853C2C973D3B0A11E2C', '123456789', NULL, NULL, 0, '2019-03-24 03:30:42'),
(47, '4E56DD29BFD145CC6FC7F7DA278CBA7155519738DE9A35A80BC95B35192DFD45', '123456789', NULL, NULL, 0, '2019-03-24 03:33:39'),
(48, '8A4688F2DCD4948ED3594C180B009CB355004203F4CD5B0CD29F9D88D1D12065', '123456789', NULL, NULL, 0, '2019-03-24 03:37:34'),
(49, '10623C950497FE18FA37C426EB6698787A5BA5CCC6A161C61BF085CB7F65B440', '123456789', NULL, NULL, 0, '2019-03-24 03:46:27'),
(50, '48951E539FA04DC5C65F258E08F3729883B4F1829CC38FEE5E685D4F24FA831B', '123456789', NULL, NULL, 0, '2019-03-24 03:48:33'),
(51, '6BD7DDBE317D0DB54049DAF2EB8865AC49ADA920CA558583CA5428762547E708', '123456789', NULL, NULL, 0, '2019-03-24 03:54:40'),
(52, '0E1286438590F0516FDE95CF53D17457705DB18A8BD1E59DF5DBFAC4FFC1662E', '123456789', NULL, NULL, 0, '2019-03-24 04:25:03'),
(53, 'F0E04F57E6B8D077AAB24BB8746FDAD460BEFAD378F7EB296096C388CA1348F5', '123456789', NULL, NULL, 0, '2019-03-24 04:39:19'),
(54, '207A74F3B2A1C43B3BCEE981B8DE8920FDFFC50039D21E4B316FE97A23D237E8', '123456789', NULL, NULL, 0, '2019-03-24 06:51:53'),
(55, '1501420555A7D3B388B106AEE308AA1F740C53808C482C3801D1181B6A5E1EBA', '123456789', NULL, NULL, 0, '2019-03-24 06:56:00'),
(56, 'E86B2B69F1A2A322035215D4145033EDDD832BA33D68E347C8206108F716957C', '123456789', NULL, NULL, 0, '2019-03-24 06:58:43'),
(57, 'DB30F2B90E36A47204F3398CE40F69FB19631F65DCB8D568400350626F9F26FA', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:02:21'),
(58, '3CBBABA7D5425B0A4762B89CAB3E7690861B629077E00898A00C3BD5996676F1', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:05:44'),
(59, '657AB04D1B2B4BBC350D1F819EA671D05E5CF6D4BEED846CFD39F2F1FEEAD139', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:13:20'),
(60, '4E6771C69129E75DD37F09E4CB5F15D238C9512CC5ED788C03D7789435EA2F72', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:15:35'),
(61, '5A735B334BB7840B175AB16152AE1968925DA60BF6F5A93D6022CD01FCAFD84C', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:16:59'),
(62, 'A85E94F5BEEA309D00F79315C6D415DA11A6C9C91EBDF6B8869832A646F9B1E4', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:18:55'),
(63, '704A38BCB0EF432960CA9D9685E6239785E6F9BD048E09D13C48039A1CD19591', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:20:00'),
(64, '1B8C7526F19F1479B6FDF4CCE1416827619DCA8F2BB55BB1885A8C8F90FEDA42', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:21:45'),
(65, '17EDB9E227DAB290B89902A9C19272AA00D24DA5C5AAE1A0E1D428D50BB4A512', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 0, '2019-03-24 07:24:58'),
(66, '7CC40D078EFA4EB3A9FEA7567A73D377C8197DD1497F63D8578C9B9C2580220A', 'e0496e5f63ea2a6c690c55e65ec39a9', NULL, NULL, 1, '2019-03-24 07:35:41'),
(67, '2F3D990EF990122CFD62F441DD0A8BAC34FE2F16F72A7339055B9F0A4090E0A8', '123456789', NULL, NULL, 0, '2019-03-24 16:02:32'),
(68, 'AB75B7C2B4CBAF5D01F364C6C5C146052CF714C562C1FB53BE31C4E17A401C92', '123456789', NULL, NULL, 0, '2019-03-24 16:27:57'),
(69, '5C0A5577E11C6EC3C32437D32E75439BB249B34AFEB6BA5B5FC67726DB73BA31', '123456789', NULL, NULL, 0, '2019-03-24 16:37:18'),
(70, '2CEFA66F60839158026396078D3FC70FECD321D8EECEEDB273CF2A1CD2B4E42A', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 16:45:16'),
(71, '2E5C81B4BA9DA74977F4C619AB6EA7F17C9B208B31DF2BA3E3167DE0BCC0720D', '123456789', NULL, NULL, 0, '2019-03-24 16:50:37'),
(72, '21E2FFE84F517C9E2C2F24666883AFD2C8D39FFB2E5064F2ECCF8C235250D0D6', '123456789', NULL, NULL, 0, '2019-03-24 16:55:54'),
(73, 'E5AC50A1B46F75E6B893EAE200BDD22D609D69A947B34F8DE41085A3BF88B978', '123456789', NULL, NULL, 0, '2019-03-24 16:58:03'),
(74, 'FD99CE695AF5F0850A5A60E495B1D4F95CA179D8857E4B6757B0131C441A7195', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 17:21:01'),
(75, 'D388A18E10DB5415B22BF7CDE0F01C678F57BC415AE933B927173FD632D983FE', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 17:33:06'),
(76, 'ADD1CF52EE3D9F0BE5E3F71337102B5170A3141F0EFD9EC414305C3B7A9E905A', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '1', 1, '2019-03-24 17:33:54'),
(77, '8E2E3A236E8F141C13505F99598C43B89167F019E7167241F0C9F537F46AFA99', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 17:48:20'),
(78, '7C6C9D41FA5DD41DBE497296064E752E7CF6799F322ACA128A899B56F4A26614', '123456789', NULL, NULL, 0, '2019-03-24 21:11:12'),
(79, '774A8905EA1CE03A65C82017C145BBD3625E18EB89EF5F51874B92181F3ECC1F', '123456789', NULL, NULL, 0, '2019-03-24 21:18:25'),
(80, '98996BD7215C7EC55ED11F43216632AAB07BEC2EA716E1E71308B4330CE1251C', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 21:31:55'),
(81, '5AD3AC60BED989F036D338D61DD4A3DB1DE9BEFB869A0E2A5A21188E48F8448E', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 21:31:56'),
(82, '73881C2F9B070969339B577A1FE2F6D89806079ACD1994E9E1C280E0EC35550C', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 21:38:11'),
(83, '9ADA7A3553E70227F0EE9C6F643BB81166980971B0DBCA7FB3AEA12761C38242', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-24 21:38:18'),
(84, 'F25A222BD7EA2D5A6C9EAFA36134B63916CF1C30B0F6EC090A741DB27D87FA27', '123456789', NULL, NULL, 0, '2019-03-25 02:04:24'),
(85, 'A98C1740E908F07C9747BD9D6D77A5C4AB554822CF5F78B2460B44567B2657FC', '123456789', NULL, NULL, 0, '2019-03-25 04:25:21'),
(86, '05E840371E1D672DD15ED2B293C42EC0DF6CA3DB21321B085E9174AE791BA57E', '123456789', NULL, NULL, 0, '2019-03-25 04:47:27'),
(87, 'E07094C6ED55A33BECA7BF7E5EB224CED198A62F9F325CD6C4151C4E4BE00568', '123456789', NULL, NULL, 0, '2019-03-25 05:00:35'),
(88, '81B54ED91E5FD2EDFD98E6CC7187B153A68E4A6E4BEF5EA24072F39B757A60FB', '123456789', NULL, NULL, 0, '2019-03-25 08:06:12'),
(89, '911CEAD903744A8D3261F1EF318541504B1CA18B55CD432F9C851CDAFEFE1005', '123456789', NULL, NULL, 0, '2019-03-25 08:14:38'),
(90, '6C9E2ADE127868A9EEA290189E3BA5E0A55A0E9089A6BA3AAA8DB34ED4EBDFD5', '123456789', NULL, NULL, 0, '2019-03-25 09:06:13'),
(91, 'DDF5C43AEF629BFEEB42346E09F12426361B0D99E5D42FEA34B27B332A471EEF', '123456789', NULL, NULL, 0, '2019-03-25 09:08:03'),
(92, '392E4F5206056A7A65DDF36A64697337CC525923CA0AB7C8C3256E4B9AF9D401', '123456789', NULL, NULL, 0, '2019-03-25 10:46:42'),
(93, '5F47F436C3E1930DA21A44CC4FAC101D665D5508A761CE95C0D04870E2E806F3', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-03-25 11:55:43'),
(94, 'E9C56FA71969FFBCC977E1B91C82F6F257241F14D2E6F5590046F624517D6FC2', '123456789', NULL, NULL, 0, '2019-03-25 12:05:43'),
(95, 'A9DA62215ADC9B78D150FA5DD9141DCF37297822C00B469EBDB8BE95B0AC3E58', '123456789', NULL, NULL, 0, '2019-03-25 13:48:15'),
(96, 'CF412D5C71628BF5B0955320D828140A44F82C465746FBB59F07952A9944F01C', '123456789', NULL, NULL, 0, '2019-03-25 14:37:17'),
(97, '4B895199ED65475E49CDB82D3B1EFD6D182F105A2E3E08B49DDBA8DFB577C9C8', '123456789', NULL, NULL, 0, '2019-03-25 15:11:27'),
(98, 'CCEF94C5AAF7B3FE6E922FCA9FE6538E5573DB74578466BA0C19AA2A494E1679', '123456789', NULL, NULL, 0, '2019-03-25 15:26:42'),
(99, '718F5F3E52F95A1F999001CD81456EAEA4F4BCF36F86416446CD59A8905A9AB4', '123456789', NULL, NULL, 0, '2019-03-25 15:53:37'),
(100, '58DA4E1FDA6BD71E6EA2FA94983E6874264FB6398AD63C69BC86118BE106313A', '123456789', NULL, NULL, 0, '2019-03-25 15:54:48'),
(101, 'FEDBB508CDAFEE34CC52BDC7EBA3DA9A57A48C1AA714F958E12805F90E841DF3', '123456789', NULL, NULL, 0, '2019-03-25 16:22:18'),
(102, 'B280373272EAA8C7E11A80D7DDE8A5B705AB084B7975017C79831AA3733838D8', '123456789', NULL, NULL, 0, '2019-03-25 16:26:37'),
(103, 'FC623B3FAB180914A5E7FF18A7DB74206EDEAFEB185D9D2086BDB4DB75E68CA7', '123456789', NULL, NULL, 0, '2019-03-25 16:45:18'),
(104, '33E1D2933CD4DC4BA903B0F46449AE84533CB60C1CEB99F46EAEAFC11C4DF51A', '123456789', NULL, NULL, 0, '2019-03-26 12:07:44'),
(105, 'FD134AD550FAB16725EAB63AF56BBDBE0E5B341E6145CD02539260C3307BBFB7', '123456789', NULL, NULL, 0, '2019-03-26 12:42:45'),
(106, 'DE8E08A300D2A9191B2A44157D7DC69BB251FC701E86E1A9AA05BD8972BD0A8D', '123456789', NULL, NULL, 0, '2019-03-26 17:43:37'),
(107, '13631865C571167D8E5AA6CF5D3FB94F04B6E70D20A7DB5AD86C49E464562FEB', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 0, '2019-03-29 17:28:49'),
(108, 'B577D028D1A9D33292DA2AE84FEF14123C145678B32FF84E64894FC94438D7A7', '123456789', NULL, NULL, 0, '2019-03-29 20:05:15'),
(109, 'A353759D42CC77B280150881C4C6AFEF1FFB622E446B9747E37BE82B4CCBDF8B', '123456789', NULL, NULL, 0, '2019-03-30 00:38:33'),
(110, '1744FD6773B1060CC5F25D2BD2137B7E35AF6FE176F3189AD6ED898346A4F1E1', '123456789', NULL, NULL, 0, '2019-03-30 04:29:53'),
(111, '948257A7AA159A7C56EFE54284B0DA32240A7ECC7CBA87FD898F971A72587096', '123456789', NULL, NULL, 0, '2019-03-30 05:21:42'),
(112, 'D728E1966E41CE84882AD739328E3C3DEF61B49BA154AEEA54B8354BA9454914', '123456789', NULL, NULL, 0, '2019-03-30 05:38:30'),
(113, 'CE7BF512E3719EA67A3AF15DCE9692EBF349B697F10F6C4FF5793BA1D5EFD998', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-03-30 08:10:34'),
(114, 'B7DB9A2A7586B4C2D3041018A888417F7201D656F1932FA081255CB1DD9D1B52', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-03-30 08:14:42'),
(115, 'BB1A9EEAE543A7D2D285C41EE43C96EC2C12EA2930B9C3965794306CA85C920F', '123456789', NULL, NULL, 0, '2019-03-30 08:24:31'),
(116, 'D15CAC4A3D7761B47B1FBFB512CCC7C55A7CDE4AF23111D5599B15A666C0CBF6', '123456789', NULL, NULL, 0, '2019-03-30 08:35:08'),
(117, '7D6E394A739F32A3F78B2E3C76B8EC62EAF47F627FC347D3C3C17D76538D91D2', '123456789', NULL, NULL, 0, '2019-03-30 08:48:04'),
(118, 'C05E609229910E2FB30EA47C76660807A72B79B74143E7DF61A2A2E120A3549E', '123456789', NULL, NULL, 0, '2019-03-31 12:11:08'),
(119, 'E47F8CBB518DAD3C4A0C3349B35ADB65F4FD1E8FE9F854EDD9A7A6F84206A481', '123456789', NULL, NULL, 0, '2019-03-31 12:12:06'),
(120, 'FD003B026512EEC88D75225E21A6E3F07D67263FBD166D66B1AF342068E98AD8', '123456789', NULL, NULL, 0, '2019-03-31 15:43:43'),
(121, '8B92066DC01884480A5C928A21CACE3F1B4412A94D52BD343F9281B61F0B9DAA', '123456789', NULL, NULL, 0, '2019-03-31 17:57:50'),
(122, '3792FB5D28F5AF177F6EBE77ED92B82524BA31F23B14BEDE954FFBAAF4FE9B1F', '123456789', NULL, NULL, 0, '2019-03-31 18:08:51'),
(123, 'BA4BCE6B83E3FE76D44C3AC6C9DBD8072025B7A6527F1FABB78F1B61D500308A', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '2', 1, '2019-03-31 19:50:13'),
(124, '57498F1399A0992D8F160ECC4EDFF3EE76323029B8C65DEB04339DB2DFF9CEAA', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 06:07:55'),
(125, '5275563FA13C5F0D6A1B6C31AA29F2F5D38C0F126FAD9044914EC8F670386083', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 06:13:23'),
(126, '4638297543FC033AFB404A47A4D6E0705A39A5484D25F2EA528F98976412DEC2', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 06:16:45'),
(127, 'F3B56231D24C65FC7591DC985F9C1CA70097692A3344B44C52D3B171F1B5F2A8', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 06:50:30'),
(128, 'E86000D57EDAD1F82E5C6F2AECB20949F9B7725F6D42FA31DAB4385A5DEA662E', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 06:54:08'),
(129, '316BD7E0F0887300DF7418ADD07D0B1523EAC3C9EE45B5158AD2AABCA597D4DE', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 06:58:07'),
(130, '3A8D86ABE5DC7C241B43A933D371B38B3DDCFFFCE39863A24C35CAD137C269FB', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:33:54'),
(131, '37C322623576525C5FB29BFEB2EFC0AD16422D4E665AAD29781E1D9A07029D86', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:34:28'),
(132, '8D95EBEC47BA17D3F7292D913CEFF9CF4C58F1DA092DD76F5E26F08B2FD73D71', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:36:06'),
(133, '70DC403234F18F226B044DBF8311EE6BA87D407EB879CD95B39F318BBDA8CDB4', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:37:39'),
(134, '489CBC7F38C4C1F2900299FC0A8B67B72DA3F2ABA693E948CDCBCCFC766D1423', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:47:46'),
(135, '95BF7FE3384C5A0461ADB1FA8ABDCB11663D8D0706D31D35E0932DB6F10BA0CC', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:50:29'),
(136, '5282D1B38DE6FB14DD23FECED8DE31BE0E3F215352470733778D178BDCDE5261', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:51:56'),
(137, '9F1BAF68AB2467622C0DC920EBB0B342CAD9A976D226538B0E1402489929C6BE', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 07:55:12'),
(138, '654AEBEE7E23ADAD58FF98B988F4C5AA60EF6C27BD6BDDEEA72FFAE466852174', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 08:06:07'),
(139, '181916629F1A29A5CFC26963BFA6229510898B512E7BAEDFCEB6531B01D14C67', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 08:09:05'),
(140, 'A76495B38338FB36D45B89C9EB9F7C2E0BB0CED15021828B199FF3129F1BB2DF', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 08:13:56'),
(141, '8BE9A6028F993FC69666F2D0002C9F29660C6D98BB106A18295D477AF6E1B97B', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-01 08:18:17'),
(142, '4DF6534594BBAA08B02B1674C178CE174E025DE06DA63061735C6F057F711726', '123456789', NULL, NULL, 0, '2019-04-02 03:03:19'),
(143, '3B163B692B7D331A5FB343A569E71CBE5A847BEFD96A29BC614E4E2E79626185', '2c7c7b3a1892876ee5dd2f2d84cef056', NULL, NULL, 1, '2019-04-02 03:04:24'),
(144, 'E4EE26D99DF7936D2BB7BFAD0E721C149DDBBF7664609232AD6F06B48D0F6263', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 05:59:40'),
(145, '4148A8AD7E5816A0E8049EAD99C4815AB04A74EEB327A34F05366E8C768B9723', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 06:12:44'),
(146, '4D2BACCE57D31ED191216170894947FA8B1A7FB20821DE3279DE7FBC74AC3C13', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 06:13:43'),
(147, '496BB190C828EC8BA2C53C942B931D64FFBED7332F89E65753A113CFA3255DF8', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 06:20:41'),
(148, 'D0EAB2CBB30EF5F9EE2E75599CFC528874AAF3CD42010FF968A9E4B142FDCD5E', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 06:49:03'),
(149, 'E6AA81DE20C5A49D3F3E786E25DF60AE1D4D1470FF7F27B4581F078688B095DF', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 06:57:45'),
(150, 'A1B26FC2679F422D9D176D498B31506EC04B917D3C4C1A8A132C71A691BF6856', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 07:02:09'),
(151, '563532652F055E19D954A0F84CD1CF0928C8FA18237D160890F9F0BC66FADF5B', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 07:21:00'),
(152, '29363CBE7399982B2C2E66A0A8334A3BB8BAC747284515ACA17D3B42E11E4246', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 07:23:16'),
(153, '993BC85C3F6CA5F9413A4D9F4DBD13039C7FD98AFA6CCF9DF45D8EB3777E669E', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 07:25:12'),
(154, '4F1C994961772C7FCC4CFE3D16BE23D110B3A501FEF80E59BDE02166F3926A91', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 07:26:04'),
(155, 'F83502423CCE108F71EDC072DB29F20622CB5EB9F791CC9F9AB507A8C620B919', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 07:27:48'),
(156, 'F96D050AC1869CF22A0C14D92598E2AB784A26BE352DED2244DA93C66E3B9091', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 07:36:00'),
(157, '01D18E5D69ACF9EF2EF61F52F68A497CBC9CEBD99282C627520120B0EDC1E1AF', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 12:57:23'),
(158, 'B36DBBEEBF91CDDC987D15919EBB4F95D90073531E996293B250C5367EEBD750', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-02 13:03:56'),
(159, '645594AA88014210A7E92E5762789A0C7950837978C817088CB32105372AC200', '123456789', NULL, NULL, 0, '2019-04-03 17:48:14'),
(160, '53C6939AEF44F8A96AE209BCFB12C7073AF46778980738E60731F4E959B5DA11', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-03 22:10:17'),
(161, 'D9E51F3574D8B9E01371125700A800291CC5672294FD1CB7910B37426B98999B', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-03 22:14:12'),
(162, '0DF1054A53F4E36C4F418E75665053A9DA7CE7365697AC7679554EDEBACFAD5E', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-03 22:18:41'),
(163, '2A67BEE81D0984A61EF9ED3BFB5ADF2A69206076089AB9FB850A498B5FB10F0B', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-03 22:20:27'),
(164, '298248015A12D0A104E1792D32D20A83AB5337C358F9E696196D94D4A46B1924', '123456789', NULL, NULL, 0, '2019-04-04 07:51:38'),
(165, 'AF7D46227B437839F668ACA28BE4A0EF26FF6450ABDA49C57D360A627D142A7C', '123456789', NULL, NULL, 0, '2019-04-04 08:00:04'),
(166, '6D0CE9A2B246394A7840D4A6F5DC9CA989E231003F3B2E7EE42872FE7AFE9952', '123456789', NULL, NULL, 0, '2019-04-04 08:28:43'),
(167, '5C1862434278DD84F83C5E86C298585FE9378B1F23208B220EC46C199B359C74', '123456789', NULL, NULL, 0, '2019-04-04 09:03:13'),
(168, '1F40EB151B24D7C0FED9DD2A1E04D3DB74BFFED073327E50D4E02E8723C6D1AC', '123456789', NULL, NULL, 0, '2019-04-04 09:06:08'),
(169, '77F310BF7096C4B31A89518F74726051EC70024BA01861CD0F36E98AAEC13E3C', '123456789', NULL, NULL, 0, '2019-04-04 09:28:29'),
(170, 'C2E2CF36AE6A416D99BDC3ED65B920055C2B001E692C08360BCC9203C6CFCE0F', '123456789', NULL, NULL, 0, '2019-04-04 10:29:22'),
(171, '60DB992E4B3A23BFD271DC9056153B3C73364762836B856321014941DF8DD195', '123456789', NULL, NULL, 0, '2019-04-04 10:30:24'),
(172, '756A4081F450C10A7097ED6F35964A9AFAF25F8680192E45D4550F4A7B192871', '123456789', NULL, NULL, 0, '2019-04-04 10:31:02'),
(173, 'CE41FEC4202603B136917CBE2460A2D9E6089B3663A164609A819021F100A5F8', '123456789', NULL, NULL, 0, '2019-04-04 10:34:56'),
(174, 'E50F1F1B0183F18DC532C0666FF1CA61CC253500F267B1306881C7FDB3B7DA0E', '123456789', NULL, NULL, 0, '2019-04-04 10:39:09'),
(175, '67481CFF907E63E184D6099D5F280DBAEF9FF79E2561D1EA9F2C76A44416F54A', '123456789', NULL, NULL, 0, '2019-04-04 10:42:02'),
(176, '3898F5E8C65AAC0D2FEF1F2B41B1BE2F67E35170EDB3EFE323589EAB7C4FBC74', '123456789', NULL, NULL, 0, '2019-04-04 10:46:50'),
(177, '91283B73F183F4DEE655C2DF2CA14819167441B4F6F457BE3CB65619B2962BC3', '123456789', NULL, NULL, 0, '2019-04-04 15:30:35'),
(178, '79AE84B81D52B84F2458513933B3AE7337C5D6E2315F117D3867532A9544345F', '123456789', NULL, NULL, 0, '2019-04-04 15:31:24'),
(179, '4A96BBC391A8614992060E396AB122D99D0102AB0C116B215676EC15B72BE011', '123456789', NULL, NULL, 0, '2019-04-04 15:36:40'),
(180, 'A1718F9ABB7D8C61E5366D4963892311C0696E726A774BD5BEEA876D538886D3', NULL, '49d5dd0e075cdf55903a4d075b417c0', '2', 1, '2019-04-04 17:44:34'),
(181, 'BC74191CA3B8AC6D820DD2E687CF80FD73BE190000570EC75C33BBFDCEBE9E70', '123456789', NULL, NULL, 0, '2019-04-04 17:48:47'),
(182, '73FC9E2F06B1F90904DE6CDE822D0A3FF433FAE7D7E0A8842089FFD006CA59BE', '123456789', NULL, NULL, 0, '2019-04-04 18:04:53'),
(183, '9B828189CEE8CAE2AE82BBD681A40D955A0C13C64E1115437CDD2B14A8382F40', '123456789', NULL, NULL, 0, '2019-04-04 18:05:37'),
(184, '4765B398241EC370EF161B78C0CB8D8C9E43E24D4B2025454C297BAE76F9D2B8', '123456789', NULL, NULL, 0, '2019-04-04 18:12:11'),
(185, 'D72C8031FD46FC195A7166AC88AF2716CF74E85FD287ECDABFEEA42E4F48F59C', '123456789', NULL, NULL, 0, '2019-04-04 18:20:04'),
(186, 'AD738B71499C34DD152798BCABEB48F28025386C5784FF5BA3A4B5795C4FD84E', '123456789', NULL, NULL, 0, '2019-04-04 18:21:47'),
(187, 'AC3B8D8017EF604055CBC6DC07A5A9782011C6394452DC8B5D94BA6F2A5A24B1', '123456789', NULL, NULL, 0, '2019-04-04 18:53:28'),
(188, '8AB3703372E02A6B20694F51FDAC3D0FDD56B6211285EF9BF7B06949590C9659', '123456789', NULL, NULL, 0, '2019-04-04 18:55:36'),
(189, '0085234517B671CBB677B10B8D961D830106D139E57993248C5BCC393CBC07CA', NULL, '233f5824263d3ac76952187cf3c8478e', '2', 0, '2019-04-04 19:01:57'),
(190, '8ACBCC65AE50136DD0E301C56D0FB9B07BB2BF2C504E48E4E09474A09221EC0E', '123456789', NULL, NULL, 0, '2019-04-04 19:03:36'),
(191, 'B21487DE381085CA2AB888D0EE7C9235229A55438D3CA78154EA0A66CF7B2BB4', '123456789', NULL, NULL, 0, '2019-04-04 19:04:57'),
(192, 'D0E8BB1655040D726240E05BA8D176602713872D29017F61B00E68CA81E9D77E', '123456789', NULL, NULL, 0, '2019-04-04 19:13:06'),
(193, 'DD737A9AE4F41ACB6072A99C92D61FC5417D9E70ACE6EAE327C73660BF0EB3E6', NULL, '233f5824263d3ac76952187cf3c8478e', '2', 0, '2019-04-04 19:32:40'),
(194, '1722E303BB9678AAAC2F65D4C29F8911DC21BF9DF36A9F2712FFBD5F7E82A9A3', '123456789', NULL, NULL, 0, '2019-04-04 19:37:07'),
(195, '90B8A352A09CC8BB0D62B7D47B3BD3CA9429F647A4F9055DF9487B6C1040BA1A', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-04 19:38:43'),
(196, '0E4A88B2C7A8AC9E9DA10684FD28D0DF84E85EF985F0E6BD4FDC8F70B7152EC3', '123456789', NULL, NULL, 0, '2019-04-04 19:39:06'),
(197, '55D9CF32A78D2B8F9FEEBF75666AD91CC52F389C2F55687AC4DD44B08730E004', NULL, '233f5824263d3ac76952187cf3c8478e', '2', 1, '2019-04-04 19:57:18'),
(198, 'B0DD52B736AAF474670BDA3219034337600D0C7A41E788504421A77B67E52D4A', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-04 20:29:17'),
(199, '65D05BC8532BF709B525CEC3C883BDFF3E70C21BF77FEE991AC89A9DE629D033', '123456789', NULL, NULL, 0, '2019-04-04 20:45:03'),
(200, 'AB4BF382D0B3E42A2BE6CE28DD428A85DAEF26362B1A9F98C9196C45EFA795A5', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-04 20:45:59'),
(201, '7BEC9A0E75BDF787F2D9AE01033B271104A5E9FC9548B51B40CCB3D2FC3F1F64', '123456789', NULL, NULL, 0, '2019-04-04 21:12:04'),
(202, '81D5E3566712DD7CCD0053EA769D882752B25C3A859B65A42CF4C920A4A9ADE0', '123456789', NULL, NULL, 0, '2019-04-04 21:13:17'),
(203, '90882920EB287AD310AE68EB12D1CEDACDE4B7403B9AC4A75E9700ADEDD7C495', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-04 21:13:51'),
(204, '76EBA44277B3FED8E2A5DD6CDE498D0E53BC61B291D70D4123CC8837EA85CC44', '123456789', NULL, NULL, 0, '2019-04-04 21:16:35'),
(205, '006F034C53EAAF61287DA848D269A66136E5FB17BB632E98A5FDFC97F219A892', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-04 21:17:20'),
(206, '13F73F9E25DFEB0C5814E3992D7FED37DEA99DC71012CA9AA60B508D662A821A', NULL, '170290ddde54fb1b663c012b3ced963a', '2', 0, '2019-04-04 21:24:20'),
(207, 'C338F2DCF5C32699F2545C519631D966F7D70E7CEFC957E5BF09E53E3835ABBD', NULL, '170290ddde54fb1b663c012b3ced963a', '2', 1, '2019-04-04 21:26:16'),
(208, '96BC5BE77671B3C017EB93C906C9323CA7A5394CA0FE9B318F880659D12F1FDE', '123456789', NULL, NULL, 0, '2019-04-04 21:39:13'),
(209, 'B333395936024A36247379C1D4C38D751288CC85CECF905EFEE3210A4036B36C', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-04 21:39:58'),
(210, 'B1BAC454F3F2ECBA2CC273B008FBBC083334CEA7AEB262C09FE742EDF425E6EC', NULL, '3eef59dbce464eec4aac4440de62e022', '2', 1, '2019-04-04 21:46:31'),
(211, 'EA344C5AA083FAE524B11FD58B39400541FE447E2E0EA73094E8BB2E09FA51FD', '1e570e8529deaadba8aaee0fb50e82eb', NULL, NULL, 1, '2019-04-04 22:01:29'),
(212, '3DBD2765B2A095102C119EB4FD2B3D13ED0DC8F9BB1DBEF8DB48C133B677D4C6', '123456789', NULL, NULL, 0, '2019-04-05 09:27:40'),
(213, 'E7FF645E1C67571943EEB3347B3B918BE52EC5A35EC44FB07C9F55406E1A971D', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-06 04:25:16'),
(214, '1B7572DD7BB3AA84B767DF92F5F21DACF8219C543116339F581ABDA81A4C74EC', '123456789', NULL, NULL, 0, '2019-04-06 08:09:15'),
(215, 'B21A4E29AEFE70CC28FEF4643BDD376619A5F36207C3089A28ED07777EB22F43', '123456789', NULL, NULL, 0, '2019-04-06 08:11:26'),
(216, 'FCE6FAE64020CF17D2B8F112C4B1EAA44FD6E1B3892DD283E03DF4D85701C8A4', '123456789', NULL, NULL, 0, '2019-04-06 08:16:10'),
(217, '5ADB13E23EAACA0D4A88EB6D0819C57A7BA1E09AB9B0E87EE056623F3AE49B77', '123456789', NULL, NULL, 0, '2019-04-06 08:17:40'),
(218, 'DD927D63013DAFB9B91FCA8124861D757BFB66A8AD0AA20C59A7ADE2045E4ACF', '123456789', NULL, NULL, 0, '2019-04-06 08:18:41'),
(219, '835A311D180D596590231623563322661C383934A02F4D73A9A94384C32C5B4D', '123456789', NULL, NULL, 0, '2019-04-06 08:20:44'),
(220, 'A8EBB952D717DD6F16C1913F9A15E9BD0FA24EF3C69B85AAAA2E8DA9EA928868', '123456789', NULL, NULL, 0, '2019-04-06 08:21:17'),
(221, '729DECD7A79542973AEA4E196D94E0CE0E04BC7CF5D52DAB413A37E3D26462F7', '123456789', NULL, NULL, 0, '2019-04-06 08:22:40'),
(222, '9C14AB4147FA5455158C6E12FB005AE95ED6B7D8D871787C6CFCA50A692C7BBD', '123456789', NULL, NULL, 0, '2019-04-06 09:21:00'),
(223, '936872FB6DD9E99DEF41BEA0361B508780DEBFE4279F366EDCFB625593681E1E', '123456789', NULL, NULL, 0, '2019-04-06 09:33:14'),
(224, '8C6958BC085F159FDCD2C4D722B7F2A2C08C40E0763BE639ACB9CE98D0FA5790', '123456789', NULL, NULL, 0, '2019-04-06 09:35:28'),
(225, 'C09A2192491446B552B587BF97EDA6507A71EEFAE09FB2ED348B21A75212BC35', '123456789', NULL, NULL, 0, '2019-04-06 10:19:07'),
(226, '7BC06DE799910534CE35991C1C586F47C7CC1B0410E03EE08857FD418D847C4C', '123456789', NULL, NULL, 0, '2019-04-06 17:08:27'),
(227, 'B689EC17ACBA308EC36B92330D0FF64BBF126DBFEF3696392AB18AA8FCF4A0FA', '123456789', NULL, NULL, 0, '2019-04-07 07:57:42'),
(228, 'CA7F9040A52A4484EF8E7D3145A8B4B5A381B4EEA9E1D006859C7FADB1CC4B85', '123456789', NULL, NULL, 0, '2019-04-07 07:59:32'),
(229, '993FC2222A767714DB90BE84F1726CC4E17B5D320769B26C58C176ADA0BA422A', '123456789', NULL, NULL, 0, '2019-04-07 08:00:42'),
(230, '27E8A4B858D5C2B0C6BE748C77E5C398E0582756A6D9BFA1C6EC7C45BF8263E8', '123456789', NULL, NULL, 0, '2019-04-07 08:05:14'),
(231, 'B5474CB9AEF7B0D18D4F1AE40E4F42C2AE14C5766D8B477ACB4CF07B32FC6661', '123456789', NULL, NULL, 0, '2019-04-07 08:13:43'),
(232, 'A81CF331D09ECD7F1AF278C896A9E86F994619126E000700CED2D9775EE07771', '123456789', NULL, NULL, 0, '2019-04-07 08:16:55'),
(233, 'C7D618B002F8A64EFAB6E444E2F81D9867EC96552FA845E171580F7A2DCF1073', '123456789', NULL, NULL, 0, '2019-04-07 09:03:39'),
(234, 'DBB24D9ED953B1FA337EFA64BBA877CEB94271719B7E4A537101D176413424EE', '123456789', NULL, NULL, 0, '2019-04-07 09:18:38'),
(235, '17FB6FFF3DCE91F2E43985B4233E25EE470F17432FA93FB84909A1A9A123DCB6', '123456789', NULL, NULL, 0, '2019-04-07 09:19:48'),
(236, '480BD4E9BCB118034273CB1975D2354E68F12DE4B799B322D4D4BDB116FDE1EE', '123456789', NULL, NULL, 0, '2019-04-07 09:20:48'),
(237, 'BF8EDEF6C5B7AB1D1B5FCFFF86EB62DB01280D7E2192E817AB838A51B06B4E4A', '123456789', NULL, NULL, 0, '2019-04-07 09:22:27'),
(238, '587FC30BDA75E6F8569EBE55F01CA1B06CBAC3E9E65220F10FFE8700A925E8F5', '123456789', NULL, NULL, 0, '2019-04-07 09:24:55'),
(239, 'DDA2ED0A18611D44F17E901C3B5D4E064942530D056A70503959F3865AD3BDB7', '123456789', NULL, NULL, 0, '2019-04-07 09:44:55'),
(240, '55E0C9334018672EE529513A16E4A10B84D6131AF2A322E0B099FE2F195EA1C4', '123456789', NULL, NULL, 0, '2019-04-07 09:49:17'),
(241, '5DE1B377FDDFF3D88DBBE79B146622B64528DFFF426CC8B8502ABC490784C429', '123456789', NULL, NULL, 0, '2019-04-07 10:03:45'),
(242, '8DDC8E4FBB06C42FB7A6592052B12F1F6DB0858BB9F866042CEB7D188E98BBDB', '123456789', NULL, NULL, 0, '2019-04-07 11:08:24'),
(243, 'B065557A886C24C97E6003EFCEBF14C33EE95668ABD6D478C65A0E2D627E974A', '123456789', NULL, NULL, 0, '2019-04-07 11:09:29'),
(244, 'BA69E769A7BF8D2AF43EE89704961B867647C4657756909AFE4197FC1098EAEB', '123456789', NULL, NULL, 0, '2019-04-07 11:10:38'),
(245, '52557D6A5491AD737A3E58491F3CB742792221E79E5DEFC26D33DF3A0D10E453', '123456789', NULL, NULL, 0, '2019-04-07 16:09:26'),
(246, '0E83980E9BBD568A80D1B4651726ACE0E731CC8197669CFB0174BDABBC992F69', '123456789', NULL, NULL, 0, '2019-04-08 09:22:00'),
(247, '0843837500191A1A908566937E1BEE006754E2407589ED0D209C33270EEA9FB4', '123456789', NULL, NULL, 0, '2019-04-08 09:23:42'),
(248, 'EE9672C74430F4B0494415AAC600FC06ECE426069587653779549AC1713491EB', '123456789', NULL, NULL, 0, '2019-04-08 12:02:42'),
(249, 'A26BCAB28DF25F0250F6EEFF6D10EE696288FD0E192F65AE45D1F0D07E9556F9', '123456789', NULL, NULL, 0, '2019-04-08 12:13:44'),
(250, '247FF198C828E67B1DFD85A1BD51ED15D88AD9FB4157F4B46B2F6AAE07DBFF84', '123456789', NULL, NULL, 0, '2019-04-08 12:15:13'),
(251, 'BFEA0FD0A4F86276BDBA742E2CB1CD502CDDAE1B42D1C75DF392D5C0C44C5272', '123456789', NULL, NULL, 0, '2019-04-08 12:16:02'),
(252, '798C96731C4F14EC9D1967F96444EA80AB68FF051A947A4C4C0B141F28D75718', '123456789', NULL, NULL, 0, '2019-04-08 12:17:52'),
(253, 'F94B50FD8262947C58309B92ACD30057232463F9EC879E7762E7003C9C233F5B', '123456789', NULL, NULL, 0, '2019-04-08 13:05:24'),
(254, 'D3BA7AF203B3ED0EFAA3670B7A5A68EC5B1FC7E4C094C3DEDD6F9DA66CA2BDE4', '123456789', NULL, NULL, 0, '2019-04-08 13:08:49'),
(255, 'ED2630CAD2E4D86CFCCDAB2AC03A92BB97E42F05B48417753215BD542B41AEE1', '123456789', NULL, NULL, 0, '2019-04-08 13:59:25'),
(256, '9A76D30A2D95B8410E8F4B4EA8B85838129879D8260C0C66CA94E957382DB501', '123456789', NULL, NULL, 0, '2019-04-08 18:07:34'),
(257, '08AA6BF80AC2BF6CCC4BE9E9DC2B221C5F65B3C7E6D1C11351F4C4E7E6A72638', '123456789', NULL, NULL, 0, '2019-04-08 18:09:24'),
(258, 'ABAA4FA6008A03CB9D2E0A8399CF67BD876D3858E746B39822271E1275682CCD', '123456789', NULL, NULL, 0, '2019-04-08 18:15:23'),
(259, '3BC664B7876813E27291AD66750304D620D274CEF767165781994B6C84D05790', '123456789', NULL, NULL, 0, '2019-04-08 18:15:32'),
(260, 'FFA8C7B845C970084B119FBD7F46858C2AB255234749E813AF54C559DEF56221', '123456789', NULL, NULL, 0, '2019-04-08 18:30:11'),
(261, '50E2C25097A9E155EBCD70BCDDB38BEBF2DA7AC54EAA22CF406C510A6DB266E5', '123456789', NULL, NULL, 0, '2019-04-08 18:30:53'),
(262, '243A84D160944C6B44AB0963EFBA9B3349DE636EE0D79229208E460AB5E13CFA', '123456789', NULL, NULL, 0, '2019-04-08 18:32:53'),
(263, 'F81F0F4B2359862D99F84267C3812E6161B199C7A129B5B38128F0C747960575', '123456789', NULL, NULL, 0, '2019-04-08 18:34:43'),
(264, '5EB6082D899E01D2951E72E49A57B9B297B4270332A1AA13137B500A76C19369', '123456789', NULL, NULL, 0, '2019-04-08 18:35:46'),
(265, 'C0CFEB3ED3CD0C3673CE7A2CA6EA4B31B941E4E21F20B5B8994291CB7F773FB1', '123456789', NULL, NULL, 0, '2019-04-08 18:41:26'),
(266, 'B3ED2EBA3ED5D1E16FFAEFC602FF10AD401C384975DA9CE88D5A5B141C21E31D', '123456789', NULL, NULL, 0, '2019-04-08 18:43:44'),
(267, 'DF013B5E8C2E289A198EE8D8F30BE73BD88DBAE4AACFF590F212BC7097CEC92C', '123456789', NULL, NULL, 0, '2019-04-08 18:45:20'),
(268, '9302198CFCFB948688C760B3EF910CF31C8C91D4F055A94B0FB7D37A6FF4BF11', '123456789', NULL, NULL, 0, '2019-04-08 18:47:26'),
(269, '334619182475B8C4E260FEEC7FC7D0F880E5D0EB6B020808DA8FF0251CB4F394', '123456789', NULL, NULL, 0, '2019-04-08 18:48:35'),
(270, '28E76CB57B6548CEEC41D2285FAF34677ED97711EB98A0157614D82E3B91200D', '123456789', NULL, NULL, 0, '2019-04-08 19:06:27'),
(271, '50C8085ABD0C7DA02BCA30E190254564EA38CCCA1207A67B7694EF82F3E9800F', '123456789', NULL, NULL, 0, '2019-04-08 19:12:47'),
(272, '20018A2F4348EC2099C86DEC367643716A96FD492B62AE9CD606E37AF2B8A034', '123456789', NULL, NULL, 0, '2019-04-08 19:14:55'),
(273, 'C30CD8D519415EEDB31A45D80BCD22AEC6E0297F508A7EA042DE9AEDEA3DCACF', '123456789', NULL, NULL, 0, '2019-04-08 19:16:10'),
(274, 'CF1958C2ACDE00E0928652254558B4905460D1838574E3F9410A958CAA63109E', '123456789', NULL, NULL, 0, '2019-04-08 19:17:11'),
(275, 'EB70C32F020BB9FA610E98C761C573B2A9345454B218BCD490EF5856AD292FF8', '123456789', NULL, NULL, 0, '2019-04-08 19:18:46'),
(276, 'A91E17FAC4F226E5560A925C22DA74093872AEE71B1B39FBC89A97E200EEE2C6', '123456789', NULL, NULL, 0, '2019-04-08 19:19:36'),
(277, '15BC83AD6758B2016572AFE390D92C02AC91FEBC321E4CA7F9C2759B5F0CD12B', '123456789', NULL, NULL, 0, '2019-04-08 19:20:29'),
(278, 'BBA6DE0565EF49D7B1A5A0C061318766924B60F01BE44D20A0C8A2A842089AC2', '123456789', NULL, NULL, 0, '2019-04-08 19:21:21'),
(279, '2A256E300C177BA2C8DB2FACBEB024BEFE30DF152CA5CBF13813AA179C531048', '123456789', NULL, NULL, 0, '2019-04-08 19:21:58'),
(280, 'E45D49C26DFB49CA5383E46099512A31F8508D2B2D705407970589E3F5EE9EE4', '123456789', NULL, NULL, 0, '2019-04-09 01:08:47'),
(281, 'C677C01732DF37209628461F9DEC73D7FAB1B4974FC2244DD175A05C21CD3F0E', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-09 01:10:24'),
(282, 'D742D9D747982AA5C0E3D1BDF24F55B59437DCC163351F8C420AA413056A0E8B', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-09 01:28:48'),
(283, 'B8EA47BCE0CCB4CBB1CD6969F7555FB8132AFCC5330C99239AD1C4C6DD07B0B7', '123456789', NULL, NULL, 0, '2019-04-09 03:15:30'),
(284, '009A78839C3BB600F433F3592896F1D278B81E08E8EB2ACF5CB5FA3C940A54CA', '123456789', NULL, NULL, 0, '2019-04-09 03:18:19'),
(285, 'B7471967888A1BB16CB89EBF5499C38AF947D9DDBCCC354F2D2B1C11020DD407', '123456789', NULL, NULL, 0, '2019-04-09 03:20:09'),
(286, 'FCC00308000E057345E162D2F1C5F804F4C14688C93803E098A706E0762324CB', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-09 03:21:20'),
(287, '260943C7544DAD4CAD1A12CB7B015D3B2A7AC805C008B0311898010426E139DD', '123456789', NULL, NULL, 0, '2019-04-09 03:22:04'),
(288, '030BD2A0F4A7F95F1AB0435312CD21A0DCA309ADA030B5448A0C0FD5266F7480', '123456789', NULL, NULL, 0, '2019-04-09 03:25:16'),
(289, '537F7233E42C8E19771D79A44F93F0B277268031128461BFE1D581C10E1E9497', '123456789', NULL, NULL, 0, '2019-04-09 03:27:19'),
(290, '25E443E0432A2AE1F0E4A1E27AB316A59DBA9BE93ACB7721BD5C38089FA56E99', '123456789', NULL, NULL, 0, '2019-04-09 03:28:02'),
(291, '04CD4D69CE424C675D1F5F7BE651AAF707B7CE93D50B8195BD6446FEDDE518AB', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 0, '2019-04-09 03:30:04'),
(292, '88F480E1D5640D731C9018143FFA58BAD781F4B743958EE3C06076F7646AB7CB', '123456789', NULL, NULL, 0, '2019-04-09 03:35:49'),
(293, 'A146BD457CD1E8C21EFD5643CE80F56191738CD171ED5CE6E7652D887B5015B7', 'bc7ba742be2c911a041daa273d805c82', NULL, NULL, 1, '2019-04-09 03:37:04'),
(294, '06FFD0DFC35D3DFE9CC49E86729FF6B19C0B159062E76E234D679BD95F37A197', '123456789', NULL, NULL, 0, '2019-04-09 03:48:06'),
(295, '73DA5819C3E9EB244E336902AF0D9D92A373C2F5F0F4EC7FDEBDB7503DA6A00D', '123456789', NULL, NULL, 0, '2019-04-09 03:48:33'),
(296, '16F840DD38C72FEA4E00D25693D75C13EE7FDEF4A766EBB03780A86E03D3ADE7', '123456789', NULL, NULL, 0, '2019-04-09 04:19:26'),
(297, '6E283D8A07B25F3130C07380610D09C776F2F38A911B9C3284DA627BEDD348D0', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 04:30:47'),
(298, '6E9FB30DBB76D337F24119F3DBC0AB841157E2F2350B0183A2A674E1D1C409D0', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 05:06:51'),
(299, '11AC413C95F1641B5ABEA739180329B4AA0FD8BA5CAA87F78BDF3D4A68012924', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 05:40:15'),
(300, '13D5C47B0CD9E8EEFE701193F5DF382C170A4ACB842A4C1CFB13127C5CD9A809', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 05:41:28'),
(301, 'BAA27E0F0B384A4B7D90D773FEACB3AE275CFE33443A38145AB40DE6EBC44A50', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 05:42:16'),
(302, 'AAAFE0CA4C06519B60F9A8AB96FD7642DAD1F9F0DA7ED773D133908B14255C53', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 05:48:39'),
(303, 'E8B821955993C3D98AC4FEB96680FCC9F3C82965E427CEDF0AB43F36C1E1AF61', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 05:50:15'),
(304, '62154EB048FC9F1AAA2996CA0706907FE78AFAB793DB0EA4B396DB9123F17113', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 0, '2019-04-09 05:54:08'),
(305, '05CE7B273D132B7A266F31AFAF015C5C536D8C0B396C77E0D0C59A8518557B40', NULL, 'c371cb388cad4237f9f2b4f027c05d1f', '3', 1, '2019-04-09 05:54:42'),
(306, '1219BC3DEFE80B6D2F143C58CA665DC020E8029DF40A9BCF93CCAF7819D6CA9C', '123456789', NULL, NULL, 0, '2019-04-09 08:51:28'),
(307, 'C61660DD5E9EF384A44D8DA94F49C692A37C7046A9EE41A5D9CE483977179F75', '123456789', NULL, NULL, 0, '2019-04-09 09:10:02'),
(308, '96C90863838D7134C9ADA6B333B2039C783B455839E615177725DB938DF5C071', '123456789', NULL, NULL, 0, '2019-04-09 09:11:03'),
(309, '73746E5F25EC6CAF2C8102393CFE0B6FD2D58F664AADBC5A06A905A958C70B7A', '123456789', NULL, NULL, 0, '2019-04-09 09:11:03'),
(310, 'A924B87CA0F376732F1412754C997ED6BD3DF6239548A236F2363E10131A4BB6', '123456789', NULL, NULL, 0, '2019-04-09 09:15:28'),
(311, '20557B02D7E764A71191D217BC902B90D0CBA0C64F8BBEE60DE6D7696A30A875', '123456789', NULL, NULL, 0, '2019-04-09 09:15:28'),
(312, '2F4C153A288943FE8A88081C5D68A0A4B45AFBA461A5C6610780289055798FF8', '123456789', NULL, NULL, 0, '2019-04-09 09:23:08'),
(313, '7D2A40F93AC84E896C4E68BB8D2E4D2CB6DEA920A287803CAD0EA42DD70BF306', '123456789', NULL, NULL, 0, '2019-04-09 09:23:08'),
(314, '5FEE813967D0BE551817301468821B9BB94C7C6109C2CF139CB86A0A02B056DE', '123456789', NULL, NULL, 1, '2019-04-09 09:25:10');

-- --------------------------------------------------------

--
-- Table structure for table `transactions_bdm`
--

CREATE TABLE `transactions_bdm` (
  `id_trans` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type_trans` int(11) NOT NULL,
  `date_trans` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name_trans` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `desc_trans` varchar(200) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `status_trans` int(11) NOT NULL DEFAULT '1',
  `comprovante_trans` varchar(10) NOT NULL,
  `id_trans_estorno` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions_bdm`
--

INSERT INTO `transactions_bdm` (`id_trans`, `type_trans`, `date_trans`, `name_trans`, `desc_trans`, `status_trans`, `comprovante_trans`, `id_trans_estorno`) VALUES
('138f13b577fa942d1192b3bec0926476', 1, '2019-04-04 21:47:42', 'jj', 'jj', 1, '64M43P85X0', NULL),
('2172a6934d05d3b87c58da41f83ce408', 5, '2019-04-03 17:52:02', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, '4X1TVI75L1', NULL),
('3012f95521659f845ca7249bc6a82bb5', 2, '2019-04-04 19:59:27', 'Pagamento de boleto', 'Boleto: 81650000000-4 77433659201-9 90628469103-5 41035993516-1', 2, 'YIQVM1FTX9', NULL),
('3ed0aecdc6af065f2f092fa7d8d4ee98', 5, '2019-04-04 21:20:58', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, 'CG6JEHL7T3', NULL),
('44d9d3f551b4e988dc4e852a878b45ad', 2, '2019-04-04 21:51:56', 'Pagamento de boleto', 'Boleto: 81650000000-4 77433659201-9 90628469103-5 41035993516-1', 1, 'KHXYX74134', NULL),
('4570f20793266421f080e057358abc56', 1, '2019-04-04 19:33:55', 'user', 'user', 1, '2SPH3TZXS9', NULL),
('4f9dac2d3eccee629b18f98303910abb', 5, '2019-03-24 16:58:39', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, 'ANEE344GAL', NULL),
('58940dd4abb077ed23a651316688da24', 5, '2019-03-24 17:42:01', 'Mais testes', 'Mais testes', 1, 'OH8MR35IXV', NULL),
('61fb046f6930cbd83493c66fb107fb69', 5, '2019-03-24 16:51:18', 'teste', 'teste', 1, '9CFICVMT3H', NULL),
('65a89380bc98d8a57d3879f90eab46df', 5, '2019-04-04 19:05:36', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, '2P1NJ8AFIP', NULL),
('67289576b983a9dcae1977e36de800bd', 5, '2019-04-09 03:27:45', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, 'MCYXZAHZHO', NULL),
('6ec34e93779fa9dd58dcf19388a272e0', 5, '2019-03-24 18:08:30', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, '18IYDMPOXX', NULL),
('82c92eb2f8e1657589cf919437dd13fa', 5, '2019-03-24 16:30:05', 'Teste de OP', 'Teste de OP', 1, '8X7SG6MSWD', NULL),
('a33e969a525c25b479b7c9e694c6a434', 5, '2019-04-08 19:06:52', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, 'QDXFGSVTYG', NULL),
('b35020948cb8866de1765c095aa188f6', 1, '2019-04-04 21:27:13', 'augusto', 'augusto', 1, 'YB1CYP0CC2', NULL),
('c6e6a5dc6023b4135be4b01f01e8a930', 2, '2019-03-24 21:39:01', 'Pagamento de boleto', 'Boleto: 84630000003-7 32290296201-6 90205038000-2 00233488706-0', 2, '19BHWZ0VTG', NULL),
('c794222ba275a381e58465c906cd87b0', 5, '2019-04-04 21:45:18', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, 'DICXVZ5X84', NULL),
('c838d67744ba89f23882b2a3052dacaa', 2, '2019-03-24 17:56:50', 'Pagamento de boleto', 'Boleto: 81650000000-4 77433659201-9 90628469103-5 41035993516-1', 1, '0ORTQHCP2B', NULL),
('c84beb7cc8d4f51fa3a08e4043f6aa4e', 2, '2019-03-24 18:11:16', 'Pagamento de boleto', 'Boleto: 84630000003-7 32290296201-6 90205038000-2 00233488706-0', 1, 'DQB9WUL1FG', NULL),
('d4a5b06d35f758362a14e0476f60731a', 5, '2019-04-08 19:21:38', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, '2754J85F6N', NULL),
('d89ffd78d6c94d96ef4d7e81b4ac4751', 5, '2019-04-08 19:19:06', 'Deposito em Conta BDM', 'Deposito em Conta BDM', 1, 'DS5231WQNQ', NULL),
('da57b3eb955381b345010328854a34e6', 1, '2019-04-04 21:29:13', 'augusto', 'augusto', 1, 'R3C5H7CI7H', NULL),
('e7a170a1f9b8324903e72610784077df', 5, '2019-03-24 21:28:25', 'Just some changes', 'Just some changes', -1, 'TBDFGRYLY0', NULL),
('e8da450d63e2a4f4db3b89944529b4a8', 8, '2019-03-24 21:30:26', 'Estorno: Just some changes', 'Just some changes', 1, 'RHXHWN7VHA', 'e7a170a1f9b8324903e72610784077df');

-- --------------------------------------------------------

--
-- Table structure for table `transactions_lines`
--

CREATE TABLE `transactions_lines` (
  `id_line` int(11) NOT NULL,
  `id_trans` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `credit_line` double DEFAULT '0',
  `debit_line` double DEFAULT '0',
  `status_line` int(11) NOT NULL DEFAULT '1',
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions_lines`
--

INSERT INTO `transactions_lines` (`id_line`, `id_trans`, `credit_line`, `debit_line`, `status_line`, `id_acbknt`) VALUES
(1, '82c92eb2f8e1657589cf919437dd13fa', 199, 0, 0, '449016bee8f865645cfc65573fc5ed4'),
(2, '61fb046f6930cbd83493c66fb107fb69', 1000, 0, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(3, '4f9dac2d3eccee629b18f98303910abb', 721, 0, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(4, '58940dd4abb077ed23a651316688da24', 10000, 0, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(5, 'c838d67744ba89f23882b2a3052dacaa', 0, 7743, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(6, '6ec34e93779fa9dd58dcf19388a272e0', 100000, 0, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(7, 'c84beb7cc8d4f51fa3a08e4043f6aa4e', 0, 33229, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(8, 'e7a170a1f9b8324903e72610784077df', 10000, 0, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(9, 'e8da450d63e2a4f4db3b89944529b4a8', 0, 10000, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(10, 'c6e6a5dc6023b4135be4b01f01e8a930', 0, 33229, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(11, '2172a6934d05d3b87c58da41f83ce408', 1000, 0, 0, 'c371cb388cad4237f9f2b4f027c05d1f'),
(12, '65a89380bc98d8a57d3879f90eab46df', 100000, 0, 0, '233f5824263d3ac76952187cf3c8478e'),
(13, '4570f20793266421f080e057358abc56', 20000, 0, 0, '53e88ee663ece785f2a63bb7b75ae42b'),
(14, '4570f20793266421f080e057358abc56', 0, 20000, 0, '233f5824263d3ac76952187cf3c8478e'),
(15, '3012f95521659f845ca7249bc6a82bb5', 0, 7743, 0, '233f5824263d3ac76952187cf3c8478e'),
(16, '3ed0aecdc6af065f2f092fa7d8d4ee98', 100000, 0, 0, '170290ddde54fb1b663c012b3ced963a'),
(17, 'b35020948cb8866de1765c095aa188f6', 10, 0, 0, '233f5824263d3ac76952187cf3c8478e'),
(18, 'b35020948cb8866de1765c095aa188f6', 0, 10, 0, '170290ddde54fb1b663c012b3ced963a'),
(19, 'da57b3eb955381b345010328854a34e6', 10, 0, 0, '233f5824263d3ac76952187cf3c8478e'),
(20, 'da57b3eb955381b345010328854a34e6', 0, 10, 0, '170290ddde54fb1b663c012b3ced963a'),
(21, 'c794222ba275a381e58465c906cd87b0', 100000, 0, 0, '3eef59dbce464eec4aac4440de62e022'),
(22, '138f13b577fa942d1192b3bec0926476', 10, 0, 0, '176e422a638dd3dd63668ec3dd586d8c'),
(23, '138f13b577fa942d1192b3bec0926476', 0, 10, 0, '3eef59dbce464eec4aac4440de62e022'),
(24, '44d9d3f551b4e988dc4e852a878b45ad', 0, 7743, 0, '3eef59dbce464eec4aac4440de62e022'),
(25, 'a33e969a525c25b479b7c9e694c6a434', 10000, 0, 0, '3d5492abf084d1fee2f968072639426a'),
(26, 'd89ffd78d6c94d96ef4d7e81b4ac4751', 1000, 0, 0, '3d5492abf084d1fee2f968072639426a'),
(27, 'd4a5b06d35f758362a14e0476f60731a', 500, 0, 0, '3d5492abf084d1fee2f968072639426a'),
(28, '67289576b983a9dcae1977e36de800bd', 12000, 0, 0, '91e82979927ebe82d5d8d64bc14f1144');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id_tf` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_rem` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_dest` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `title_tf` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `desc_tf` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `valor_tf` double DEFAULT NULL,
  `date_tf` datetime NOT NULL,
  `status_tf` int(11) NOT NULL DEFAULT '1',
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`id_tf`, `id_acbknt_rem`, `id_acbknt_dest`, `title_tf`, `desc_tf`, `valor_tf`, `date_tf`, `status_tf`, `id_trans`) VALUES
('45b49728e561b1ca56b5337cad2dbb45', '170290ddde54fb1b663c012b3ced963a', '233f5824263d3ac76952187cf3c8478e', 'augusto', 'paga', 10, '2019-04-04 18:29:15', 1, 'da57b3eb955381b345010328854a34e6'),
('54e9a5f3f2330d7abfd7a31295e98a82', '170290ddde54fb1b663c012b3ced963a', '233f5824263d3ac76952187cf3c8478e', 'augusto', 'paga', 10, '2019-04-04 18:27:17', 1, 'b35020948cb8866de1765c095aa188f6'),
('5e9b5ae294a196dfad13c80012398ca4', '3eef59dbce464eec4aac4440de62e022', '176e422a638dd3dd63668ec3dd586d8c', 'jj', 'paga', 10, '2019-04-04 18:47:46', 1, '138f13b577fa942d1192b3bec0926476'),
('beebce6bfcc58aca61724ec74c7fe70b', '233f5824263d3ac76952187cf3c8478e', '53e88ee663ece785f2a63bb7b75ae42b', 'user', 'louco', 20000, '2019-04-04 16:33:57', 1, '4570f20793266421f080e057358abc56');

-- --------------------------------------------------------

--
-- Table structure for table `try_access`
--

CREATE TABLE `try_access` (
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_device` int(11) NOT NULL,
  `date_try` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `location_try` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_devices`
--

CREATE TABLE `user_devices` (
  `id_d` int(11) NOT NULL,
  `mac_adress_d` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fcm_token_d` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_d` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_devices`
--

INSERT INTO `user_devices` (`id_d`, `mac_adress_d`, `id_acbknt`, `fcm_token_d`, `status_d`) VALUES
(1, '90:b6:86:cd:bf:f0', NULL, NULL, 1),
(2, '28:83:35:59:e5:f5', NULL, NULL, 1),
(3, 'e0:2c:b2:fb:8c:9f', 'c371cb388cad4237f9f2b4f027c05d1f', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_has_device`
--

CREATE TABLE `user_has_device` (
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_device` int(11) NOT NULL,
  `status_uh` int(11) NOT NULL,
  `data_uh` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_has_device`
--

INSERT INTO `user_has_device` (`id_acbknt`, `id_device`, `status_uh`, `data_uh`) VALUES
('170290ddde54fb1b663c012b3ced963a', 2, 1, '2019-04-04 21:24:20'),
('233f5824263d3ac76952187cf3c8478e', 2, 1, '2019-04-04 19:01:57'),
('3eef59dbce464eec4aac4440de62e022', 2, 1, '2019-04-04 21:46:31'),
('49d5dd0e075cdf55903a4d075b417c0', 2, 1, '2019-04-04 17:44:34'),
('c371cb388cad4237f9f2b4f027c05d1f', 1, 1, '2019-03-24 17:33:54'),
('c371cb388cad4237f9f2b4f027c05d1f', 2, 1, '2019-03-24 16:45:16'),
('c371cb388cad4237f9f2b4f027c05d1f', 3, 1, '2019-03-25 11:55:43');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_has_client`
--

CREATE TABLE `vendor_has_client` (
  `id_vc` int(11) NOT NULL,
  `id_acbknt_client` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_vendor` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `consumed_vc` int(11) NOT NULL DEFAULT '0',
  `type_acc_vc` int(11) NOT NULL,
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `cpf_admin_UNIQUE` (`cpf_admin`),
  ADD UNIQUE KEY `email_admin_UNIQUE` (`email_admin`);

--
-- Indexes for table `boletos`
--
ALTER TABLE `boletos`
  ADD PRIMARY KEY (`id_bol`),
  ADD KEY `id_acbknt_boleto_idx` (`id_acbknt`),
  ADD KEY `id_trans_boleto_idx` (`id_trans`),
  ADD KEY `fk_id_admin_bol` (`id_admin`),
  ADD KEY `fk_id_admin_pagamento_bol` (`id_admin_pagamento`),
  ADD KEY `id_cnab_idx` (`id_cnab`);

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`id_card`);

--
-- Indexes for table `card_account_transfer`
--
ALTER TABLE `card_account_transfer`
  ADD PRIMARY KEY (`id_card_transfer`),
  ADD KEY `fk_card_account_transfer_card_wallet1_idx` (`id_card_wallet`),
  ADD KEY `fk_card_account_transfer_transactions_bdm1_idx` (`id_trans`),
  ADD KEY `fk_card_account_transfer_set_account1_idx` (`id_acbknt`);

--
-- Indexes for table `card_contracts`
--
ALTER TABLE `card_contracts`
  ADD PRIMARY KEY (`id_contract`),
  ADD KEY `fk_card_contracts_card_proposal1_idx` (`id_card_proposal`),
  ADD KEY `fk_card_contracts_card1_idx` (`id_card`),
  ADD KEY `fk_card_contracts_data_client1_idx` (`id_dcc`);

--
-- Indexes for table `card_proposal`
--
ALTER TABLE `card_proposal`
  ADD PRIMARY KEY (`id_card_proposal`),
  ADD KEY `fk_card_proposal_card1_idx` (`id_card`),
  ADD KEY `fk_card_proposal_data_client1_idx` (`id_dcc`);

--
-- Indexes for table `card_wallet`
--
ALTER TABLE `card_wallet`
  ADD PRIMARY KEY (`id_card_wallet`),
  ADD KEY `fk_card_wallet_card_contracts1_idx` (`id_contract`);

--
-- Indexes for table `client_password_change_token`
--
ALTER TABLE `client_password_change_token`
  ADD PRIMARY KEY (`id_token`),
  ADD KEY `fk_client_password_change_token_data_client1_idx` (`id_dcc`);

--
-- Indexes for table `cnab_file`
--
ALTER TABLE `cnab_file`
  ADD PRIMARY KEY (`id_cnab`);

--
-- Indexes for table `ConfigAccountServices`
--
ALTER TABLE `ConfigAccountServices`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `data_client`
--
ALTER TABLE `data_client`
  ADD PRIMARY KEY (`id_dcc`),
  ADD UNIQUE KEY `cpf_dcc` (`cpf_dcc`),
  ADD UNIQUE KEY `email_dcc` (`email_dcc`),
  ADD UNIQUE KEY `profile_pic_dcc` (`profile_pic_dcc`),
  ADD UNIQUE KEY `id_acbknt` (`id_acbknt`),
  ADD KEY `FK_ACC_DATA_idx` (`id_acbknt`);

--
-- Indexes for table `deposito`
--
ALTER TABLE `deposito`
  ADD PRIMARY KEY (`id_dep`),
  ADD KEY `fk_idacc_dest_dep_idx` (`id_acbknt_dest`),
  ADD KEY `fk_id_trans_dep_idx` (`id_trans`),
  ADD KEY `fk_id_admin_dep_idx` (`id_admin`);

--
-- Indexes for table `digital_certificate`
--
ALTER TABLE `digital_certificate`
  ADD PRIMARY KEY (`id_certificate`),
  ADD KEY `fk_digital_certificate_set_account1_idx` (`id_acbknt`);

--
-- Indexes for table `feriados`
--
ALTER TABLE `feriados`
  ADD PRIMARY KEY (`mes`,`dia`,`local`);

--
-- Indexes for table `integrations`
--
ALTER TABLE `integrations`
  ADD PRIMARY KEY (`id_integration`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`hash_log`),
  ADD KEY `code_lc_log_idx` (`code_lc`),
  ADD KEY `id_admin_log_idx` (`id_admin`);

--
-- Indexes for table `monthly_tax`
--
ALTER TABLE `monthly_tax`
  ADD PRIMARY KEY (`id_mt`),
  ADD KEY `id_acbknt_tax_idx` (`id_acbknt`),
  ADD KEY `id_trans_tax_idx` (`id_trans`);

--
-- Indexes for table `plano`
--
ALTER TABLE `plano`
  ADD PRIMARY KEY (`id_plano`);

--
-- Indexes for table `plano_conta`
--
ALTER TABLE `plano_conta`
  ADD PRIMARY KEY (`id_plano_conta`),
  ADD UNIQUE KEY `id_acbknt_UNIQUE` (`id_acbknt`),
  ADD KEY `id_acbknt_index` (`id_acbknt`),
  ADD KEY `FK_PLANO_idx` (`id_plano`);

--
-- Indexes for table `plano_conta_minutrade`
--
ALTER TABLE `plano_conta_minutrade`
  ADD PRIMARY KEY (`id_plano_conta_minutrade`),
  ADD KEY `FK_PLANO_CONTA_MINUTRADE` (`id_plano_conta`);

--
-- Indexes for table `set_account`
--
ALTER TABLE `set_account`
  ADD PRIMARY KEY (`id_acbknt`),
  ADD UNIQUE KEY `num_acbknt_UNIQUE` (`num_acbknt`),
  ADD KEY `FK_AG_ACCOUNT_idx` (`id_agbknt`);

--
-- Indexes for table `set_agence`
--
ALTER TABLE `set_agence`
  ADD PRIMARY KEY (`id_agbknt`),
  ADD UNIQUE KEY `agencia_agbknt` (`agencia_agbknt`);

--
-- Indexes for table `simple_sell`
--
ALTER TABLE `simple_sell`
  ADD PRIMARY KEY (`id_sell`),
  ADD KEY `fk_id_vendedor_idx` (`id_acbknt`),
  ADD KEY `id_trans_idx` (`id_trans`),
  ADD KEY `fk_id_cliente` (`id_acbknt_cli`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id_token`),
  ADD UNIQUE KEY `token_UNIQUE` (`hash`);

--
-- Indexes for table `transactions_bdm`
--
ALTER TABLE `transactions_bdm`
  ADD PRIMARY KEY (`id_trans`),
  ADD UNIQUE KEY `comprovante_trans` (`comprovante_trans`),
  ADD UNIQUE KEY `comprovante_trans_2` (`comprovante_trans`);

--
-- Indexes for table `transactions_lines`
--
ALTER TABLE `transactions_lines`
  ADD PRIMARY KEY (`id_line`),
  ADD KEY `FK_TRANS_REQUESTPAY_idx` (`id_trans`),
  ADD KEY `FK_ACC_LINE_idx` (`id_acbknt`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id_tf`),
  ADD KEY `fk_idacc_rem_idx` (`id_acbknt_rem`),
  ADD KEY `fk_idacc_dest_idx` (`id_acbknt_dest`),
  ADD KEY `fk_id_trans_tf_idx` (`id_trans`);

--
-- Indexes for table `try_access`
--
ALTER TABLE `try_access`
  ADD KEY `FK_DEVICE_idx` (`id_device`),
  ADD KEY `FK_SET_ACC` (`id_acbknt`);

--
-- Indexes for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD PRIMARY KEY (`id_d`),
  ADD UNIQUE KEY `mac_adress_d_UNIQUE` (`mac_adress_d`),
  ADD UNIQUE KEY `fcm_token_d_UNIQUE` (`fcm_token_d`),
  ADD UNIQUE KEY `id_acbknt_UNIQUE` (`id_acbknt`);

--
-- Indexes for table `user_has_device`
--
ALTER TABLE `user_has_device`
  ADD UNIQUE KEY `key_user_device` (`id_acbknt`,`id_device`),
  ADD KEY `fk_id_acbknt_uh_idx` (`id_acbknt`),
  ADD KEY `fk_id_device_uh_idx` (`id_device`);

--
-- Indexes for table `vendor_has_client`
--
ALTER TABLE `vendor_has_client`
  ADD PRIMARY KEY (`id_vc`),
  ADD KEY `id_acbknt_cliente_vc_idx` (`id_acbknt_client`),
  ADD KEY `id_acbknt_vendor_vc_idx` (`id_acbknt_vendor`),
  ADD KEY `id_trans_vc` (`id_trans`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `boletos`
--
ALTER TABLE `boletos`
  MODIFY `id_bol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id_card` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cnab_file`
--
ALTER TABLE `cnab_file`
  MODIFY `id_cnab` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `ConfigAccountServices`
--
ALTER TABLE `ConfigAccountServices`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_client`
--
ALTER TABLE `data_client`
  MODIFY `id_dcc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `integrations`
--
ALTER TABLE `integrations`
  MODIFY `id_integration` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `monthly_tax`
--
ALTER TABLE `monthly_tax`
  MODIFY `id_mt` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `plano`
--
ALTER TABLE `plano`
  MODIFY `id_plano` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `plano_conta`
--
ALTER TABLE `plano_conta`
  MODIFY `id_plano_conta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `plano_conta_minutrade`
--
ALTER TABLE `plano_conta_minutrade`
  MODIFY `id_plano_conta_minutrade` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=315;
--
-- AUTO_INCREMENT for table `transactions_lines`
--
ALTER TABLE `transactions_lines`
  MODIFY `id_line` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `user_devices`
--
ALTER TABLE `user_devices`
  MODIFY `id_d` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `vendor_has_client`
--
ALTER TABLE `vendor_has_client`
  MODIFY `id_vc` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `boletos`
--
ALTER TABLE `boletos`
  ADD CONSTRAINT `fk_id_admin_bol` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `fk_id_admin_pagamento_bol` FOREIGN KEY (`id_admin_pagamento`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `id_acbknt_boleto` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_cnab` FOREIGN KEY (`id_cnab`) REFERENCES `cnab_file` (`id_cnab`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_trans_boleto` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `card_account_transfer`
--
ALTER TABLE `card_account_transfer`
  ADD CONSTRAINT `fk_card_account_transfer_card_wallet1` FOREIGN KEY (`id_card_wallet`) REFERENCES `card_wallet` (`id_card_wallet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_card_account_transfer_set_account1` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_card_account_transfer_transactions_bdm1` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `card_contracts`
--
ALTER TABLE `card_contracts`
  ADD CONSTRAINT `fk_card_contracts_card1` FOREIGN KEY (`id_card`) REFERENCES `card` (`id_card`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_card_contracts_card_proposal1` FOREIGN KEY (`id_card_proposal`) REFERENCES `card_proposal` (`id_card_proposal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_card_contracts_data_client1` FOREIGN KEY (`id_dcc`) REFERENCES `data_client` (`id_dcc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `card_proposal`
--
ALTER TABLE `card_proposal`
  ADD CONSTRAINT `fk_card_proposal_card1` FOREIGN KEY (`id_card`) REFERENCES `card` (`id_card`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_card_proposal_data_client1` FOREIGN KEY (`id_dcc`) REFERENCES `data_client` (`id_dcc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `card_wallet`
--
ALTER TABLE `card_wallet`
  ADD CONSTRAINT `fk_card_wallet_card_contracts1` FOREIGN KEY (`id_contract`) REFERENCES `card_contracts` (`id_contract`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `client_password_change_token`
--
ALTER TABLE `client_password_change_token`
  ADD CONSTRAINT `fk_client_password_change_token_data_client1` FOREIGN KEY (`id_dcc`) REFERENCES `data_client` (`id_dcc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `data_client`
--
ALTER TABLE `data_client`
  ADD CONSTRAINT `FK_ACC_DATA` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deposito`
--
ALTER TABLE `deposito`
  ADD CONSTRAINT `fk_id_admin_dep` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_id_trans_dep` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_idacc_dest_dep` FOREIGN KEY (`id_acbknt_dest`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `digital_certificate`
--
ALTER TABLE `digital_certificate`
  ADD CONSTRAINT `fk_digital_certificate_set_account1` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `id_admin_log` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `monthly_tax`
--
ALTER TABLE `monthly_tax`
  ADD CONSTRAINT `id_acbknt_tax` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_trans_tax` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `plano_conta`
--
ALTER TABLE `plano_conta`
  ADD CONSTRAINT `FK_PLANO` FOREIGN KEY (`id_plano`) REFERENCES `plano` (`id_plano`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_PLANO_CONTA` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `plano_conta_minutrade`
--
ALTER TABLE `plano_conta_minutrade`
  ADD CONSTRAINT `FK_PLANO_CONTA_MINUTRADE` FOREIGN KEY (`id_plano_conta`) REFERENCES `plano_conta` (`id_plano_conta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `set_account`
--
ALTER TABLE `set_account`
  ADD CONSTRAINT `FK_AG_ACCOUNT` FOREIGN KEY (`id_agbknt`) REFERENCES `set_agence` (`id_agbknt`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `simple_sell`
--
ALTER TABLE `simple_sell`
  ADD CONSTRAINT `fk_id_cliente` FOREIGN KEY (`id_acbknt_cli`) REFERENCES `set_account` (`id_acbknt`),
  ADD CONSTRAINT `fk_id_vendedor` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_trans` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transactions_lines`
--
ALTER TABLE `transactions_lines`
  ADD CONSTRAINT `FK_ACC_LINE` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TRANS_REQUESTPAY0` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `fk_id_trans_tf` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_idacc_dest` FOREIGN KEY (`id_acbknt_dest`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_idacc_rem` FOREIGN KEY (`id_acbknt_rem`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `try_access`
--
ALTER TABLE `try_access`
  ADD CONSTRAINT `FK_DEVICE` FOREIGN KEY (`id_device`) REFERENCES `user_devices` (`id_d`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_SET_ACC` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD CONSTRAINT `id_acbknt_device` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_has_device`
--
ALTER TABLE `user_has_device`
  ADD CONSTRAINT `fk_id_acbknt_uh` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_id_device_uh` FOREIGN KEY (`id_device`) REFERENCES `user_devices` (`id_d`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `vendor_has_client`
--
ALTER TABLE `vendor_has_client`
  ADD CONSTRAINT `id_acbknt_cliente_vc` FOREIGN KEY (`id_acbknt_client`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_acbknt_vendor_vc` FOREIGN KEY (`id_acbknt_vendor`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_trans_vc` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
