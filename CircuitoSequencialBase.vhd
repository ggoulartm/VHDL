library ieee;
use ieee.std_logic_1164.all;

entity CircuitoSequencialBase is
	generic(N: positive := 8);
	port(
		-- controle de entrada
		clock, reset: in std_logic;
		-- controle de saida
		-- dados de entrada
		input0: in std_logic_vector(N-1 downto 0);
		-- dados de saida
		output0: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture arch of CircuitoSequencialBase is
	subtype InternalState is std_logic_vector(N-1 downto 0);
	signal nextState, currentState: InternalState;
begin
	-- next-state logic --99% do trabalho de circuitos sequenciais
	nextState <= input0; --pq eh simples
	
	-- internal state
	process(clock, reset) is
	begin
		if reset='1' then
			currentState <= (others=>'0');--unica coisa que pode mexer
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;
	-- output logic
	output0 <= currentState; --pq eh simples
	
end architecture;