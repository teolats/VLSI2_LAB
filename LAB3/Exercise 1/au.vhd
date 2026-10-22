library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity au is
    generic (n : integer := 8);
    port(
        A     : in  std_logic_vector(n-1 downto 0);
        B     : in  std_logic_vector(n-1 downto 0);
        M     : in  std_logic; -- 0 for Add, 1 for Sub
        sum   : out std_logic_vector(n-1 downto 0);
        coutp : out std_logic
    );
end au; 

architecture str_au of au is
    component full_adder
        port (
            a, b, cin : in std_logic;
            s, cout   : out std_logic
        );
    end component;

    signal xor_bits : std_logic_vector(n-1 downto 0);
    signal c        : std_logic_vector(n downto 0);

begin
    c(0) <= M; 

    ADDER_LOOP: for i in 0 to n-1 generate
        xor_bits(i) <= B(i) xor M;
        
        FA_inst: full_adder
            port map (
                a    => A(i),
                b    => xor_bits(i),
                cin  => c(i),
                s    => sum(i),
                cout => c(i+1)
            );
    end generate ADDER_LOOP;
    coutp <= c(n);

end str_au;
