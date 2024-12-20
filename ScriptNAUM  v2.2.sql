DROP DATABASE naum;

CREATE DATABASE naum;
USE naum;

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
  `cidade` varchar(255) NOT NULL,
  `cep` varchar(255) NOT NULL,
  `numero` varchar(255) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `uf` varchar(255) NOT NULL,
  `rua` varchar(255) NOT NULL,
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
  `nome` varchar(255) DEFAULT NULL,
  `link_barbearia` varchar(1000) DEFAULT NULL,
  `ativa` tinyint(1) DEFAULT NULL,
  `foto_barbearia` varchar(1000) DEFAULT NULL,
  `endereco_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK95fh0pnqn0tgd1baowspc35mp` (`endereco_id`),
  CONSTRAINT `FK95fh0pnqn0tgd1baowspc35mp` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`)
);

CREATE TABLE `semana` (
	`id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `segunda` boolean default null,
    `terca` boolean default null,
    `quarta` boolean default null,
    `quinta` boolean default null,
    `sexta` boolean default null,
    `sabado` boolean default null,
    `domingo` boolean default null
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
  `fk_dias_semana` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  key `constraintdiasdasemana` (`fk_dias_semana`),
  KEY `FK7wpd3f1n8aqj48ii8k8uoq9p6` (`barbearia_id`),
  KEY `FKdlxkvxpw1sb35hh80mhyxa3f0` (`usuario_id`),
  CONSTRAINT `FK7wpd3f1n8aqj48ii8k8uoq9p6` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearia` (`id`),
  CONSTRAINT `FKdlxkvxpw1sb35hh80mhyxa3f0` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `constraintdiasdasemana` foreign key (`fk_dias_semana`) REFERENCES `semana` (`id`)
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
  `tipo_aviso` varchar(100) DEFAULT NULL,
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

INSERT INTO permissao (descricao) VALUES ('ADM'), ('Padrão');

INSERT INTO usuario (nome, email, senha, tipo) VALUES
('Guilherme', 'guilherme@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', 'BARBEIRO');

INSERT INTO endereco (cidade, cep, numero, bairro, uf, rua) VALUES ('São Paulo', '08460348', '331', 'Vila Abc', 'SP', 'R. Castanho da Silva');

INSERT INTO barbearia (id, nome, link_barbearia, ativa, foto_barbearia, endereco_id) VALUES (1, 'Barbearia TM', 'http://localhost:3001', TRUE, 'https://res-console.cloudinary.com/dmgfyyioo/media_explorer_thumbnails/3745a8c61a7eb36c0113035e895e85e6/detailed', 1);

INSERT INTO barbeiro (nome, email, senha, telefone, descricao, barbeiro_ativo, foto, barbearia_id, fk_permissao, usuario_id) VALUES
('Guilherme', 'guilherme@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', '11999999999', 'Barbeiro dono da Barbearia TM', 1, 'https://th.bing.com/th/id/OIG1.0BeicJdeVre_rnigiRM4?w=1024&h=1024&rs=1&pid=ImgDetMain', 1, 1, 1);

INSERT INTO usuario (nome, email, senha, tipo) VALUES
('Administrador', 'adm@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', 'ADMIN');

INSERT INTO login_adm (email, senha, usuario_id) VALUES
('adm@gmail.com', '$2a$10$0/TKTGxdREbWaWjWYhwf6e9P1fPOAMMNqEnZgOG95jnSkHSfkkIrC', 2);

INSERT INTO `servico` (`preco`, `tempo_servico`, `barbearia_id`, `nome_servico`)
VALUES
(20.00, 60, 1, 'Luzes'),
(40.00, 90, 1, 'Platinado'),
(20.00, 30, 1, 'Barba'),
(35.00, 90, 1, 'Progressiva'),
(30.00, 60, 1, 'Pigmentação'),
(40.00, 60, 1, 'Colometria');

select id from servico;
select id from usuario;
select id, nome, email from cliente;
