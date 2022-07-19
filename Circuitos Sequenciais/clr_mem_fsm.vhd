library ieee;
use ieee.std_logic_1164.all;
entity clr_mem_fsm is
	generic(SYNC: integer);
	port(
		clk,clear: in std_logic;
		mem,rw,burst: in std_logic;
		oe, we: out std_logic
	);
end entity;
architecture mult_seg_arch of clr_mem_fsm is
	type mc_state_type is
		(idle, read1, read2, read3, read4, write);
	signal state_reg, state_i, state_next: mc_state_type;
begin
	--state register
	reset_ff_gen: --register with asynchronous clear
	if SYNC/=1 generate
		process(clk,clear)
		begin
			if (clear='1') then
				state_reg<=idle;
			elsif rising_edge(clk) then
				state_reg<=state_next;
			end if;
		end process;
	end generate;
	no_reset_ff_gen: --register without asynchronous clear
	if SYNC=1 generate
		process(clk)
		begin
			if rising_edge(clk) then
				state_reg<=state_next;
			end if;
		end process;
	end generate;
	--next-state logic
	process(state_reg,rw,burst)
	begin
		case state_reg is
			when idle=>
				if mem='1' then
					if rw='1' then
						state_i<=read1;
					else
						state_i<=write;
				else
					state_i<=idle;
				end if;
			when write =>
				state_i<=idle;
			when read1 =>
				if (burst='1') then
					state_i<=read2;
				else
					state_i<=idle;
				end if;
			when read2 =>
				state_i <= read3;
			when read3 =>
				state_i <= read4;
			when read4 =>
				state_i <= idle;
		end case;
	end process;
	no_sync_clr_gen: --without max
	if SYNC/=1 generate
		state_next<=state_i;
	end generate;
	sync_clr_gen: --withmax
	if SYNC=1 generate
		state_next<=idle when clear='1' else state_i;
	end generate;
	--Moore output logic
	process(state_reg)
	begin
		we<='0';
		oe<='0';
		case state_reg is
			when idle =>
			when write =>
				we <= '1';
			when read1 =>
				oe <= '1';
			when read2 =>
				oe <= '1';
			when read3 =>
				oe <= '1'
			when read4 =>
				oe <= '1';
		end case;
	end process;
end architecture;
