library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity barrelShifter is
	generic(	width: positive;
				toLeft: boolean;
				toRigth: boolean);
	port(	input: in std_logic_vector(width-1 downto 0);
			direction: in std_logic; --0:toLeft , 1:toRigth
			shift: in std_logic_vector(integer(ceil(log2(real(width))))-1 downto 0);
			output: out std_logic_vector(width-1 downto 0) );
end entity;

use ieee.numeric_std.all;
architecture behav0 of barrelShifter is
signal outputLeft, outputRigth: std_logic_vector(width-1 downto 0);
begin
	outputLeft <= std_logic_vector(shift_left(unsigned(input), to_integer(unsigned(shift))));
	outputRigth <= std_logic_vector(shift_right(unsigned(input), to_integer(unsigned(shift))));
	ifL: if toLeft and not toRigth generate
		output <= outputLeft;
	end generate;
	ifR: if toRigth and not toLeft generate
		output <= outputRigth;
	end generate;
	ifLR: if toRigth and toLeft generate
		output <= outputLeft when direction='0' else outputRigth;
	end generate;
end architecture;