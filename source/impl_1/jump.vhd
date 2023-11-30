library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity jump is
	port(
		aPressed : in std_logic_vector (7 downto 0); -- coresponds to shift registor's A value which is LSB
		vgaClk : in std_logic;
		cubePos : out std_logic_vector(6 downto 0)-- current bottom left pixel of cube's position
	);
end jump;

architecture synth of jump is
signal count : unsigned(6 downto 0);
signal position : unsigned(6 downto 0); -- current position
signal lastPosition : unsigned(6 downto 0); -- last clock cycles' position
begin
	process(vgaClk) begin
		if rising_edge(vgaClk) then
			if (position = 7d"0" and aPressed = "00000001") then
				--count <= 6d"1";
				position <= 7d"1";
				lastPosition <= 7d"0";
			elsif (position = 7d"0" and aPressed(0) = '0') then
				position <= 7d"0";
				lastPosition <= 7d"0";
			elsif (position = 7d"60") then
				position <= 7d"59";
				lastPosition <= 7d"60";
				--count <= 6d"59";
			elsif (position > lastPosition) then
				lastPosition <= position;
				position <= position + 1;
				--count <= count + 1;
			elsif (position < lastPosition) then
				lastPosition <= position;
				position <= position - 1;
				--count <= count - 1;
			end if;
		end if;
	end process;
	cubePos <= std_logic_vector(position);
end;
	
	