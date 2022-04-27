library ieee;
use ieee.std_logic_1164.all;

entity regb is
    Port (  wd: in std_logic_vector (7 downto 0) := (others=>'0');
            ws: in std_logic_vector (1 downto 0) := (others=>'0');
            rs1: in std_logic_vector (1 downto 0) := (others=>'0');
            rs2: in std_logic_vector (1 downto 0) := (others=>'0');
            clk, we: in std_logic;
            rd1: out std_logic_vector (7 downto 0) := (others=>'0');
            rd2: out std_logic_vector (7 downto 0) := (others=>'0')
            );
end regb;

architecture behav of regb is
--  Declaration of the component that will be instantiated.


component demux8 is
    port (  I : in std_logic;
            S : in std_logic_vector (1 downto 0);
            Y : out std_logic_vector (3 downto 0) := (others=>'0')
            );
end component;

component reg is
    port(	
        I:	    in std_logic_vector (7 downto 0); -- for loading
        clock:	in std_logic; -- rising-edge triggering 
        enable:	in std_logic; -- 0: don't do anything; 1: reg is enabled
        O:	    out std_logic_vector(7 downto 0) := (others=>'0') -- output the current register content. 
    );
end component;

component mux8 is
    Port (  I0 : in std_logic_vector (7 downto 0);
            I1 : in std_logic_vector (7 downto 0);
            I2 : in std_logic_vector (7 downto 0);
            I3 : in std_logic_vector (7 downto 0);
            S : in std_logic_vector (1 downto 0);
            Y : out std_logic_vector (7 downto 0) := (others=>'0')
            );
end component;
    
-- Write enable wires that connect demux to registers
signal W : std_logic_vector (3 downto 0) := (others=>'0');
-- Read wires that connect registers to mux
signal R0 : std_logic_vector (7 downto 0) := (others=>'0');
signal R1 : std_logic_vector (7 downto 0) := (others=>'0');
signal R2 : std_logic_vector (7 downto 0) := (others=>'0');
signal R3 : std_logic_vector (7 downto 0) := (others=>'0');

begin
--  Component instantiation.
demuxws: demux8 port map ( I => we, S => ws, Y => W);
reg0: reg port map (i => wd, clock => clk, enable => W(0), O => R0);
reg1: reg port map (i => wd, clock => clk, enable => W(1), O => R1);
reg2: reg port map (i => wd, clock => clk, enable => W(2), O => R2);
reg3: reg port map (i => wd, clock => clk, enable => W(3), O => R3);
muxrd1: mux8 port map ( I0 => R0, I1 => R1, I2 => R2, I3 => R3, S => rs1, Y => rd1);
muxrd2: mux8 port map ( I0 => R0, I1 => R1, I2 => R2, I3 => R3, S => rs2, Y => rd2);

end behav;