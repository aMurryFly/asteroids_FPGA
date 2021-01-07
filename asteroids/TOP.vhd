library ieee;
use ieee.std_logic_1164.all;

ENTITY TOP IS
PORT(
	--salida a VGA
    input_clk:  in   STD_LOGIC; 
	 pixel_clk:  buffer   STD_LOGIC;
	 red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	 h_sync   :  OUT  STD_LOGIC;  
    v_sync   :  OUT  STD_LOGIC; 
	 
	 -- Para el juego 
    dipsw    :  in std_logic_vector (1 downto 0); -- movimiento
	 button   : in std_logic --disparo
	 );

END TOP;

ARCHITECTURE arqTOP OF TOP IS
signal pix_clock: std_logic;
signal disp_ena: std_logic;
signal column:  INTEGER;
signal row:  INTEGER;
signal reloj    :  std_logic;


BEGIN
	
	relojLento: entity work.relojlento(arqrelojlento) port map(input_clk,reloj);
	divFrec: entity work.genMhz(arqgenMhz) port map(input_clk,pixel_clk);
	
	vgaControl: entity work.vga_controller(behavior) port map(pixel_clk,
																		'1',
																		h_sync,
																		v_sync,
																		disp_ena,
																		column,
																		row);--,
																		--n_blank,
																		--n_sync);
	
	gameLogic: entity work.hw_image_generator(behavior) port map(disp_ena,
																			row,
																			column,
																			red,
																			green,
																			blue,
																			dipsw,
																			button,
																			reloj
																			);

END ARCHITECTURE arqTOP;