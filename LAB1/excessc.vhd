library ieee;
use ieee.std_logic_1164.all;

entity excessc is
  port (
    A   : in std_logic_vector(2 downto 0);
    Sum : out std_logic_vector(3 downto 0)
  );
end excessc;


architecture behavioral of excessc is
begin
  
  with A select
    Sum <= "0011" when "000",
           "0100" when "001",
           "0101" when "010",
           "0110" when "011",
           "0111" when "100",
           "1000" when "101",
           "1001" when "110",
           "1010" when "111",
           "0000" when others;

end architecture behavioral;