-- Banco de dados para o site de brechó online

CREATE DATABASE brecho_online;

USE brecho_online;

-- Tabela para armazenar informações dos usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    senha VARCHAR(255) NOT NULL,  -- Para autenticação
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    endereco TEXT,  -- Endereço do usuário (opcional)
    data_nascimento DATE,  -- Data de nascimento do usuário (opcional)
    status ENUM('ativo', 'inativo') DEFAULT 'ativo'  -- Status da conta
);

-- Tabela para armazenar categorias dos produtos
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT,  -- Descrição da categoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para armazenar informações dos produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    id_categoria INT,
    imagem VARCHAR(255),  -- Caminho para a imagem do produto
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantidade INT DEFAULT 1,  -- Quantidade disponível
    status ENUM('disponível', 'indisponível') DEFAULT 'disponível',  -- Status do produto
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

-- Tabela para armazenar informações de vendas (contatos pelo WhatsApp)
CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_produto INT,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'concluída', 'cancelada') DEFAULT 'pendente',  -- Status da venda
    contato_whatsapp VARCHAR(15),  -- Número do WhatsApp do comprador
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

-- Tabela para armazenar avaliações dos produtos
CREATE TABLE avaliacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    id_usuario INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),  -- Avaliação de 1 a 5
    comentario TEXT,  -- Comentário do usuário
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_produto) REFERENCES produtos(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabela para armazenar endereços de entrega (opcional)
CREATE TABLE enderecos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    endereco TEXT NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    data_adicionado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabela para armazenar log de atividades dos usuários
CREATE TABLE log_atividades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    acao VARCHAR(255),  -- Descrição da ação
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);
