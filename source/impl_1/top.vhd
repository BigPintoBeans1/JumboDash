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
		--ledController : out std_logic_vector(7 downto 0)
	);
end top;

architecture synth of top is 

component HSOSC is
	generic (
	
		CLKHF_DIV : String := "0b00"); -- Divide 48MHz clock
	port(
		CLKHFPU : in std_logic := '1'; -- Set to 1 to power up
		CLKHFEN : in std_logic := '1'; -- Set to 1 to enable output
		CLKHF : out std_logic := 'X'); -- Clock output
	end component;

component counter is
	port (
	clk : in std_logic;
	addr : out unsigned(2 downto 0)
	);
end component;

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
		rgb : out std_logic_vector(5 downto 0);
		valid : in std_logic;
		--spikePosX : unsigned(9 downto 0)
		spikeArr : in std_logic_vector(19 downto 0);
		spikeInterval : in unsigned(4 downto 0);
		spikePosA : out unsigned(9 downto 0);
		spikePosB : out unsigned(9 downto 0);
		collided : in std_logic
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
		vgaClk : in std_logic;
		cubePos : out unsigned(9 downto 0)
	);
end component;

component lfsr4 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(3 downto 0)
  );
end component;

component spikeMove is
	port(
		frameClk : in std_logic;
		frame2Clk : in std_logic;
		spikeArr : out std_logic_vector(19 downto 0);
		spikeInterval : out unsigned(4 downto 0)
		--spikePosX : out unsigned(9 downto 0) -- since y value is constant 229
	);
end component;

component collisions is
	port(
		frame2Clk : in std_logic;
		cubePos : in unsigned(9 downto 0);-- current bottom left pixel of cube's position
		spikePosB : in unsigned(9 downto 0); -- current bottom left pixel of the spike that spawns in the segment before the cube
		spikePosA : in unsigned(9 downto 0); -- current bottom left pixel of the spike that spawns in the cube segment
		collided : out std_logic := '0'
	);
end component;

component game_state is
	port(
		frameClk : in std_logic;
		collided : in std_logic;
		controllerResult : in std_logic_vector(7 downto 0);
		startGame : out std_logic;
		endGame : out std_logic
	);
end component;

-- Main clk
signal clk : std_logic;
signal addr : unsigned(2 downto 0);

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

-- Spike_gen Signals
signal randomNum : std_logic_vector(3 downto 0);
signal spikeGenClk : std_logic; -- clock shared with generation and randomizer
signal spikePosX : unsigned(9 downto 0); -- spike position x-value
signal spikeInterval : unsigned(4 downto 0);

-- Collisions Signals
signal spikePosA : unsigned(9 downto 0);
signal spikePosB : unsigned(9 downto 0);
signal collided : std_logic;

-- Game_State Signals
signal startGame : std_logic;
signal endGame : std_logic;

begin


controller1 : controller port map(
	controllerInput => controllerIn,
	controllerLatch => controlLatch,
	controllerClk => controlClk,
	controllerResult => controllerResult
);


HSOSCclock : HSOSC generic map ( CLKHF_DIV => "0b00")
port map ( 
	CLKHFPU => '1',
	CLKHFEN => '1',
	CLKHF => clk
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
	rgb => rgb,
	valid => valid,
	cube_bot => cube_bot,
	row => row,
	col => col,
	spikeArr => spikeArr,
	spikeInterval => spikeInterval,
	spikePosA => spikePosA,
	spikePosB => spikePosB,
	collided => collided
);

spikeMove1 : spikeMove port map(
	frameClk => frameClk,
	frame2Clk => frame2Clk,
	spikeArr => spikeArr,
	spikeInterval => spikeInterval
);

jump1 : jump port map(
	vgaClk => vga_clk,
	cubePos => cube_bot,
	aPressed => controllerResult -- need to port map controller then add "aPressed" here
);

collisions1 : collisions port map(
	frame2Clk => frame2Clk,
	cubePos => cube_bot,
	spikePosA => spikePosA,
	spikePosB => spikePosB,
	collided => collided
	
);

game_state1 : game_state port map(
	frameClk => frameClk,
	collided => collided,
	controllerResult => controllerResult,
	startGame => startGame,
	endGame => endGame
);


end;