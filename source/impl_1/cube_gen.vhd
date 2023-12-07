library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cube_gen is
	port(
		vga_clk : in std_logic;
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		cube_bot : in unsigned(9 downto 0) := 10d"229";
		playing_rgb : out std_logic_vector(5 downto 0);
		valid : in std_logic;
		spikeArr : in std_logic_vector(19 downto 0);
		spikeInterval : in unsigned(4 downto 0);
		wonGame : in std_logic;
		collided : out std_logic := '0'
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
signal ground_bot : unsigned(9 downto 0) := 10d"230" + 10d"25"; -- 10 pixels wide
signal cube_top : unsigned(9 downto 0);

signal background : std_logic_vector(5 downto 0);
signal row_vector : std_logic_vector(9 downto 0);
signal col_vector : std_logic_vector(9 downto 0);
signal int_spikeInterval : Integer;
signal cube_rgb : std_logic_vector(5 downto 0);

begin
	--Cube height of 32
	cube_top <= cube_bot - 32;
	int_spikeInterval <= to_Integer(spikeInterval);

	cube_rgb <= "000111" when (valid = '1' and row >= cube_top and row <= cube_bot and col >= 224 and col <= 255) else -- 209 and 229 are off center to the left of screen
		"000000";
		
	playing_rgb <=
		"111111" when (valid = '1' and collided = '1') else
		--"000011" when (valid = '1' and wonGame = '1') else --Changing entire screen to blue except cube (makes purple)
		--"000111" when (valid = '1' and row >= cube_top and row <= cube_bot and col >= 224 and col <= 255) else -- 209 and 229 are off center to the left of screen
		
		"001100" when (valid = '1' and row >= cube_top and row <= (cube_top + 6) and col >= 224 and col <= 255) else
		"001100" when (valid = '1' and row >= (cube_top+7) and row <= (cube_top+26) and col >= 224 and col <= 229) else
		"001100" when (valid = '1' and row >= (cube_top+7) and row <= (cube_top+26) and col >= 250 and col <= 255) else
		"001100" when (valid = '1' and row >= (cube_top+27) and row <= (cube_top+32) and col >= 224 and col <= 255) else
		"001100" when (valid = '1' and row >= (cube_top+7) and row <= (cube_top+13) and col >= 236 and col <= 243) else
		"001100" when (valid = '1' and row >= (cube_top+14) and row <= (cube_top+21) and col >= 230 and col <= 249) else
		"110110" when (valid = '1' and row >= (cube_top+7) and row <= (cube_top+13) and col >= 230 and col <= 235) else
		"110110" when (valid = '1' and row >= (cube_top+7) and row <= (cube_top+13) and col >= 244 and col <= 249) else
		"110110" when (valid = '1' and row >= (cube_top+22) and row <= (cube_top+26) and col >= 230 and col <= 249) else

		
		"100011" when (valid = '1' and row >= ground_top and row <= ground_bot) else
		
		"111100" when (valid = '1' and col >= (14 + (32*1) - int_spikeInterval) and col < (17 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*1) - int_spikeInterval) and col < (21 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*1) - int_spikeInterval) and col < (26 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*1) - int_spikeInterval) and col < (31 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 225 and row <= 229) else
		"111100" when (valid = '1' and col >= (14 + (32*2) - int_spikeInterval) and col < (17 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*2) - int_spikeInterval) and col < (21 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*2) - int_spikeInterval) and col < (26 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*2) - int_spikeInterval) and col < (31 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 225 and row <= 229) else
		"111100" when (valid = '1' and col >= (14 + (32*3) - int_spikeInterval) and col < (17 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*3) - int_spikeInterval) and col < (21 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*3) - int_spikeInterval) and col < (26 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*3) - int_spikeInterval) and col < (31 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 225 and row <= 229) else                                                                                
		"111100" when (valid = '1' and col >= (14 + (32*4) - int_spikeInterval) and col < (17 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*4) - int_spikeInterval) and col < (21 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*4) - int_spikeInterval) and col < (26 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*4) - int_spikeInterval) and col < (31 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 225 and row <= 229) else	
		"111100" when (valid = '1' and col >= (14 + (32*5) - int_spikeInterval) and col < (17 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*5) - int_spikeInterval) and col < (21 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*5) - int_spikeInterval) and col < (26 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*5) - int_spikeInterval) and col < (31 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 225 and row <= 229) else	                                                                                   
		"111100" when (valid = '1' and col >= (14 + (32*6) - int_spikeInterval) and col < (17 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*6) - int_spikeInterval) and col < (21 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*6) - int_spikeInterval) and col < (26 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*6) - int_spikeInterval) and col < (31 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 225 and row <= 229) else	
		"111100" when (valid = '1' and col >= (14 + (32*7) - int_spikeInterval) and col < (17 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*7) - int_spikeInterval) and col < (21 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*7) - int_spikeInterval) and col < (26 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*7) - int_spikeInterval) and col < (31 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 225 and row <= 229) else	                                                                                   
		"111100" when (valid = '1' and col >= (14 + (32*8) - int_spikeInterval) and col < (17 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*8) - int_spikeInterval) and col < (21 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*8) - int_spikeInterval) and col < (26 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*8) - int_spikeInterval) and col < (31 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 225 and row <= 229) else
		"111100" when (valid = '1' and col >= (14 + (32*9) - int_spikeInterval) and col < (17 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*9) - int_spikeInterval) and col < (21 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*9) - int_spikeInterval) and col < (26 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*9) - int_spikeInterval) and col < (31 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 225 and row <= 229) else
		"111100" when (valid = '1' and col >= (14 + (32*10) - int_spikeInterval) and col < (17 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*10) - int_spikeInterval) and col < (21 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*10) - int_spikeInterval) and col < (26 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*10) - int_spikeInterval) and col < (31 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 225 and row <= 229) else
		"111100" when (valid = '1' and col >= (14 + (32*11) - int_spikeInterval) and col < (17 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*11) - int_spikeInterval) and col < (21 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*11) - int_spikeInterval) and col < (26 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*11) - int_spikeInterval) and col < (31 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 225 and row <= 229) else
		"111100" when (valid = '1' and col >= (14 + (32*12) - int_spikeInterval) and col < (17 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*12) - int_spikeInterval) and col < (21 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*12) - int_spikeInterval) and col < (26 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*12) - int_spikeInterval) and col < (31 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 225 and row <= 229) else                                                                                                                                                   
		"111100" when (valid = '1' and col >= (14 + (32*13) - int_spikeInterval) and col < (17 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*13) - int_spikeInterval) and col < (21 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*13) - int_spikeInterval) and col < (26 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*13) - int_spikeInterval) and col < (31 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 225 and row <= 229) else                                                                                   
		"111100" when (valid = '1' and col >= (14 + (32*14) - int_spikeInterval) and col < (17 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*14) - int_spikeInterval) and col < (21 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*14) - int_spikeInterval) and col < (26 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*14) - int_spikeInterval) and col < (31 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 225 and row <= 229) else                                                                                                                                                   
		"111100" when (valid = '1' and col >= (14 + (32*15) - int_spikeInterval) and col < (17 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*15) - int_spikeInterval) and col < (21 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*15) - int_spikeInterval) and col < (26 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*15) - int_spikeInterval) and col < (31 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 225 and row <= 229) else
		"111100" when (valid = '1' and col >= (14 + (32*16) - int_spikeInterval) and col < (17 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*16) - int_spikeInterval) and col < (21 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*16) - int_spikeInterval) and col < (26 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*16) - int_spikeInterval) and col < (31 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 225 and row <= 229) else                                                                                                                                                   
		"111100" when (valid = '1' and col >= (14 + (32*17) - int_spikeInterval) and col < (17 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*17) - int_spikeInterval) and col < (21 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*17) - int_spikeInterval) and col < (26 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*17) - int_spikeInterval) and col < (31 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 225 and row <= 229) else                                                                                       
		"111100" when (valid = '1' and col >= (14 + (32*18) - int_spikeInterval) and col < (17 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*18) - int_spikeInterval) and col < (21 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*18) - int_spikeInterval) and col < (26 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*18) - int_spikeInterval) and col < (31 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 225 and row <= 229) else                                                                                                                                                  
		"111100" when (valid = '1' and col >= (14 + (32*19) - int_spikeInterval) and col < (17 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 197 and row <= 208) else
		"111100" when (valid = '1' and col >= (10 + (32*19) - int_spikeInterval) and col < (21 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 209 and row <= 216) else
		"111100" when (valid = '1' and col >= (5  + (32*19) - int_spikeInterval) and col < (26 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 217 and row <= 224) else
		"111100" when (valid = '1' and col >= (0  + (32*19) - int_spikeInterval) and col < (31 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 225 and row <= 229) else
	                                                                                        
		--"010101" when (valid = '1' and col >= (0) and col < (32  - int_spikeInterval) and spikeArr(0) = '1' and row >= 197 and row <= 229) else
		
		background when (valid = '1') else
		"000000";
		
		--If cube overlaps with spike make collided one
		process (vga_clk) is
		begin
			if ((valid = '1' and col >= (14 + (32*7) - int_spikeInterval) and col < (17 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 197 and row <= 208 and cube_rgb = "000111") or
				(valid = '1' and col >= (10 + (32*7) - int_spikeInterval) and col < (21 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 209 and row <= 216 and cube_rgb = "000111") or
				(valid = '1' and col >= (5  + (32*7) - int_spikeInterval) and col < (26 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 217 and row <= 224 and cube_rgb = "000111") or
				(valid = '1' and col >= (0  + (32*7) - int_spikeInterval) and col < (31 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 225 and row <= 228 and cube_rgb = "000111")) then
				collided <= '1';
			elsif ((valid = '1' and col >= (14 + (32*8) - int_spikeInterval) and col < (17 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 197 and row <= 208 and cube_rgb = "000111") or
				   (valid = '1' and col >= (10 + (32*8) - int_spikeInterval) and col < (21 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 209 and row <= 216 and cube_rgb = "000111") or
			   	   (valid = '1' and col >= (5  + (32*8) - int_spikeInterval) and col < (26 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 217 and row <= 224 and cube_rgb = "000111") or
				   (valid = '1' and col >= (0  + (32*8) - int_spikeInterval) and col < (31 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 225 and row <= 228 and cube_rgb = "000111")) then
				collided <= '1';
			else
				collided <= '0';
			end if;
		end process;
		
		row_vector <= std_logic_vector(row);
		col_vector <= std_logic_vector(col);
		
		backgroundROM1 : backgroundROM port map (
			clk => vga_clk, -- not sure if this is the right clock??
			xadr => unsigned(col_vector(9 downto 2)), -- divide by 4(assigns each pixel defined in rom to 4 pixels on screen)
			yadr => unsigned(row_vector(8 downto 2)), -- divide by 4 (assigns each pixel defined in rom to 4 pixels on screen)
			rgb => background -- should be in if block as else (if nothing else there draw background)
		);
		
	
end;
