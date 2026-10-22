library ieee;
use ieee.std_logic_1164.all;


entity mux is
   generic (n : integer := 8);
   port ( a, b, c, d ,e ,f: in std_logic_vector(n-1 downto 0);
   sel: in std_logic_vector (2 downto 0);
   y: out std_logic_vector (7 downto 0));
     
end mux;



architecture mux3 of mux is
begin
 with sel select
 y <= a when "000", --add
 b when "001", --subst
 c when "100", --AND
 d when "101", --INV
 e when "110", --OR
 f when "111", --XOR
 "00000000" when others;
 
 end mux3;
 



