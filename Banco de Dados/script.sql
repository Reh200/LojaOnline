-- Criar o banco de dados
CREATE DATABASE brecho_online;
USE brecho_online;

-- Tabela: Usuários
CREATE TABLE Usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    tipo_usuario ENUM('comprador', 'vendedor', 'ambos') NOT NULL
);

-- Tabela: Produtos
CREATE TABLE Produtos (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL,
    imagem_url VARCHAR(255),
    vendedor_id INT,
    FOREIGN KEY (vendedor_id) REFERENCES Usuarios(usuario_id)
);

-- Tabela: Compras
CREATE TABLE Compras (
    compra_id INT AUTO_INCREMENT PRIMARY KEY,
    comprador_id INT,
    produto_id INT,
    data_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'concluída', 'cancelada') DEFAULT 'pendente',
    FOREIGN KEY (comprador_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Tabela: Envios
CREATE TABLE Envios (
    envio_id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT,
    endereco_destino VARCHAR(255) NOT NULL,
    data_envio DATETIME,
    codigo_rastreamento VARCHAR(50),
    FOREIGN KEY (compra_id) REFERENCES Compras(compra_id)
);

-- Tabela: Pagamentos
CREATE TABLE Pagamentos (
    pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT,
    metodo_pagamento ENUM('whatsapp') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento DATETIME,
    FOREIGN KEY (compra_id) REFERENCES Compras(compra_id)
);
