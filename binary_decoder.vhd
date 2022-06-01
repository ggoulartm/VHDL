-- Parameterized binary decoder using a for generate statement
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity binary_decoder is
	generic(width: natural);
	port(
		a: in std_logic_vector(width-1 downto 0);
		code: out std_logic_vector(2**width-1 downto 0)
	);
end entity;

architecture gen_arch of binary_decoder is
begin
	comp_gen:
	for i in 0 to (2**width-1) generate
		code(i) <= '1' when i=to_integer(unsigned(a)) else
			'0';
	end generate;
end architecture;
