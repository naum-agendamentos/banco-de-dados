DROP DATABASE naum;

CREATE DATABASE naum;
USE naum;
SELECT  id, foto FROM barbeiro;
CREATE TABLE `usuario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `tipo` enum('BARBEIRO','ADMIN','CLIENTE') DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `endereco` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cidade` varchar(45) NOT NULL,
  `cep` varchar(45) NOT NULL,
  `numero` varchar(45) NOT NULL,
  `bairro` varchar(45) NOT NULL,
  `uf` varchar(45) NOT NULL,
  `rua` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `cliente` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKc3u631ocxdrtm3ccpme0kjlmu` (`usuario_id`),
  CONSTRAINT `FKc3u631ocxdrtm3ccpme0kjlmu` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
);

CREATE TABLE `permissao` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `barbearia` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `link_barbearia` varchar(45) DEFAULT NULL,
  `ativa` tinyint(1) DEFAULT NULL,
  `foto_barbearia` varchar(45) DEFAULT NULL,
  `endereco_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK95fh0pnqn0tgd1baowspc35mp` (`endereco_id`),
  CONSTRAINT `FK95fh0pnqn0tgd1baowspc35mp` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`)
);

CREATE TABLE `barbeiro` (
  `barbeiro_ativo` bit(1) NOT NULL,
  `fk_permissao` int DEFAULT NULL,
  `barbearia_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `foto` BLOB NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7wpd3f1n8aqj48ii8k8uoq9p6` (`barbearia_id`),
  KEY `FKdlxkvxpw1sb35hh80mhyxa3f0` (`usuario_id`),
  CONSTRAINT `FK7wpd3f1n8aqj48ii8k8uoq9p6` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearia` (`id`),
  CONSTRAINT `FKdlxkvxpw1sb35hh80mhyxa3f0` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
);

CREATE TABLE `servico` (
  `preco` double DEFAULT NULL,
  `tempo_servico` int DEFAULT NULL,
  `barbearia_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome_servico` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKs79gad185dsaw65svtp4gt2ro` (`barbearia_id`),
  CONSTRAINT `FKs79gad185dsaw65svtp4gt2ro` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearia` (`id`)
);

CREATE TABLE `agendamento` (
  `valor_total` double DEFAULT NULL,
  `barbeiro_id` bigint DEFAULT NULL,
  `cliente_id` bigint DEFAULT NULL,
  `fim` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `inicio` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqxtgfgl3b80ib97ygbpq796yw` (`barbeiro_id`),
  KEY `FKsgdo4l8yts964f089m6ujyuef` (`cliente_id`),
  CONSTRAINT `FKqxtgfgl3b80ib97ygbpq796yw` FOREIGN KEY (`barbeiro_id`) REFERENCES `barbeiro` (`id`),
  CONSTRAINT `FKsgdo4l8yts964f089m6ujyuef` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
);

CREATE TABLE `agendamento_servicos_ids` (
  `agendamento_id` bigint NOT NULL,
  `servicos_ids` bigint DEFAULT NULL,
  KEY `FKj38nmqpmuq583o2wbb0rf9cbk` (`agendamento_id`),
  CONSTRAINT `FKj38nmqpmuq583o2wbb0rf9cbk` FOREIGN KEY (`agendamento_id`) REFERENCES `agendamento` (`id`)
);

CREATE TABLE `avaliacao` (
  `qtd_estrela` int DEFAULT NULL,
  `barbearia_id` bigint DEFAULT NULL,
  `cliente_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `FKo314r3503x2q0ktuqc9dwan1q` (`barbearia_id`),
  KEY `FKpogwypj6dq5o1p5vu3q31lifm` (`cliente_id`),
  CONSTRAINT `FKo314r3503x2q0ktuqc9dwan1q` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearia` (`id`),
  CONSTRAINT `FKpogwypj6dq5o1p5vu3q31lifm` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
);

CREATE TABLE `login_adm` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjvynbplbbg3vo70k2h9rg501m` (`usuario_id`),
  CONSTRAINT `FKjvynbplbbg3vo70k2h9rg501m` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
);

CREATE TABLE `mural_avisos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `barbeiro_id` bigint DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `data` datetime DEFAULT NULL,
  `urgencia` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_barbeiro_mural` (`barbeiro_id`),
  CONSTRAINT `FK_barbeiro_mural` FOREIGN KEY (`barbeiro_id`) REFERENCES `barbeiro` (`id`)
);

select * from endereco ;
select * from barbearia ;
select * from servico ;
select * from permissao ;
select * from barbeiro;
select * from cliente ;
select * from avaliacao ;
select * from agendamento ;
select * from usuario ;

INSERT INTO Permissao (descricao) VALUES ('ADM'), ('Padrão');

INSERT INTO Usuario (nome, email, senha, tipo) VALUES
('Guilherme', 'guilherme@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', 'BARBEIRO');

INSERT INTO Endereco (cidade, cep, numero, bairro, uf, rua) VALUES ('Cidade 1', '12345678', '123', 'Bairro 1', 'UF1', 'Rua 1');

INSERT INTO Barbearia (id, nome, link_barbearia, ativa, foto_barbearia, endereco_id) VALUES (1, 'Barbearia 1', 'link1', TRUE, 'foto1.jpg', 1);

INSERT INTO Barbeiro (nome, email, senha, telefone, descricao, barbeiro_ativo, foto, barbearia_id, fk_permissao, usuario_id) VALUES
('Guilherme', 'guilherme@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', '123456789', 'Descrição do Barbeiro 1', 1, 'foto1.jpg', 1, 1, 1);

INSERT INTO Usuario (nome, email, senha, tipo) VALUES
('Administrador', 'adm@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', 'ADMIN');

INSERT INTO Login_adm (email, senha, usuario_id) VALUES
('adm@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', 2);

select id from servico;
select id from usuario;
select id, nome, email from cliente;
