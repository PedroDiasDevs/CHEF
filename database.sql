-- Criação do banco de dados
CREATE DATABASE CHEF;
USE CHEF;

-- Tabela de Usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(15),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nome_cartao VARCHAR(100),
    numero_cartao VARCHAR(20),
    data_expiracao DATE,
    cvv VARCHAR(4),
    status_assinatura ENUM('Ativo', 'Inativo') NOT NULL DEFAULT 'Ativo'
) ENGINE=InnoDB;

-- Tabela de Receitas
CREATE TABLE receitas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    tempo_preparo INT NOT NULL,
    dificuldade ENUM('Fácil', 'Média', 'Difícil') NOT NULL,
    modo_preparo TEXT NOT NULL,
    porcoes INT NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Ingredientes
CREATE TABLE ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade_padrao DECIMAL(10, 2) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- Tabela intermediária para Receita e Ingrediente
CREATE TABLE receita_ingrediente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    receita_id INT NOT NULL,
    ingrediente_id INT NOT NULL,
    quantidade DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (receita_id) REFERENCES receitas(id) ON DELETE CASCADE,
    FOREIGN KEY (ingrediente_id) REFERENCES ingredientes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Estoque
CREATE TABLE estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome_produto VARCHAR(100) NOT NULL,
    quantidade DECIMAL(10, 2) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Encomendas
CREATE TABLE encomendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    data_entrega DATE NOT NULL,
    status ENUM('Pendente', 'Confirmado') NOT NULL DEFAULT 'Pendente',
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Itens de Encomenda
CREATE TABLE encomenda_itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    encomenda_id INT NOT NULL,
    descricao_item VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (encomenda_id) REFERENCES encomendas(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Índices para otimização de consultas
CREATE INDEX idx_usuario_email ON usuarios(email);
CREATE INDEX idx_receita_usuario ON receitas(usuario_id);
CREATE INDEX idx_estoque_usuario ON estoque(usuario_id);
CREATE INDEX idx_encomenda_usuario ON encomendas(usuario_id);