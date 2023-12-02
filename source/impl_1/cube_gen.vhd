library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cube_gen is
	port(
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		cube_bot : in unsigned(9 downto 0) := 10d"229";
		rgb : out std_logic_vector(5 downto 0);
		valid : in std_logic;
		spikePosX : in unsigned(9 downto 0)
	);
end cube_gen;

architecture synth of cube_gen is

signal ground_top : unsigned(9 downto 0) := 10d"230";
signal ground_bot : unsigned(9 downto 0) := 10d"230" + 10d"10"; -- 10 pixels wide
signal cube_top : unsigned(9 downto 0);
signal spikeEndPosX : unsigned(9 downto 0);

begin
	--Cube height of 20
	cube_top <= cube_bot - 20;
	-- spike base is 20 pixels
	spikeEndPosX <= spikePosX + 20;

	rgb <=
		"110000" when (valid = '1' and row >= cube_top and row <= cube_bot and col >= 209 and col <= 229) else -- 209 and 229 are off center to the left of screen
		"001100" when (valid = '1' and row >= ground_top and row <= ground_bot) else
		"000011" when (valid = '1' and col >= spikePosX and col <= (spikeEndPosX) and row >= 209 and row <= 229)  else
		"000000";
		
	
	
end;
