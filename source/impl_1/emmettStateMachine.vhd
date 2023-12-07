library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity game_machine is
	port(
		vga_clk : in std_logic;
		valid : in std_logic;
		collided : in std_logic;
		controllerResult : in std_logic_vector(7 downto 0);
		won : in std_logic;
		playing_rgb : in std_logic_vector(5 downto 0);
		rgb : out std_logic_vector(5 downto 0)

	);
end game_machine;

architecture synth of game_machine is 

signal startGame : std_logic := '0';
signal endGame : std_logic := '0';
signal wonGame : std_logic := '0';

type state is (START, PLAY, ENDZ);
signal current_state : state := START;

begin

	process(vga_clk) is begin
		if rising_edge(vga_clk) then
			
			case current_state is
				when START =>
					rgb <= "001100" when(valid = '1') else "000000";
					if(controllerResult(4) = '1') then
						current_state <= PLAY;
					end if;
				when PLAY =>
					rgb <= playing_rgb when(valid = '1') else "000000";
					if (collided = '1') then
						current_state <= ENDZ;
					end if;
				when ENDZ =>
					rgb <= "110000" when(valid = '1') else "000000";
					if(controllerResult(6) = '1') then
						current_state <= START;
					end if;
			end case;
		end if;
	end process;
end;

