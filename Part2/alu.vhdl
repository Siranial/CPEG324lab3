library ieee;
use ieee.std_logic_1164.all;

entity alu is
    Port (  
    );
end alu;

architecture behavioral of alu is

    component addSub8 is
        Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
               S : in STD_LOGIC;
               Y : out STD_LOGIC_vector (7 downto 0));
    end component;

    begin

        -- Logic

end behavioral;