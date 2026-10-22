library ieee;
use ieee.std_logic_1164.all;

entity Mux2to1 is
    port (
        in0, in1 : in std_logic_vector(3 downto 0);
        sel      : in std_logic;
        output   : out std_logic_vector(3 downto 0)
    );
end Mux2to1;

architecture concurrent_arch of Mux2to1 is
begin
    
    output <= in0 when sel = '0' else in1;
end concurrent_arch;
