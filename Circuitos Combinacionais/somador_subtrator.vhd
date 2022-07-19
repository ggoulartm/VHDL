library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addersubtractorsuperultra is
generic(
width: integer := 4;
isAdder: boolean := true;
isSubtractor: boolean := false;
calcOvf: boolean := true;
calcCout: boolean := true
);
port(
inpt0,inpt1: in std_logic_vector(width-1 downto 0);
op: in std_logic;
result: out std_logic_vector(width downto 0);
cout: out std_logic;
ovf: out std_logic
);
end entity;

architecture rtl of addersubtractorsuperultra is
signal
begin
	generateOverflow: 
	if calcOvf=true generate
	ovf <= result(width) xor result(width-1);
	end generate;

	generateAdder: 
	if isAdder=true generate
	result <= inpt0 + inpt1;
	end generate


	generateSubtractor: 
	if isSubtractor=true generate
	result <= inpt0 - inpt1;
	end generate


	generateCout: 
	if calcCout=true generate
	cout <= result(width);
	end generate
end architecture;
