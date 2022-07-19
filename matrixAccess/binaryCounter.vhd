----------------------------------------------------------------------------------
-- Company:     Federal University of Santa Catarina - UFSC
-- Engineer:    Prof. Dr. Eng. Rafael Luiz Cancian
-- Create Date: 2021
-- Design Name: 
-- Module Name:    binaryCounter
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

entity binaryCounter is
	generic(	width: positive;
				generateEnb: boolean;
				generateInc: boolean;
				generateLoad: boolean;
				resetValue: integer := 0 );
	port(	-- control
			clock, reset: in std_logic;
			load, enb, inc: in std_logic;
			-- data
			input: in std_logic_vector(width-1 downto 0);
			output: out std_logic_vector(width-1 downto 0)	);
end entity;

use ieee.numeric_std.all;

architecture behav0 of binaryCounter is
subtype state is unsigned(width-1 downto 0);
signal nextState, currentState: state;
-- auxiliar
signal tempInc, tempCount, tempEnb, tempLoad: state;
begin
	-- next-state logic
	ifInc: if generateInc generate
		--tempInc <= to_unsigned(+1,nextState'length) when inc='1' else to_unsigned(-1,nextState'length);
		tempInc <= (0=>'1', others=>'0') when inc='1' else (others=>'1');
	end generate;
	ifNotInc: if not generateInc generate
		tempInc <= (0=>'1', others=>'0');
	end generate;
	tempCount <= currentState+tempInc;
	ifEnb: if generateEnb generate
		tempEnb <= tempCount when enb='1' else currentState;
	end generate;
	ifNotEnb: if not generateEnb generate
		tempEnb <= tempCount;
	end generate;
	ifLoad: if generateLoad generate
		tempLoad <= unsigned(input) when load='1' else tempEnb;
	end generate;
	ifNotLoad: if not generateLoad generate
		tempLoad <= tempEnb;
	end generate;
	nextState <= tempLoad;
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