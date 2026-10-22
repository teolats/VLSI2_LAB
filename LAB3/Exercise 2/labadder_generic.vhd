library ieee;
use ieee.std_logic_1164.all;

entity labadder_generic is
    generic (K : integer := 4); 
    port(
        a, b : in  std_logic_vector(K-1 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(K downto 0) 
    );   
end labadder_generic;

architecture structural of labadder_generic is 
    signal c : std_logic_vector(K downto 0);
begin
    c(0) <= cin;
    
    
    FA_GEN: for i in 0 to K-1 generate
        s(i)   <= a(i) xor b(i) xor c(i);
        c(i+1) <= (a(i) and b(i)) or (c(i) and (a(i) xor b(i)));
    end generate;
    
    s(K) <= c(K); 
end structural;
