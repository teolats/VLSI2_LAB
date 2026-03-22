library ieee;
use ieee.std_logic_1164.all;

entity grayb is
  port (
    A   : in std_logic_vector(2 downto 0);
    Sum : out std_logic_vector(3 downto 0)
  );
end grayb;

architecture structural of grayb is
begin
  
  with A select
    Sum <= "0000" when "000",
           "0001" when "001",
           "0011" when "010",
           "0010" when "011",
           "0110" when "100",
           "0111" when "101",
           "0101" when "110",
           "0100" when "111",
           "0000" when others;

end architecture structural;
