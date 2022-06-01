library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity up_or_down_mode_counter is
	generic(
		width: natural
	);
	port(
		clk, reset: in std_logic;
		mode: in std_logic
		q: out std_logic_vector(width-1 downto 0)
	);
end entity;

architecture arch of up_or_down_mode_counter is
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
	r_next<=r_reg+1 when mode='1' else
		r_reg-1;
	--output logic
	q<=std_logic_vector(r_reg);
end architecture;
