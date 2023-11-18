CREATE PROCEDURE InserirLocacao
	@idLocacao int,
	@dtLocacao date,
	@dtReserva date,
	@idFuncionario int,
	@idCliente int
	AS
	BEGIN TRANSACTION 
		INSERT INTO Locacao VALUES (@idLocacao, @dtLocacao, @dtReserva, @idFuncionario, @idCliente)
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
	@codFilme int,
	@idLocacao int,
	@status varchar(15),
	@dtDevPrevista date,
	@dtDevefetiva date
	AS
	BEGIN TRANSACTION
		INSERT INTO ComporAluguel VALUES (@codFilme, @idLocacao, @status, @dtDevPrevista, @dtDevefetiva)
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
	@codFilme int,
	@idLocacao int,
	@status varchar(15),
	@dtDevPrevista date,
	@dtDevefetiva date
	AS
	BEGIN TRANSACTION
		INSERT INTO ComporAluguel VALUES (@codFilme, @idLocacao, @status, @dtDevPrevista, @dtDevefetiva)
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
	@status varchar(15),
	@idLocacao int
	AS
	BEGIN TRANSACTION
		INSERT INTO Filme VALUES (@codFilme, @titulo, @genero, @sinopse, @dtLancamento)
		if @@ROWCOUNT < 0  
		BEGIN
			INSERT INTO Filme VALUES (@codFilme, @titulo, @genero, @sinopse, @dtLancamento)
			INSERT INTO ComporAluguel VALUES (@codFilme, @idLocacao, @status, @dtDevPrevista, @dtDevefetiva)
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			INSERT INTO ComporAluguel VALUES (@codFilme, @idLocacao, @status, @dtDevPrevista, @dtDevefetiva)
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

CREATE PROCEDURE InserirParticipanteDeFilme
	@codFilme int,
	@idIntegrante int,
	@diretor varchar(3),
	@atorPrincipal varchar(3)
	AS
	BEGIN TRANSACTION
		INSERT INTO Participacao  VALUES (@codFilme, @idIntegrante, @diretor, @atorPrincipal)
		if @@ROWCOUNT > 0  
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			print ('Este filme nao existe')
			ROLLBACK TRANSACTION
			return 0
		END

CREATE PROCEDURE InserirFilmeParaCompra
	@codFilme int,
	@titulo varchar(255),
	@genero varchar(255),
	@sinopse varchar(255),
	@dtLancamento date,
	@ntFiscal varchar(255),
	@quantidade int
	AS
	BEGIN TRANSACTION
		INSERT INTO Filme VALUES (@codFilme, @titulo, @genero, @sinopse, @dtLancamento)
		if @@ROWCOUNT < 0  
		BEGIN
			INSERT INTO Filme VALUES (@codFilme, @titulo, @genero, @sinopse, @dtLancamento)
			INSERT INTO ComporCompra VALUES (@codFilme, @ntFiscal, @quantidade)
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			INSERT INTO ComporCompra VALUES (@codFilme, @ntFiscal, @quantidade)
			COMMIT TRANSACTION
			return 0
		END

CREATE PROCEDURE InserirCompra
	@ntFiscal varchar(255),
	@dtCompra date,
	@valor decimal(10,2),
	@idFuncionario int,
	@idCliente int
	AS
	BEGIN TRANSACTION 
		INSERT INTO Compra VALUES (@ntFiscal, @dtCompra, @valor, @idFuncionario, @idCliente)
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

CREATE PROCEDURE InserirFilmeNaCompra
	@codFilme int,
	@precoVenda decimal(10,2),
	@qtdeEstoque int
	AS
	BEGIN TRANSACTION
		INSERT INTO Filme_venda VALUES (@codFilme, @precoVenda, @qtdeEstoque)
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

CREATE PROCEDURE InserirFuncionario
	@id int,
	@enderecoFilial varchar(255),
	@nome varchar(255),
	@cpf varchar(11),
	@contato varchar(255),
	@endereco varchar(255)
	AS
	BEGIN TRANSACTION
		INSERT INTO Funcionario VALUES (@id, @enderecoFilial)
		if @@ROWCOUNT > 0  
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			INSERT INTO Pessoa VALUES (@nome, @cpf, @contato, @endereco)
			COMMIT TRANSACTION
			return 0
		END

CREATE PROCEDURE InserirCliente
	@id int,
	@tipo varchar(255),
	@nome varchar(255),
	@cpf varchar(11),
	@contato varchar(255),
	@endereco varchar(255)
	AS
	BEGIN TRANSACTION
		INSERT INTO Cliente VALUES (@id, @tipo)
		if @@ROWCOUNT > 0  
		BEGIN
			COMMIT TRANSACTION
			return 1
		END
		else
		BEGIN
			INSERT INTO Pessoa VALUES (@nome, @cpf, @contato, @endereco)
			COMMIT TRANSACTION
			return 0
		END

CREATE PROCEDURE AtualizarLocacao
	@idLocacao int,
	@dtLocacao date,
	@dtReserva date,
	@idFuncionario int,
	@idCliente int
	AS
	BEGIN TRANSACTION 
		UPDATE Locacao SET dtLocacao = @dtLocacao, dtReserva = @dtReserva, id_funcionario = @idFuncionario, id_cliente = @idCliente WHERE id = @idLocacao
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

CREATE PROCEDURE AtualizarFilme
	@codFilme int,
	@titulo varchar(255),
	@genero varchar(255),
	@sinopse varchar(255),
	@dtLancamento date
	AS
	BEGIN TRANSACTION 
		UPDATE Filme SET titulo = @titulo, genero = @genero, sinopse = @sinopse, dt_lancamento = @dtLancamento WHERE cod_filme = @codFilme
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

CREATE PROCEDURE EntregarFilme
	@idLocacao int,
	@codFilme int,
	@status varchar(15),
	@dtDevPrevista date,
	@dtDevefetiva date
	AS
	BEGIN TRANSACTION 
		UPDATE ComporAluguel SET cod_filme = @codFilme, status = 'Finalizado', data_dev_prevista = @dtDevPrevista, data_dev_efetiva = @dtDevefetiva WHERE idLocacao = @idLocacao
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

CREATE PROCEDURE CancelarFilme
	@idLocacao int,
	@codFilme int,
	@status varchar(15),
	@dtDevPrevista date,
	@dtDevefetiva date
	AS
	BEGIN TRANSACTION 
		UPDATE ComporAluguel SET cod_filme = @codFilme, status = 'Cancelado', data_dev_prevista = @dtDevPrevista, data_dev_efetiva = @dtDevefetiva WHERE idLocacao = @idLocacao
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

CREATE PROCEDURE AtualizarFilmeParaAluguel
	@codFilme int,
	@precoDiario decimal(10,2),
	@qtdDisponivel int
	AS
	BEGIN TRANSACTION 
		UPDATE Filme_aluguel SET preco_diario = @precoDiario, qtdDisponivel = @qtdDisponivel WHERE cod_filme = @codFilme
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

CREATE PROCEDURE AtualizarFilmeParaCompra
	@codFilme int,
	@precoVenda decimal(10,2),
	@qtdEstoque int
	AS
	BEGIN TRANSACTION 
		UPDATE Filme_venda SET preco_venda = @precoVenda, qtdeEstoque = @qtdEstoque WHERE cod_filme = @codFilme
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

CREATE PROCEDURE AtualizarIntegranteDeFilme
	@idIntegrante int,
	@nomeIntegrante varchar(255)
	AS
	BEGIN TRANSACTION 
		UPDATE IntegranteFilme SET nome = @nomeIntegrante WHERE id = @idIntegrante
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

CREATE PROCEDURE AtualizarParticipanteDeFilme
	@codFilme int,
	@idIntegrante int,
	@diretor varchar(3),
	@atorPrincipal varchar(3)
	AS
	BEGIN TRANSACTION 
		UPDATE Participacao SET diretor = @diretor, atorPrincipal = @atorPrincipal, id = @idIntegrante WHERE cod_filme = @codFilme
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

CREATE PROCEDURE AtualizarCompra
	@ntFiscal varchar(255),
	@dtCompra date,
	@valor decimal(10,2),
	@idFuncionario int,
	@idCliente int
	AS
	BEGIN TRANSACTION 
		UPDATE Compra SET data = @dtCompra, valor = @valor, id_funcionario = @idFuncionario, id_cliente = @idCliente WHERE nota_fiscal = @ntFiscal
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

CREATE PROCEDURE AtualizarFuncionario
	@id int,
	@enderecoFilial varchar(255)
	AS
	BEGIN TRANSACTION 
		UPDATE Funcionario SET enderecoFilial = @enderecoFilial WHERE id = @id
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

CREATE PROCEDURE AtualizarCliente
	@id int,
	@tipo varchar(255)
	AS
	BEGIN TRANSACTION 
		UPDATE Cliente SET tipo = @tipo WHERE id = @id
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
