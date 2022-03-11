library ieee;
use ieee.std_logic_1164.all;

entity CompIsEqual4 is
    port(
        P: in std_logic_vector(2 downto 0);
        END_GAME: out std_logic);
end CompIsEqual4;

architecture behavior of CompIsEqual4 is
begin
    process(P)
    begin
        if (P = "100") then
            END_GAME <= '1';
        else
            END_GAME <= '0';
        end if;
    end process;
end behavior;