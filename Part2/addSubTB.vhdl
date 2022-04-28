library ieee;
use ieee.std_logic_1164.all;

entity as_tb is
end as_tb;

architecture behav of as_tb is

	component addSub8 is
		Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
			   S : in STD_LOGIC;
			   Y : out STD_LOGIC_vector (7 downto 0));
	end component;

-- Input signals
signal a,b: std_logic_vector (7 downto 0);
signal s: std_logic;
-- Output signals
signal y: std_logic_vector (7 downto 0);

begin
-- Component Instantiation
addsub : addSub8 port map(A => a, B => b, S => s, Y => y);

--  Test cases for ALU
process
type pattern_type is record
--  The inputs of the ALU.
		a,b: std_logic_vector (7 downto 0);
		s: std_logic;
--  The expected outputs of the ALU.
		y: std_logic_vector (7 downto 0);

end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
--  a   ,   b   ,  s ,   o
(("00000100", "00000010", '0', "00000110"), -- 4 + 2 = 6
("00000100", "00000010", '1', "00000010"), -- 4 - 2 = 2
("10000000", "10000000", '0', "00000000"), -- 128 + 128 = 0 (unhandled overflow)
("10000000", "10000001", '1', "11111111") -- 8 - 8 = -1
);
begin
--  Check each pattern.
	for n in patterns'range loop
--  Set the inputs.
		a <= patterns(n).a;
		b <= patterns(n).b;
		s <= patterns(n).s;
--  Wait for the results.
		wait for 1 ns;
--  Check the outputs.
		assert y = patterns(n).y
		report "bad output value" severity error;
	end loop;
	assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
	wait;
end process;
end behav;