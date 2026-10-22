
library ieee;
use ieee.std_logic_1164.all;
use work.sorter_pkg.all;

entity tb_sorter is
end tb_sorter;

architecture beh of tb_sorter is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal inputs, outputs : type_array_8x8;
begin
    uut: entity work.Sorter_8bit port map(clk, rst, inputs, outputs);

    clk <= not clk after 5 ns;

    process
    begin
        inputs <= (x"0A", x"14", x"05", x"09", x"03", x"08", x"0C", x"0E"); -- 10, 20, 5, 9, 3, 8, 12, 14
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 100 ns;
        assert outputs(0) = x"03" report "Sort Failed" severity error;
        wait;
    end process;
end beh;