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
		spikeInterval : in unsigned(4 downto 0);
		spikePosA : out unsigned(9 downto 0);
		spikePosB : out unsigned(9 downto 0);
		collided : in std_logic
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

	spikePosA <= 224 - spikeInterval;
	spikePosB <= 256 - spikeInterval;


	rgb <=
		"111111" when (valid = '1' and collided = '1') else
		"110000" when (valid = '1' and row >= cube_top and row <= cube_bot and col >= 224 and col <= 256) else -- 209 and 229 are off center to the left of screen
		"001100" when (valid = '1' and row >= ground_top and row <= ground_bot) else
		--"010101" when (valid = '1' and col >= (0) and col < (32  - int_spikeInterval)  and spikeArr(0) = '1' and row >= 197 and row <= 229) else
		
		--Spike 1: leftmost spike
		--"010101" when (valid = '1' and col >= (15) and col <= (16)  and spikeArr(0) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14) and col <= (17)  and spikeArr(0) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13) and col <= (18)  and spikeArr(0) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12) and col <= (19)  and spikeArr(0) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11) and col <= (20)  and spikeArr(0) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10) and col <= (21)  and spikeArr(0) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9 ) and col <= (22)  and spikeArr(0) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8 ) and col <= (23)  and spikeArr(0) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7 ) and col <= (24)  and spikeArr(0) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6 ) and col <= (25)  and spikeArr(0) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5 ) and col <= (26)  and spikeArr(0) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4 ) and col <= (27)  and spikeArr(0) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3 ) and col <= (28)  and spikeArr(0) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2 ) and col <= (29)  and spikeArr(0) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1 ) and col <= (30)  and spikeArr(0) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0 ) and col <= (31)  and spikeArr(0) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*1) - int_spikeInterval) and col <= (16 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*1) - int_spikeInterval) and col <= (17 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*1) - int_spikeInterval) and col <= (18 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*1) - int_spikeInterval) and col <= (19 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*1) - int_spikeInterval) and col <= (20 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*1) - int_spikeInterval) and col <= (21 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*1) - int_spikeInterval) and col <= (22 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*1) - int_spikeInterval) and col <= (23 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*1) - int_spikeInterval) and col <= (24 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*1) - int_spikeInterval) and col <= (25 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*1) - int_spikeInterval) and col <= (26 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*1) - int_spikeInterval) and col <= (27 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*1) - int_spikeInterval) and col <= (28 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*1) - int_spikeInterval) and col <= (29 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*1) - int_spikeInterval) and col <= (30 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*1) - int_spikeInterval) and col <= (31 + (32*1) - int_spikeInterval)  and spikeArr(1) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*2)  - int_spikeInterval) and col < (16 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*2)  - int_spikeInterval) and col < (17 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*2)  - int_spikeInterval) and col < (18 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*2)  - int_spikeInterval) and col < (19 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*2)  - int_spikeInterval) and col < (20 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*2)  - int_spikeInterval) and col < (21 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*2)  - int_spikeInterval) and col < (22 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*2)  - int_spikeInterval) and col < (23 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*2)  - int_spikeInterval) and col < (24 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*2)  - int_spikeInterval) and col < (25 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*2)  - int_spikeInterval) and col < (26 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*2)  - int_spikeInterval) and col < (27 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*2)  - int_spikeInterval) and col < (28 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*2)  - int_spikeInterval) and col < (29 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*2)  - int_spikeInterval) and col < (30 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*2)  - int_spikeInterval) and col < (31 + (32*2)  - int_spikeInterval)  and spikeArr(2) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*3)  - int_spikeInterval) and col < (16 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*3)  - int_spikeInterval) and col < (17 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*3)  - int_spikeInterval) and col < (18 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*3)  - int_spikeInterval) and col < (19 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*3)  - int_spikeInterval) and col < (20 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*3)  - int_spikeInterval) and col < (21 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*3)  - int_spikeInterval) and col < (22 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*3)  - int_spikeInterval) and col < (23 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*3)  - int_spikeInterval) and col < (24 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*3)  - int_spikeInterval) and col < (25 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*3)  - int_spikeInterval) and col < (26 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*3)  - int_spikeInterval) and col < (27 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*3)  - int_spikeInterval) and col < (28 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*3)  - int_spikeInterval) and col < (29 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*3)  - int_spikeInterval) and col < (30 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*3)  - int_spikeInterval) and col < (31 + (32*3) - int_spikeInterval)  and spikeArr(3) = '1' and row >= 227 and row <= 228) else


		--"010101" when (valid = '1' and col >= (15 + (32*4) - int_spikeInterval) and col < (16 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*4) - int_spikeInterval) and col < (17 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*4) - int_spikeInterval) and col < (18 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*4) - int_spikeInterval) and col < (19 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*4) - int_spikeInterval) and col < (20 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*4) - int_spikeInterval) and col < (21 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*4) - int_spikeInterval) and col < (22 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*4) - int_spikeInterval) and col < (23 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*4) - int_spikeInterval) and col < (24 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*4) - int_spikeInterval) and col < (25 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*4) - int_spikeInterval) and col < (26 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*4) - int_spikeInterval) and col < (27 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*4) - int_spikeInterval) and col < (28 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*4) - int_spikeInterval) and col < (29 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*4) - int_spikeInterval) and col < (30 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*4) - int_spikeInterval) and col < (31 + (32*4) - int_spikeInterval)  and spikeArr(4) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*5) - int_spikeInterval) and col < (16 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*5) - int_spikeInterval) and col < (17 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*5) - int_spikeInterval) and col < (18 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*5) - int_spikeInterval) and col < (19 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*5) - int_spikeInterval) and col < (20 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*5) - int_spikeInterval) and col < (21 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*5) - int_spikeInterval) and col < (22 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*5) - int_spikeInterval) and col < (23 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*5) - int_spikeInterval) and col < (24 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*5) - int_spikeInterval) and col < (25 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*5) - int_spikeInterval) and col < (26 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*5) - int_spikeInterval) and col < (27 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*5) - int_spikeInterval) and col < (28 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*5) - int_spikeInterval) and col < (29 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*5) - int_spikeInterval) and col < (30 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*5) - int_spikeInterval) and col < (31 + (32*5) - int_spikeInterval)  and spikeArr(5) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*6) - int_spikeInterval) and col < (16 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*6) - int_spikeInterval) and col < (17 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*6) - int_spikeInterval) and col < (18 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*6) - int_spikeInterval) and col < (19 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*6) - int_spikeInterval) and col < (20 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*6) - int_spikeInterval) and col < (21 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*6) - int_spikeInterval) and col < (22 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*6) - int_spikeInterval) and col < (23 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*6) - int_spikeInterval) and col < (24 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*6) - int_spikeInterval) and col < (25 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*6) - int_spikeInterval) and col < (26 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*6) - int_spikeInterval) and col < (27 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*6) - int_spikeInterval) and col < (28 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*6) - int_spikeInterval) and col < (29 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*6) - int_spikeInterval) and col < (30 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*6) - int_spikeInterval) and col < (31 + (32*6) - int_spikeInterval)  and spikeArr(6) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*7) - int_spikeInterval) and col < (16 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*7) - int_spikeInterval) and col < (17 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*7) - int_spikeInterval) and col < (18 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*7) - int_spikeInterval) and col < (19 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*7) - int_spikeInterval) and col < (20 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*7) - int_spikeInterval) and col < (21 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*7) - int_spikeInterval) and col < (22 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*7) - int_spikeInterval) and col < (23 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*7) - int_spikeInterval) and col < (24 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*7) - int_spikeInterval) and col < (25 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*7) - int_spikeInterval) and col < (26 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*7) - int_spikeInterval) and col < (27 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*7) - int_spikeInterval) and col < (28 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*7) - int_spikeInterval) and col < (29 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*7) - int_spikeInterval) and col < (30 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*7) - int_spikeInterval) and col < (31 + (32*7) - int_spikeInterval)  and spikeArr(7) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*8) - int_spikeInterval) and col < (16 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*8) - int_spikeInterval) and col < (17 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*8) - int_spikeInterval) and col < (18 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*8) - int_spikeInterval) and col < (19 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*8) - int_spikeInterval) and col < (20 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*8) - int_spikeInterval) and col < (21 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*8) - int_spikeInterval) and col < (22 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*8) - int_spikeInterval) and col < (23 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*8) - int_spikeInterval) and col < (24 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*8) - int_spikeInterval) and col < (25 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*8) - int_spikeInterval) and col < (26 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*8) - int_spikeInterval) and col < (27 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*8) - int_spikeInterval) and col < (28 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*8) - int_spikeInterval) and col < (29 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*8) - int_spikeInterval) and col < (30 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*8) - int_spikeInterval) and col < (31 + (32*8) - int_spikeInterval)  and spikeArr(8) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*9) - int_spikeInterval) and col < (16 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*9) - int_spikeInterval) and col < (17 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*9) - int_spikeInterval) and col < (18 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*9) - int_spikeInterval) and col < (19 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*9) - int_spikeInterval) and col < (20 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*9) - int_spikeInterval) and col < (21 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*9) - int_spikeInterval) and col < (22 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*9) - int_spikeInterval) and col < (23 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*9) - int_spikeInterval) and col < (24 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*9) - int_spikeInterval) and col < (25 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*9) - int_spikeInterval) and col < (26 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*9) - int_spikeInterval) and col < (27 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*9) - int_spikeInterval) and col < (28 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*9) - int_spikeInterval) and col < (29 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*9) - int_spikeInterval) and col < (30 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*9) - int_spikeInterval) and col < (31 + (32*9) - int_spikeInterval)  and spikeArr(9) = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*10) - int_spikeInterval) and col < (16 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*10) - int_spikeInterval) and col < (17 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*10) - int_spikeInterval) and col < (18 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*10) - int_spikeInterval) and col < (19 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*10) - int_spikeInterval) and col < (20 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*10) - int_spikeInterval) and col < (21 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*10) - int_spikeInterval) and col < (22 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*10) - int_spikeInterval) and col < (23 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*10) - int_spikeInterval) and col < (24 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*10) - int_spikeInterval) and col < (25 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*10) - int_spikeInterval) and col < (26 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*10) - int_spikeInterval) and col < (27 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*10) - int_spikeInterval) and col < (28 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*10) - int_spikeInterval) and col < (29 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*10) - int_spikeInterval) and col < (30 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*10) - int_spikeInterval) and col < (31 + (32*10) - int_spikeInterval)  and spikeArr(10)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*11) - int_spikeInterval) and col < (16 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*11) - int_spikeInterval) and col < (17 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*11) - int_spikeInterval) and col < (18 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*11) - int_spikeInterval) and col < (19 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*11) - int_spikeInterval) and col < (20 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*11) - int_spikeInterval) and col < (21 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*11) - int_spikeInterval) and col < (22 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*11) - int_spikeInterval) and col < (23 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*11) - int_spikeInterval) and col < (24 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*11) - int_spikeInterval) and col < (25 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*11) - int_spikeInterval) and col < (26 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*11) - int_spikeInterval) and col < (27 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*11) - int_spikeInterval) and col < (28 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*11) - int_spikeInterval) and col < (29 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*11) - int_spikeInterval) and col < (30 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*11) - int_spikeInterval) and col < (31 + (32*11) - int_spikeInterval)  and spikeArr(11)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*12) - int_spikeInterval) and col < (16 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*12) - int_spikeInterval) and col < (17 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*12) - int_spikeInterval) and col < (18 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*12) - int_spikeInterval) and col < (19 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*12) - int_spikeInterval) and col < (20 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*12) - int_spikeInterval) and col < (21 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*12) - int_spikeInterval) and col < (22 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*12) - int_spikeInterval) and col < (23 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*12) - int_spikeInterval) and col < (24 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*12) - int_spikeInterval) and col < (25 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*12) - int_spikeInterval) and col < (26 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*12) - int_spikeInterval) and col < (27 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*12) - int_spikeInterval) and col < (28 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*12) - int_spikeInterval) and col < (29 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*12) - int_spikeInterval) and col < (30 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*12) - int_spikeInterval) and col < (31 + (32*12) - int_spikeInterval)  and spikeArr(12)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*13) - int_spikeInterval) and col < (16 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*13) - int_spikeInterval) and col < (17 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*13) - int_spikeInterval) and col < (18 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*13) - int_spikeInterval) and col < (19 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*13) - int_spikeInterval) and col < (20 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*13) - int_spikeInterval) and col < (21 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*13) - int_spikeInterval) and col < (22 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*13) - int_spikeInterval) and col < (23 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*13) - int_spikeInterval) and col < (24 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*13) - int_spikeInterval) and col < (25 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*13) - int_spikeInterval) and col < (26 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*13) - int_spikeInterval) and col < (27 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*13) - int_spikeInterval) and col < (28 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*13) - int_spikeInterval) and col < (29 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*13) - int_spikeInterval) and col < (30 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*13) - int_spikeInterval) and col < (31 + (32*13) - int_spikeInterval)  and spikeArr(13)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*14) - int_spikeInterval) and col < (16 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*14) - int_spikeInterval) and col < (17 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*14) - int_spikeInterval) and col < (18 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*14) - int_spikeInterval) and col < (19 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*14) - int_spikeInterval) and col < (20 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*14) - int_spikeInterval) and col < (21 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*14) - int_spikeInterval) and col < (22 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*14) - int_spikeInterval) and col < (23 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*14) - int_spikeInterval) and col < (24 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*14) - int_spikeInterval) and col < (25 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*14) - int_spikeInterval) and col < (26 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*14) - int_spikeInterval) and col < (27 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*14) - int_spikeInterval) and col < (28 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*14) - int_spikeInterval) and col < (29 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*14) - int_spikeInterval) and col < (30 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*14) - int_spikeInterval) and col < (31 + (32*14) - int_spikeInterval)  and spikeArr(14)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*15) - int_spikeInterval) and col < (16 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*15) - int_spikeInterval) and col < (17 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*15) - int_spikeInterval) and col < (18 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*15) - int_spikeInterval) and col < (19 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*15) - int_spikeInterval) and col < (20 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*15) - int_spikeInterval) and col < (21 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*15) - int_spikeInterval) and col < (22 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*15) - int_spikeInterval) and col < (23 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*15) - int_spikeInterval) and col < (24 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*15) - int_spikeInterval) and col < (25 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*15) - int_spikeInterval) and col < (26 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*15) - int_spikeInterval) and col < (27 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*15) - int_spikeInterval) and col < (28 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*15) - int_spikeInterval) and col < (29 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*15) - int_spikeInterval) and col < (30 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*15) - int_spikeInterval) and col < (31 + (32*15) - int_spikeInterval)  and spikeArr(15)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*16) - int_spikeInterval) and col < (16 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*16) - int_spikeInterval) and col < (17 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*16) - int_spikeInterval) and col < (18 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*16) - int_spikeInterval) and col < (19 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*16) - int_spikeInterval) and col < (20 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*16) - int_spikeInterval) and col < (21 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*16) - int_spikeInterval) and col < (22 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*16) - int_spikeInterval) and col < (23 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*16) - int_spikeInterval) and col < (24 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*16) - int_spikeInterval) and col < (25 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*16) - int_spikeInterval) and col < (26 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*16) - int_spikeInterval) and col < (27 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*16) - int_spikeInterval) and col < (28 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*16) - int_spikeInterval) and col < (29 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*16) - int_spikeInterval) and col < (30 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*16) - int_spikeInterval) and col < (31 + (32*16) - int_spikeInterval)  and spikeArr(16)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*17) - int_spikeInterval) and col < (16 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*17) - int_spikeInterval) and col < (17 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*17) - int_spikeInterval) and col < (18 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*17) - int_spikeInterval) and col < (19 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*17) - int_spikeInterval) and col < (20 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*17) - int_spikeInterval) and col < (21 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*17) - int_spikeInterval) and col < (22 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*17) - int_spikeInterval) and col < (23 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*17) - int_spikeInterval) and col < (24 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*17) - int_spikeInterval) and col < (25 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*17) - int_spikeInterval) and col < (26 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*17) - int_spikeInterval) and col < (27 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*17) - int_spikeInterval) and col < (28 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*17) - int_spikeInterval) and col < (29 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*17) - int_spikeInterval) and col < (30 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*17) - int_spikeInterval) and col < (31 + (32*17) - int_spikeInterval)  and spikeArr(17)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*18) - int_spikeInterval) and col < (16 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*18) - int_spikeInterval) and col < (17 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*18) - int_spikeInterval) and col < (18 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*18) - int_spikeInterval) and col < (19 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*18) - int_spikeInterval) and col < (20 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*18) - int_spikeInterval) and col < (21 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*18) - int_spikeInterval) and col < (22 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*18) - int_spikeInterval) and col < (23 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*18) - int_spikeInterval) and col < (24 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*18) - int_spikeInterval) and col < (25 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*18) - int_spikeInterval) and col < (26 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*18) - int_spikeInterval) and col < (27 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*18) - int_spikeInterval) and col < (28 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*18) - int_spikeInterval) and col < (29 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*18) - int_spikeInterval) and col < (30 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*18) - int_spikeInterval) and col < (31 + (32*18) - int_spikeInterval)  and spikeArr(18)  = '1' and row >= 227 and row <= 228) else
		

		--"010101" when (valid = '1' and col >= (15 + (32*19) - int_spikeInterval) and col < (16 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 197 and row <= 198) else
		--"010101" when (valid = '1' and col >= (14 + (32*19) - int_spikeInterval) and col < (17 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 199 and row <= 200) else
		--"010101" when (valid = '1' and col >= (13 + (32*19) - int_spikeInterval) and col < (18 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 201 and row <= 202) else
		--"010101" when (valid = '1' and col >= (12 + (32*19) - int_spikeInterval) and col < (19 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 203 and row <= 204) else
		--"010101" when (valid = '1' and col >= (11 + (32*19) - int_spikeInterval) and col < (20 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 205 and row <= 206) else
		--"010101" when (valid = '1' and col >= (10 + (32*19) - int_spikeInterval) and col < (21 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 207 and row <= 208) else
		--"010101" when (valid = '1' and col >= (9  + (32*19) - int_spikeInterval) and col < (22 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 209 and row <= 210) else
		--"010101" when (valid = '1' and col >= (8  + (32*19) - int_spikeInterval) and col < (23 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 211 and row <= 212) else
		--"010101" when (valid = '1' and col >= (7  + (32*19) - int_spikeInterval) and col < (24 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 213 and row <= 214) else
		--"010101" when (valid = '1' and col >= (6  + (32*19) - int_spikeInterval) and col < (25 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 215 and row <= 216) else
		--"010101" when (valid = '1' and col >= (5  + (32*19) - int_spikeInterval) and col < (26 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 217 and row <= 218) else
		--"010101" when (valid = '1' and col >= (4  + (32*19) - int_spikeInterval) and col < (27 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 219 and row <= 220) else
		--"010101" when (valid = '1' and col >= (3  + (32*19) - int_spikeInterval) and col < (28 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 221 and row <= 222) else
		--"010101" when (valid = '1' and col >= (2  + (32*19) - int_spikeInterval) and col < (29 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 223 and row <= 224) else
		--"010101" when (valid = '1' and col >= (1  + (32*19) - int_spikeInterval) and col < (30 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 225 and row <= 226) else
		--"010101" when (valid = '1' and col >= (0  + (32*19) - int_spikeInterval) and col < (31 + (32*19) - int_spikeInterval)  and spikeArr(19)  = '1' and row >= 227 and row <= 228) else
 		
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
