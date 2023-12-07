library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity jump is
	port(
		aPressed : in std_logic_vector (7 downto 0); -- coresponds to shift registor's A value which is LSB
		vga_clk : in std_logic;
		cubePos : out unsigned(9 downto 0)-- current bottom left pixel of cube's position
	);
end jump;

architecture synth of jump is
signal position : unsigned(9 downto 0) := 10d"229"; -- current position
signal lastPosition : unsigned(9 downto 0) := 10d"229"; -- last clock cycles' position
signal slowClk : std_logic;
signal count : unsigned(25 downto 0);
begin

	process(vga_clk) begin
		if rising_edge(vga_clk) then
			count <= count + 1;
		end if;
	end process;
	
	slowClk <= count(18);
	
	process(slowClk) begin
		if rising_edge(slowClk) then
			if (position >= 10d"229" and aPressed(7) = '1') then
				position <= 10d"228";
				lastPosition <= 10d"229";
			elsif (position >= 10d"229" and aPressed(7) = '0') then
				position <= 10d"229";
				lastPosition <= 10d"229";
			elsif (position <= 10d"149") then
				position <= 10d"150";
				lastPosition <= 10d"149";
			elsif ((position > lastPosition) and (position < 10d"230")) then
				lastPosition <= position;
				position <= position + 4;
			elsif (position < lastPosition) then
				lastPosition <= position;
				position <= position - 4;
			else
				position <= 10d"229";
				lastPosition <= 10d"229";
			end if;
			
		end if;
	end process;
	cubePos <= position;
end;
	
	