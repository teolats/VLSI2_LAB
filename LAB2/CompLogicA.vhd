library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CompLogicA is
    port (
        A_log, B_log : in std_logic_vector(3 downto 0);
        EQ, GR, LS : out std_logic
    );
end CompLogicA;

architecture rtl of CompLogicA is
begin
    EQ <= '1' when (A_log = B_log) else '0';
    GR <= '1' when (A_log > B_log) else '0';
    LS <= '1' when (A_log /= B_log and not(A_log > B_log)) else '0';
end rtl;


