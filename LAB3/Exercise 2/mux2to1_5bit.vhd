library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_5bit is
    port(
        in0    : in  std_logic_vector(4 downto 0);
        in1    : in  std_logic_vector(4 downto 0); 
        sel    : in  std_logic;                    
        output : out std_logic_vector(4 downto 0)  
    );
end mux2to1_5bit;

architecture behavioral of mux2to1_5bit is
begin
    
    output <= in0 when sel = '0' else in1;
end behavioral;
