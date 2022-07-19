library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity MatAccOperationalBlock is
	generic(NumBitsI, numBitsJ: positive);
	port(
		-- control inputs
		clock, reset: in std_logic;
		-- data inputs
		i: in  std_logic_vector(NumBitsI-1 downto 0);
		j: in  std_logic_vector(NumBitsJ-1 downto 0);
		memQ: in std_logic_vector(7 downto 0);
		-- data outputs
		memData: out std_logic_vector(7 downto 0);
		memAddress: out std_logic_vector(15 downto 0);
		data: out std_logic_vector(B-1 downto 0);
		-- command inputs
		--COMPLETE
		-- status outputs
		--COMPLETE
	);	
end entity;

architecture structural of MatAccOperationalBlock  is
	component registerN is
		generic(	width: positive;
					resetValue: integer := 0 );
		port(	-- control
				clock, reset, load: in std_logic;
				-- data
				input: in std_logic_vector(width-1 downto 0);
				output: out std_logic_vector(width-1 downto 0));
	end component;
	component compare is
		generic(	width: positive;
					isSigned: boolean;
					generateLessThan: boolean;
					generateEqual: boolean );
		port(	input0, input1: in std_logic_vector(width-1 downto 0);
				lessThan, equal: out std_logic );
	end component;
	component binaryCounter is
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
	end component;
	component barrelShifter is
		generic(	width: positive;
					toLeft: boolean;
					toRigth: boolean);
		port(	input: in std_logic_vector(width-1 downto 0);
				direction: in std_logic; --0:toLeft , 1:toRigth
				shift: in std_logic_vector(integer(ceil(log2(real(width))))-1 downto 0);
				output: out std_logic_vector(width-1 downto 0) );
	end component;
	component addersubtractor is
		generic(	N: positive;
				isAdder: boolean;
				isSubtractor: boolean;
				generateCout: boolean := true;
				generateOvf: boolean := true);
		port(	
			a, b: in std_logic_vector(N-1 downto 0);
			op: in std_logic;
			result: out std_logic_vector(N-1 downto 0);
			ovf, cout: out std_logic );
	end component;
	component multiplier is
		generic(N: positive);
		port(   
			 a, b: in std_logic_vector(N-1 downto 0);
			y: out std_logic_vector(2*N-1 downto 0) 
		);
	end component;
	component binaryDecoder is
		generic(inputWidth: positive);
		port(	input: in std_logic_vector(inputWidth-1 downto 0);
				output: out std_logic_vector(2**inputWidth-1 downto 0));
	end component;	
	--COMPLETE (signals)
begin
--COMPLETE
end;
