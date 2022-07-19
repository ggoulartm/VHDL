library ieee;
use ieee.std_logic_1164.all;

entity PortaoGaragem is
	port(-- controle
		clock, reset: in std_logic;
		-- dados
		SA, SF, SO, CR: in std_logic;
		MT: out std_logic_vector(1 downto 0));
end entity;

architecture arch of PortaoGaragem is
subtype state is std_logic_vector(1 downto 0);
signal estadoAtual, proximoEstado: state;
constant Aberto: std_logic_vector(1 downto 0):="00";
constant Fechado: std_logic_vector(1 downto 0):="01";
constant Abrindo: std_logic_vector(1 downto 0):="10";
constant Fechando: std_logic_vector(1 downto 0):="11";

begin


-- lógica de proximo estado
process (estadoAtual,SA, SF, SO, CR) is
begin
	proximoEstado <= Fechando;
	case estadoAtual is
		when Fechado =>
			if CR='1' then proximoEstado <= Abrindo;
			else proximoEstado <= Fechado;
			end if;
		when Abrindo =>
			if SA='1' then proximoEstado <= Aberto;
			else proximoEstado <= Abrindo;
			end if;
		when Aberto =>
			if CR='1' then proximoEstado <= Fechando;
			else proximoEstado <= Aberto;
			end if;
		when Fechando =>
			if SO='1' then proximoEstado <= Abrindo;
			elsif SF='1' then proximoEstado <= Fechado;
			else proximoEstado <= Fechando;
			end if;
	end case;
end process;

-- elemento de memória
process(clock, reset) is
begin
	if reset='1' then
		estadoAtual <= Fechando;
	elsif rising_edge(clock) then
		estadoAtual <= proximoEstado;
	end if;
end process;

-- lógica de saída
with EstadoAtual select
	MT <= "00" when Aberto,
			"11" when Fechando,
			"01" when Fechado,
			"10" when Abrindo;
end architecture;