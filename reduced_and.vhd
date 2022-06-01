library ieee;
use std_logic_1164.all;
entity reduced_and is
	generic(width: natural);
	port(
		a: in std_logic_vector(width-1 downto 0);
		y: out std_logic
	);
end entity;
architecture exit_arch of reduced_and is
begin
	process(a)
		variable tmp: std_logic;
	begin
		tmp := '1';	
		for i in 0 to (width-1) loop
			if a(i)='0' then
				tmp :='0'
				exit;
			end if;
		end loop;
		y<=tmp;
	end process;
end architecture;
