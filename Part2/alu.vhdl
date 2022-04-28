library ieee;
use ieee.std_logic_1164.all;

entity alu is
    Port (  A,B : in std_logic_vector (7 downto 0);
            OP : in std_logic_vector (1 downto 0);
            EQ : out std_logic;
            O : out std_logic_vector (7 downto 0)
    );
end alu;

architecture behavioral of alu is

    component addSub8 is
        Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
               S : in STD_LOGIC; -- 0 for addition and 1 for subtraction
               Y : out STD_LOGIC_vector (7 downto 0));
    end component;

    component comparator is
        Port (  A,B : in STD_LOGIC_VECTOR (7 downto 0);
                Y : out STD_LOGIC
        );
    end component;

    signal addOut : std_logic_vector (7 downto 0) := (others=>'0');
    signal compOut : std_logic:='0';
    
    begin

        adder : addSub8 port map(A => A, B => B, S => op(0), Y => addOut);
        comp : comparator port map(A => A, B => B, Y => compOut);

        process(addOut,compOut,OP) begin

            if OP(1) /= '1' then
                -- If op(1) == 0 then use addsub unit
                O <= addOut;
            elsif OP(0) = '1' then
                -- if op == 11 then use comparator unit
                EQ <= compOut;
            end if;

            -- Do nothing if op == 10

        end process;

end behavioral;