IF(disp_ena = '1') THEN --display time
	 
	 
-- PRIMER EJERCICIO
    IF((row > 200  and row < 250) AND (column > 1 and column < 50)) THEN
        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '1');
            
    ELSIF((row > 200  and row < 250) AND (column > 100 and column < 150)) THEN
        red <= (OTHERS => '0');
        green  <= (OTHERS => '1');
        blue <= (OTHERS => '0');
            
    ELSIF((row > 200  and row < 250) AND (column > 200 and column < 250)) THEN
        red <= (OTHERS => '1');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');
        
    ELSIF((row > 200  and row < 250) AND (column > 300 and column < 350)) THEN
        red <= (OTHERS => '1');
        green  <= (OTHERS => '1');
        blue <= (OTHERS => '1');
            
    ELSIF((row > 200  and row < 250) AND (column > 400 and column < 450)) THEN
        red <= (OTHERS => '1');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');
    
   -- SEGUNDO EJERCICIO
    IF((row > 200  and row < 210) AND (column > 110 and column < 140)) THEN
        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '1');
     
    ELSIF((row > 210  and row < 240) AND (column > 140 and column < 150)) THEN
        red <= (OTHERS => '0');
        green  <= (OTHERS => '1');
        blue <= (OTHERS => '0');
            
    ELSIF((row > 250  and row < 280) AND (column > 140 and column < 150)) THEN
        red <= (OTHERS => '1');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');
        
    ELSIF((row > 280  and row < 290) AND (column > 110 and column < 140)) THEN
        red <= (OTHERS => '1');
        green  <= (OTHERS => '1');
        blue <= (OTHERS => '1');
            
    ELSIF((row > 250  and row < 280) AND (column > 100 and column < 110)) THEN
        red <= (OTHERS => '0');
        green  <= (OTHERS => '1');
        blue <= (OTHERS => '1');
            
    ELSIF((row > 210  and row < 240) AND (column > 100 and column < 110)) THEN
        red <= (OTHERS => '1');
        green  <= (OTHERS => '1');
        blue <= (OTHERS => '0');	
            
    ELSIF((row > 240  and row < 250) AND (column > 110 and column < 140)) THEN
        red <= (OTHERS => '1');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '1');
        
-- GENERAL		
   ELSE
   red <= (OTHERS => '0');
   green  <= (OTHERS => '0');
   blue <= (OTHERS => '0');
 END IF;
   
   
ELSE                           --blanking time
 red <= (OTHERS => '0');
 green <= (OTHERS => '0');
 blue <= (OTHERS => '0');
END IF;

END PROCESS;