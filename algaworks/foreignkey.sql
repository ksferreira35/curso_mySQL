DROP DATABASE pedido_cliente;
CREATE DATABASE pedido_cliente;
USE pedido_cliente;

CREATE TABLE clientes (
    cod_cliente        BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome               VARCHAR(100),
    email              VARCHAR(50),
    data_nasc          DATE,
    CONSTRAINT nome_cliente UNIQUE (nome),
    INDEX ix_nome(nome)
) ENGINE=InnoDB;

CREATE TABLE pedidos (
    cod_pedido         BIGINT AUTO_INCREMENT PRIMARY KEY,
    data_creation      DATETIME,
    obs                TEXT,
    data_entrega       DATE,
    valor_frete        DECIMAL(6,2),
    valor_total        DECIMAL(10,2),
    cliente_id         BIGINT,
    forma_pagamento    VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT "ORCAMENTO",
    FOREIGN KEY (cliente_id) REFERENCES clientes(cod_cliente)
) ENGINE=InnoDB;

CREATE TABLE produtos (
    cod_prod           BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome               VARCHAR(100),
    valor_unitario     DECIMAL(6,2),
    quantidade_estoque BIGINT
) ENGINE=InnoDB;

CREATE TABLE pedidos_produtos (
    cod_pedido_produto BIGINT AUTO_INCREMENT PRIMARY KEY,
    cod_pedido         BIGINT,
    cod_prod           BIGINT,
    quantidade         INT,
    FOREIGN KEY (cod_pedido) REFERENCES pedidos(cod_pedido),
    FOREIGN KEY (cod_prod) REFERENCES produtos(cod_prod)
) ENGINE=InnoDB;

INSERT IGNORE INTO clientes (nome, email, data_nasc) 
VALUES 
    ("João Silva", "joao@email.com", "1990-01-01"),
    ("Maria Santos", "maria@email.com", "1991-02-20"),
    ("Rafael Costa","rafael@email.com","1989-04-10"),
    ("Pedro Macedo","pedro@email.com","1992-05-22"),
    ("José Pereira", "jose@email.com", "1990-10-10");

INSERT INTO pedidos (data_creation, data_entrega, valor_frete, valor_total, cliente_id, forma_pagamento, status)
VALUES (now(), '2025-06-12', 2.00, 200.00, 1, "Dinheiro", "EM ANDAMENTO");

INSERT INTO pedidos (data_creation, data_entrega, valor_frete, valor_total, cliente_id, obs, forma_pagamento)
VALUES 
    ("2025-01-04 15:45:21", "2025-01-23", 5.34, 99.99, 2, "Entrega Urgente", "Cartão"),
    ("2014-07-11 15:22:00", "2014-07-15", 33.00, 400.00, 2, "Entrega Normal", "Cartão"),
    ("2025-03-01 09:10:00", "2025-03-10", 12.00, 150.00, 1, "Pedido com observação especial", "Cartão"),
    ("2025-04-15 18:30:45", "2025-04-20", 8.50, 200.00, 1, "Entrega no fim de semana", "Cartão");

ALTER TABLE produtos ADD CONSTRAINT nome_unico UNIQUE (nome);

SET SQL_SAFE_UPDATES = 0;

INSERT IGNORE INTO produtos (nome, valor_unitario, quantidade_estoque) 
VALUES  
    ("Cola Super", 24.40, 300),
    ("Cimento X", 45.50, 140),
    ('Papel A4', 12.00, 100),
    ("Caneta", 7.00, 200),
    ("Borracha", 2.00, 300);

INSERT INTO pedidos_produtos (cod_pedido, cod_prod, quantidade) VALUES 
    (4, 1, 4),
    (4, 2, 2),
    (1, 1, 4),
    (1, 3, 2);

TRUNCATE pedidos_produtos;

INSERT INTO pedidos (data_creation, data_entrega, valor_frete, valor_total, cliente_id)
VALUES (now(), '2014-08-24', 10.00, 100.00, 1);

SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM produtos;
SELECT * FROM pedidos_produtos;

SELECT * FROM clientes WHERE nome = "João da Silva";
SELECT * FROM clientes WHERE data_nasc >= "1991-01-01";

SELECT * FROM pedidos WHERE obs IS NOT NULL AND valor_total > 200;

SELECT p.*
 FROM pedidos p
   , clientes c
 WHERE p.cliente_id = c.cod_cliente
	AND c.nome = 'João Silva';
    
SELECT pr.nome
	 , pp.quantidade
     , pe.data_entrega
 FROM clientes c
	, pedidos pe
    , pedidos_produtos pp
    , produtos pr
 WHERE c.cod_cliente = pe.cliente_id
   AND pe.cod_pedido = pp.cod_pedido
   AND pp.cod_prod = pr.cod_prod
   AND c.nome = 'João Silva';
   
SELECT * FROM pedidos
 WHERE month(data_creation) = 7
 AND year(data_creation) = 2014
 AND day(data_creation) = 11;
 
SELECT * FROM pedidos
 WHERE data_creation >= "2014-07-01 00:00:00"
 AND data_creation <= "2014-07-31 23:59:59";
 
EXPLAIN SELECT * FROM clientes
 WHERE nome = "João Silva";
 
DELETE FROM pedidos WHERE cliente_id is null;

UPDATE pedidos
 SET status = "EMITIDO"
 WHERE forma_pagamento != "Cartão";
 
SELECT * FROM pedidos;

SELECT status
	 , SUM(valor_total) total_vendas
 FROM pedidos
 GROUP BY status;
 
SELECT date(data_creation)
	 , sum(valor_total)
     , status
 FROM pedidos
 WHERE status = "ORCAMENTO"
 GROUP BY date(data_creation);
 
SELECT status
	 , AVG(valor_total) total_vendas
 FROM pedidos
 GROUP BY status;
 
SELECT * FROM clientes
ORDER BY data_nasc;

SELECT * FROM clientes
 WHERE nome LIKE "J%";
 
SELECT DISTINCT data_entrega 
 FROM pedidos 
 ORDER BY data_entrega;

SELECT * FROM produtos
	WHERE cod_prod IN (3, 4);
    
-- SUB-SELECT
SELECT DISTINCT c.nome
	 , c.email
     , p.status
 FROM clientes c
	, pedidos p
 WHERE cod_cliente IN (SELECT cliente_id FROM pedidos WHERE p.status = "CANCELADO") 
  AND c.cod_cliente = p.cliente_id;
  
SELECT DISTINCT c.nome, c.email
FROM clientes c
WHERE c.cod_cliente IN (
    SELECT cliente_id
    FROM pedidos
    WHERE status = "CANCELADO"
);

SELECT DISTINCT c.nome, c.email, p.status
FROM clientes c
JOIN pedidos p ON c.cod_cliente = p.cliente_id
WHERE p.status = "CANCELADO";

