CREATE PROCEDURE InserirLocacao
	@idLocacao INT,
	@dtLocacao DATE,
	@idFuncionario INT,
	@idCliente INT,
	@valor NUMERIC(5,2)
AS
BEGIN
	BEGIN TRANSACTION;

		INSERT INTO Locacao (id, dtLocacao, id_funcionario, id_cliente, valor)
		VALUES (@idLocacao, @dtLocacao, @idFuncionario, @idCliente, @valor)

		IF @@ROWCOUNT > 0
		BEGIN
			COMMIT TRANSACTION;
			RETURN 1;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;
		END
END;
---
CREATE PROCEDURE InserirReserva
	@idReserva INT,
	@dtLocacao DATE,
	@idFuncionario INT,
	@idCliente INT,
	@valor NUMERIC(5,2)
AS
BEGIN
	BEGIN TRANSACTION;

		INSERT INTO Locacao (id, dtReserva, id_funcionario, id_cliente, valor)
		VALUES (@idReserva, @dtLocacao, @idFuncionario, @idCliente, @valor)

		IF @@ROWCOUNT > 0
		BEGIN
			COMMIT TRANSACTION;
			RETURN 1;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;
		END
END;
---
CREATE PROCEDURE InserirCliente
    @id int,
	@nome varchar(255),
	@cpf varchar(11),
	@contato varchar(255),
	@endereco varchar(255),
	@tipo VARCHAR(255)
AS
BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Pessoa WHERE Pessoa.id = @id)
    BEGIN
        INSERT INTO Pessoa
        VALUES (@id, @nome, @nome, @cpf, @contato, @endereco);
    END

    INSERT INTO Cliente 
    VALUES (@id, @tipo);

	IF @@ROWCOUNT > 1
	BEGIN 
		COMMIT TRANSACTION;
		RETURN 1;
	END
	ELSE
	BEGIN 
		ROLLBACK TRANSACTION;
		RETURN 0;
	END
go
---

CREATE PROCEDURE InserirFuncionario
    @id int,
	@nome varchar(255),
	@cpf varchar(11),
	@contato varchar(255),
	@endereco varchar(255),
	@dtContratacao DATE
AS
BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Pessoa WHERE Pessoa.id = @id)
    BEGIN
        INSERT INTO Pessoa
        VALUES (@id, @nome, @nome, @cpf, @contato, @endereco);
    END

    INSERT INTO Funcionario 
    VALUES (@id, @dtContratacao);

	IF @@ROWCOUNT > 1
	BEGIN 
		COMMIT TRANSACTION;
		RETURN 1;
	END
	ELSE
	BEGIN 
		ROLLBACK TRANSACTION;
		RETURN 0;
	END
go
---

CREATE PROCEDURE InserirFilmeAluguel
    @cod_filme INT,
    @titulo VARCHAR(255),
    @genero VARCHAR(255),
    @sinopse VARCHAR(255),
    @dt_lancamento DATE,
    @preco_diario DECIMAL(10,2),
    @qtdDisponivel INT
AS
BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Filme WHERE cod_filme = @cod_filme)
    BEGIN
        INSERT INTO Filme (cod_filme, titulo, genero, sinopse, dt_lancamento)
        VALUES (@cod_filme, @titulo, @genero, @sinopse, @dt_lancamento);
    END

    INSERT INTO Filme_aluguel (cod_filme, preco_diario, qtdDisponivel)
    VALUES (@cod_filme, @preco_diario, @qtdDisponivel);

	IF @@ROWCOUNT > 1
	BEGIN 
		COMMIT TRANSACTION;
		RETURN 1;
	END
	ELSE
	BEGIN 
		ROLLBACK TRANSACTION;
		RETURN 0;
	END
go
---
CREATE PROCEDURE InserirFilmeVenda
    @cod_filme INT,
    @titulo VARCHAR(255),
    @genero VARCHAR(255),
    @sinopse VARCHAR(255),
    @dt_lancamento DATE,
    @preco_venda DECIMAL(10,2),
    @qtdeEstoque INT
AS
BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Filme WHERE cod_filme = @cod_filme)
    BEGIN
        INSERT INTO Filme (cod_filme, titulo, genero, sinopse, dt_lancamento)
        VALUES (@cod_filme, @titulo, @genero, @sinopse, @dt_lancamento);
    END

    INSERT INTO Filme_venda (cod_filme, preco_venda, qtdeEstoque)
    VALUES (@cod_filme, @preco_venda, @qtdeEstoque);

    IF @@ROWCOUNT > 0
    BEGIN 
        COMMIT TRANSACTION;
        RETURN 1;
    END
    ELSE
    BEGIN 
        ROLLBACK TRANSACTION;
        RETURN 0;
    END

go
---
CREATE PROCEDURE EntregarFilme
	@idLocacao int,
	@codFilme int,
	@dtDevefetiva date
	AS
	BEGIN TRANSACTION 
		UPDATE ComporAluguel SET status = 'Finalizado', data_dev_efetiva = @dtDevefetiva WHERE idLocacao = @idLocacao and cod_filme = @codFilme
		if @@ROWCOUNT > 0
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			ROLLBACK TRANSACTION
			return 0
		END

---
CREATE PROCEDURE CancelarFilme
	@idLocacao int,
	@codFilme int,
	@dtDevefetiva date
	AS
	BEGIN TRANSACTION 
		UPDATE ComporAluguel SET status = 'Cancelado', data_dev_efetiva = @dtDevefetiva WHERE idLocacao = @idLocacao and cod_filme = @codFilme
		if @@ROWCOUNT > 0
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			ROLLBACK TRANSACTION
			return 0
		END
---
CREATE PROCEDURE InserirFilmeNaLocacao
	@codFilme int,
	@idLocacao int,
	@dtDevPrevista date
	AS
	BEGIN TRANSACTION
		INSERT INTO ComporAluguel VALUES (@codFilme, @idLocacao, 'Ativo', @dtDevPrevista)
		if @@ROWCOUNT > 0
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			ROLLBACK TRANSACTION
			return 0
		END
---
CREATE PROCEDURE InserirFilmeNaReserva
	@codFilme int,
	@idLocacao int,
	@dtDevPrevista date
	AS
	BEGIN TRANSACTION
		INSERT INTO ComporAluguel VALUES (@codFilme, @idLocacao, 'Reservado', @dtDevPrevista)
		if @@ROWCOUNT > 0
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			ROLLBACK TRANSACTION
			return 0
		END