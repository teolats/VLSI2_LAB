library ieee;
use ieee.std_logic_1164.all;

entity csla_block_generic is
    generic (K : integer := 4);
    port(
        a, b : in  std_logic_vector(K-1 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(K-1 downto 0);
        cout : out std_logic
    );
end csla_block_generic;

architecture structural of csla_block_generic is
    component labadder_generic is
        generic (K : integer);
        port(a, b : in std_logic_vector(K-1 downto 0); cin : in std_logic; s : out std_logic_vector(K downto 0));
    end component;

    signal s0, s1 : std_logic_vector(K downto 0);
begin
    
    ADD_ZERO: labadder_generic generic map(K) port map(a, b, '0', s0);
    ADD_ONE:  labadder_generic generic map(K) port map(a, b, '1', s1);

    s <= s0(K-1 downto 0) when cin = '0' else s1(K-1 downto 0);

    cout <= (s1(K) and cin) or s0(K);

end structural;
