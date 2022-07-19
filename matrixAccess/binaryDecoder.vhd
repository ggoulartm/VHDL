library ieee;
use ieee.std_logic_1164.all;

entity binaryDecoder is
	generic(inputWidth: positive);
	port(	input: in std_logic_vector(inputWidth-1 downto 0);
			output: out std_logic_vector(2**inputWidth-1 downto 0));
end entity;

use ieee.numeric_std.all;
architecture behav0 of binaryDecoder is
	constant one: unsigned(2**inputWidth-1 downto 0) := (0=>'1', others=>'0');
begin
	output <= std_logic_vector(shift_left(one, to_integer(unsigned(input)) ));
end architecture;