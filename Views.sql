CREATE VIEW RelatorioVendasGeral
AS
SELECT COUNT(C.nota_fiscal) AS 'Quantidade de Vendas', DAY(C.data) AS Dia, MONTH(C.data) AS Mês, YEAR(C.data) AS Ano 
FROM Compra C 
GROUP BY DAY(C.data), MONTH(C.data), YEAR(C.data)
go
SELECT * FROM RelatorioVendasGeral
go

CREATE VIEW RelatorioLocacoesGeral
AS
SELECT COUNT(L.id) AS 'Quantidade de Alugueis', DAY(L.data) AS Dia, MONTH(L.data) AS Mês, YEAR(L.data) AS Ano 
FROM Locacao L 
GROUP BY DAY(L.data), MONTH(L.data), YEAR(L.data)
go
SELECT * FROM RelatorioLocacoesGeral
go

---
CREATE VIEW RelatorioFilmes AS
SELECT
    F.cod_filme AS 'Codigo Filme',
    F.titulo AS 'Titulo',
    COUNT(DISTINCT CA.idLocacao) AS 'Quantidade Locacoes',
    COUNT(DISTINCT CC.nota_fiscal) AS 'Quantidade Vendas'
FROM
    Filme F
LEFT JOIN
    ComporAluguel CA ON F.cod_filme = CA.cod_filme
LEFT JOIN
    ComporCompra CC ON F.cod_filme = CC.cod_filme
GROUP BY
    F.cod_filme, F.titulo
go

SELECT * FROM RelatorioFilmes
go
---

ALTER VIEW RelatorioGerenciamentoFuncionarios AS
SELECT
    F.id AS 'ID Funcionario',
    P.nome AS 'Nome',
    COUNT(DISTINCT L.id) AS 'Locacoes',
    COUNT(DISTINCT C.nota_fiscal) AS 'Vendas'
FROM
    Funcionario F
INNER JOIN
    Pessoa P ON P.id = F.id
INNER JOIN
    Compra C ON F.id = C.id_funcionario
INNER JOIN
    Locacao L ON F.id = L.id_funcionario
GROUP BY
    F.id, P.nome

select * from RelatorioGerenciamentoFuncionarios
go

---

CREATE VIEW RelatorioGerenciamentoFiliais AS
SELECT
    F.id_filial AS 'ID Filial',
    Filial.nomeFilial AS 'Nome Filial',
    COUNT(DISTINCT CF.id) AS 'QuantidadeFuncionarios',
    COUNT(DISTINCT C.nota_fiscal) AS 'QuantidadeVendas',
    COUNT(DISTINCT L.id) AS 'QuantidadeLocacoes'
FROM
    Filial
LEFT JOIN
    ComporFilial CF ON Filial.id_filial = CF.id_filial
LEFT JOIN
    Funcionario F ON CF.id = F.id
LEFT JOIN
    Compra C ON F.id = C.id_funcionario
LEFT JOIN
    Locacao L ON F.id = L.id_funcionario
GROUP BY
    F.id_filial, Filial.nomeFilial
go

SELECT * FROM RelatorioGerenciamentoFiliais
go

---
-- Criando a view para o relatório de estados
CREATE VIEW RelatorioEstados AS
SELECT
    Filial.estado AS 'Estado',
    COUNT(DISTINCT C.nota_fiscal) AS 'QuantidadeVendas',
    COUNT(DISTINCT L.id) AS 'QuantidadeLocacoes'
FROM
    Filial
LEFT JOIN
    ComporFilial CF ON Filial.id_filial = CF.id_filial
LEFT JOIN
    Funcionario F ON CF.id = F.id
LEFT JOIN
    Compra C ON F.id = C.id_funcionario
LEFT JOIN
    Locacao L ON F.id = L.id_funcionario
GROUP BY
    Filial.estado
go
select * from RelatorioEstados
---
-- Criando a view para o relatório de cidades
CREATE VIEW RelatorioCidades AS
SELECT
    Filial.cidade AS 'Cidade',
    Filial.estado AS 'Estado',
    COUNT(DISTINCT C.nota_fiscal) AS 'QuantidadeVendas',
    COUNT(DISTINCT L.id) AS 'QuantidadeLocacoes'
FROM
    Filial
LEFT JOIN
    ComporFilial CF ON Filial.id_filial = CF.id_filial
LEFT JOIN
    Funcionario F ON CF.id = F.id
LEFT JOIN
    Compra C ON F.id = C.id_funcionario
LEFT JOIN
    Locacao L ON F.id = L.id_funcionario
GROUP BY
    Filial.cidade, Filial.estado
go
select * from RelatorioCidades

---

CREATE VIEW RelatorioEstoqueFilmes AS
SELECT F.cod_filme as 'Codigo Filme', F.titulo as 'Titulo', FV.qtdeEstoque as 'Disponivel para venda', FA.qtdDisponivel as 'Disponivel para aluguel'
FROM Filme F
INNER JOIN Filme_venda FV ON F.cod_filme = FV.cod_filme
INNER JOIN Filme_aluguel FA ON F.cod_filme = FA.cod_filme
go
SELECT * FROM RelatorioEstoqueFilmes
go

---

ALTER VIEW PesquisaLocal AS
SELECT DISTINCT
    F.cod_filme AS 'Código do Filme',
    F.titulo AS 'Título',
    F.genero AS 'Gênero',
    F.sinopse AS 'Sinopse',
    F.dt_lancamento AS 'Data de Lançamento',
    FA.preco_diario AS 'Preço Locação Diário',
    FA.qtdDisponivel AS 'Quantidade Disponível Locação',
    FV.preco_venda AS 'Preço Venda',
    FV.qtdeEstoque AS 'Quantidade Disponível Venda'
FROM
    Filme F
LEFT JOIN
    Filme_aluguel FA ON F.cod_filme = FA.cod_filme
LEFT JOIN
    Filme_venda FV ON F.cod_filme = FV.cod_filme
LEFT JOIN
    ComporAluguel CA ON F.cod_filme = CA.cod_filme
LEFT JOIN
    ComporCompra CC ON F.cod_filme = CC.cod_filme
LEFT JOIN
    Locacao L ON CA.idLocacao = L.id
LEFT JOIN
    Compra C ON CC.nota_fiscal = C.nota_fiscal
LEFT JOIN
    Participacao P ON F.cod_filme = P.cod_filme
LEFT JOIN
    IntegranteFilme I ON P.id = I.id
go
select * from PesquisaLocal
go