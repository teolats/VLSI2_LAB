library ieee;
use ieee.std_logic_1164.all;

entity csa_16bit_generate is
    generic (BLOCK_SIZE : integer := 4); 
    port(
        a, b : in  std_logic_vector(15 downto 0);
        cin  : in  std_logic;
        sum  : out std_logic_vector(15 downto 0);
        cout : out std_logic
    );
end csa_16bit_generate;

architecture structural of csa_16bit_generate is
    constant NUM_BLOCKS : integer := 16 / BLOCK_SIZE;

    component labadder_generic is
        generic (K : integer);
        port(a, b : in std_logic_vector(K-1 downto 0); cin : in std_logic; s : out std_logic_vector(K downto 0));
    end component;

    component csla_block_generic is
        generic (K : integer);
        port(a, b : in std_logic_vector(K-1 downto 0); cin : in std_logic; s : out std_logic_vector(K-1 downto 0); cout : out std_logic);
    end component;

    signal carries : std_logic_vector(NUM_BLOCKS downto 0);
    signal first_s : std_logic_vector(BLOCK_SIZE downto 0);

begin
    carries(0) <= cin;

    
    FIRST_BLOCK: labadder_generic 
        generic map (K => BLOCK_SIZE)
        port map (
            a   => a(BLOCK_SIZE-1 downto 0),
            b   => b(BLOCK_SIZE-1 downto 0),
            cin => carries(0),
            s   => first_s
        );
    sum(BLOCK_SIZE-1 downto 0) <= first_s(BLOCK_SIZE-1 downto 0);
    carries(1) <= first_s(BLOCK_SIZE);

   
    BLOCKS_STRUCTURE: for i in 1 to NUM_BLOCKS-1 generate
        NEXT_BLOCKS: csla_block_generic 
            generic map (K => BLOCK_SIZE)
            port map (
                a    => a((i+1)*BLOCK_SIZE-1 downto i*BLOCK_SIZE),
                b    => b((i+1)*BLOCK_SIZE-1 downto i*BLOCK_SIZE),
                cin  => carries(i),
                s    => sum((i+1)*BLOCK_SIZE-1 downto i*BLOCK_SIZE),
                cout => carries(i+1)
            );
    end generate;

    cout <= carries(NUM_BLOCKS);

end structural;
