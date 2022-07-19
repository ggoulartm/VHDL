library ieee;
use ieee.std_logic_1164.all;

entity cod_bin is
generic(n: positive := 2);
	port(
		inp: in std_logic_vector(2**n-1 downto 0);
		outp: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture cod of cod_bin is
signal tmp: integer;
begin
	tmp <= to_integer(unsigned(inp));
	outp <= std_logic_vector(tmp);
end architecture;
