library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.util_pkg.all;
entity shiftermult is
	generic(n:natural);
	port(
		clk,reset: in std_logic;
		start: in std_logic;
		a_in,b_in:in std_logic_vector(n-1 downto 0);
		ready: out std_logic;
		r: out std_logic_vector(2*n-1 downto 0)
	);
end entity;
architecture shift_add_arch of shiftermult is
	constant C_WIDTH: integer := log2c(WIDTH)+1;
	constant C_INIT: unsigned(C_WIDTH-1 downto 0) := to_unsigned(n,C_WIDTH);
	type state_type is (idle,add_shft);
	signal state_reg, state_next: state_type;
	signal a_reg, a_next: unsigned(n-1 downto 0);
	signal n_reg, n_next: unsigned(C_WIDTH-1 downto 0);
	signal p_reg, p_next: unsigned(2*n downto 0);
	alias pu_next: unsigned(n downto 0) is
		p_next(2*n downto n);
	alias pu_reg: unsigned(n downto 0) is
		p_reg(2*n downto n);
	alias pl_reg: unsigned(n-1 downto 0) is
		p_reg(n-1 downto 0);
begin
	process(clk,reset)
	begin
		if reset='1' then
			state_reg <= idle;
			a_reg <= (others => '0');
			n_reg <= (others => '0');
			p_reg <= (others => '0');
		elsif rising_edge(clk) then
			state_reg <= state_next;
			a_reg <= a_next;
			n_reg <= n_next;
			p_reg <= p_next;
		end if;
	end process;
	process(start, state_reg, a_reg, n_reg, p_reg, a_in, b_in, n_next, p_next)
	begin
		a_next <= a_reg;
		n_next <= n_reg;
		p_next <= p_reg;
		ready <= '0';
		case state_reg is
			when idle =>
				if start = '1' then
					p_next(n-1 downto 0) <= unsigned(b_in);
					p_next(2*n downto n) <= (others=>'0');
					a_next <= unsigned(a_in);
					n_next <= C_INIT;
					state_next <= add_shft;
				else
					state_next <= idle;
				end if;
				ready <= '1';
			when add_shft =>
				n_next <= n_reg - 1;
				if (p_reg(0)='1') then
					pu_next <= pu_reg+('0'&a_reg);
				else
					pu_next <= pu_reg;
				end if;
				p_next <= 0 & pu_next & pl_reg(n-1 downto 1);
				if (n_next/=0) then
					state_next <= add_shft;
				else
					state_next <= idle;
				end if;
		end case;
	end process;
	r<=std_logic_vector(p_reg(2*n-1 downto 0));
end architecture;
			
