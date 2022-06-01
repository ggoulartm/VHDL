library ieee;
use ieee.std_logic_1164.all;
entity fa is
	port(
		ai,bi,ci: in std_logic;
		so,co: out std_logic
	);
end entity;
architecture arch of fa is
begin
	so <= ai xor bi xor ci;
	co <= (ai and bi) or (ai and ci) or (bi and ci);
end architecture;
