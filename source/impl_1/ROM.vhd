library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- components and port maps
entity ROMaddress is
  port(
	  clk : in std_logic;
	  addr : in unsigned(2 downto 0);
	  data : out std_logic_vector(6 downto 0)
  );
end ROMaddress;

-- clock input 1 std_
-- address input 3 bits
-- data output 7 bits (6 downto 0)

architecture synth of ROMaddress is

begin
process(clk) is
begin
if rising_edge(clk) then

case addr is
		when "000" => data <= "0111111"; -- Assumes 3-bit address and 7-bit data
		when "001" => data <= "0011111"; -- You can make these any size you want
		when "010" => data <= "0001111";
		when "011" => data <= "0000111";
		when "100" => data <= "0000011";
		when "101" => data <= "0000001"; 
		when "110" => data <= "0000000";
		when "111" => data <= "1111111";
		when others => data <= "0000000"; -- Don't forget the "others" case!
		end case;
end if;
end process;

end;
