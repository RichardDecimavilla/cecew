LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY anti_rebote IS
  GENERIC(
    delay_cnt  :  INTEGER := 2
	 );  
  PORT(
    clk,boton  : IN  STD_LOGIC;  
    result  	: OUT STD_LOGIC
	 ); 
END anti_rebote;

ARCHITECTURE logic OF anti_rebote IS
  SIGNAL ffs   	: STD_LOGIC_VECTOR(1 DOWNTO 0); 
  SIGNAL cnt_set : STD_LOGIC;                    
  SIGNAL cnt_out : STD_LOGIC_VECTOR(delay_cnt DOWNTO 0) := (OTHERS => '0'); 
BEGIN

  cnt_set <= ffs(0) xor ffs(1);   
  
  PROCESS(clk)
  BEGIN
    IF(clk'EVENT and clk = '1') THEN
      ffs(0) <= boton;
      ffs(1) <= ffs(0);
      If(cnt_set = '1') THEN                  
        cnt_out <= (OTHERS => '0');
      ELSIF(cnt_out(delay_cnt) = '0') THEN 
        cnt_out <= cnt_out + 1;
      ELSE                                        
        result <= ffs(1);
      END IF;    
    END IF;
  END PROCESS;
END logic;
