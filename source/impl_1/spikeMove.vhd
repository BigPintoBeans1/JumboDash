library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spikeMove is
	port(
		frameClk : in std_logic;
		--spikePosX : out unsigned(9 downto 0) -- since y value is constant 229
		spikeArr : out std_logic_vector(19 downto 0);
		spikeInterval : out unsigned(4 downto 0)
		
	);
end spikeMove;

architecture synth of spikeMove is

--signal position : unsigned(9 downto 0) := 10d"479"; -- current position of right most base pixel
signal spikeMap : std_logic_vector(59 downto 0);
signal rollClk : std_logic;
signal rollCount : unsigned(5 downto 0);

begin
	spikeMap <= "011011000001010110000101010101011100000010010101000010001000";
	--process(rollClk) begin
		--if rising_edge(rollClk) then
			--if(rollCount <= 6d"40") then
				--spikeArr <= spikeMap((6d"19"+rollCount) downto rollCount);
			--elsif(rollCount > 6d"40" and rollCount <= 6d"60") then
				--spikeArr <= spikeMap(59 downto rollCount) & (rollCount - 6d"40")d"0";
			--end if;
		--end if;
	--end process;

	process(frameClk) begin
		if rising_edge(frameClk) then
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