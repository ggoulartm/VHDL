-- Parameterized two-dimensional multiplexer using a genuine array
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.util_pkg.all;
entity mux2d is
	generic(
		P: natural; --number of input ports
		B: natural --number of bits per port
	);
	port(
		a:in std_logic_2d(P-1 downto 0, B-1 downto 0);
		sel:in std_logic_vector(log2c(P)-1 downto 0);
		y:out std_logic_vector(B-1 downto 0)
	);
end entity;
architecture two_d_arch of mux2d is
	type std_logic_2d is
		array(natural range <>, natural range <>) of std_logic;
begin
	process(a,sel)
	begin
		y<=(others=>'0');
		for i in 0 to (P-1) loop
			if i = to_integer(unsigned(sel)) then
				for j in 0 to (B-1) loop
					y(j) <= a(i,j);
				end loop;
			end if;
		end loop;
	end process;
end architecture;
