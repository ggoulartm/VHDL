-- Listing 14.9: Parameterized Adder with Status Circuit 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity para_adder_status is
	generic(width: natural);
	port(
		a,b: in std_logic_vector(width-1 downto 0);
		cin: in std_logic;
		sum: out std_logic_vector(width-1 downto 0);
		cout,zero,overflow,sign: out std_logic
	);
end entity;

architecture arch of para_adder_status is
	signal a_ext,b_ext, sum_ext: signed(width+1 downto 0);
	signal ovf: std_logic;
	alias sign_a: std_logic is a_ext(width);
	alias sign_b: std_logic is b_ext(width);
	alias sign_s: std_logic is sum_ext(width);
begin
	a_ext <= signed('0' & a & '1');
	b_ext <= signed('0' & b & '1');
	sum_ext <= a_ext+b_ext;
	ovf <= (sign_a and sign_b and (not sign_s)) or ((not sign_a) and (not sign_b) and sign s);
	cout <= sum_ext(width+1);
	sign <= sign_s when ovf='0' else
		not sign_s;
	zero <= '1' when (sum_ext(width downto 0)=0 and ovf='0') else
		'0';
	overflow <= ovf;
	sum <= std_logic_vector(sum_ext(width downto 1));
end architecture;
	
