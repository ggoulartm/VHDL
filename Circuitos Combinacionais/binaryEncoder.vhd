library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binaryEncoder is
	generic(
		n:positive;
		priorityMSB: boolean
	);
	port(
		inp: in std_logic_vector(2**n-1 downto 0);
		outp: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture behav0 of binaryEncoder is
begin
	if0:
	if priorityMSB generate
		process(inp) is
		begin
			outp<=(others=>'0');
			for i in 0 to inp'high loop
				if inp(i)='1' then
					outp <= std_logic_vector(to_unsigned(i,outp'length));
				end if;
			end loop;
		end process;
	end generate;
	if1:
	if not priorityMSB generate
		process(inpt) is
		begin
			outp<=(others=>'0');
			for i in input'high downto 0 loop
				if inpt(i)='1' then
					outp <= std_logic_vector(to_unsigned(i,outp'length));
				end if;
			end loop;
		end process;
	end generate;
end architecture;
