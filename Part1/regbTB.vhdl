library ieee;
use ieee.std_logic_1164.all;

entity regb_tb is
end regb_tb;

architecture behav of regb_tb is
--  Declaration of the component that will be instantiated.

component regb is
    Port (  i: in std_logic_vector (7 downto 0) := (others=>'0');
            s: in std_logic_vector (1 downto 0) := (others=>'0');
            clk, enable: in std_logic;
            o: out std_logic_vector (7 downto 0) := (others=>'0')
            );
end component;

-- Input and output signal declaration
signal i : std_logic_vector (7 downto 0) := (others=>'0');
signal s : std_logic_vector (1 downto 0) := (others=>'0');
signal clk, enable : std_logic;
signal o : std_logic_vector (7 downto 0) := (others=>'0');

begin
-- Component Instantiation
regbank : regb port map( I => i, S => s, clk => clk, enable => enable, O => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the reg.
	i : std_logic_vector (7 downto 0);
    s : std_logic_vector (1 downto 0);
	clock, enable : std_logic;
--  The expected outputs of the reg.
	o: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00000100", "01", '0', '1', "00000000"),
("00000100", "01", '1', '0', "00000100"),
("00000000", "00", '0', '1', "00000000"),
("10000001", "00", '1', '0', "10000001")
);
begin
    --  Check each pattern.
	for n in patterns'range loop
    --  Set the inputs.
		i <= patterns(n).i;
        s <= patterns(n).s;
		clk <= patterns(n).clock;
		enable <= patterns(n).enable;
    --  Wait for the results.
		wait for 1 ns;
    --  Check the outputs.
		assert o = patterns(n).o
		report "bad output value" severity error;
	end loop;
	assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
	wait;
end process;
end behav;
