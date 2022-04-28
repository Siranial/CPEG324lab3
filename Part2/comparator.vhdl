library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is
    Port (  A,B : in STD_LOGIC_VECTOR (7 downto 0);
            Y : out STD_LOGIC
    );
end comparator;

architecture Behavioral of comparator is

begin

    Y <= (A(0) xnor B(0)) and (A(1) xnor B(1)) and (A(2) xnor B(2)) and 
        (A(3) xnor B(3)) and (A(4) xnor B(4)) and (A(5) xnor B(5)) and 
        (A(6) xnor B(6)) and (A(7) xnor B(7));

end Behavioral;