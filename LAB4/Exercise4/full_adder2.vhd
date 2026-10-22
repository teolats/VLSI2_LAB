library ieee;
use ieee.std_logic_1164.all;

entity full_adder2 is
    port (a, b, cin : in std_logic; s, cout : out std_logic);
end full_adder2;

architecture concurrent of full_adder2 is
begin
    s    <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end concurrent;

library ieee;
use ieee.std_logic_1164.all;

entity Mux2to1 is
    port (in0, in1, sel : in std_logic; output : out std_logic);
end Mux2to1;

architecture concurrent of Mux2to1 is
begin
    output <= in0 when sel = '0' else in1;
end architecture;
