library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CAS is
    port(
        in1, in2   : in  std_logic_vector(7 downto 0);
        asc        : in  std_logic;
        low, high  : out std_logic_vector(7 downto 0)
    );
end CAS;

architecture structural of CAS is
begin
    process(in1, in2, asc)
    begin
        if asc = '1' then
            if unsigned(in1) <= unsigned(in2) then
                low <= in1; high <= in2;
            else
                low <= in2; high <= in1;
            end if;
        else
            if unsigned(in1) >= unsigned(in2) then
                low <= in1; high <= in2;
            else
                low <= in2; high <= in1;
            end if;
        end if;
    end process;
end structural;
