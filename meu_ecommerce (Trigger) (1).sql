-- Cria o banco de dados
create database meu_ecommerce;

use meu_ecommerce;

---------------------------------------------------------------------

create table Clientes(
	idClientes int(10) not null auto_increment primary key,
    nomeCompleto varchar(255) not null,
    dataNascimento date not null,
    dataCadastro datetime not null,
    email varchar(255) unique null,
    senha varchar(255)  not null,
    status int(1) 
);

-- Insere na tabela de clientes
insert into Clientes(nomeCompleto, dataNascimento, dataCadastro, email, senha,status) values ('Daniel Victor Martins Horacio', '2002-09-13', '2024-02-14', 'ALGOBacana@.com', '@#Key,Dotc@m7025', 1);
insert into Clientes(nomeCompleto, dataNascimento, dataCadastro, email, senha,status) values ('Daniel Victor Martins Horacio', '2002-09-13', '2024-02-14', 'ALGO@.com', '@#Key,Dotc@m7025', 1);
insert into Clientes(nomeCompleto, dataNascimento, dataCadastro, senha,status) values ('Daniel Victor Martins Horacio', '2002-09-13', '2024-02-14', '@#Key,Dotc@m7025', 1);

select * from Clientes;

---------------------------------------------------------------------

create table Pedidos(
	idPedidos int(10) not null auto_increment primary key,
    idClientes int not null,
    foreign key(idClientes) references Clientes(idClientes),
    dataCadastro datetime not null,
    precoFrete decimal(10,2) null,
    precoDesconto decimal(10,2) null,
    status int(1)
);

-- Insere na tabela de pedidos
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2024-05-15', 29.99,15,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2024-07-20', 30,10,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2023-12-21', 24.99,12,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2024-10-03', 12,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2023-12-21', 24.99,12,1);

select * from Pedidos;

truncate table Pedidos;

-- Exercicio 4 ATV 3
-- A) 
-- junta as tabelas de pedidos e clientes contendo apenas os atributos idPedidos; nomeCompleto e email
select idPedidos, nomeCompleto, email 
from Pedidos
inner join  Clientes on Clientes.idClientes = Pedidos.idClientes;

-- Exercicio 4 ATV 3 Left Join
-- A)
select idPedidos, nomeCompleto, email
from Clientes
left join Pedidos
on Clientes.idClientes = Pedidos.idPedidos;

-- Exercicio 4 ATV 3 Right Join
-- A)
select idPedidos, nomeCompleto, email
from Clientes
right join Pedidos
on Pedidos.idClientes = Pedidos.idPedidos;


---------------------------------------------------------------------

create table CuponsDesconto (
	idCuponsDesconto int not null auto_increment primary key,
	codigo varchar(30) not null,
    valor decimal(10,2),
    status int(1)
);

---------------------------------------------------------------------

create table PedidosPagamentos(
	idPedidosPagamentos int not null auto_increment primary key,
    idPedidos int not null,
    foreign key(idPedidos) references Pedidos(idPedidos),
    formaPagamento varchar(50) not null,
    valorPago decimal(10,2) not null,
    status int (1)
);

---------------------------------------------------------------------

create table PedidosEnvios(
	idPedidosEnvios int(10) not null auto_increment primary key,
    idPedidos int not null,
    foreign key(idPedidos) references Pedidos(idPedidos),
    dataCadastro datetime not null,
    dataEnvio datetime not null,
    status int(1)
);

---------------------------------------------------------------------

create table Produtos (
	idProdutos int not null auto_increment primary key,
    nome varchar(100) not null,
    preco double(10,2) not null,
    tipo int(1) not null,
    estoque int(10) not null,
    idProdutosCategorias int(10) not null,
    foreign key(idProdutosCategorias) references Produtos_Categorias(idProdutosCategorias),
    status int(1)
);

-- Insere na tabela de produtos
insert into Produtos(nome, preco, tipo, estoque, status) values('Dipirona', 10.95, 1, 5,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('IOPIDINE', 11, 0, 6,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('EMEND', 12, 1, 7,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('STRATTERA', 113, 1, 9,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('BACIIM', 144.99, 0, 10,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('ALUNBRIG', 15, 1, 8,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('Cefadroxil', 16, 0, 2,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('Citalopram', 28, 0, 9,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('Canamicina', 29, 1, 1,1);
insert into Produtos(nome, preco, tipo, estoque, status) values('Natalizumabe', 7000, 0, 1,1);
insert into Produtos(nome, preco, tipo, estoque, idProdutosCategorias, status) values('Natalizumabe', 7000, 0, 1, 1 ,1);

DELETE FROM Produtos WHERE nome = 'Natalizumabe';

 

select * from Produtos;
-- Seleciona o valor maximo da tabela de produtos do atributo preco
select Max(Preco) from produtos;

truncate table Produtos;
---------------------------------------------------------------------

create table PedidosProdutos(
	idPedidos int(10) not null,
    foreign key(idPedidos) references Pedidos(idPedidos),
    idProdutos int(10) not null,
    foreign key(idProdutos) references Produtos(idProdutos),
    quantidade int(10) not null,
    preco decimal(10,2) not null
);

-- Insere na tabela de PedidosProdutos
insert into PedidosProdutos(idPedidos, idProdutos, quantidade, preco) values(1,5,5,144.99);
insert into PedidosProdutos(idPedidos, idProdutos, quantidade, preco) values(2,8,1,28.00);
insert into PedidosProdutos(idPedidos, idProdutos, quantidade, preco) values(3,1,6,10.95);
insert into PedidosProdutos(idPedidos, idProdutos, quantidade, preco) values(4,6,3,15.00);
insert into PedidosProdutos(idPedidos, idProdutos, quantidade, preco) values(4,3,4,12.00);
insert into PedidosProdutos(idPedidos, idProdutos, quantidade, preco) values(4, 10, 1, '7000.00');

select * from PedidosProdutos;	
select * from Produtos;
select * from Pedidos;
drop table PedidosProdutos;

-- Faz a soma dos Pedidos e Produtos totais do cliente
select sum(preco) as total from PedidosProdutos;

-- Exercicio 4 ATV 3
-- B)
select p.nome, sum(pp.quantidade) as quantidade_perdida
from Produtos as p
  join PedidosProdutos as pp on p.idProdutos = pp.idProdutos
group by
  p.nome;

-- Exercicio 4 ATV3 Left Join
-- B)  
  select p.nome, sum(pp.quantidade) as quantidade_perdida
from Produtos as p
  left join PedidosProdutos as pp on p.idProdutos = pp.idProdutos
group by
  p.nome;
  
-- Exercicio 4 ATV3 Right Join
-- B)  
  select p.nome, sum(pp.quantidade) as quantidade_perdida
from Produtos as p
  right join PedidosProdutos as pp on p.idProdutos = pp.idProdutos
group by
	p.nome;

-- Exercicio 1 ATV 3
create table Produtos_Categorias(
	idProdutosCategorias int not null auto_increment primary key,
    nomeCategorias varchar(20) not null,
    status int(1) 
);

alter table Produtos_Categorias;
describe Produtos_Categorias;

-- Exercicio 2 e 3 ATV 3
select * from Produtos_Categorias;
select * from Produtos;
insert into Produtos_Categorias(nomeCategorias,status) values ('Remedio');
insert into Produtos_Categorias(nomeCategorias,status) values ('Remedio Controlado', 0);
insert into Produtos_Categorias(nomeCategorias,status) values ('Remedio Generico', 0);


-- Exercicio 4 ATV 3 
-- C)
select pc.nomeCategorias, p.nome 
from Produtos as p
	JOIN Produtos_Categorias AS pc ON p.idProdutosCategorias = pc.idprodutoscategorias;

-- Exercicio 4 ATV3 Left Join
-- C)  
select pc.nomeCategorias, p.nome 
from Produtos as p
	left join Produtos_Categorias AS pc ON p.idProdutosCategorias = pc.idprodutoscategorias;

-- Exercicio 4 ATV3 right Join
-- C)  
select p.idProdutosCategorias, p.nome, c.nomeCategorias
from Produtos_Categorias as c
	right join produtos p on c.idProdutosCategorias = p.idProdutosCategorias;


delimiter $
create trigger EnviosVenda after insert
on PedidosProdutos
for each row
begin
	update Produtos set estoque = estoque - new.quantidade
where idProdutos = new.idProdutos;
END $

create trigger EnviosVenda_Delete after delete
on PedidosProdutos
for each row
begin
	update Produtos set estoque = estoque + old.quantidade
where idProdutos = old.idProdutos;
END $

delimiter ;

show triggers;

INSERT INTO PedidosEnvios(idPedidos, dataCadastro, dataEnvio, status) VALUES (1, '2024-03-12', '2024-04-15', 1);
INSERT INTO PedidosEnvios(idPedidos, dataCadastro, dataEnvio, status) VALUES (2, '2025-04-16', '2026-05-19', 1);
INSERT INTO PedidosEnvios(idPedidos, dataCadastro, dataEnvio, status) VALUES (3, '2026-05-18', '2027-05-16', 1);

select * from PedidosEnvios;
select * from PedidosPagamentos;
select * from Pedidos;

delete from PedidosPagamentos where idPedidosPagamentos >0;

insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2023-12-21', 39,10,0);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2023-12-21', 39,10,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2023-12-21', 39,10,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2023-12-21', 100,0,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2024-01-24', 15,50,1);
insert into Pedidos(idClientes, dataCadastro, precoFrete, precoDesconto, status) values(1,'2024-01-24', 15,50,1);

drop trigger Total_pedidos;

delimiter $

create trigger Pagamento_status after insert
on Pedidos 
for each row
begin
	insert into PedidosPagamentos (idPedidos, formaPagamento, valorPago, status) values(new.idPedidos, 'boleto', 0, 0);
END;


create trigger criptografar_senha_cliente
before insert on Clientes
for each row
begin
  set NEW.senha = md5(NEW.senha);
END;   

END $

create trigger Total_pedidos
after insert on Produtos
for each row
begin
	update PedidosProdutos set preco = ( select sum(quantidade * preco)
	from PedidosProdutos
    where idPedidos = new.idPedidos
    );
END;

END $