-- Filmes em Estoque para uma dada Loja
create or replace procedure qtde_filmes_por_loja (
  IN in_film_id int,
  IN in_store_id int,
  OUT out_total int
)
language plpgsql
as $$
begin
    select count(i.inventory_id) into out_total
	from inventory i
	join store s on (s.store_id = i.store_id)
    join film f on (f.film_id = i.film_id)
	where f.film_id = in_film_id
	  and s.store_id = in_store_id;
end; $$

do $$
declare 
  total int;
begin
  call qtde_filmes_por_loja(1, 2, total);
  raise notice '%', total;
end; $$

----------------------

---Procedimento que receba film_id e retorne uma tabela contendo como
---resultado apenas os campos obrigatórios da tabela film

create or replace procedure get_film_fields (
  IN in_film_id int,
  OUT out_film_row record	
)
language plpgsql
as $$
begin
	select 
	  film_id, 
	  title, 
	  language_id, 
	  rental_duration, 
	  rental_rate, 
	  replacement_cost 
	  INTO out_film_row
	from film
	where film_id = in_film_id;
end; $$
do $$
declare
 row record;
begin
  call get_film_fields(12, row);
  raise notice '%', row;
end; $$