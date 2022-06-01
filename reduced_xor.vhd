library ieee;
use ieee.std_logic_1164.all;

entity reduced_xor is
	generic(width: natural);
	port(
		a: in std_logic_vector(width-1 downto 0);
		y: out std_logic
	);
end entity;

architecture gen_arch of reduced_xor is
signal tmp: std_logic_vector(width-1 downto 0);
begin
	tmp(0)<=a(0);
	xor_gen:
	for i in 1 to (width-1) generate
		tmp(i) <= a(i) xor tmp(i-1);
	end generate;
	y<=tmp(width-1);
end architecture;
