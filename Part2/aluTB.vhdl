library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture behav of alu_tb is

	component alu is
		Port (  A,B : in std_logic_vector (7 downto 0);
				OP : in std_logic_vector (1 downto 0);
				EQ : out std_logic;
				O : out std_logic_vector (7 downto 0)
		);
	end component;

-- Input signals
signal a,b: std_logic_vector (7 downto 0);
signal op: std_logic_vector (1 downto 0);
-- Output signals
signal eq: std_logic;
signal o: std_logic_vector (7 downto 0);

begin
-- Component Instantiation
addsub : alu port map(A => a, B => b, OP => op, EQ => eq, O => o);

--  Test cases for ALU
process
type pattern_type is record
--  The inputs of the ALU.
		a,b: std_logic_vector (7 downto 0);
		op: std_logic_vector (1 downto 0);
--  The expected outputs of the ALU.
		eq: std_logic;
		o: std_logic_vector (7 downto 0);

end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
--    a     ,    b     , op ,eq ,    o
(("00001000","00000110","00",'U',"00001110"),
("00001000","00000110","01",'U',"00000010"), 
("00000000","00000000","10",'U',"00000010"),
("00000001","00000001","11",'1',"00000010")
);
begin
--  Check each pattern.
	for n in patterns'range loop
--  Set the inputs.
		a <= patterns(n).a;
		b <= patterns(n).b;
		op <= patterns(n).op;
--  Wait for the results.
		wait for 1 ns;
--  Check the outputs.
		assert eq = patterns(n).eq
		report "bad eq value" severity error;
		assert o = patterns(n).o
		report "bad output value" severity error;
	end loop;
	assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
	wait;
end process;
end behav;