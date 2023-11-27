library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- components and port maps
entity top is
  port(
	  sevenSeg : out std_logic_vector(6 downto 0)
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

signal clk: std_logic;
signal addr: unsigned(2 downto 0);

begin
HSOSCclock : HSOSC generic map ( CLKHF_DIV => "0b00")
port map 
( CLKHFPU => '1',
  CLKHFEN => '1',
  CLKHF => clk);
 
 
Count : counter port map (clk  => clk, 
						  addr => addr					);

ROM : ROMaddress port map (clk  => clk, 
							addr => addr,
							data => sevenSeg
					);

 
end;