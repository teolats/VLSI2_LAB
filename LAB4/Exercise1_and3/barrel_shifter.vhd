library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter is
  generic (n : integer := 8);
  port (
    A       : in std_logic_vector(n-1 downto 0);
    Out_res : out std_logic_vector(n-1 downto 0);
    shift   : in std_logic
  );
end barrel_shifter;

architecture structural of barrel_shifter is

  component mux is
    port ( 
      a, b: in std_logic;
      sel:  in std_logic;
      y:    out std_logic
    );
  end component;

begin 

  SHIFT_LOOP: for i in 0 to n-1 generate
    
    MSB_MUX: if i = n-1 generate
      MUX_INST: mux
        port map (
          a   => A(i),     
          b   => '0',      
          sel => shift,
          y   => Out_res(i)
        );
    end generate MSB_MUX;
    
    OTHER_MUX: if i < n-1 generate
      MUX_INST: mux
        port map (
          a   => A(i),     
          b   => A(i+1),   
          sel => shift,
          y   => Out_res(i)
        );
    end generate OTHER_MUX;
    
  end generate SHIFT_LOOP;

end structural;
