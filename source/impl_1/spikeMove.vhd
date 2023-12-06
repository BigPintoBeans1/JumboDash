library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spikeMove is
	port(
		frameClk : in std_logic;
		spikeArr : out std_logic_vector(19 downto 0) := "00000000000000000000"; -- spikes shown on the screen
		spikeInterval : out unsigned(4 downto 0) := "00000"; -- a counter of the frameClk
		frame2Clk : in std_logic -- faster clock for moving spikes faster
		
	);
end spikeMove;

architecture synth of spikeMove is

signal spikeMap : std_logic_vector(99 downto 0);
signal rollClk : std_logic;
signal rollCount : unsigned(6 downto 0); -- amount of spikes that have been put on screen
signal zeros : std_logic_vector(19 downto 0);
signal rightMost : unsigned(6 downto 0);
signal int_rightMost : integer;
signal int_rollCount : integer;


begin
	spikeMap <= "0000000000000000000001000010000001000100000100001000010000000001000100001000100000000000000000000000"; -- LSB is on the right
	rightMost <= rollCount + 7d"19"; -- last element in spikeArr
	-- leftMost is just rollCount
	int_rightMost <= to_integer(rightMost);
	int_rollCount <= to_integer(rollCount);
	
	process(rollClk) begin
		if rising_edge(rollClk) then
			-- this if else statement displays each 20 bit spike arr from map based on 20 rollcounts
			if (rollCount >= 7d"0" and rollCount < 7d"80") then
				spikeArr <= spikeMap(int_rightMost downto int_rollCount);
			else
				spikeArr <= 20b"0";
			end if;
		end if;
	end process;
	

	process(frame2Clk) begin
		if rising_edge(frame2Clk) then
			spikeInterval <= spikeInterval + 1;
			if spikeInterval = "11111" then
				rollClk <= '1';
				rollCount <= rollCount + 1;
			else 
				rollClk <= '0';
			end if;
		end if;
	end process;
end;