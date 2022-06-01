library ieee;
use ieee.std_logic_1164.all;

entity flipflopD is
	generic(width: natural)
	port(
		clk, en: std_logic;
		d: in std_logic_vector(width-1 downto 0);
		q: out std_logic_vector(width-1 downto 0)
	);
end entity;

architecture rtl of flipflopD is
begin
	process(clk,en)
	begin
		if(rising_edge(clk) and en='1') then
			q<=d;
		end if;
	end process;
end architecture;
