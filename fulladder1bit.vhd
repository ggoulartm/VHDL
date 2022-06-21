----------------------------------------------------------------------------------
-- Company:     Federal University of Santa Catarina - UFSC
-- Engineer:    Prof. Dr. Eng. Rafael Luiz Cancian
-- Create Date: 2021
-- Design Name: 
-- Module Name:    fulladder1bit
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

entity fulladder1bit is
	port(
		cin, a, b: in std_logic;
		sum: out std_logic;
		cout: out std_logic
	);
end entity;

architecture arch1 of fulladder1bit is
begin
	sum <= cin xor a xor b;
	cout <= (cin and a) or (cin and b) or (a and b);
end architecture;