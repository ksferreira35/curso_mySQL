CREATE DATABASE pedido_cliente;
USE pedido_cliente;

DROP DATABASE pedido_cliente;

CREATE TABLE clientes (
cod_cliente 	BIGINT AUTO_INCREMENT PRIMARY KEY,
	nome 		VARCHAR(100),
	email 		VARCHAR(50),
	data_nasc 	DATE
) ENGINE=InnoDB;

CREATE TABLE pedidos (
cod_pedido 			BIGINT AUTO_INCREMENT PRIMARY KEY,
	data_creation 	DATETIME,
    obs 			TEXT,
    data_entrega 	DATE,
    valor_frete 	DECIMAL(6,2),
    valor_total 	DECIMAL(10,2),
    cliente_id 		BIGINT,
    CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes(cod_cliente)
) ENGINE=InnoDB;

CREATE TABLE produtos (
cod_prod 				BIGINT AUTO_INCREMENT PRIMARY KEY,
	nome 				VARCHAR(100),
    valor_unitario 		DECIMAL(6,2),
    quantidade_estoque 	BIGINT
) ENGINE=InnoDB;

CREATE TABLE pedidos_produtos (
cod_pedido_produto 			 BIGINT AUTO_INCREMENT PRIMARY KEY,
	cod_pedido 				 BIGINT,
    cod_prod 				 BIGINT,
    quantidade				 INT,
	FOREIGN KEY (cod_pedido) REFERENCES pedidos(cod_pedido),
    FOREIGN KEY (cod_prod) 	 REFERENCES produtos(cod_prod)
) ENGINE=InnoDB;

-- one to many
-- many to one
-- many to many

INSERT INTO clientes (nome, email, data_nasc)
VALUES ("João da Silva", "joao@email.com", "1990-01-01");

INSERT INTO pedidos (data_creation, obs, data_entrega, valor_frete, valor_total, cliente_id)
VALUES ("2025-06-03 15:32:21", "Entrega Normal", "2025-06-10", 10.34, 190.35, 1);

TRUNCATE pedidos;

INSERT INTO produtos (cod_prod, nome, valor_unitario, quantidade_estoque) VALUES 
(3, "Cola Super", 24.40, 300),
(4, "Cimento X", 45.50, 140);

INSERT INTO pedidos_produtos(cod_pedido, cod_prod, quantidade) VALUES 
(1, 3, 3),
(1, 4, 2);

SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM produtos;
SELECT * FROM pedidos_produtos;