library ieee;
use ieee.std_logic_1164.all;

entity csa_5 is
    port (
        op1, op2, op3, op4, op5 : in std_logic_vector(7 downto 0);
        sum_out : out std_logic_vector(10 downto 0)
    );
end csa_5;

architecture structural of csa_5 is
    component full_adder2 port (a, b, cin : in std_logic; s, cout : out std_logic); end component;
    component carry_skip_adder port (a, b : in std_logic_vector(10 downto 0); cin : in std_logic; s : out std_logic_vector(10 downto 0); cout : out std_logic); end component;

    signal s1, c1 : std_logic_vector(7 downto 0) := (others => '0');
    signal s2, c2 : std_logic_vector(8 downto 0) := (others => '0');
    signal s3, c3 : std_logic_vector(9 downto 0) := (others => '0');
    signal final_a, final_b : std_logic_vector(10 downto 0) := (others => '0');

begin
    L1: for i in 0 to 7 generate
        FA1: full_adder2 port map (op1(i), op2(i), op3(i), s1(i), c1(i));
    end generate;

    FA2_0: full_adder2 port map (s1(0), '0', op4(0), s2(0), c2(1));
    L2: for i in 1 to 7 generate
        FA2: full_adder2 port map (s1(i), c1(i-1), op4(i), s2(i), c2(i+1));
    end generate;
    s2(8) <= c1(7); 
    c2(0) <= '0';

    FA3_0: full_adder2 port map (s2(0), '0', op5(0), s3(0), c3(1));
    L3: for i in 1 to 7 generate
        FA3: full_adder2 port map (s2(i), c2(i), op5(i), s3(i), c3(i+1));
    end generate;
    
    s3(8) <= s2(8);
    s3(9) <= c2(8);
    c3(0) <= '0';

    final_a <= "0" & s3;       
    final_b <= "0" & c3(9 downto 1) & "0"; 

    CPA_INST: carry_skip_adder 
        port map (a => final_a, b => final_b, cin => '0', s => sum_out, cout => open);

end structural;
