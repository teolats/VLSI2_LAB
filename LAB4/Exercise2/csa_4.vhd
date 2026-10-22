library ieee;
use ieee.std_logic_1164.all;

entity csa_4 is
    port (
        A, B, C, D : in  std_logic_vector(3 downto 0);
        FinalSum   : out std_logic_vector(5 downto 0) 
    );
end csa_4;

architecture structural of csa_4 is

    component Full_Adder
        port (a, b, cin : in std_logic; s, cout : out std_logic);
    end component;

    signal s1, c1 : std_logic_vector(3 downto 0);
    signal s2, c2 : std_logic_vector(4 downto 0);
    signal cpa_c  : std_logic_vector(5 downto 0);

begin

    GEN_CSA1: for i in 0 to 3 generate
        FA_inst1: Full_Adder port map (A(i), B(i), C(i), s1(i), c1(i));
    end generate;

    FA_inst2_0: Full_Adder port map (s1(0), '0', D(0), s2(0), c2(1));
    GEN_CSA2: for i in 1 to 3 generate
        FA_inst2: Full_Adder port map (s1(i), c1(i-1), D(i), s2(i), c2(i+1));
    end generate;
    s2(4) <= c1(3);
    c2(0) <= '0'; 

    cpa_c(0) <= '0';
    GEN_CPA: for i in 0 to 4 generate
        FA_final: Full_Adder port map (s2(i), c2(i), cpa_c(i), FinalSum(i), cpa_c(i+1));
    end generate;
    
    FinalSum(5) <= cpa_c(5);

end structural;
