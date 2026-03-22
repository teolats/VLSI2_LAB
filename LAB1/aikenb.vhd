library ieee;
use ieee.std_logic_1164.all;

entity aikenb is
  port (
    A   : in std_logic_vector(2 downto 0);
    Sum : out std_logic_vector(3 downto 0)
  );
end aikenb;

architecture structural of aikenb is
begin
  
  with A select
    Sum <= "0000" when "000",
           "0001" when "001",
           "0010" when "010",
           "0011" when "011",
           "0100" when "100",
           "1011" when "101",
           "1100" when "110",
           "1101" when "111",
           "0000" when others;

end architecture structural;