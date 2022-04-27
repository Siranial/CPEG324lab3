library ieee;
use ieee.std_logic_1164.all;

entity regb_tb is
end regb_tb;

architecture behav of regb_tb is
--  Declaration of the component that will be instantiated.

component regb is
    Port (  wd: in std_logic_vector (7 downto 0) := (others=>'0');
            ws: in std_logic_vector (1 downto 0) := (others=>'0');
            rs1: in std_logic_vector (1 downto 0) := (others=>'0');
            rs2: in std_logic_vector (1 downto 0) := (others=>'0');
            clk, we: in std_logic;
            rd1: out std_logic_vector (7 downto 0) := (others=>'0');
            rd2: out std_logic_vector (7 downto 0) := (others=>'0')
            );
end component;

-- Input and output signal declaration
signal wd : std_logic_vector (7 downto 0) := (others=>'0');
signal ws : std_logic_vector (1 downto 0) := (others=>'0');
signal rs1 : std_logic_vector (1 downto 0) := (others=>'0');
signal rs2 : std_logic_vector (1 downto 0) := (others=>'0');
signal clk, we : std_logic;
signal rd1 : std_logic_vector (7 downto 0) := (others=>'0');
signal rd2 : std_logic_vector (7 downto 0) := (others=>'0');

begin
-- Component Instantiation
regbank : regb port map( wd => wd, ws => ws, rs1 => rs1, rs2 => rs2, clk => clk, we => we, rd1 => rd1, rd2 => rd2);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the reg.
	wd : std_logic_vector (7 downto 0);
    ws : std_logic_vector (1 downto 0);
	rs1 : std_logic_vector (1 downto 0);
	rs2 : std_logic_vector (1 downto 0);
	clk, we : std_logic;
--  The expected outputs of the reg.
	rd1: std_logic_vector (7 downto 0);
	rd2: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
--    wd    ,  ws ,  rs1,  rs2, clk,  we,     rd1   ,     rd2
(("00000100", "00", "00", "01", '0', '1', "00000000", "00000000"),
("00000100", "00", "00", "01", '1', '1', "00000100", "00000000"),
("00000000", "01", "10", "01", '0', '1', "00000000", "00000000"),
("00100000", "01", "00", "01", '1', '0', "00000100", "00100000"),
("00000100", "00", "00", "01", '0', '0', "00000100", "00100000"),
("00000100", "00", "00", "01", '1', '0', "00000100", "00100000")
);
begin
    --  Check each pattern.
	for n in patterns'range loop
    --  Set the inputs.
		wd <= patterns(n).wd;
		ws <= patterns(n).ws;
        rs1 <= patterns(n).rs1;
		rs2 <= patterns(n).rs2;
		clk <= patterns(n).clk;
		we <= patterns(n).we;
    --  Wait for the results.
		wait for 1 ns;
    --  Check the outputs.
		assert rd1 = patterns(n).rd1
		report "bad rd1 value" severity error;
		assert rd2 = patterns(n).rd2
		report "bad rd2 value" severity error;
	end loop;
	assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
	wait;
end process;
end behav;
