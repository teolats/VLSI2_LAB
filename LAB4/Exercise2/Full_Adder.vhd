library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder is
    port (
        a, b, cin : in std_logic;
        s, cout   : out std_logic
    );
end Full_Adder;

architecture concurrent_arch of Full_Adder is
begin
    s    <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end concurrent_arch;
