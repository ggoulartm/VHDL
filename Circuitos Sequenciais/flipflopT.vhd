library ieee;
use ieee.std_logic_1164.all;

entity flipflopT is
	generic(width: natural)
	port(
		clk,rst: std_logic;
		T: in std_logic;
		q: out std_logic_vector(width-1 downto 0)
	);
end entity;

architecture rtl of flipflopT is
begin
q<=0;
	process(clk,T,rst)
	begin
		if(rst='1') then
			q<=0;
		elsif(rising_edge(clk) and T='1') then
			q<=not q;
		end if;
	end process;
end architecture;
