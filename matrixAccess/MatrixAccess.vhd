library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity MatrixAccess is
	generic(
		NL: positive := 10;
		MC: positive := 8;
		BaseAddr: positive := 20;
		B: positive := 4
	);
	port(
		-- control inputs
		clock, reset: in std_logic;
		iniciar: in std_logic;
		-- data inputs
		i: in  std_logic_vector(integer(ceil(log2(real(NL))))-1 downto 0);
		j: in  std_logic_vector(integer(ceil(log2(real(MC))))-1 downto 0);
		-- control outputs
		pronto: out std_logic;
		-- data outputs
		data: out std_logic_vector(B-1 downto 0);
		-- RAM interface
		memQ: in std_logic_vector(7 downto 0);
		memData: out std_logic_vector(7 downto 0);
		memAddress: out std_logic_vector(15 downto 0);
		memWren: out std_logic
	);
end entity;

architecture structural of MatrixAccess is
--COMPLETE
begin
--COMPLETE
end architecture;