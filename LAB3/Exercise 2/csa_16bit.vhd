library ieee;
use ieee.std_logic_1164.all;

entity csa_16bit is
    port(
        a, b : in  std_logic_vector(15 downto 0);
        cin  : in  std_logic;
        sum  : out std_logic_vector(15 downto 0);
        cout : out std_logic
    );
end csa_16bit;

architecture structural of csa_16bit is

    
    component labadder is
        port(a, b : in std_logic_vector(3 downto 0); cin : in std_logic; s : out std_logic_vector(4 downto 0));
    end component;

    
    component csla_block_4bit is
        port(a, b : in std_logic_vector(3 downto 0); cin : in std_logic; s : out std_logic_vector(3 downto 0); cout : out std_logic);
    end component;

    
    signal c : std_logic_vector(3 downto 1);
    signal s0_out : std_logic_vector(4 downto 0);

begin

    
    
    B0: labadder port map(
        a   => a(3 downto 0),
        b   => b(3 downto 0),
        cin => cin,
        s   => s0_out
    );
    sum(3 downto 0) <= s0_out(3 downto 0);
    c(1)            <= s0_out(4); 

    -- Block 1: bits 4-7
    B1: csla_block_4bit port map(
        a    => a(7 downto 4),
        b    => b(7 downto 4),
        cin  => c(1),
        s    => sum(7 downto 4),
        cout => c(2)
    );

    -- Block 2: bits 8-11
    B2: csla_block_4bit port map(
        a    => a(11 downto 8),
        b    => b(11 downto 8),
        cin  => c(2),
        s    => sum(11 downto 8),
        cout => c(3)
    );

    -- Block 3: bits 12-15
    B3: csla_block_4bit port map(
        a    => a(15 downto 12),
        b    => b(15 downto 12),
        cin  => c(3),
        s    => sum(15 downto 12),
        cout => cout 
    );

end structural;
