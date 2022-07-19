-- Listing 14.10: Parameterized Ring Counter
library ieee;
use ieee.std_logic_1164.all;
entity para_ring_counter is
	generic(width: natural);
	port(
		clk,rst: in std_logic;
		q: out std_logic_vector(width-1 downto 0)
	);
end entity;

--architecture using asynchronous initialization
architecture reset_arch of para_ring_counter is
	signal r_reg: std_logic_vector(width-1 downto 0);
	signal r_next: std_logic_vector(width-1 downto 0);
begin
--register
	process(clk,rst)
	begin
		if(rst='1') then
			r_reg <= (0=>'1', others=>'0');
		elsif(rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;
-- next-state logic
r_next <= r_reg(0) & r_reg(width-1 downto 1);
-- output logic
q <= r_reg;
end architecture;

-- architecture using self-correcting circuit
architecture self_correct_arch of para_ring_counter is
	signal r_reg: std_logic_vector(width-1 downto 0);
	signal r_next: std_logic_vector(width-1 downto 0);
	signal s_in: std_logic;
	alias r_high: std_logic_vector(width-2 downto 0) is r_reg(width01 downto 1);
begin
-- register
	process(clk,rst)
	begin
		if(rst='1') then
			r_reg <= (others => '0')
		elsif(rising_edge(clk) then
			r_reg <= r_next;
		end if;
	end process;
-- next-state logic
s_in <= '1' when r_high = (r_high'range => '0') else
	'0';
r_next <= s_in & r_reg(width-1 downto 1);
-- output logic
q <= r_reg;
end architecture
