CREATE TABLE Pessoa (
id INT NOT NULL,
nome VARCHAR(255) NOT NULL,
cpf VARCHAR(11) NOT NULL,
contato VARCHAR(255) NOT NULL,
endereco VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
)
go

CREATE TABLE Funcionario (
id INT NOT NULL,
dtContratacao DATE NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES Pessoa
)
go

CREATE TABLE Cliente (
id INT NOT NULL,
tipo VARCHAR(255) NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES Pessoa
)
go

CREATE TABLE Compra (
nota_fiscal VARCHAR(255) NOT NULL,
data DATE NOT NULL,
valor DECIMAL(10,2) NOT NULL,
id_funcionario INT NOT NULL,
id_cliente INT NOT NULL,
PRIMARY KEY (nota_fiscal),
FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id),
FOREIGN KEY (id_cliente) REFERENCES Cliente (id)
)
go

create index ixcompra_cli on Compra(id_cliente)
go
create index ixcomra_func on Compra(id_funcionario)
go

CREATE TABLE Locacao (
id INT NOT NULL,
data DATE NOT NULL,
dtLocacao DATE NOT NULL,
dtReserva DATE,
id_funcionario INT NOT NULL,
id_cliente INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id),
FOREIGN KEY (id_cliente) REFERENCES Cliente (id)
)
go

create index ixlocacao_cli on Locacao(id_cliente)
go
create index ixlocacao_func on Locacao(id_funcionario)
go

CREATE TABLE Filme (
cod_filme INT NOT NULL,
titulo VARCHAR(255) NOT NULL,
genero VARCHAR(255) NOT NULL,
sinopse VARCHAR(255) NOT NULL,
dt_lancamento DATE NOT NULL,
PRIMARY KEY (cod_filme)
)
go

CREATE TABLE Filme_venda (
cod_filme INT NOT NULL,
preco_venda DECIMAL(10,2) NOT NULL,
qtdeEstoque INT NOT NULL,
PRIMARY KEY (cod_filme),
FOREIGN KEY (cod_filme) REFERENCES Filme (cod_filme)
)
go

CREATE TABLE ComporCompra (
cod_filme INT NOT NULL,
nota_fiscal VARCHAR(255) NOT NULL,
quantidade INT NOT NULL,
PRIMARY KEY (cod_filme, nota_fiscal),
FOREIGN KEY (cod_filme) REFERENCES Filme_venda (cod_filme),
FOREIGN KEY (nota_fiscal) REFERENCES Compra (nota_fiscal)
)
go

create index ixcompra_filme on ComporCompra(cod_filme)
go

create index ixcompra_nota on ComporCompra(nota_fiscal)
go

CREATE TABLE Filme_aluguel (
cod_filme INT NOT NULL,
preco_diario DECIMAL(10,2) NOT NULL,
qtdDisponivel INT NOT NULL,
PRIMARY KEY (cod_filme),
FOREIGN KEY (cod_filme) REFERENCES Filme (cod_filme)
)
go

CREATE TABLE ComporAluguel (
cod_filme INT NOT NULL,
idLocacao INT NOT NULL,
status varchar(15) NOT NULL,
data_dev_prevista DATE NOT NULL,
data_dev_efetiva DATE,
PRIMARY KEY (cod_filme, idLocacao),
FOREIGN KEY (cod_filme) REFERENCES Filme_aluguel (cod_filme),
FOREIGN KEY (idLocacao) REFERENCES Locacao (id)
)
go

create index ixaluguel_filme on ComporAluguel(cod_filme)
go

create index ixaluguel_locaca on ComporAluguel(idLocacao)
go


CREATE TABLE IntegranteFilme (
id INT NOT NULL,
nome VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
)
go

CREATE TABLE Participacao (
cod_filme INT NOT NULL,
id INT NOT NULL,
diretor varchar(3) NOT NULL,
atorPrincipal varchar(3) NOT NULL,
PRIMARY KEY (cod_filme, id),
FOREIGN KEY (cod_filme) REFERENCES Filme (cod_filme),
FOREIGN KEY (id) REFERENCES IntegranteFilme (id)
)
go

create index ixparticipacao_integrante on Participacao(id)
go

create index ixparticipacao_filme on Participacao(cod_filme)
go

CREATE TABLE Filial (
id_filial INT NOT NULL,
cidade VARCHAR(30) NOT NULL,
estado VARCHAR(30) NOT NULL,
nomeFilial VARCHAR(255) NOT NULL
PRIMARY KEY (id_filial)
)
go

CREATE TABLE ComporFilial (
id_filial INT NOT NULL,
id INT NOT NULL
PRIMARY KEY (id_filial, id),
FOREIGN KEY (id_filial) REFERENCES Filial (id_filial),
FOREIGN KEY (id) REFERENCES Funcionario (id)
)
go

create index ixcompor_filial on ComporFilial(id_filial)
go

create index ixfilial_funcionario on ComporFilial(id)
go