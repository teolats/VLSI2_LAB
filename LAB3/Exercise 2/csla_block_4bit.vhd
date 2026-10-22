library ieee;
use ieee.std_logic_1164.all;

entity csla_block_4bit is
    port(
        a, b : in  std_logic_vector(3 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end csla_block_4bit;

architecture structural of csla_block_4bit is

    
    component labadder is
        port(a, b : in std_logic_vector(3 downto 0); cin : in std_logic; s : out std_logic_vector(4 downto 0));
    end component;

    
    component mux2to1_5bit is
        port(in0, in1 : in std_logic_vector(4 downto 0); sel : in std_logic; output : out std_logic_vector(4 downto 0));
    end component;

    
    signal s0_vec, s1_vec : std_logic_vector(4 downto 0); 
    signal selection      : std_logic_vector(4 downto 0); 

begin

    
    adder0: labadder port map(
        a   => a,
        b   => b,
        cin => '0',
        s   => s0_vec
    );
    
    
    adder1: labadder port map(
        a   => a,
        b   => b,
        cin => '1',
        s   => s1_vec
    );

    mux_inst: mux2to1_5bit port map(
        in0    => s0_vec,     
        in1    => s1_vec,     
        sel    => cin,        
        output => selection   
    );
    
    
    s    <= selection(3 downto 0); 
    cout <= selection(4);          

end structural;
