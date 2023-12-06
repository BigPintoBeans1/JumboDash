library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity collisions is
	port(
		frame2Clk : in std_logic;
		cubePos : in unsigned(9 downto 0);-- current bottom left pixel of cube's position
		spikePosB : in unsigned(9 downto 0); -- current bottom left pixel of the spike that spawns in the segment before the cube
		spikePosA : in unsigned(9 downto 0); -- current bottom left pixel of the spike that spawns in the cube segment
		spikeArr : in std_logic_vector(19 downto 0); 
		collided : out std_logic := '0'
	);
end collisions;

architecture synth of collisions is 

	signal numStep : unsigned(8 downto 0); -- number of pixels to the right of the spike bottom left that correlate to the height of the bottom of the cube
	signal numPixAbove : unsigned(9 downto 0); -- Number of width pixels that are at or above the height of the bottom of the cube

begin
	--make relative height from ground and divide by 2 to get number of steps
	--when cube is above the top of the triangle keep num step at 15
	numStep <= ((cubePos - 230) / 2)  when (cubePos <= 197) else 9d"15"; -- 230 is ground
	numPixAbove <= (32 - numStep*2);
	
	process(frame2Clk) is begin
		if(cubePos >= 197 and spikeArr(7) = '1') then -- 197 is max heigh of spike
			-- if the right point of intersection is between the column bounds of the cube then flag collided (256 and 224 are cube left and right)
			if(((spikePosA + numStep + numPixAbove) <= 256) and (spikePosA + numStep + numPixAbove) >= 224) then 
				collided <= '1';
			--same for left point
			elsif(((spikePosA + numStep) <= 256) and (spikePosA + numStep) >= 224) then
				collided <= '1';
			end if;
		end if;
		if(cubePos >= 197 and spikeArr(8) = '1') then
			--CHECK B TOO!
			if(((spikePosB + numStep + numPixAbove) <= 256) and (spikePosB + numStep + numPixAbove) >= 224) then 
				collided <= '1';
			elsif(((spikePosB + numStep) <= 256) and (spikePosB + numStep) >= 224) then
				collided <= '1';
			end if;
		end if;
	end process;
end architecture;