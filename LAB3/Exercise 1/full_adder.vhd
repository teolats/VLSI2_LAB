library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
 Port ( a : in std_logic;
 b : in std_logic;
 cin : in std_logic;
 s : out std_logic;
 cout : out std_logic);

end full_adder;
 
architecture gate_level of full_adder is
 
begin
 s <= a XOR b XOR cin ;
 Cout <= (a AND b) OR (cin AND a) OR (cin AND b) ;
 
end gate_level;
