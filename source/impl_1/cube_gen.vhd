library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cube_gen is
	port(
		vga_clk : in std_logic;
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		cube_bot : in unsigned(9 downto 0) := 10d"229";
		rgb : out std_logic_vector(5 downto 0);
		valid : in std_logic;
		spikeArr : in std_logic_vector(19 downto 0);
		spikeInterval : in unsigned(4 downto 0)
		--spikePosX : in unsigned(9 downto 0)
	);
end cube_gen;

architecture synth of cube_gen is

component backgroundROM is
	port (
		clk : in std_logic;
		xadr: in unsigned(7 downto 0);
		yadr : in unsigned(6 downto 0); -- 0-1023
		rgb : out std_logic_vector(5 downto 0)
	);
end component;

signal ground_top : unsigned(9 downto 0) := 10d"230";
signal ground_bot : unsigned(9 downto 0) := 10d"230" + 10d"10"; -- 10 pixels wide
signal cube_top : unsigned(9 downto 0);
signal spikeEndPosX : unsigned(9 downto 0);

signal background : std_logic_vector(5 downto 0);
signal row_vector : std_logic_vector(9 downto 0);
signal col_vector : std_logic_vector(9 downto 0);
signal int_spikeInterval : Integer;

begin
	--Cube height of 20
	cube_top <= cube_bot - 32;
	-- spike base is 20 pixels
	--spikeEndPosX <= spikePosX + 32;
	int_spikeInterval <= to_Integer(spikeInterval);

	rgb <=
		"110000" when (valid = '1' and row >= cube_top and row <= cube_bot and col >= 224 and col <= 256) else -- 209 and 229 are off center to the left of screen
		"001100" when (valid = '1' and row >= ground_top and row <= ground_bot) else
		"010101" when (valid = '1' and col >= (0) and col < (32  - int_spikeInterval)  and spikeArr(0) = '1' and row >= 197 and row <= 229) else
		
		"010101" when (valid = '1' and col >= (32  - int_spikeInterval) and col < (64  - int_spikeInterval)  and spikeArr(1) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (64  - int_spikeInterval) and col < (96  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (96  - int_spikeInterval) and col < (128 - int_spikeInterval)  and spikeArr(3) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (128 - int_spikeInterval) and col < (160 - int_spikeInterval)  and spikeArr(4) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (160 - int_spikeInterval) and col < (192 - int_spikeInterval)  and spikeArr(5) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (192 - int_spikeInterval) and col < (224 - int_spikeInterval)  and spikeArr(6) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (224 - int_spikeInterval) and col < (256 - int_spikeInterval)  and spikeArr(7) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (256 - int_spikeInterval) and col < (288 - int_spikeInterval)  and spikeArr(8) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (288 - int_spikeInterval) and col < (320 - int_spikeInterval)  and spikeArr(9) = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (320 - int_spikeInterval) and col < (352 - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (352 - int_spikeInterval) and col < (384 - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (384 - int_spikeInterval) and col < (416 - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (416 - int_spikeInterval) and col < (448 - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (448 - int_spikeInterval) and col < (480 - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (480 - int_spikeInterval) and col < (512 - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (512 - int_spikeInterval) and col < (544 - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (544 - int_spikeInterval) and col < (576 - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (576 - int_spikeInterval) and col < (608 - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 197 and row <= 229) else
		"010101" when (valid = '1' and col >= (608 - int_spikeInterval) and col < (640 - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 197 and row <= 229) else
 		--"000011" when (valid = '1' and col >= spikePosX and col <= (spikeEndPosX) and row >= 197 and row <= 229)  else
		background when (valid = '1') else
		"000000";
		
		row_vector <= std_logic_vector(row);
		col_vector <= std_logic_vector(col);
		
		
		backgroundROM1 : backgroundROM port map (
			clk => vga_clk, -- not sure if this is the right clock??
			xadr => unsigned(col_vector(9 downto 2)), -- divide by 4(assigns each pixel defined in rom to 4 pixels on screen)
			yadr => unsigned(row_vector(8 downto 2)), -- divide by 4 (assigns each pixel defined in rom to 4 pixels on screen)
			rgb => background -- should be in if block as else (if nothing else there draw background)
		);
	
end;
