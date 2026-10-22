library ieee;
use ieee.std_logic_1164.all;

entity carry_skip_adder is
    port (
        a, b : in std_logic_vector(10 downto 0);
        cin  : in std_logic;
        s    : out std_logic_vector(10 downto 0);
        cout : out std_logic
    );
end carry_skip_adder;

architecture structural of carry_skip_adder is
    component full_adder2 port (a, b, cin : in std_logic; s, cout : out std_logic); end component;
    component Mux2to1 port (in0, in1, sel : in std_logic; output : out std_logic); end component;

    signal c : std_logic_vector(11 downto 0);
    signal p : std_logic_vector(10 downto 0);
    signal skip_en : std_logic;
begin
    c(0) <= cin;
    
    GEN_FA: for i in 0 to 10 generate
        FA: full_adder2 port map (a(i), b(i), c(i), s(i), c(i+1));
        p(i) <= a(i) xor b(i);
    end generate;

    skip_en <= p(0) and p(1) and p(2) and p(3) and p(4) and p(5) and p(6) and p(7) and p(8) and p(9) and p(10);
    
    MUX_FINAL: Mux2to1 port map (c(11), c(0), skip_en, cout);
    
end structural;
