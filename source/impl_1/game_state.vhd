library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity game_state is
	port(
		frameClk : in std_logic;
		collided : in std_logic;
		controllerResult : in std_logic_vector(7 downto 0);
		won : in std_logic;
		startGame : out std_logic := '0';
		endGame : out std_logic := '0';
		wonGame : out std_logic := '0';
		globalReset : out std_logic := '0'
	);
end game_state;

architecture synth of game_state is 

begin
	process (frameClk) is
	begin
	
		startGame <= '1' when controllerResult(4) = '1' else '0'; --Start the game (spikes begin moving)
		
		endGame <= '1' when collided = '1' else '0'; --Game over when collided is 1
		
		globalReset <= '1' when endGame = '1' else '0';
		
		wonGame <= '1' when won = '1' else '0';
				
	end process;
	
end;