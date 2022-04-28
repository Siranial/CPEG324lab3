library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addSub8 is
    Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
           S : in STD_LOGIC;
           Y : out STD_LOGIC_vector (7 downto 0));
end addSub8;


architecture Behavioral of addSub8 is

component twosComp8 is
    Port (  I: in std_logic_vector (7 downto 0);
            O: out std_logic_vector (7 downto 0));
end component;

component mux2to1 is
    Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
           S : in STD_LOGIC;
           Y : out STD_LOGIC_vector (7 downto 0));
end component;

component fullAdder is
    Port (  A,B,Cin: in std_logic;
            O, Cout: out std_logic
            );
end component;

-- Signal Declaration
signal negB : std_logic_vector (7 downto 0) := (others=>'0');
signal muxOut : std_logic_vector (7 downto 0) := (others=>'0');
signal carry : std_logic_vector (6 downto 0) := (others=>'0');

begin

    -- Feeds the adder negative B when op(0) = 1 (subtracting)
    TC: twosComp8 port map(I => B, O => negB);
    m2t1: mux2to1 port map(A => B, B => negB, S => S, Y => muxOut);
    -- 8 bit adder block
    FA0: fullAdder port map(    A => A(0), B => muxOut(0), Cin => '0', 
                                O => Y(0), Cout => carry(0));
    FA1: fullAdder port map(    A => A(1), B => muxOut(1), Cin => carry(0), 
                                O => Y(1), Cout => carry(1));
    FA2: fullAdder port map(    A => A(2), B => muxOut(2), Cin => carry(1), 
                                O => Y(2), Cout => carry(2));
    FA3: fullAdder port map(    A => A(3), B => muxOut(3), Cin => carry(2), 
                                O => Y(3), Cout => carry(3));
    FA4: fullAdder port map(    A => A(4), B => muxOut(4), Cin => carry(3), 
                                O => Y(4), Cout => carry(4));
    FA5: fullAdder port map(    A => A(5), B => muxOut(5), Cin => carry(4), 
                                O => Y(5), Cout => carry(5));
    FA6: fullAdder port map(    A => A(6), B => muxOut(6), Cin => carry(5), 
                                O => Y(6), Cout => carry(6));
    FA7: fullAdder port map(    A => A(7), B => muxOut(7), Cin => carry(6), 
                                O => Y(7));

end Behavioral;