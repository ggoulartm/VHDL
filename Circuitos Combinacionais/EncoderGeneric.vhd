library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EncoderGeneric is
	generic(
		n: positive := 3; -- quantidade de bits que a saída terá
		Valid_input: boolean := true;
		MSB: boolean := true);
	port(
		input: in std_logic_vector((2**n)-1 downto 0);
		valid: out std_logic;
		output: out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture arch of EncoderGeneric is
signal aux: std_logic_vector(n-1 downto 0);
begin

	MSB_left: if MSB=true generate
	
		process(input) is
		begin
			output <= (others=>'0');
			for i in input'low to input'high loop
				if input(i)='1' then
					output <= std_logic_vector(to_unsigned(i, output'length));
				end if;
			end loop;
		end process;
		
	end generate;
	
	MSB_rigth: if MSB=false generate
	
		process(input) is
		begin
			output <= (others=>'0');
			for i in input'high to input'low loop
				if input(i)='1' then
					output <= std_logic_vector(to_unsigned(i, output'length));
				end if;
			end loop;
		end process;
		
	end generate;
	
	ValidInput: if Valid_input generate
		valid <= '1' when unsigned(input)>0 else '0';
	end generate;
	
end architecture;