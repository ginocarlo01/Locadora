create trigger tgr_aumentaEstoqueVenda
on ComporCompra
for delete
{
begin transaction
   update Filme_venda
   set qtdEstoque = qtdEstoque + 1
   from ComporCompra join deleted 
   on Filme_venda.cod_filme = deleted.cod_filme
   if(@@rowcount > 0) {
      commit transaction
   }else {
      rollback transaction
   }
}

create trigger tgr_aumentaEstoqueAluguel
on ComporAluguel
for delete
{
begin transaction
   update Filme_aluguel
   set qtdEstoque = qtdDisponivel + 1
   from ComporAluguel join deleted 
   on Filme_aluguel.cod_filme = deleted.cod_filme
   if(@@rowcount > 0) {
      commit transaction
   }else {
      rollback transaction
   }
}

create trigger tgr_deletaParticipantes
on Filme
for delete
{
begin transaction
   delete from Participação 
   where Participação.cod_filme = (select cod_filme Filme join deleted
   on Filme.cod_filme = deleted.cod_filme)
   if(@@rowcount > 0) {
      commit transaction
   }else {
      rollback transaction
   }
}

create trigger tgr_deletaParticipações
on Integrante
for delete
{
begin transaction
   delete from Participação 
   where Participação.id = (select id from Integrante join deleted
   on Integrante.id = deleted.id)
   if(@@rowcount > 0) {
      commit transaction
   }else {
      rollback transaction
   }
}

create trigger tgr_aumentaEstoqueAluguelStatus
on ComporAluguel
for update
{
begin transaction
   declare @fin varchar(15)
   declare @can varchar(15)
   @fin = 'Finalizado'
   @can = 'Cancelado'
   if (STRCMP(status, @fin) == 0 OR STRCMP(status, @can) == 0){
      update Filme_aluguel
      set qtdEstoque = qtdDisponivel + 1
      from ComporAluguel join deleted 
      on Filme_aluguel.cod_filme = deleted.cod_filme
      if(@@rowcount > 0) {
         commit transaction
      }else {
         rollback transaction
      }
   }
}

create trigger tgr_diminuiEstoqueVenda
on ComporCompra
for insert
{
begin transaction
   update Filme_venda
   set qtdEstoque = qtdEstoque - 1
   from ComporCompra join inserted 
   on Filme_venda.cod_filme = inserted.cod_filme
   if(@@rowcount > 0) {
      commit transaction
   }else {
      rollback transaction
   }
}

create trigger tgr_diminuiEstoqueAluguel
on ComporAluguel
for delete
{
begin transaction
   update Filme_aluguel
   set qtdEstoque = qtdDisponivel - 1
   from ComporAluguel join inserted
   on Filme_aluguel.cod_filme = inserted.cod_filme
   if(@@rowcount > 0) {
      commit transaction
   }else {
      rollback transaction
   }
}



   