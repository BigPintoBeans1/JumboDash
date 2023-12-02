library IEEE;
use IEEE.std_logic_1164.all;

entity lfsr4 is
  port(
	  outClk : out std_logic;
	  inClk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(3 downto 0)
  );
end lfsr4;

architecture synth of lfsr4 is

signal r : std_logic_vector(3 downto 0);
signal counter : unsigned(25 downto 0);
begin
process(inClk) begin
	if rising_edge(inClk) then
		counter <= counter + 1;
	end if;
end process;

outClk <= counter(22); -- this is the clock that generates a random number

process(outClk) begin
    if reset = "00010000" then --pressing the start button triggers the random generator to restart
        r <= "0001";
    elsif rising_edge(outClk) then 
        r(3) <= r(0);
        r(2) <= r(3) xor r(0);
        r(1) <= r(2);
        r(0) <= r(1);
    end if;

end process;
count <= r;
end;

