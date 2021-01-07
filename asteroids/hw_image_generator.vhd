LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hw_image_generator IS

  GENERIC(
    pixels_y :  INTEGER := 640; 
    pixels_x :  INTEGER := 480
	 );
	 
	 
	 
  PORT(
    disp_ena :  IN   STD_LOGIC;  
    row      :  IN   INTEGER;   
    column   :  IN   INTEGER;    
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	 
	 --Entradas para la lógica del juego
	 dipsw    :  in std_logic_vector (1 downto 0);
	 button   :  in std_logic;
	 reloj    :  in std_logic
	); 
	 
END hw_image_generator;


ARCHITECTURE behavior OF hw_image_generator IS


--/////////////////////[VARIABLES GLOBALES]/////////////////////////////ejercicio5

--cantidad de asteroides y variables de la nave
signal asteroid: integer range 0 to 10 := 4; 
signal lives: integer:= 3; 
signal boxCol: std_logic := '1'; 

--carga y mov de asteroides
signal boxCol1: std_logic := '1'; 
signal boxCol2: std_logic := '1'; 
signal boxCol3: std_logic := '1'; 
signal boxCol4: std_logic := '1'; 




-- Memory Dir y coordenadas auxiliares
signal dx: integer range 0 to 700 :=700; 
signal dy: integer range 0 to 700 :=700; 
signal direc: std_logic := '0';


--/////////////////////[VARIABLES DE ENTIDADES]/////////////////////////////

--INICIAL POS SPACESHIP
signal x: integer range 0 to 700 := 210;
signal y: integer range 0 to 700 := 10;



--BARIABLES DE CADA ASTEROIDE

signal x1:integer range 0 to 700 := 30;
signal y1:integer range 0 to 700 := 280;
signal dx1: integer range 0 to 700 :=700;
signal dy1: integer range 0 to 700 :=700;
signal flagLive1: std_logic := '1';

--2
signal x2:integer range 0 to 700 := 30;
signal y2:integer range 0 to 700 := 380;
signal dx2: integer range 0 to 700 :=700;
signal dy2: integer range 0 to 700 :=700;
signal flagLive2: std_logic := '1';

--3
signal x3:integer range 0 to 700 := 10;
signal y3:integer range 0 to 700 := 480;
signal dx3: integer range 0 to 700 :=700;
signal dy3: integer range 0 to 700 :=700;
signal flagLive3: std_logic := '1';

--4
signal x4:integer range 0 to 700 := 10;
signal y4:integer range 0 to 700 := 180;
signal dx4: integer range 0 to 700 :=700;
signal dy4: integer range 0 to 700 :=700;
signal flagLive4: std_logic := '1';


--Para control de ROM .miff
signal h_frame: integer := 210;
signal v_frame: integer := 233;
signal talla: integer := 12;

signal pixel: std_logic_vector(3 downto 0);
signal pixel2: std_logic_vector(3 downto 0);
signal pixel3: std_logic_vector(3 downto 0);
signal pixel4: std_logic_vector(3 downto 0);
signal direccion : integer;


--Carga de Miff -> asteroides
type memoriaSP is array (2499 downto 0) of std_logic_vector(7 downto 0);
signal mem_sp : memoriaSP;
attribute ram_init_file : string;
attribute ram_init_file of mem_sp : signal is "mif_files/ast2sal.mif";

type memoriaSP2 is array (2499 downto 0) of std_logic_vector(7 downto 0);
signal mem_sp2 : memoriaSP2;
attribute ram_init_file of mem_sp2 : signal is "mif_files/astsal.mif";

--Carga de Miff -> Spaceship
type memorianave is array (2499 downto 0) of std_logic_vector(7 downto 0);
signal mem_n : memorianave;
attribute ram_init_file of mem_n : signal is "mif_files/navemsal.mif";


BEGIN




-- MOVIMIENTO SPACESHIP
PROCESS(reloj, dipsw)
  BEGIN
  
  		--MOVIMIENTO HACIO ABAJO		
		IF( reloj'EVENT AND reloj='1') THEN
			IF(dipsw(1)='0' AND dipsw(0)='1') THEN
					IF(x>10 and x<420) THEN
						x<=x-2;
						y<=y;
					ELSE
						x<=x+2;
					END IF;
			
			--MOVIMIENTO HACIO ABAJO		
			ELSIF ( dipsw(1)='0' AND dipsw(0)='0') THEN 
					IF(x>10 and x<420) THEN
						y<=y;
						x<=x+2;
					ELSE
						x<=x-2;
					END IF;
			END IF;
		END IF;
		
END PROCESS;


-- SHOOTING AND DAMAGE SPACESHIP
PROCESS(reloj,button)
  BEGIN
		IF( reloj'EVENT AND reloj='1') THEN	
			
			-- SHPACE SHIP SHOT LOGIC
				IF(boxCol='1' AND button = '0' and lives>0) THEN
					dx<=x+25;
					dy<=y+28;
					boxCol<='0';
					
				ELSIF(boxCol='0') THEN
					IF(dy>10) THEN
						dy<=dy+10;
				END IF;
				
			--ASTEROIDES LOGIC
				--1
				IF((dx>=dx1 AND dx<=dx1+50) AND (dy>=dy1 AND dy<=dy1+50) AND flagLive1='1') THEN
					boxCol <='1';
					flagLive1 <='0';
					asteroid<=asteroid-1;
					
				--2
				ELSIF((dx>=dx2 AND dx<=dx2+50) AND (dy>=y2 AND dy<=y2+50) AND flagLive2='1') THEN
					boxCol <='1';
					flagLive2 <='0';
					asteroid<=asteroid-1;
					
				--3
				ELSIF((dx>=dx3 AND dx<=dx3+50) AND (dy>=y3 AND dy<=y3+50) AND flagLive3='1') THEN
					boxCol <='1';
					flagLive3 <='0';
					asteroid<=asteroid-1;
					
				--4
				ELSIF((dx>=dx4 AND dx<=dx4+50) AND (dy>=y4 AND dy<=y4+50) AND flagLive4='1') THEN
					boxCol <='1';
					flagLive4 <='0';
					asteroid<=asteroid-1;
					
					
				ELSIF (dy>=670 ) THEN
					boxCol <='1';

				END IF;
			END IF;
		END IF;
  END PROCESS;






-- MOVIMIENTO ASTEROIDS 
PROCESS(reloj)
  BEGIN
		IF( reloj'EVENT AND reloj='1') THEN	
			
		--Asteroide 1
			--Initial pos
			IF(boxCol1='1' and flagLive1='1') THEN
				dx1<=10;
				dy1<=630;
				boxCol1<='0';
			ELSIF(boxCol1='0') THEN
			-- Velocidad
				IF(dy1>10) THEN
					dy1<=dy1-3;
				END IF;
			--Colision Box
				IF((dx1+25>=x+5 AND dx1+25<=X+50) AND (dy1+25>=y+5 AND dy1+25<=y+45)) THEN
						boxCol1 <='1';
						lives <=lives-1;
				ELSIF (dy1<20 AND flagLive1='1' ) THEN
						boxCol1 <='1';
				END IF;
			END IF;
			
			--AST 2
		   IF(boxCol2='1' AND flagLive2='1') THEN
				dx2<=110;
				dy2<=630;
				boxCol2<='0';
			ELSIF(boxCol2='0' ) THEN
				IF(dy2>10) THEN
					dy2<=dy2-4;
				END IF;
				IF((dx2+25>=x+5 AND dx2+25<=X+50) AND (dy2+25>=y+5 AND dy2+25=y+45)) THEN
						boxCol2 <='1';
						lives <=lives-1;
				ELSIF (dy2<20 and flagLive2='1') THEN
						boxCol2 <='1';
				END IF;
			END IF;
			
			--AST 3
			IF(boxCol3='1' AND flagLive3='1') THEN
				dx3<=210;
				dy3<=630;
				boxCol3<='0';
			ELSIF(boxCol3='0' ) THEN
				IF(dy3>10) THEN
					dy3<=dy3-3;
				END IF;
				IF((dx3+25>=x+5 AND dx3+25<=X+45) AND (dy3+25>=y+5 AND dy3+25<=y+45)) THEN
					boxCol3 <='1';
					lives <=lives-1;
				ELSIF (dy3<20  and flagLive3='1') THEN
					boxCol3 <='1';
				END IF;
			END IF;
	
			
			--AST 4
			IF(boxCol4='1' AND flagLive4='1') THEN
				dx4<=410;
				dy4<=630;
				boxCol4<='0';
			ELSIF(boxCol4='0' ) THEN
				IF(dy4>10) THEN
					dy4<=dy4-6;
				END IF;
				IF((dx4+25>=x+5 AND dx4+25<=X+45) AND (dy4+25>=y+5 AND dy4+25<=y+45)) THEN
					boxCol4 <='1';
					lives <=lives-1;
				ELSIF (dy4<20  and flagLive4='1') THEN
					boxCol4 <='1';
				END IF;
			END IF;
			
		END IF;
  END PROCESS;
  


--DRAW MIF 
 PROCESS(disp_ena, row, column)

  BEGIN
	IF(disp_ena = '1') THEN 
	

		--SPACE SHIP ROOM TO IMAGE REFERENCE
		IF((row >=x  and row <=x+50) AND (column >=y and column <= y+50) AND lives>0) THEN
			direccion<= ((row-x)*50)+(column-y);	
			pixel3<= mem_n(direccion) (7 downto 4);
			
			red <= pixel3;
			green <= pixel3;
			blue <= pixel3;
		
		
		-- disparo nave 
		ELSIF((row >=dx-2  and row <=dx+2) AND (column >=dy-2 and column <=dy+2) AND (boxCol='0')) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
		
		
	
		-- ASTEROIDE 1
		ELSIF((row >=dx1  and row <=dx1+50) AND (column >=dy1 and column <=dy1+50) AND (boxCol1='0') AND flagLive1='1') THEN
			direccion<= ((row-dx1)*50)+(column-dy1);	
			pixel<= mem_sp(direccion) (7 downto 4);
			red <= pixel;
			green <= pixel;
			blue <= pixel;
			
		--AST 2
		ELSIF((row >=dx2 and row <=dx2+50) AND (column >=dy2 and column <=dy2+50)  and (boxCol2='0') AND flagLive2='1') THEN
		direccion<= ((row-dx2)*50)+(column-dy2);	
			pixel<= mem_sp2(direccion) (7 downto 4);
			red <= pixel;
			green <= pixel;
			blue <= pixel;

		--AST 3
		ELSIF((row >=dx3  and row <=dx3+50) AND (column >=dy3 and column <=dy3+50) and (boxCol3='0') AND flagLive3='1') THEN
			direccion<= ((row-dx3)*50)+(column-dy3);	
			pixel<= mem_sp(direccion) (7 downto 4);
			red <= pixel;
			green <= pixel;
			blue <= pixel;

		--AST 4
		ELSIF((row >=dx4  and row <=dx4+50) AND (column >=dy4 and column <=dy4+50) and (boxCol4='0') AND flagLive4='1') THEN
		direccion<= ((row-dx4)*50)+(column-dy4);	
			pixel<= mem_sp2(direccion) (7 downto 4);
			red <= pixel;
			green <= pixel;
			blue <= pixel;


		
		
-- WIN WORD :D		
-- LETRA w
		ELSIF((row >=200  and row <=216) AND (column >=280 and column <=284) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
			
		ELSIF((row >=200  and row <=216) AND (column >=296 and column <=300) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
		ELSIF((row >=208  and row <=216) AND (column >=288 and column <=292) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
		ELSIF((row >=216  and row <=220) AND (column >=284 and column <=288) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
			
		ELSIF((row >=216  and row <=220) AND (column >=292 and column <=296) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
--LETRA i
		ELSIF((row >=200  and row <=220) AND (column >=304 and column <=308) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
		

		ELSIF((row >=200  and row <=220) AND (column >=312 and column <=316) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');

--LETRA N		
		ELSIF((row >=200  and row <=220) AND (column >=328 and column <=332) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
		
		ELSIF((row >=204  and row <=216) AND (column >=320 and column <=324) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
			
		ELSIF((row >=200  and row <=204) AND (column >=316 and column <=320) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
			
		ELSIF((row >=216  and row <=220) AND (column >=324 and column <=328) AND (asteroid<=0)) THEN
			red <= (OTHERS => '1');
			green <= (OTHERS => '1');
			blue <= (OTHERS => '1');
		
		
	--blanking time
	 ELSE 
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
	 END IF;
END IF;


END PROCESS;







  

  
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
END behavior;
