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
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		rgb : out std_logic_vector(5 downto 0)

	);
end game_machine;

architecture synth of game_machine is 

component die_rom is
  port(
	  clk : in std_logic;
	  die_xadr: in unsigned(7 downto 0);
	  die_yadr : in unsigned(6 downto 0); -- 0-1023
	  rgb : out std_logic_vector(5 downto 0)
  );
end component;

component win_rom is
  port(
	  clk : in std_logic;
	  win_xadr: in unsigned(7 downto 0);
	  win_yadr : in unsigned(6 downto 0); -- 0-1023
	  rgb : out std_logic_vector(5 downto 0)
  );
end component;

component start_rom is
  port(
	  clk : in std_logic;
	  start_xadr: in unsigned(7 downto 0);
	  start_yadr : in unsigned(6 downto 0); -- 0-1023
	  rgb : out std_logic_vector(5 downto 0)
  );
end component;

signal startGame : std_logic := '0';
signal endGame : std_logic := '0';
signal wonGame : std_logic := '0';
signal dieRom : std_logic_vector(5 downto 0);
signal winRom : std_logic_vector(5 downto 0);
signal startRom : std_logic_vector(5 downto 0);
signal row_vector : std_logic_vector(9 downto 0);
signal col_vector : std_logic_vector(9 downto 0);

type state is (START, PLAY, WIN, DIE);
signal current_state : state := START;

begin

	process(vga_clk) is begin
		if rising_edge(vga_clk) then
			
			case current_state is
				when START =>
					rgb <= startRom when (valid = '1') else "000000";
					if(controllerResult(4) = '1') then
						current_state <= PLAY;
					end if;
				when PLAY =>
					rgb <= playing_rgb when(valid = '1') else "000000";
					if (won = '1') then
						current_state <= WIN;
					elsif (collided = '1') then
						current_state <= DIE;
					end if;
				when WIN =>
					rgb <= winRom when (valid = '1') else "000000";
					if (controllerResult(6) = '1') then
						current_state <= START;
					end if;
				when DIE =>
					rgb <= dieRom when (valid = '1') else "000000";
					if (controllerResult(6) = '1') then
						current_state <= START;
					end if;
			end case;
		end if;
	end process;
	
	row_vector <= std_logic_vector(row);
	col_vector <= std_logic_vector(col);
	
	die_rom1 : die_rom port map (
			clk => vga_clk,
			die_xadr => unsigned(col_vector(9 downto 2)), -- divide by 4(assigns each pixel defined in rom to 4 pixels on screen)
			die_yadr => unsigned(row_vector(8 downto 2)), -- divide by 4 (assigns each pixel defined in rom to 4 pixels on screen)
			rgb => dieRom -- should be in if block as else (if nothing else there draw background)
		);
		
	win_rom1 : win_rom port map (
			clk => vga_clk,
			win_xadr => unsigned(col_vector(9 downto 2)), -- divide by 4(assigns each pixel defined in rom to 4 pixels on screen)
			win_yadr => unsigned(row_vector(8 downto 2)), -- divide by 4 (assigns each pixel defined in rom to 4 pixels on screen)
			rgb => winRom -- should be in if block as else (if nothing else there draw background)
		);
	
	start_rom1 : start_rom port map (
			clk => vga_clk,
			start_xadr => unsigned(col_vector(9 downto 2)), -- divide by 4(assigns each pixel defined in rom to 4 pixels on screen)
			start_yadr => unsigned(row_vector(8 downto 2)), -- divide by 4 (assigns each pixel defined in rom to 4 pixels on screen)
			rgb => startRom -- should be in if block as else (if nothing else there draw background)
		);
end;

