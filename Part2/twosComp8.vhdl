library ieee;
use ieee.std_logic_1164.all;

entity twosComp8 is
    Port (  I: in std_logic_vector (7 downto 0);
            O: out std_logic_vector (7 downto 0));
end twosComp8;

architecture behavioral of twosComp8 is

	-- Carry vector to assist with operation
	signal C : std_logic_vector (6 downto 0);

	begin

	O(0) <= not(I(0)) xor '1';
	C(0) <= not(I(0)) and '1';

	O(1) <= not(I(1)) xor C(0);
	C(1) <= not(I(1)) and C(0);

	O(2) <= not(I(2)) xor C(1);
	C(2) <= not(I(2)) and C(1);

	O(3) <= not(I(3)) xor C(2);
	C(3) <= not(I(3)) and C(2);

	O(4) <= not(I(4)) xor C(3);
	C(4) <= not(I(4)) and C(3);

	O(5) <= not(I(5)) xor C(4);
	C(5) <= not(I(5)) and C(4);

	O(6) <= not(I(6)) xor C(5);
	C(6) <= not(I(6)) and C(5);

	O(7) <= not(I(7)) xor C(6);

end behavioral;