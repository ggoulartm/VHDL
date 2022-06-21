library ieee;
use ieee.std_logic_1164.all;

entity TopLevelMultiplicadorEntreRegs is
	generic(N: positive := 16);
	port(   
	    clock: in std_logic;
	    a, b: in std_logic_vector(N-1 downto 0);
		y: out std_logic_vector(2*N-1 downto 0) 
	);
end entity;

architecture struct of TopLevelMultiplicadorEntreRegs is
component multiplierCR is
	generic(N: positive);
	port(   
		 a, b: in std_logic_vector(N-1 downto 0);
		y: out std_logic_vector(2*N-1 downto 0) 
	);
end component;
component  registerN is
	generic(	width: natural;
				resetValue: integer := 0 );
	port(	-- control
			clock, reset, load: in std_logic;
			-- data
			input: in std_logic_vector(width-1 downto 0);
			output: out std_logic_vector(width-1 downto 0));
end component;
signal aQ, bQ: std_logic_vector(N-1 downto 0);
signal yD: std_logic_vector(2*N-1 downto 0);
begin
	regA: registerN generic map(N) port map (clock, '0', '1', a, aQ);
	regB: registerN generic map(N) port map (clock, '0', '1', b, bQ);
	mult: multiplierCR generic map(N) port map (aQ, bQ, yD);
	regy: registerN generic map(2*N) port map (clock, '0', '1', yD, y);
end architecture;
