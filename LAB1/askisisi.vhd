library ieee;
use ieee.std_logic_1164.all;

entity askisisi is
  port (
    A   : in std_logic_vector(6 downto 0);
    Sum : out std_logic_vector(2 downto 0)
  );
end askisisi;

architecture structural of askisisi is 
begin
  
  Sum <= "111" when A(6)='1' else
         "110" when A(5)='1' else
         "101" when A(4)='1' else
         "100" when A(3)='1' else
         "011" when A(2)='1' else
         "010" when A(1)='1' else
         "001" when A(0)='1' else
         "000";

end architecture structural;
