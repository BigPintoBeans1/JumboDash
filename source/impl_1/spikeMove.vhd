library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spikeMove is
	port(
		frameClk : in std_logic;
		--spikePosX : out unsigned(9 downto 0) -- since y value is constant 229
		spikeArr : out std_logic_vector(19 downto 0) := "00000000000000000000"; -- spikes shown on the screen
		spikeInterval : out unsigned(4 downto 0) := "00000"; -- a counter of the frameClk
		frame2Clk : in std_logic -- faster clock for moving spikes faster
		
	);
end spikeMove;

architecture synth of spikeMove is

--signal position : unsigned(9 downto 0) := 10d"479"; -- current position of right most base pixel
signal spikeMap : std_logic_vector(99 downto 0);
signal rollClk : std_logic;
signal rollCount : unsigned(6 downto 0); -- amount of spikes that have been put on screen
signal zeros : std_logic_vector(19 downto 0);
signal rightMost : unsigned(6 downto 0);
signal int_rightMost : integer;
signal int_rollCount : integer;
signal numZerosEnd : unsigned(6 downto 0);
signal numzerosBeg : unsigned(6 downto 0);
signal int_numZerosEnd : integer;
signal int_numZerosBeg : integer;
signal trailing : unsigned(6 downto 0);
signal int_trailing : integer;


begin
	spikeMap <= "0000000000000000000001000010000001000100000100001000010000000001000100001000100000000000000000000000"; -- LSB is on the right
	zeros <= "00000000000000000000";
	rightMost <= rollCount + 7d"19"; -- last element in spikeArr
	-- leftMost is just rollCount
	int_rightMost <= to_integer(rightMost);
	int_rollCount <= to_integer(rollCount);
	
	process(rollClk) begin
		if rising_edge(rollClk) then
			-- this if else statement displays(with glitches?) each 20 bit spike arr from map based on 20 rollcounts
			--if (rollCount < 7d"20") then
				--spikeArr <= spikeMap(19 downto 0); -- zeros in the whole thing but then based on rollcount add spike map(msb to lsb = right to left)
			if (rollCount >= 7d"0" and rollCount < 7d"80") then
				spikeArr <= spikeMap(int_rightMost downto int_rollCount);
			--elsif (rollCount >= 7d"40" and rollCount < 7d"60") then
				--spikeArr <= spikeMap(59 downto 40);
			else
				spikeArr <= 20b"0";
			end if;
			--if(rollCount < 7d"20") then
			--	spikeArr <= (zeros(int_numZerosBeg downto 0) & spikeMap(int_rollCount downto 0));
			--elsif(rollCount >= 7d"20" and rollCount < 7d"60") then
			--	spikeArr <= spikeMap(int_rollCount downto int_rightMost);
			--elsif(rollCount >= 7d"60" and rollCount < 7d"79") then
			--	spikeArr <= (spikeMap(59 downto int_rightMost) & zeros(int_numZerosEnd downto 0));
			--else
			--	spikeArr <= 20d"0";
			--end if;
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
	--process(frameClk) begin
		--if rising_edge(frameClk) then
			--position <= position - 2;
		--end if;
	--end process;
	--spikePosX <= position;
end;