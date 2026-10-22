library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decimaldisplay is
    port (
        inputNO         : in  std_logic_vector(4 downto 0); 
        inputNO_DECIMAL : in  std_logic_vector(3 downto 0); 
        dp              : out std_logic;
        sseg_MON        : out std_logic_vector(6 downto 0); 
        sseg_DEK        : out std_logic_vector(6 downto 0);
        sseg_DECIMAL    : out std_logic_vector(6 downto 0)
    );
end decimaldisplay;

architecture behavioral of decimaldisplay is

    function to_sseg(val : integer) return std_logic_vector is
    begin
        case val is
            when 0 => return "1111110";
            when 1 => return "0110000";
            when 2 => return "1101101";
            when 3 => return "1111001";
            when 4 => return "0110011";
            when 5 => return "1011011";
            when 6 => return "1011111";
            when 7 => return "1110000";
            when 8 => return "1111111";
            when 9 => return "1111011";
            when others => return "0000000"; 
        end case;
    end function;

begin

    process(inputNO, inputNO_DECIMAL)
        variable int_part : integer;
        variable dec_part : integer;
        variable dek      : integer;
        variable mon      : integer;
    begin
        int_part := to_integer(unsigned(inputNO));
        dec_part := to_integer(unsigned(inputNO_DECIMAL));

        if int_part > 25 then
            sseg_DEK     <= "0000000"; 
            sseg_MON     <= "1001111"; 
            sseg_DECIMAL <= "0000000"; 
            dp           <= '0';
        else
            
            dek := int_part / 10;
            mon := int_part mod 10;

            if dek = 0 then
                sseg_DEK <= "0000000";
            else
                sseg_DEK <= to_sseg(dek);
            end if;

            sseg_MON <= to_sseg(mon);
          
            if dec_part > 9 then
                 sseg_DECIMAL <= "1001111"; 
            else
                 sseg_DECIMAL <= to_sseg(dec_part);
            end if;

            if dec_part > 0 then
                dp <= '1';
            else
                dp <= '0';
            end if;
        end if;
    end process;

end behavioral;
