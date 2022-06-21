----------------------------------------------------------------------------------
-- Company:     Federal University of Santa Catarina - UFSC
-- Engineer:    Prof. Dr. Eng. Rafael Luiz Cancian
-- Create Date: 2021
-- Design Name: 
-- Module Name:    moduleCounter
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- Dependencies: 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity moduleCounter is
	generic(	module: positive;
				generateEnb: boolean;
				resetValue: integer := 0 );
	port(	-- control
			clock, reset, load: in std_logic;
			enb: in std_logic;
			-- data
			input: in std_logic_vector(integer(ceil(log2(real(module))))-1 downto 0);
			output: out std_logic_vector(integer(ceil(log2(real(module))))-1 downto 0)	);
end entity;

use ieee.numeric_std.all;

architecture behav0 of moduleCounter is
subtype state is unsigned(integer(ceil(log2(real(module))))-1 downto 0);
signal nextState, currentState: state;
-- auxiliar signals
signal tempNextState: state;
begin
	-- next-state logic
	tempNextState <= 	to_unsigned(0, currentState'length) when currentState=module-1 else 
							currentState+1;
	hasEnb: if generateEnb generate
		nextState <=	unsigned(input) when load='1' else 
							currentState when enb='0' else tempNextState; 
	end generate;
	noEnb: if not generateEnb generate
		nextState <=	unsigned(input) when load='1' else tempNextState; 
	end generate;
	-- memory element
	process(clock, reset) is
	begin
		if reset='1' then
			currentState <= (to_unsigned(resetValue, currentState'length));
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;
	-- output logic
	output <= std_logic_vector(currentState);
end architecture;