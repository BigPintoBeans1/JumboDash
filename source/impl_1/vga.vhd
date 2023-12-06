library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
	port(
		vga_clk : in std_logic;
		HSYNC : out std_logic := '1';
		VSYNC : out std_logic := '1';
		col : out unsigned(9 downto 0);
		row : out unsigned(9 downto 0);
		valid : out std_logic := '1';
		frameClk : out std_logic;
		frame2Clk : out std_logic
	);
end;

architecture synth of vga is
	signal scol : unsigned(9 downto 0) := "0000000000";
	signal srow : unsigned(9 downto 0) := "0000000000";
begin
	process(vga_clk) is begin
		if rising_edge(vga_clk)then
			--if (srow = 262 and scol = 700) or (srow = 0 and scol = 700) then
				--frameClk <= not frameClk;
			--end if;
			if (scol = 799) then
				scol <= "0000000000";
				srow <= srow + 1;
			else
				scol <= scol + 1;
			end if;
			
			if (srow = 524) then
				srow <= "0000000000";
			end if;
		end if;
	end process;
	
	--horizontal: visible(0-639) FP(640-655) SYNC(656-751) BP(752-799)
	HSYNC <= '0' when((scol > 659) and (scol < 756)) else '1';
	--vertical: visible(0-479) FP(480-489) SYNC(490-491) BP(492-524)
	VSYNC <= '0' when((srow > 490) and (srow < 493)) else '1';
	--Valid is used to tell pattern_gen when to send rgb values
	valid <= '1' when ((scol <= 639) and (srow <= 479)) else '0';
	
	--frameClk <= '1' when (srow = 482) else '0';
	frameClk <= '1' when (srow = 524) else '0';

	frame2Clk <= '1' when (srow = 262 or srow = 524) else '0';
	row <= srow;
	col <= scol;
end;