--A Serial-to-parallel converter accepts input data serially and stores the data in a shift register. Since the output of the register can be accessed simultaneously, the serial data is converted into parallel format. A parameterized design is shown
--Listing 14.8 - Parameterized serial-toparallel converter using a clever array representation

library ieee;
use ieee.std_logic_1164.all;
entity s2p_converter is
	generic (WIDTH: natural) ;
	port(
		clk: in std_logic;
		si: in std_logic;
		q: out std_logic_vector(WIDTH-1 downto 0)
	);
end entity;

architecture array_arch of s2p_converter is
signal q_reg , q_next : std_logic_vector(WIDTH-1 downto 0);
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			q_reg <= q_next;
		end if;
	end process;
q_next <= si & q_reg(W1DTH-1 downto 1);
q <= q_reg;
end architecture;

architecture gen_proc_arch of s2p_converter is
	signal q_next: std_logic_vector(WIDTH-1 downto 0);		
	signal q_reg: std_logic_vector(WIDTH downto 0);
begin
	q_reg(WIDTH) <= si;
	dff_gen:
	for i in (WIDTH-1) downto 0 generate
		--DFF
		process(clk)
		begin
			if rising_edge(clk) then
				q_reg(i) <= q_next(i);
			end if;
		end process;
		-- next state logic
		q_next(i)<=q_reg(i+1);
	end generate;
	--output
	q<=q_reg(WIDTH-1 downto 0);
end architecture;
