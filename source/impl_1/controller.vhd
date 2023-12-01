library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
  
entity controller is 
  port( 
	controllerInput : in std_logic; 
	controllerLatch : out std_logic; 
	controllerClk : out std_logic; 
	controllerResult : out std_logic_vector(7 downto 0)
  ); 
end controller; 
  
architecture synth of controller is 
  
component HSOSC is 
	generic (CLKHF_DIV : String := "0b00"); -- Divide 48MHz clock by 2N (0-3) 
	port(CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up 
     	CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output 
     	CLKHF : out std_logic := 'X'); -- Clock output 
end component; 
  
signal clk : std_logic; 
signal intermediate : std_logic_vector (7 downto 0); 
signal count : unsigned(25 downto 0); 
signal slowClk : std_logic; 
signal slowCount : unsigned (7 downto 0); 
  
begin 
  
osc : HSOSC generic map ( CLKHF_DIV => "0b00") 
    	port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk); 
		
process (clk) begin 
	if rising_edge(clk) then 
		count <= count + 1; 
	end if; 
end process; 
  
slowClk <= count(8); 
slowCount <= count(16 downto 9); 
controllerLatch <= '1' when slowCount = 0x"08" else '0'; 
controllerClk <= slowClk when (slowCount < 0x"08") else '0'; 

process (controllerClk) begin 
	if rising_edge(controllerClk) then 
		intermediate(7 downto 1) <= intermediate(6 downto 0); 
		intermediate(0) <= not controllerInput; -- added a not because it pulses low otherwise 
	end if; 
end process; 

controllerResult <= intermediate when controllerLatch; 
end; 