library ieee;
use ieee.std_logic_1164.all;

package sorter_pkg is
    type type_array_8x8 is array (0 to 7) of std_logic_vector(7 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use work.sorter_pkg.all;

entity Sorter_8bit is
    port(
        clk, rst : in std_logic;
        inputs   : in  type_array_8x8;
        outputs  : out type_array_8x8
    );
end Sorter_8bit;

architecture structural of Sorter_8bit is
    
    component CAS is
        port(
            in1, in2  : in std_logic_vector(7 downto 0); 
            asc       : in std_logic; 
            low, high : out std_logic_vector(7 downto 0)
        );
    end component;

    component QD is
        generic (n : integer := 8);
        port(clk, rst : in std_logic; q : in std_logic_vector(n-1 downto 0); d : out std_logic_vector(n-1 downto 0));
    end component;

    signal r_in, s1, s2, s3, s4, s5, s6, r_out : type_array_8x8;

begin

    gen_in: for i in 0 to 7 generate
        reg_i: QD port map(clk, rst, inputs(i), r_in(i));
    end generate;

    c1_0: CAS port map(r_in(0), r_in(1), '1', s1(0), s1(1));
    c1_1: CAS port map(r_in(2), r_in(3), '0', s1(2), s1(3));
    c1_2: CAS port map(r_in(4), r_in(5), '1', s1(4), s1(5));
    c1_3: CAS port map(r_in(6), r_in(7), '0', s1(6), s1(7));

    c2_0: CAS port map(s1(0), s1(2), '1', s2(0), s2(2));
    c2_1: CAS port map(s1(1), s1(3), '1', s2(1), s2(3));
    c2_2: CAS port map(s1(4), s1(6), '0', s2(4), s2(6));
    c2_3: CAS port map(s1(5), s1(7), '0', s2(5), s2(7));

    c3_0: CAS port map(s2(0), s2(1), '1', s3(0), s3(1));
    c3_1: CAS port map(s2(2), s2(3), '1', s3(2), s3(3));
    c3_2: CAS port map(s2(4), s2(5), '0', s3(4), s3(5));
    c3_3: CAS port map(s2(6), s2(7), '0', s3(6), s3(7));

    gen_s4: for i in 0 to 3 generate
        cs4: CAS port map(s3(i), s3(i+4), '1', s4(i), s4(i+4));
    end generate;

    c5_0: CAS port map(s4(0), s4(2), '1', s5(0), s5(2));
    c5_1: CAS port map(s4(1), s4(3), '1', s5(1), s5(3));
    c5_2: CAS port map(s4(4), s4(6), '1', s5(4), s5(6));
    c5_3: CAS port map(s4(5), s4(7), '1', s5(5), s5(7));

    gen_s6: for i in 0 to 3 generate
        cs6: CAS port map(s5(2*i), s5(2*i+1), '1', s6(2*i), s6(2*i+1));
    end generate;

    gen_out: for i in 0 to 7 generate
        reg_o: QD port map(clk, rst, s6(i), outputs(i));
    end generate;

end structural;
