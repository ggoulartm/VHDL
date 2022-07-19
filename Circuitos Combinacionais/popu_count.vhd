--Parameterized population counter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.util_pkg.all;
entity popu_count is
	generic(width: natural);
	port(
		a: in std_logic_vector(width-1 downto 0);
		count: out std_logic_vector(log2c(width)-1 downto 0)
	);
end entity;
architecture loop_linear_arch of popu_count is
begin
	process(a)
		variable sum: unsigned(log2c(width)-1 downto 0);
	begin
		sum := (others=>'0');
		for i in 0 to (width-1) loop
			if a(i) = '1' then
				sum := sum + 1;
			end if;
		end loop;
		count <= std_logic_vector(sum);
	end process;
end architecture;
