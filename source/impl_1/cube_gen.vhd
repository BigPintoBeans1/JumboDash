library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cube_gen is
	port(
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		rgb : out std_logic_vector(5 downto 0);
		valid : in std_logic
	);
end cube_gen;

architecture synth of cube_gen is

begin
	rgb <= "000000" when (valid = '1' and row < 229) else 
		"110000" when (valid = '1' and row >= 229 and row <= 249 and col >= 309 and col <= 329) else
		"000000" when (valid = '1' and row > 249) else
		"000000";
	
end;
