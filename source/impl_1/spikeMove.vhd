library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spikeMove is
	port(
		frameClk : in std_logic;
		spikePosX : out unsigned(9 downto 0) -- since y value is constant 229
	);
end spikeMove;

architecture synth of spikeMove is

signal position : unsigned(9 downto 0) := 10d"479"; -- current position of right most base pixel

begin

	
	process(frameClk) begin
		if rising_edge(frameClk) then
			if position >= 10d"20" then
				position <= position - 1;
			end if;
		end if;
	end process;
	spikePosX <= position;
end;