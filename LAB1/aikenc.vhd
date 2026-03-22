library ieee;
use ieee.std_logic_1164.all;

entity aikenc is
  port (
    A   : in std_logic_vector(2 downto 0);
    Sum : out std_logic_vector(3 downto 0)
  );
end aikenc;

architecture structural of aikenc is
begin

   Sum <= "0000" when A = "000" else
          "0001" when A = "001" else
          "0010" when A = "010" else
          "0011" when A = "011" else
          "0100" when A = "100" else
          "1011" when A = "101" else
          "1100" when A = "110" else
          "1101" when A = "111" else
          "0000";

end architecture structural;
