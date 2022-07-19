library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binaryDecoder is
	generic(WIDTH:natural);
	port(
		a: in std_logic_vector(WIDTH-1 downto 0);
		code: out std_logic_vector(2**WIDTH-1 downto 0)
	);
end entity;
architecture loop_arch of binaryDecoder is
begin
	process(a)
	begin
		for i in 0 to(2**WIDTH-1) loop
			if i=to_integer(unsigned(a)) then
				code(i) <= '1';
			else
				code(i) <= '0';
			end if;
		end loop;
	end process;
end architecture;
