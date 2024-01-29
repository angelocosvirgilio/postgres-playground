--select poly.get_my_input(1);

--select poly.get_my_input('ciao');


/*
create or replace function poly.optional_inputs(
	int_input text,
    your_date date DEFAULT CURRENT_DATE 
)
returns RECORD 
language plpgsql
as $$
declare 
	
begin
	--ret_value= int_input;

	return (int_input, your_date) ;
end; $$
*/

select poly.get_two_inputs('hello'/*, '2024-01-10'*/);