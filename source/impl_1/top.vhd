library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
		fpga_clk : in std_logic; -- 12MHz clock from fpga
		sevenSeg : out std_logic_vector(6 downto 0);
		HSYNC : out std_logic;
		VSYNC : out std_logic;
		rgb : out std_logic_vector(5 downto 0)
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

component ROMaddress is
	port (
	clk : in std_logic;
	addr : in unsigned(2 downto 0);
	data : out std_logic_vector(6 downto 0)
	);
end component;

component vga is
	port(
		vga_clk : in std_logic;
		HSYNC : out std_logic := '1';
		VSYNC : out std_logic := '1';
		row : out unsigned(9 downto 0);
		col : out unsigned(9 downto 0);
		valid : out std_logic := '1'
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

signal clk: std_logic;
signal addr: unsigned(2 downto 0);

begin

HSOSCclock : HSOSC generic map ( CLKHF_DIV => "0b00")
port map ( 
	CLKHFPU => '1',
	CLKHFEN => '1',
	CLKHF => clk
);
 
Count : counter port map (
	clk  => clk, 
	addr => addr
);

ROM : ROMaddress port map (
	clk  => clk, 
	addr => addr,
	data => sevenSeg
);

mypll_1 : mypll port map(
	ref_clk_i => fpga_clk,
	rst_n_i => reset,
	outcore_o => output_freq,
	outglobal_o => vga_clk
);
	
vga_1 : vga port map(
	vga_clk => vga_clk,
	HSYNC => HSYNC,
	VSYNC => VSYNC,
	valid => valid,
	row => row,
	col => col
);

end;