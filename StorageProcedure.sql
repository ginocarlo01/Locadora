CREATE PROCEDURE InserirLocacao
	@idLocacao int,
	@dtLocacao date,
	@idFuncionario int,
	@valor numeric(5,2)
	AS
	BEGIN TRANSACTION 
		INSERT INTO Locacao VALUES (@idLocacao, @dtLocacao, @idFuncionario, @valor)
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

CREATE PROCEDURE InserirReserva
	@idReserva int,
	@dtReserva date,
	@idFuncionario int,
	@valor numeric(5,2)
	AS
	BEGIN TRANSACTION 
		INSERT INTO Locacao VALUES (@idReserva, @dtReserva, @idFuncionario, @valor)
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

CREATE PROCEDURE InserirFilmeNaLocacao
	@dtDevPrevista date,
	@dtDevefetiva date,
	@status varchar(15)
	AS
	BEGIN TRANSACTION
		INSERT INTO ComporAluguel VALUES (@dtDevPrevista, @dtDevefetiva, @status)
		if @@ROWCOUNT > 0 AND @status = 'Ativo' 
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			ROLLBACK TRANSACTION
			return 0
		END

CREATE PROCEDURE InserirFilmeNaReserva
	@dtDevPrevista date,
	@dtDevefetiva date,
	@status varchar(15)
	AS
	BEGIN TRANSACTION
		INSERT INTO ComporAluguel VALUES (@dtDevPrevista, @dtDevefetiva, @status)
		if @@ROWCOUNT > 0 AND @status = 'Reserva' 
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			ROLLBACK TRANSACTION
			return 0
		END

CREATE PROCEDURE InserirFilmeParaAluguel
	@codFilme int,
	@titulo varchar(255),
	@genero varchar(255),
	@sinopse varchar(255),
	@dtLancamento date,
	@dtDevPrevista date,
	@dtDevefetiva date,
	@status varchar(15)
	AS
	BEGIN TRANSACTION
		INSERT INTO Filme VALUES (@codFilme, @titulo, @genero, @sinopse, @dtLancamento)
		if @@ROWCOUNT < 0  
		BEGIN
			INSERT INTO Filme VALUES (@codFilme, @titulo, @genero, @sinopse, @dtLancamento)
			INSERT INTO ComporAluguel VALUES (@dtDevPrevista, @dtDevefetiva, @status)
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			INSERT INTO ComporAluguel VALUES (@dtDevPrevista, @dtDevefetiva, @status)
			COMMIT TRANSACTION
			return 0
		END

CREATE PROCEDURE InserirFilme
	@codFilme int,
	@titulo varchar(255),
	@genero varchar(255),
	@sinopse varchar(255),
	@dtLancamento date
	AS
	BEGIN TRANSACTION
		INSERT INTO Filme VALUES (@codFilme, @titulo, @genero, @sinopse, @dtLancamento)
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

CREATE PROCEDURE InserirIntegranteDeFilme
	@idIntegrante int,
	@nomeIntegrante varchar(255)
	AS
	BEGIN TRANSACTION
		INSERT INTO IntegranteFilme  VALUES (@idIntegrante, @nomeIntegrante)
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