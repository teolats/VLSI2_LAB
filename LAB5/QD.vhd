library ieee;
use ieee.std_logic_1164.all;

entity QD is 
    generic (n : integer := 8);
    port(
        clk, rst : in std_logic;
        q        : in std_logic_vector(n-1 downto 0);
        d        : out std_logic_vector(n-1 downto 0)
    );
end QD;

architecture arch of QD is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            d <= (others => '0');
        elsif rising_edge(clk) then
            d <= q;
        end if;
    end process;
end arch;
