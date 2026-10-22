library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity ComparatorCircuitB is
    port (
        A, B : in std_logic_vector(3 downto 0);
        EQUAL, GREATER, LESS : out std_logic
    );
end ComparatorCircuitB;

architecture behavioral of ComparatorCircuitB is
   
    signal diff : std_logic_vector(4 downto 0);
begin

    EQUAL <= '1' when (A = B) else '0';

   
    diff <= ('0' & A) - ('0' & B);
    
    LESS <= diff(4); 


    GREATER <= '1' when (A /= B and diff(4) = '0') else '0';

end behavioral;