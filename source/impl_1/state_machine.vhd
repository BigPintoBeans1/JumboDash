library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity state_machine is
	port(
		frameClk : in std_logic;
		valid : in std_logic;
		startGame : in std_logic;
		endGame : in std_logic;
		wonGame : in std_logic;
		globalReset : in std_logic;
		playing_rgb : in std_logic_vector(5 downto 0);
		rgb : out std_logic_vector(5 downto 0)
	);
end state_machine;
-- How the computer enacts the changed state and outputs onto the screen
architecture synth of state_machine is 

	signal firstTime : std_logic := '0';
	--signal onStart : std_logic;
	--signal onEnd : std_logic;
	--signal onPlaying : std_logic;
	signal start_rgb : std_logic_vector(5 downto 0);
	signal end_rgb : std_logic_vector(5 downto 0);
	signal state : std_logic_vector(1 downto 0); -- "00" is start, "01" is winning game, "10" is end
begin

	process (frameClk) is -- worried about this being in process potentially
	begin
		if (not firstTime) then
			start_rgb <= "001100";
			end_rgb <= "110000";
			firstTime <= '1';
		  --onStart <= '1';
			--onEnd <= '0';
			--onPlaying <= '0';
			state <= "00";
		end if;

			-- whenever endGame is triggered go back to the original game playing state, draw everything in cube_gen and spikeMove from the beginning
			
			-- whenever wonGame is triggered change the screen all to one color, then loop back to startGame with nothing moving?
			
			-- whenever globalreset is triggered go back to startGame
			
			-- need startGame state where no spikes generate only until controller start button is pressed, then enters playing game state which is just currently what we have
			
		if (state = "00" and startGame = '1') then
			state <= "10";
		elsif (state = "10" and startGame = '1') then 
			state <= "00";
		elsif (state = "01" and endGame = '1') then
			state <= "00";
		end if;
		
			--state <= "00";
		--elsif (state = "00" and startGame = '0') then
			--state <= "00";
		--elsif (state = "01" and wonGame = '1') then
			--state <= "10";
		--elsif (state = "01" and endGame = '1') then
			--state <= "00";
		--elsif (state = "10" and startGame = '1') then
			--state <= "00";
	end process;
		
	--state <= s;
	rgb <= "001100" when (state = "00" and valid = '1') else
		"110000" when (state = "10" and valid = '1') else
		playing_rgb when (state = "01" and valid = '1') else
		"000011" when valid = '1' else
		"000000";
	
end;