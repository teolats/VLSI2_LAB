library ieee;
use ieee.std_logic_1164.all;

entity alulab3 is
generic (n : integer := 8);
  port (
    A       : in std_logic_vector(n-1 downto 0);
    B       : in std_logic_vector(n-1 downto 0);
    Op      : in std_logic_vector(2 downto 0);
    Out_res : out std_logic_vector(n-1 downto 0);
    Zero    : out std_logic;
    Cout    : out std_logic;
        clk : in  std_logic;
        rst : in  std_logic  
  );
end alulab3;

architecture structural of alulab3 is

component QD
        generic (n : integer := 8);
        port (q   : in std_logic_vector(n-1 downto 0);
              clk : in std_logic;
              rst : in std_logic;
              d   : out std_logic_vector(n-1 downto 0));
    end component;

component lu is
        generic (n : integer := 8);
        port(
            A, B : in std_logic_vector(n-1 downto 0);
            OUT_AND, OUT_NOT, OUT_OR, OUT_XOR : out std_logic_vector(n-1 downto 0)
        );
    end component;


component au is
        generic (n : integer := 8);
    port(
        A     : in  std_logic_vector(n-1 downto 0);
        B     : in  std_logic_vector(n-1 downto 0);
        M     : in  std_logic; 
        sum   : out std_logic_vector(n-1 downto 0);
        coutp : out std_logic
);   
    end component;



component mux is
   generic (n : integer := 8);
   port ( a, b, c, d ,e ,f: in std_logic_vector(n-1 downto 0);
   sel: in std_logic_vector (2 downto 0);
   y: out std_logic_vector (n-1 downto 0));
     
end component;


    signal wire_au_sum : std_logic_vector(n-1 downto 0);
    signal wire_and    : std_logic_vector(n-1 downto 0);
    signal wire_not    : std_logic_vector(n-1 downto 0);
    signal wire_or     : std_logic_vector(n-1 downto 0);
    signal wire_xor    : std_logic_vector(n-1 downto 0);
    signal wire_final_out    : std_logic_vector(n-1 downto 0);
    signal reg_a       : std_logic_vector(n-1 downto 0);
    signal reg_b       : std_logic_vector(n-1 downto 0);
    signal reg_out_wire: std_logic_vector(n-1 downto 0);


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
LU_INST: lu 
        generic map (n => 8)
        port map (
        A => reg_a,
        B => reg_b,
        OUT_AND => wire_and,
        OUT_NOT => wire_not,
        OUT_OR => wire_or,
        OUT_XOR => wire_xor
);

AU_INST: au 
        generic map (n => 8)
        port map (
        A => reg_a,
        B => reg_b,
        M => Op(0),
        sum => wire_au_sum,
        coutp => Cout 
);

MUX_INST: mux
        generic map (n => 8)
        port map (
        a => wire_au_sum, 
        b => wire_au_sum,
        c => wire_and,
        d => wire_not,
        e => wire_or,
        f => wire_xor,
        sel => Op,
        y   => wire_final_out
);


    Out_res <= reg_out_wire;
    Zero <= '1' when reg_out_wire = "00000000" else '0';

    REG_OUT_inst: QD 
        generic map (n)
        port map (q => wire_final_out, 
                  clk => clk, 
                  rst => rst, 
                  d => reg_out_wire);

end structural;
