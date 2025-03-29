-- Criando Índices para o Desafio

use company_constraints;
show tables;
desc department;

show index from department;
alter table department add index department_dnumber(Dnumber);
alter table department add index department_Mgr_ssn(Mgr_ssn);
alter table department add index department_Mgr_start_date(Mgr_start_date);

-- Qual o departamento com maior número de pessoas?

	select count(*) as Qtd_Pessoas, Dnumber, Dname, Mgr_start_date
	from department d 
    left join employee e on e.Dno = d.Dnumber
    group by Dnumber order by Qtd_Pessoas desc;
	
-- Quais são os departamentos por cidade? 

	select Dnumber, Dname, Dlocation from 
	dept_locations natural join
	department order by Dnumber desc;

-- Relação de empregados por departamento

	select Dnumber, Dname, CONCAT(Fname,' ', Minit,' ', Lname) as 
	Employee_Name from Employee e Left Join
	Department d on e.Dno = d.Dnumber
	order by d.Dnumber desc;

-- Criando Procedures para o Desafio - Novo Departamento

use company_constraints;
desc department;

delimiter \\
create procedure department_insert(
	in Dname_p varchar(15),
    in Dnumber_p int,
    in Mgr_start_date_p date
)
begin
	insert into department (Dname, Dnumber, Mgr_start_date) values (Dname_p, Dnumber_p, Mgr_start_date_p);
end \\
delimiter ;

call department_insert ('Frota', 8, null);

-- Criar procedure com instruções de inserção, remoção e atualização de dados no BD (CASE OU IF)
drop procedure department_new_insert_data;
delimiter \\
create procedure department_new_insert_data(
	in Num int,
    in Dept_num int,
    in Dept_loc varchar(40)
)
begin
	case num
		when 1 then
			insert into department(Dnumber, Dname, Mgr_start_date) values (Dept_num, Dept_loc, current_date());
		select * from department;
		when 2 then
			delete from department where Dnumber = Dept_num;
		select * from department;
        when 3 then
			update department set Dname = 'Research' where Dnumber = Dept_num;
		select * from department;
			else
				select * from department;
		END CASE;
end \\
delimiter ;

call department_new_insert_data (99, 1, 'Teste');