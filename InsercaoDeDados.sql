-- Inserindo dados na tabela Pessoa
INSERT INTO Pessoa (id, nome, cpf, contato, endereco)
VALUES
    (1, 'João Silva', '12345678901', '123456789', 'Rua A, 123'),
    (2, 'Maria Oliveira', '23456789012', '987654321', 'Avenida B, 456'),
    (3, 'Carlos Santos', '34567890123', '567890123', 'Rua C, 789');

-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (id, dtContratacao)
VALUES
    (1, '2023-01-01'),
    (2, '2023-02-15'),
    (3, '2023-03-20');

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (id, tipo)
VALUES
    (1, 'VIP'),
    (2, 'Regular'),
    (3, 'Premium');

-- Inserindo dados na tabela Compra
INSERT INTO Compra (nota_fiscal, data, valor, id_funcionario, id_cliente)
VALUES
	('NF124', '2023-04-01', 250.50, 1, 1),
    ('NF123', '2023-04-01', 150.50, 1, 1),
    ('NF456', '2023-04-05', 200.25, 2, 2),
    ('NF789', '2023-04-10', 120.75, 3, 3);

-- Inserindo dados na tabela Locacao
INSERT INTO Locacao (id, data, dtLocacao, dtReserva, id_funcionario, id_cliente)
VALUES
    (1, '2023-04-01', '2023-04-02', '2023-04-01', 1, 1),
    (2, '2023-04-05', '2023-04-06', '2023-04-04', 2, 2),
    (3, '2023-04-10', '2023-04-12', '2023-04-09', 3, 3);

	INSERT INTO Locacao (id, data, dtLocacao, id_funcionario, id_cliente)
VALUES
    (4, '2023-04-01', '2023-04-01', 1, 1),
    (2, '2023-04-05', '2023-04-06', '2023-04-04', 2, 2),
    (3, '2023-04-10', '2023-04-12', '2023-04-09', 3, 3);

-- Inserindo dados na tabela Filme
INSERT INTO Filme (cod_filme, titulo, genero, sinopse, dt_lancamento)
VALUES
    (1, 'Matrix', 'Ação', 'Neo luta contra máquinas em um mundo virtual', '1999-03-31'),
    (2, 'O Poderoso Chefão', 'Crime', 'História de uma família mafiosa', '1972-03-24'),
    (3, 'Titanic', 'Romance', 'Amor proibido em meio ao naufrágio', '1997-11-18');

-- Inserindo dados na tabela Filme_venda
INSERT INTO Filme_venda (cod_filme, preco_venda, qtdeEstoque)
VALUES
    (1, 19.99, 50),
    (2, 29.99, 30),
    (3, 24.99, 40);

-- Inserindo dados na tabela ComporCompra
INSERT INTO ComporCompra (cod_filme, nota_fiscal, quantidade)
VALUES
    (1, 'NF123', 2),
    (2, 'NF456', 1),
    (3, 'NF789', 3);

-- Inserindo dados na tabela Filme_aluguel
INSERT INTO Filme_aluguel (cod_filme, preco_diario, qtdDisponivel)
VALUES
    (1, 5.99, 20),
    (2, 7.99, 15),
    (3, 6.99, 25);

-- Inserindo dados na tabela ComporAluguel
INSERT INTO ComporAluguel (cod_filme, idLocacao, status, data_dev_prevista, data_dev_efetiva)
VALUES
	(1, 4, 'Ativo', '2023-04-03', NULL),
    (1, 1, 'Ativo', '2023-04-03', NULL),
    (2, 2, 'Ativo', '2023-04-07', NULL),
    (3, 3, 'Ativo', '2023-04-12', NULL);

-- Inserindo dados na tabela IntegranteFilme
INSERT INTO IntegranteFilme (id, nome)
VALUES
    (1, 'Keanu Reeves'),
    (2, 'Marlon Brando'),
    (3, 'Leonardo DiCaprio');

-- Inserindo dados na tabela Participacao
INSERT INTO Participacao (cod_filme, id, diretor, atorPrincipal)
VALUES
    (1, 1, 'Sim', 'Sim'),
    (2, 2, 'Sim', 'Sim'),
    (3, 3, 'Não', 'Sim');

-- Inserindo dados na tabela Filial
INSERT INTO Filial (id_filial, cidade, estado)
VALUES
    (1, 'São Paulo', 'SP'),
    (2, 'Rio de Janeiro', 'RJ'),
    (3, 'Belo Horizonte', 'MG');

-- Inserindo dados na tabela ComporFilial
INSERT INTO ComporFilial (id_filial, id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
