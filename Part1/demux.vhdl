library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux8 is
    Port ( I : in std_logic;
           S : in std_logic_vector (1 downto 0);
           Y : out std_logic_vector (3 downto 0) := (others=>'0')
           );
end demux8;

architecture Behavioral of demux8 is

begin
    process(I,S) is
    begin
        -- Ensures that only one register is writing
        Y <= "0000";
        case S is
            when "00" => Y(0) <= I;
            when "01" => Y(1) <= I;
            when "10" => Y(2) <= I;
            when others => Y(3) <= I;
        end case;
    end process;
end Behavioral;