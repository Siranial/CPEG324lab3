library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8 is
    Port (  I0 : in std_logic_vector (7 downto 0);
            I1 : in std_logic_vector (7 downto 0);
            I2 : in std_logic_vector (7 downto 0);
            I3 : in std_logic_vector (7 downto 0);
            S : in std_logic_vector (1 downto 0);
            Y : out std_logic_vector (7 downto 0));
end mux8;

architecture Behavioral of mux8 is

begin
    process(I0,I1,I2,I3,S) is
    begin
        case S is
            when "00" => Y <= I0;
            when "01" => Y <= I1;
            when "10" => Y <= I2;
            when others => Y <= I3;
        end case;
    end process;

end Behavioral;