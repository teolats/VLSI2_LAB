library ieee;
use ieee.std_logic_1164.all;

entity lvl3_barrel_shifter is
  generic (n : integer := 8);
  port (
    inp         : in std_logic_vector(n-1 downto 0);
    outp        : out std_logic_vector(n-1 downto 0);
    shift_first : in std_logic_vector(2 downto 0);
    clk         : in std_logic;
    rst         : in std_logic  
  );
end lvl3_barrel_shifter;

architecture structural of lvl3_barrel_shifter is

  component QD
    generic (n : integer := 8);
    port (
    q   : in std_logic_vector(n-1 downto 0);
    clk : in std_logic;
    rst : in std_logic;
     d   : out std_logic_vector(n-1 downto 0)
    );
  end component;

  component mux is
    port ( 
      a,b: in std_logic;
      sel:  in std_logic;
      y:    out std_logic
    );
  end component;

  component barrel_shifter is
    generic (n : integer := 8);
    port (
      A : in std_logic_vector(n-1 downto 0);
      Out_res: out std_logic_vector(n-1 downto 0);
      shift : in std_logic
    );
  end component;

  signal wire_final_out : std_logic_vector(n-1 downto 0);
  signal reg_a          : std_logic_vector(n-1 downto 0);
  signal reg_out_wire   : std_logic_vector(n-1 downto 0);
  signal reg1           : std_logic_vector(n-1 downto 0);
  signal reg2           : std_logic_vector(n-1 downto 0);
  signal reg3           : std_logic_vector(n-1 downto 0);

begin 

  REG_A_inst: QD 
    generic map (n => n)
    port map (
      q   => inp,
      clk => clk,
      rst => rst, 
      d   => reg_a
    );

  BARREL_SHIFT_LOOP: for i in 0 to 2 generate

    BARREL_INST_FIRST: if i = 0 generate
      BARREL_INST_1: barrel_shifter
        generic map (n => n)
        port map (
          A  => reg_a,     
          Out_res => reg2,
          shift   => shift_first(i)
        );
    end generate BARREL_INST_FIRST;

    BARREL_INST_SECOND: if i = 1 generate
      MUX_LOOP_2: for j in 0 to n-1 generate
        LSB_MUX_2: if j < 2 generate
          MUX_INST: mux
            port map (
              a => reg2(j),        
              b => '0',          
              sel => shift_first(i),
              y=> reg3(j)
            );
        end generate LSB_MUX_2;
        OTHER_MUX_2: if j >= 2 generate
          MUX_INST: mux
            port map (
              a=> reg2(j),        
              b => reg2(j-2),      
              sel => shift_first(i),
              y => reg3(j)
            );
     end generate OTHER_MUX_2;
     end generate MUX_LOOP_2; 
    end generate BARREL_INST_SECOND;

    BARREL_INST_THIRD: if i = 2 generate
      MUX_LOOP_3: for j in 0 to n-1 generate
        LSB_MUX_3: if j < 4 generate
          MUX_INST: mux
            port map (
              a  => reg3(j),        
              b  => '0',          
              sel => shift_first(i),
              y  => wire_final_out(j)
            );
        end generate LSB_MUX_3;
        OTHER_MUX_3: if j >= 4 generate
          MUX_INST: mux
            port map (
              a  => reg3(j),        
              b => reg3(j-4),          
              sel => shift_first(i),
              y  => wire_final_out(j)
            );
        end generate OTHER_MUX_3;
      end generate MUX_LOOP_3;
    end generate BARREL_INST_THIRD;
    
  end generate BARREL_SHIFT_LOOP;

  REG_OUT_inst: QD 
    generic map (n => n)
    port map (
      q   => wire_final_out, 
      clk => clk, 
      rst => rst, 
      d => reg_out_wire
    );

  outp <= reg_out_wire;

end structural;
