library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spike_gen is
	port(
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		randomNum : in std_logic_vector(3 downto 0); -- random number coming from lfsr4
		spikePix : in unsigned(9 downto 0) := 10d"479"; -- one of the spikes pixel's position
		rgb : out std_logic_vector(5 downto 0);
		valid : in std_logic
	);
end spike_gen;

architecture synth of spike_gen is
signal randombit : std_logic;
begin
randombit <= randomNum(2);


end;
