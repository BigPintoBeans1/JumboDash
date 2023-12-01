library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity jump is
	port(
		aPressed : in std_logic_vector (7 downto 0); -- coresponds to shift registor's A value which is LSB
		vgaClk : in std_logic;
		cubePos : out unsigned(9 downto 0)-- current bottom left pixel of cube's position
	);
end jump;

architecture synth of jump is
signal position : unsigned(9 downto 0) := 10d"229"; -- current position
signal lastPosition : unsigned(9 downto 0) := 10d"229"; -- last clock cycles' position
signal slowClk : std_logic;
signal count : unsigned(25 downto 0);
begin

	process(vgaClk) begin
		if rising_edge(vgaClk) then
			count <= count + 1;
		end if;
	end process;
	
	slowClk <= count(19);
	
	process(slowClk) begin
		if rising_edge(slowClk) then
			if (position = 10d"229" and aPressed(7) = '1') then
				position <= 10d"228";
				lastPosition <= 10d"229";
			elsif (position = 10d"229" and aPressed(7) = '0') then
				position <= 10d"229";
				lastPosition <= 10d"229";
			elsif (position = 10d"169") then
				position <= 10d"170";
				lastPosition <= 10d"169";
			elsif ((position > lastPosition) and (position < 10d"230")) then
				lastPosition <= position;
				position <= position + 1;
			elsif (position < lastPosition) then
				lastPosition <= position;
				position <= position - 1;
			else
				position <= 10d"229";
				lastPosition <= 10d"229";
			end if;
			
		end if;
	end process;
	cubePos <= position;
end;
	
	