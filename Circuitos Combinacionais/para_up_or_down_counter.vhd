library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity para_up_or_down_counter is
	generic(
		width: natural;
		UP: natural
	);
	port(
		clk, reset: in std_logic;
		q: out std_logic_vector(width-1 downto 0)
	);
end entity;

architecture arch of para_up_or_down_counter is
	signal r_reg: unsigned(width-1 downto 0);
	signal r_next: unsigned(width-1 downto 0);
begin
	--register
	process(clk,reset)
	begin
		if(reset='1') then
			r_reg<=(others=>'0');
		elsif rising_edge(clk) then
			r_reg<=r_next;
		end if;
	end process;
	--next-state logic
	inc_gen: --incrementor
	if UP = 1 generate
		r_next<=r_reg+1;
	end generate;
	dec_gen: --decrementor
	if UP/=1 generate
		r_next<=r_reg-1;
	end generate;
	--output logic
	q<=std_logic_vector(r_reg);
end architecture;
