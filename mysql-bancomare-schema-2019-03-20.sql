-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: XXX.XX.XX.XXX    Database: bancomare
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ConfigAccountServices`
--

DROP TABLE IF EXISTS `ConfigAccountServices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ConfigAccountServices` (
  `BonusTargetAccount` int(11) NOT NULL,
  `BonusTargetAccountDigit` varchar(45) NOT NULL,
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id_admin` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `nome_admin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nascimento_admin` date DEFAULT NULL,
  `cpf_admin` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_admin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `senha_admin` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_admin` int(11) DEFAULT NULL,
  `permissao_admin` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `cpf_admin_UNIQUE` (`cpf_admin`),
  UNIQUE KEY `email_admin_UNIQUE` (`email_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boletos`
--

DROP TABLE IF EXISTS `boletos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boletos` (
  `id_bol` int(11) NOT NULL AUTO_INCREMENT,
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
  `id_cnab` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_bol`),
  KEY `id_acbknt_boleto_idx` (`id_acbknt`),
  KEY `id_trans_boleto_idx` (`id_trans`),
  KEY `fk_id_admin_bol` (`id_admin`),
  KEY `fk_id_admin_pagamento_bol` (`id_admin_pagamento`),
  KEY `id_cnab_idx` (`id_cnab`),
  CONSTRAINT `fk_id_admin_bol` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`),
  CONSTRAINT `fk_id_admin_pagamento_bol` FOREIGN KEY (`id_admin_pagamento`) REFERENCES `admin` (`id_admin`),
  CONSTRAINT `id_acbknt_boleto` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_cnab` FOREIGN KEY (`id_cnab`) REFERENCES `cnab_file` (`id_cnab`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_trans_boleto` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=67921 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card` (
  `id_card` int(11) NOT NULL AUTO_INCREMENT,
  `card_name` varchar(45) NOT NULL,
  `card_status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_card`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_account_transfer`
--

DROP TABLE IF EXISTS `card_account_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_account_transfer` (
  `id_card_transfer` varchar(60) NOT NULL,
  `id_card_wallet` varchar(60) NOT NULL,
  `id_trans` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `card_transfer_value` double NOT NULL,
  `backend_card_transfer_return_code` int(5) NOT NULL,
  PRIMARY KEY (`id_card_transfer`),
  KEY `fk_card_account_transfer_card_wallet1_idx` (`id_card_wallet`),
  KEY `fk_card_account_transfer_transactions_bdm1_idx` (`id_trans`),
  KEY `fk_card_account_transfer_set_account1_idx` (`id_acbknt`),
  CONSTRAINT `fk_card_account_transfer_card_wallet1` FOREIGN KEY (`id_card_wallet`) REFERENCES `card_wallet` (`id_card_wallet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_account_transfer_set_account1` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_account_transfer_transactions_bdm1` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_contracts`
--

DROP TABLE IF EXISTS `card_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `card_digit` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_contract`),
  KEY `fk_card_contracts_card_proposal1_idx` (`id_card_proposal`),
  KEY `fk_card_contracts_card1_idx` (`id_card`),
  KEY `fk_card_contracts_data_client1_idx` (`id_dcc`),
  CONSTRAINT `fk_card_contracts_card1` FOREIGN KEY (`id_card`) REFERENCES `card` (`id_card`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_contracts_card_proposal1` FOREIGN KEY (`id_card_proposal`) REFERENCES `card_proposal` (`id_card_proposal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_contracts_data_client1` FOREIGN KEY (`id_dcc`) REFERENCES `data_client` (`id_dcc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_proposal`
--

DROP TABLE IF EXISTS `card_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_proposal` (
  `id_card_proposal` varchar(45) NOT NULL,
  `id_card` int(11) NOT NULL,
  `id_dcc` int(11) NOT NULL,
  `proposal_status` smallint(5) NOT NULL,
  `proposal_comments` varchar(200) DEFAULT NULL,
  `proposal_date` date NOT NULL,
  `proposal_expiration_date` datetime DEFAULT NULL,
  `proposal_acceptance_date` datetime DEFAULT NULL,
  `codigo_pedido_confirmation_backend` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_card_proposal`),
  KEY `fk_card_proposal_card1_idx` (`id_card`),
  KEY `fk_card_proposal_data_client1_idx` (`id_dcc`),
  CONSTRAINT `fk_card_proposal_card1` FOREIGN KEY (`id_card`) REFERENCES `card` (`id_card`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_proposal_data_client1` FOREIGN KEY (`id_dcc`) REFERENCES `data_client` (`id_dcc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_wallet`
--

DROP TABLE IF EXISTS `card_wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_wallet` (
  `id_card_wallet` varchar(60) NOT NULL,
  `id_contract` varchar(45) NOT NULL,
  `operation_date` datetime NOT NULL,
  `operation_type` smallint(5) NOT NULL,
  `operation_value` double NOT NULL,
  `shop_name` varchar(200) DEFAULT NULL,
  `transasction_description` varchar(100) DEFAULT NULL,
  `operation_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id_card_wallet`),
  KEY `fk_card_wallet_card_contracts1_idx` (`id_contract`),
  CONSTRAINT `fk_card_wallet_card_contracts1` FOREIGN KEY (`id_contract`) REFERENCES `card_contracts` (`id_contract`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_password_change_token`
--

DROP TABLE IF EXISTS `client_password_change_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_password_change_token` (
  `id_token` varchar(45) NOT NULL,
  `token` int(4) NOT NULL,
  `creation_date` date NOT NULL,
  `token_status` smallint(5) NOT NULL,
  `id_dcc` int(11) NOT NULL,
  PRIMARY KEY (`id_token`),
  KEY `fk_client_password_change_token_data_client1_idx` (`id_dcc`),
  CONSTRAINT `fk_client_password_change_token_data_client1` FOREIGN KEY (`id_dcc`) REFERENCES `data_client` (`id_dcc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cnab_file`
--

DROP TABLE IF EXISTS `cnab_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cnab_file` (
  `id_cnab` int(11) NOT NULL AUTO_INCREMENT,
  `url_arquivo_cnab` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `url_arquivo_cnab_retorno` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_geracao_arquivo` datetime NOT NULL,
  `data_arquivo_retorno` datetime DEFAULT NULL,
  `status_cnab` int(11) NOT NULL DEFAULT '1',
  `id_admin` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_admin_retorno` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_arquivo_comprovantes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_cnab`)
) ENGINE=InnoDB AUTO_INCREMENT=565 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_client`
--

DROP TABLE IF EXISTS `data_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_client` (
  `id_dcc` int(11) NOT NULL AUTO_INCREMENT,
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
  `profile_pic_dcc` varchar(150) COLLATE latin1_general_cs DEFAULT NULL,
  PRIMARY KEY (`id_dcc`),
  UNIQUE KEY `cpf_dcc` (`cpf_dcc`),
  UNIQUE KEY `email_dcc` (`email_dcc`),
  UNIQUE KEY `profile_pic_dcc` (`profile_pic_dcc`),
  UNIQUE KEY `id_acbknt` (`id_acbknt`),
  KEY `FK_ACC_DATA_idx` (`id_acbknt`),
  CONSTRAINT `FK_ACC_DATA` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11129 DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deposito`
--

DROP TABLE IF EXISTS `deposito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deposito` (
  `id_dep` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_dest` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `title_dep` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `desc_dep` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `valor_dep` double DEFAULT NULL,
  `date_dep` datetime NOT NULL,
  `status_dep` int(11) NOT NULL DEFAULT '1',
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `id_admin` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_dep`),
  KEY `fk_idacc_dest_dep_idx` (`id_acbknt_dest`),
  KEY `fk_id_trans_dep_idx` (`id_trans`),
  KEY `fk_id_admin_dep_idx` (`id_admin`),
  CONSTRAINT `fk_id_admin_dep` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_trans_dep` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idacc_dest_dep` FOREIGN KEY (`id_acbknt_dest`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `digital_certificate`
--

DROP TABLE IF EXISTS `digital_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digital_certificate` (
  `id_certificate` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type_operation` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `key_certificate` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_certificate` datetime DEFAULT NULL,
  `validate_certificate` timestamp NULL DEFAULT NULL,
  `hash_certificate` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_certificate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_certificate`),
  KEY `fk_digital_certificate_set_account1_idx` (`id_acbknt`),
  CONSTRAINT `fk_digital_certificate_set_account1` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feriados`
--

DROP TABLE IF EXISTS `feriados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feriados` (
  `mes` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `nome` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `local` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`mes`,`dia`,`local`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integrations`
--

DROP TABLE IF EXISTS `integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integrations` (
  `id_integration` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL,
  `key` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_integration`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `hash_log` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `code_lc` int(11) NOT NULL,
  `id_admin` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `date_log` datetime NOT NULL,
  `message_log` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`hash_log`),
  KEY `code_lc_log_idx` (`code_lc`),
  KEY `id_admin_log_idx` (`id_admin`),
  CONSTRAINT `id_admin_log` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monthly_tax`
--

DROP TABLE IF EXISTS `monthly_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthly_tax` (
  `id_mt` int(11) NOT NULL AUTO_INCREMENT,
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `data_pagamento` datetime NOT NULL,
  PRIMARY KEY (`id_mt`),
  KEY `id_acbknt_tax_idx` (`id_acbknt`),
  KEY `id_trans_tax_idx` (`id_trans`),
  CONSTRAINT `id_acbknt_tax` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_trans_tax` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plano`
--

DROP TABLE IF EXISTS `plano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plano` (
  `id_plano` int(11) NOT NULL AUTO_INCREMENT,
  `nome_plano` varchar(45) NOT NULL,
  `tipo_plano` int(11) NOT NULL,
  `valor_plano` decimal(10,2) NOT NULL,
  `recorrencia_dias` int(11) NOT NULL,
  `tem_cartao` tinyint(4) NOT NULL DEFAULT '0',
  `ativo` tinyint(4) NOT NULL DEFAULT '1',
  `duracao_dias` int(11) NOT NULL,
  `data_criacao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL,
  PRIMARY KEY (`id_plano`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plano_conta`
--

DROP TABLE IF EXISTS `plano_conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plano_conta` (
  `id_plano_conta` int(11) NOT NULL AUTO_INCREMENT,
  `id_plano` int(11) NOT NULL,
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_plano` int(11) NOT NULL,
  `data_cobranca` datetime DEFAULT NULL,
  `data_criacao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL,
  `data_contratacao_plano` datetime NOT NULL,
  `data_proxima_recorrencia` datetime DEFAULT NULL,
  PRIMARY KEY (`id_plano_conta`),
  UNIQUE KEY `id_acbknt_UNIQUE` (`id_acbknt`),
  KEY `id_acbknt_index` (`id_acbknt`),
  KEY `FK_PLANO_idx` (`id_plano`),
  CONSTRAINT `FK_PLANO` FOREIGN KEY (`id_plano`) REFERENCES `plano` (`id_plano`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PLANO_CONTA` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10422 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plano_conta_minutrade`
--

DROP TABLE IF EXISTS `plano_conta_minutrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plano_conta_minutrade` (
  `id_plano_conta_minutrade` int(11) NOT NULL AUTO_INCREMENT,
  `id_plano_conta` int(11) DEFAULT NULL,
  `id_trigger` varchar(45) DEFAULT NULL,
  `erro_minutrade` varchar(100) DEFAULT NULL,
  `status_minutrade` int(11) NOT NULL,
  `data_bonus_solicitado` datetime DEFAULT NULL,
  `data_bonus_liberado` datetime DEFAULT NULL,
  `data_criacao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL,
  PRIMARY KEY (`id_plano_conta_minutrade`),
  KEY `FK_PLANO_CONTA_MINUTRADE` (`id_plano_conta`),
  CONSTRAINT `FK_PLANO_CONTA_MINUTRADE` FOREIGN KEY (`id_plano_conta`) REFERENCES `plano_conta` (`id_plano_conta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `set_account`
--

DROP TABLE IF EXISTS `set_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `first_tax_payd` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_acbknt`),
  UNIQUE KEY `num_acbknt_UNIQUE` (`num_acbknt`),
  KEY `FK_AG_ACCOUNT_idx` (`id_agbknt`),
  CONSTRAINT `FK_AG_ACCOUNT` FOREIGN KEY (`id_agbknt`) REFERENCES `set_agence` (`id_agbknt`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `set_agence`
--

DROP TABLE IF EXISTS `set_agence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `status_agbknt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_agbknt`),
  UNIQUE KEY `agencia_agbknt` (`agencia_agbknt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simple_sell`
--

DROP TABLE IF EXISTS `simple_sell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `tax_sell` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_sell`),
  KEY `fk_id_vendedor_idx` (`id_acbknt`),
  KEY `id_trans_idx` (`id_trans`),
  KEY `fk_id_cliente` (`id_acbknt_cli`),
  CONSTRAINT `fk_id_cliente` FOREIGN KEY (`id_acbknt_cli`) REFERENCES `set_account` (`id_acbknt`),
  CONSTRAINT `fk_id_vendedor` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_trans` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id_token` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(66) NOT NULL,
  `id_admin` varchar(45) DEFAULT NULL,
  `id_conta` varchar(45) DEFAULT NULL,
  `id_device` varchar(45) DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT '1',
  `data_criacao` datetime NOT NULL,
  PRIMARY KEY (`id_token`),
  UNIQUE KEY `token_UNIQUE` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=81821 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions_bdm`
--

DROP TABLE IF EXISTS `transactions_bdm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions_bdm` (
  `id_trans` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type_trans` int(11) NOT NULL,
  `date_trans` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name_trans` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `desc_trans` varchar(200) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `status_trans` int(11) NOT NULL DEFAULT '1',
  `comprovante_trans` varchar(10) NOT NULL,
  `id_trans_estorno` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_trans`),
  UNIQUE KEY `comprovante_trans` (`comprovante_trans`),
  UNIQUE KEY `comprovante_trans_2` (`comprovante_trans`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions_lines`
--

DROP TABLE IF EXISTS `transactions_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions_lines` (
  `id_line` int(11) NOT NULL AUTO_INCREMENT,
  `id_trans` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `credit_line` double DEFAULT '0',
  `debit_line` double DEFAULT '0',
  `status_line` int(11) NOT NULL DEFAULT '1',
  `id_acbknt` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_line`),
  KEY `FK_TRANS_REQUESTPAY_idx` (`id_trans`),
  KEY `FK_ACC_LINE_idx` (`id_acbknt`),
  CONSTRAINT `FK_ACC_LINE` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_TRANS_REQUESTPAY0` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=134400 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transfers` (
  `id_tf` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_rem` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_dest` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `title_tf` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `desc_tf` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `valor_tf` double DEFAULT NULL,
  `date_tf` datetime NOT NULL,
  `status_tf` int(11) NOT NULL DEFAULT '1',
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_tf`),
  KEY `fk_idacc_rem_idx` (`id_acbknt_rem`),
  KEY `fk_idacc_dest_idx` (`id_acbknt_dest`),
  KEY `fk_id_trans_tf_idx` (`id_trans`),
  CONSTRAINT `fk_id_trans_tf` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idacc_dest` FOREIGN KEY (`id_acbknt_dest`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idacc_rem` FOREIGN KEY (`id_acbknt_rem`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `try_access`
--

DROP TABLE IF EXISTS `try_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `try_access` (
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_device` int(11) NOT NULL,
  `date_try` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `location_try` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `FK_DEVICE_idx` (`id_device`),
  KEY `FK_SET_ACC` (`id_acbknt`),
  CONSTRAINT `FK_DEVICE` FOREIGN KEY (`id_device`) REFERENCES `user_devices` (`id_d`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SET_ACC` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_devices`
--

DROP TABLE IF EXISTS `user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_devices` (
  `id_d` int(11) NOT NULL AUTO_INCREMENT,
  `mac_adress_d` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fcm_token_d` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_d` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_d`),
  UNIQUE KEY `mac_adress_d_UNIQUE` (`mac_adress_d`),
  UNIQUE KEY `fcm_token_d_UNIQUE` (`fcm_token_d`),
  UNIQUE KEY `id_acbknt_UNIQUE` (`id_acbknt`),
  CONSTRAINT `id_acbknt_device` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8490 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_has_device`
--

DROP TABLE IF EXISTS `user_has_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_device` (
  `id_acbknt` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_device` int(11) NOT NULL,
  `status_uh` int(11) NOT NULL,
  `data_uh` datetime NOT NULL,
  UNIQUE KEY `key_user_device` (`id_acbknt`,`id_device`),
  KEY `fk_id_acbknt_uh_idx` (`id_acbknt`),
  KEY `fk_id_device_uh_idx` (`id_device`),
  CONSTRAINT `fk_id_acbknt_uh` FOREIGN KEY (`id_acbknt`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_device_uh` FOREIGN KEY (`id_device`) REFERENCES `user_devices` (`id_d`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendor_has_client`
--

DROP TABLE IF EXISTS `vendor_has_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor_has_client` (
  `id_vc` int(11) NOT NULL AUTO_INCREMENT,
  `id_acbknt_client` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_acbknt_vendor` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `consumed_vc` int(11) NOT NULL DEFAULT '0',
  `type_acc_vc` int(11) NOT NULL,
  `id_trans` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_vc`),
  KEY `id_acbknt_cliente_vc_idx` (`id_acbknt_client`),
  KEY `id_acbknt_vendor_vc_idx` (`id_acbknt_vendor`),
  KEY `id_trans_vc` (`id_trans`),
  CONSTRAINT `id_acbknt_cliente_vc` FOREIGN KEY (`id_acbknt_client`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_acbknt_vendor_vc` FOREIGN KEY (`id_acbknt_vendor`) REFERENCES `set_account` (`id_acbknt`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_trans_vc` FOREIGN KEY (`id_trans`) REFERENCES `transactions_bdm` (`id_trans`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-20 18:28:31
