--DFF
library ieee;
use ieee.std_logic_1164.all;
entity dff is
	port(
		clk: in std_logic;
		d: in std_logic;
		q: out std_logic
	);
end entity;

architecture arch of dff is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			q<=d;
		end if;
	end process;
end architecture;

--architecture using component instantiation
architecture gen_comp_arch of s2p_converter is
	signal q_reg: std_logic_vector(WIDTH downto 0);
	component dff
		port(
			clk: in std_logic;
			d: in std_logic;
			q: out std_logic
		);
	end component;
begin
	q_reg(WIDTH) <= si;
	dff_gen:
	for i in (WIDTH-1) downto 0 generate
		dff_array: dff
			port map (clk=>clk, d=>q_reg(i+1), q=>q_reg(i));
	end generate;
	q<=q_reg(WIDTH-1 downto 0);
end architecture;
