select poly.test_optional_in_middle('ciao', '2024-01-06', 'mondo');

select poly.test_optional_in_middle('ciao', '2024-01-06');

select poly.test_optional_in_middle('ciao', 'mondo'); -- get error because the second parameter has to be a date

select poly.test_optional_in_middle(int_input => 'buongiorno', a_string =>'italia'); -- but you can use 

