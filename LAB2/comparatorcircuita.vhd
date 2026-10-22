library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ComparatorCircuitA is
    port (
        A, B : in std_logic_vector(3 downto 0);
        clk, rst : in std_logic;
        EQUAL, GREATER, LESS : out std_logic
    );
end ComparatorCircuitA;

architecture structural of ComparatorCircuitA is

    component QD is 
        generic (n:integer:=4);
        port(q:in std_logic_vector(n-1 downto 0); clk,rst:std_logic; d:out std_logic_vector(n-1 downto 0));
    end component;

    component CompLogic_A is
        port (A_log, B_log : in std_logic_vector(3 downto 0); EQ, GR, LS : out std_logic);
    end component;

    signal regA, regB : std_logic_vector(3 downto 0);
    signal results_int : std_logic_vector(2 downto 0); 
    signal results_reg : std_logic_vector(2 downto 0);

begin

    U1: QD generic map (4) 
           port map (q => A, clk => clk, rst => rst, d => regA);
           
    U2: QD generic map (4) 
           port map (q => B, clk => clk, rst => rst, d => regB);

    U3: CompLogic_A 
           port map (A_log => regA, B_log => regB, 
                     EQ => results_int(2), GR => results_int(1), LS => results_int(0));

   
    U4: QD generic map (3) 
           port map (q => results_int, clk => clk, rst => rst, d => results_reg);

    EQUAL   <= results_reg(2);
    GREATER <= results_reg(1);
    LESS    <= results_reg(0);

end structural;
