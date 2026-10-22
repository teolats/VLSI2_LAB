library ieee;
use ieee.std_logic_1164.all;

entity absolutevalue is
    generic (n : integer := 8);
    Port ( 
        a   : in  std_logic_vector(n-1 downto 0);
        b   : in  std_logic_vector(n-1 downto 0);
        m   : in  std_logic;  
        clk : in  std_logic;
        rst : in  std_logic;
        o   : out std_logic_vector(n-1 downto 0) 
    );
end absolutevalue;

architecture structural of absolutevalue is
    
    component QD
        generic (n : integer := 4);
        port (q   : in std_logic_vector(n-1 downto 0);
              clk : in std_logic;
              rst : in std_logic;
              d   : out std_logic_vector(n-1 downto 0));
    end component;

    component full_adder is
        Port ( 
            a    : in std_logic;
            b    : in std_logic;
            cin  : in std_logic;
            s    : out std_logic;
            cout : out std_logic
        );
    end component;

    signal reg_a, reg_b : std_logic_vector(n-1 downto 0);
    signal b_xor        : std_logic_vector(n-1 downto 0);
    signal c1           : std_logic_vector(n downto 0); 
    signal diff         : std_logic_vector(n-1 downto 0);
    
    signal is_neg       : std_logic;

    signal o_xor        : std_logic_vector(n-1 downto 0);
    signal c2           : std_logic_vector(n downto 0);
    signal abs_val      : std_logic_vector(n-1 downto 0);

begin

    REG_A_inst: QD 
        generic map (n)
        port map (q => a,
                  clk => clk,
                  rst => rst, 
                  d => reg_a);
        
    REG_B_inst: QD 
        generic map (n)
        port map (q => b, 
                  clk => clk, 
                  rst => rst,
                  d => reg_b);

    c1(0) <= m;

    gen_stage1: for i in 0 to n-1 generate
        b_xor(i) <= reg_b(i) xor m;
        
        FA_inst1: full_adder port map (
            a    => reg_a(i),
            b    => b_xor(i), 
            cin  => c1(i),     
            s    => diff(i),   
            cout => c1(i+1)    
        );
    end generate gen_stage1;

    is_neg <= m and (not c1(n));

    c2(0) <= is_neg; 

    gen_stage2: for i in 0 to n-1 generate
        o_xor(i) <= diff(i) xor is_neg;
        
        FA_inst2: full_adder port map (
            a    => o_xor(i),
            b    => '0',        
            cin  => c2(i),
            s    => abs_val(i),       
            cout => c2(i+1)
        );
    end generate gen_stage2;

    REG_OUT_inst: QD 
        generic map (n)
        port map (q => abs_val, 
                  clk => clk, 
                  rst => rst, 
                  d => o);

end structural;
