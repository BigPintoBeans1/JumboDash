library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity state_machine is
	port(
		frameClk : in std_logic;
		startGame : in std_logic;
		endGame : in std_logic;
		wonGame : in std_logic
	);
end state_machine;
-- How the computer enacts the changed state and outputs onto the screen
architecture synth of game_state is 

begin
	process (frameClk) is
	begin

				
	end process;
	
end;