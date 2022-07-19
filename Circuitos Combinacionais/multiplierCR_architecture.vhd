architecture structure of multiplierCR is
	component fulladder1bit is
		port(
			cin, a, b: in std_logic;
			sum: out std_logic;
			cout: out std_logic
		);
	end component;
	type matriz2d is array(N-1 downto 0) of std_logic_vector(N downto 0);
	signal s, c, ab: matriz2d;
begin       
    geraprodutolinha: for i in ab'range generate
			geraprodutocoluna: for j in ab'range generate
				ab(i)(j) <= a(i) and b(j);
			end generate;
	end generate;
    varreLinhaBordas: for i in c'low+1 to c'high generate
		c(i)(0) <= '0';
		s(i)(N) <= c(i)(N);
	end generate;
	s(0) <= ab(0); 
	ab(0)(N) <= '0';
	varreLinhaMeio: for i in s'low+1 to s'high generate
		varreColunaMeio: for j in s'range generate
			criaFAmeio: fulladder1bit port map(c(i)(j), ab(i)(j), s(i-1)(j+1), s(i)(j), c(i)(j+1));
		end generate;
	end generate;
	varreColunasFim: for i in s'low to s'high-1 generate
		y(i) <= s(i)(0); 
	end generate;
	y(2*N-1 downto N-1) <= s(N-1);
end architecture;
