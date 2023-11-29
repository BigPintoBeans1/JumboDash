library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity game_object is
	port(
		Y : out integer
	);
end game_object;

architecture synth of game_object is

begin
process (clk) is
begin
    if rising_edge(clk) then
        -- Update object physics
        ObjectProcess: process
        begin
            -- Implement physics logic 
			 Y <= Y + Velocity * DeltaTime + 0.5 * Acceleration * DeltaTime**2;
        end process ObjectProcess;
    end if;
end process;

end;