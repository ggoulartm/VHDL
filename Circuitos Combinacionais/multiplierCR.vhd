library ieee;
use ieee.std_logic_1164.all;

entity multiplierCR is
	generic(N: positive);
	port(   
	    a, b: in std_logic_vector(N-1 downto 0);
		y: out std_logic_vector(2*N-1 downto 0) 
	);
end entity;
