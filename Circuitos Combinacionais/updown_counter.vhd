-- Comparison to configuration - The selected hardware creation can also be achieved by configuration. We can construct multiple architecture bodies, each containing a specific feature. Instead of using the feature generic, we can select the desired feature by configuring the entity with a proper architecture body.
-- For example, for the previous up-or-down free-running counter, we can eliminate the UP generic and construct one architecture body with a counting-up sequence and another with a counting-down sequence. The VHDL code is shown in listing 14.20

--Up-or-Down Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity updown_counter is
	generic(width: natural);
	port(
		clk,reset: in std_logic;
		q: out std_logic_vector(width-1 downto 0)
	);
end entity;
--architecture for the count-up sequence
architecture up_arch of updown_counter is
	signal r_reg:unsigned(width-1 downto 0);
	signal r_next:unsigned(width-1 downto 0);
begin
	--register
	process(clk,reset)
	begin
		if(reset='1') then
			r_next<=(others=>'0');
		elsif rising_edge(clk) then
			r_reg<=r_next;
		end if;
	end process;
	--next-state logic
	r_next <= r_reg + 1;
	--output logic
	q<=r_reg;
end architecture;

architecture down_arch of updown_counter is
	signal r_reg:unsigned(width-1 downto 0);
	signal r_next:unsigned(width-1 downto 0);
begin
	--register
	process(clk,reset)
	begin
		if(reset='1') then
			r_next<=(others=>'0');
		elsif rising_edge(clk) then
			r_reg<=r_next;
		end if;
	end process;
	--next-state logic
	r_next <= r_reg - 1;
	--output logic
	q<=std_logic_vector(r_reg);
end architecture;
