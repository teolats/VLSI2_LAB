library ieee;
use ieee.std_logic_1164.all;

entity lu is
    generic (n : integer := 8);
    port(
        A : in  std_logic_vector(n-1 downto 0);
        B : in  std_logic_vector(n-1 downto 0);
        OUT_AND : out std_logic_vector(n-1 downto 0);
        OUT_NOT : out std_logic_vector(n-1 downto 0);
        OUT_OR  : out std_logic_vector(n-1 downto 0);
        OUT_XOR : out std_logic_vector(n-1 downto 0)
    );
end lu; 

architecture str_lu of lu is
begin

    OUT_AND <= A AND B;
    OUT_NOT <= NOT A;
    OUT_OR  <= A OR B;
    OUT_XOR <= A XOR B;
end str_lu;
