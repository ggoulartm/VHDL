-- Implementation with an emulated array: The second description uses an emulated array, and the VHDL code is shown below. The code also includes the util_pkg since the log2c function is needed. It follows the mux_2d description  but with several simple modifications
--Use the regular std_logic_vector data type
--Define de ix function
--Use a(ix(i,j)) to replace a(i,j)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.util_pkg.all;
entity mux_emu_2d is
	generic(
		P: natural; --number of input ports
		B: natural --number of bits per port
	);
	port(
		a: in std_logic_vector(P*B-1 downto 0);
		sel: in std_logic_vector(log2c(P)-1 downto 0);
		y: out std_logic_vector(B-1 downto 0)
	);
end entity;
architecture emu_2d_arch of mux_emu_2d is
	function ix(r,c: natural) return natural is
		begin
			return (r*B+c);
		end function;
begin
	process(a,sel)
	begin
		y<=(others=>'0');
		for r in 0 to (P-1) loop
			if r = to_integer(unsigned(sel)) then
				for c in 0 to (B-1) loop
					y(c) <= a(ix(r,c));
				end loop;
			end if;
		end loop;
	end process;
end architecture;

--Implementation with an array of arrays: Because the element data type of an array of arrays must be a constrained array, the array-of-arrays data tpye is not general enough to be used in the port declaration of the two-dimensional multiplexer. However, this data type can still be used inside the architecture body. We can use the previous emulated array in the entity declaration and then convert the input into the array-of-arrats data type in the architecture body. The VHDL code of the architecture body is show below

architecture a_of_a_arch of mux_emu_2d is
	type std_aoa_type is
		array(P-1 downto 0) of std_logic_vector(B-1 downto 0);
	signal aa: std_aoa_type;
begin
	--convert to array-of-arrays data type
	process(a)
	begin
	for r in 0 to (P-1) loop
		for c in 0 to (B-1) loop
			aa(r)(c) <= a(r*B+c);
		end loop;
	end loop;
	--mux
	process(aa,sel)
	begin
		y<=(others=>'0')
		for i in 0 to (P-1) loop
			if i = to_integer(unsigned(sel)) then
				y<=aa(i);
			end if;
		end loop;
	end process;
end architecture;
