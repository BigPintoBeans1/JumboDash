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

-- Based off what happens in the game and what the user does, change the state of the game
architecture synth of game_state is 

signal firstTime : std_logic := '0';

begin
	process (frameClk) is
	begin
		if (not firstTime) then
			firstTime <= '1';
			startGame <= '0';
			endGame <= '0';
			wonGame <= '0';
			globalReset <= '0';
		else
		
			--globalReset <= '1' when (endGame = '1' or startGame = '1') else '0';
			
			if controllerResult(4) = '1' then
				startGame <= '1'; --Start the game (spikes begin moving)
			else
				startGame <= '0';
			end if;
			
			if collided = '1' then
				endGame <= '1';
			else
				endGame <= '0'; --Game over when collided is 1
			end if;
			
			if won = '1'then
				wonGame <= '1';
			else 
				wonGame <= '0';
			end if;
	end if;
				
	end process;
	
end;