library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hammingcodecirc is
    generic (n : integer := 8);
    port(
        a   : in std_logic_vector(n-1 downto 0);
        b   : in std_logic_vector(n-1 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        d   : out std_logic_vector(3 downto 0) 
    );
end hammingcodecirc;

architecture str_hammingcodecirc of hammingcodecirc is

    component QD
        generic (n : integer := 4);
        port (q   : in std_logic_vector(n-1 downto 0);
              clk : in std_logic;
              rst : in std_logic;
              d   : out std_logic_vector(n-1 downto 0));
    end component;

    component full_adder
        port ( 
            a    : in std_logic;
            b    : in std_logic;
            cin  : in std_logic;
            s    : out std_logic;
            cout : out std_logic);
    end component;

    component half_adder
        port (
            a         : in std_logic;
            b         : in std_logic;
            sum       : out std_logic;
            carry_out : out std_logic
        );
    end component;

    signal reg_a, reg_b : std_logic_vector(7 downto 0);
    signal xor_bits     : std_logic_vector(7 downto 0);
    signal dist_comb    : std_logic_vector(3 downto 0);

    signal s1_0, c1_0, s1_1, c1_1, s1_2, c1_2 : std_logic;
    signal c2_0, s2_1, c2_1, c3_0 : std_logic;

begin

    REG_A_inst: QD 
        generic map (8)
        port map (q => a, 
		  clk => clk, 
		  rst => rst, 
		  d => reg_a);
        
    REG_B_inst: QD 
        generic map (8)
        port map (q => b,	
		  clk => clk,  	
		  rst => rst, 
		  d => reg_b);

    xor_bits <= reg_a xor reg_b;

    FA1: full_adder port map (a => xor_bits(0), 
			      b => xor_bits(1), 	
			      cin => xor_bits(2), 
			      s => s1_0, 
			      cout => c1_0);

    FA2: full_adder port map (a => xor_bits(3), 
			      b => xor_bits(4), 
			      cin => xor_bits(5), 
 			      s => s1_1,
			      cout => c1_1);

    HA1: half_adder port map (a => xor_bits(6), 
			      b => xor_bits(7), 
			      sum => s1_2, 
			      carry_out => c1_2);

    FA3: full_adder port map (a => s1_0, 
			      b => s1_1, 
			      cin => s1_2, 
			      s => dist_comb(0), 
			      cout => c2_0);

    FA4: full_adder port map (a => c1_0, 
			      b => c1_1, 
			      cin => c1_2, 
			      s => s2_1, 
			      cout => c2_1);

    HA2: half_adder port map (a => s2_1, 
			      b => c2_0, 
		              sum => dist_comb(1), 
			      carry_out => c3_0);

    HA3: half_adder port map (a => c2_1, 
			      b => c3_0, 
			      sum => dist_comb(2), 
			      carry_out => dist_comb(3));

    REG_OUT_inst: QD 
        generic map (4)
        port map (q => dist_comb, 
		  clk => clk, 
	          rst => rst, d => d);

end str_hammingcodecirc;
