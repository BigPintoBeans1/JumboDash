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
		controlClk : out std_logic;
		ledController : out std_logic_vector(7 downto 0)
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
		frameClk : out std_logic
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
		spikeArr : in std_logic_vector(19 downto 0)
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
		spikeArr : out std_logic_vector(19 downto 0)
		--spikePosX : out unsigned(9 downto 0) -- since y value is constant 229
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

-- NES signal
signal controllerOutput : std_logic_vector(7 downto 0); 
-- 8 bits represent certain button being pressed it goes (MSB to LSB) a, b, select, start, up, down, left, right

-- Cube_gen signals
signal cube_bot : unsigned(9 downto 0);
signal spikeArr : std_logic_vector(19 downto 0);

-- Spike_gen Signals
signal randomNum : std_logic_vector(3 downto 0);
signal spikeGenClk : std_logic; -- clock shared with generation and randomizer
signal spikePosX : unsigned(9 downto 0); -- spike position x-value

begin

-- Where to attach reset signal to?
---lfsr : lfsr4 port map (
	--outClk => spikeGenClk,
	--inClk => clk,
	--reset => controllerOutput,-- reset should kickstart the randomizer with an initial value 
	--count => randomNum
--);

ledController <= controllerOutput;

controller1 : controller port map(
	controllerInput => controllerIn,
	controllerLatch => controlLatch,
	controllerClk => controlClk,
	controllerResult => controllerOutput
);



HSOSCclock : HSOSC generic map ( CLKHF_DIV => "0b00")
port map ( 
	CLKHFPU => '1',
	CLKHFEN => '1',
	CLKHF => clk
);

-- Count : counter port map (
-- 	clk  => clk, 
--	addr => addr
--);

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
	frameClk => frameClk
);

cube_gen1 : cube_gen port map(
	vga_clk => vga_clk,
	rgb => rgb,
	valid => valid,
	cube_bot => cube_bot,
	row => row,
	col => col,
	spikeArr => spikeArr
	--spikePosX => spikePosX
);

spikeMove1 : spikeMove port map(
	frameClk => frameClk,
	spikeArr => spikeArr
	--spikePosX => spikePosX
);

jump1 : jump port map(
	vgaClk => vga_clk,
	cubePos => cube_bot,
	aPressed => controllerOutput -- need to port map controller then add "aPressed" here
);

end;