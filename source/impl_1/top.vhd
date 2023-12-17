library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
		fpga_clk : in std_logic; -- 12MHz clock from fpga
		HSYNC : out std_logic;
		VSYNC : out std_logic;
		rgb : out std_logic_vector(5 downto 0);
		controllerIn : in std_logic;
		controlLatch : out std_logic;
		controlClk : out std_logic
	);
end top;

architecture synth of top is 

component vga is
	port(
		vga_clk : in std_logic;
		HSYNC : out std_logic := '1';
		VSYNC : out std_logic := '1';
		row : out unsigned(9 downto 0);
		col : out unsigned(9 downto 0);
		valid : out std_logic := '1';
		frameClk : out std_logic;
		frame2Clk : out std_logic
		);
end component;

component mypll is
    port(
        ref_clk_i: in std_logic;
        rst_n_i: in std_logic;
        outcore_o: out std_logic;
        outglobal_o: out std_logic
    );
end component;

-- this is now cube and spike gen (can't rename)
component cube_gen is
	port(
		vga_clk : in std_logic;
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		cube_bot : in unsigned(9 downto 0);
		playing_rgb : out std_logic_vector(5 downto 0);
		valid : in std_logic;
		spikeArr : in std_logic_vector(19 downto 0);
		spikeInterval : in unsigned(4 downto 0);
		wonGame : in std_logic;
		collided : out std_logic
	);
end component;

component controller is
  port( 
	controllerInput : in std_logic; 
	controllerLatch : out std_logic; 
	controllerClk : out std_logic; 
	controllerResult : out std_logic_vector(7 downto 0)
  ); 
end component;

component jump is
	port(
		aPressed : in std_logic_vector (7 downto 0); 
		vga_clk : in std_logic;
		cubePos : out unsigned(9 downto 0)
	);
end component;

component spikeMove is
	port(
		frameClk : in std_logic;
		frame2Clk : in std_logic;
		controllerResult : in std_logic_vector(7 downto 0);
		spikeArr : out std_logic_vector(19 downto 0);
		spikeInterval : out unsigned(4 downto 0);
		collided : in std_logic;
		--globalReset : in std_logic;
		won : out std_logic
	);
end component;


component game_machine is
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
end component;

-- VGA signals
signal vga_clk : std_logic;
signal row : unsigned(9 downto 0);
signal col : unsigned(9 downto 0);
signal valid : std_logic;
signal reset : std_logic := '1'; 

--60Hz clock
signal frameClk : std_logic;
signal frame2Clk : std_logic;

-- NES signal
signal controllerResult : std_logic_vector(7 downto 0); 
-- 8 bits represent certain button being pressed it goes (MSB to LSB) a, b, select, start, up, down, left, right

-- Cube_gen signals
signal cube_bot : unsigned(9 downto 0);
signal spikeArr : std_logic_vector(19 downto 0);
signal collided : std_logic;
signal playing_rgb : std_logic_vector(5 downto 0);

-- spikeMove Signals
signal spikeInterval : unsigned(4 downto 0);
signal won : std_logic;
--signal globalReset : std_logic;

-- Game_State Signals
signal startGame : std_logic := '0';
signal endGame : std_logic := '0';
signal wonGame : std_logic := '0';

begin

controller1 : controller port map(
	controllerInput => controllerIn,
	controllerLatch => controlLatch,
	controllerClk => controlClk,
	controllerResult => controllerResult
);

mypll_1 : mypll port map(
	ref_clk_i => fpga_clk,
	rst_n_i => reset,
	outglobal_o => vga_clk
);
	
vga_1 : vga port map(
	vga_clk => vga_clk,
	HSYNC => HSYNC,
	VSYNC => VSYNC,
	valid => valid,
	row => row,
	col => col,
	frameClk => frameClk,
	frame2Clk => frame2Clk
);

cube_gen1 : cube_gen port map(
	vga_clk => vga_clk,
	playing_rgb => playing_rgb,
	valid => valid,
	cube_bot => cube_bot,
	row => row,
	col => col,
	spikeArr => spikeArr,
	spikeInterval => spikeInterval,
	collided => collided,
	wonGame => wonGame
);

spikeMove1 : spikeMove port map(
	frameClk => frameClk,
	frame2Clk => frame2Clk,
	spikeArr => spikeArr,
	controllerResult => controllerResult,
	spikeInterval => spikeInterval,
	collided => collided,
	won => won
);

jump1 : jump port map(
	vga_clk => vga_clk,
	cubePos => cube_bot,
	aPressed => controllerResult -- need to port map controller then add "aPressed" here
);

game_machine1 : game_machine port map(
	vga_clk => vga_clk,
	valid => valid,
	collided => collided,
	controllerResult => controllerResult,
	won => won,
	playing_rgb => playing_rgb,
	row => row,
	col => col,
	rgb => rgb
);

end;