library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity game_state is
	port(
		frameClk : in std_logic;
		collided : in std_logic;
		controllerResult : in std_logic_vector(7 downto 0);
		startGame : out std_logic;
		endGame : out std_logic
	);
end game_state;

architecture synth of game_state is 

begin
	
end;