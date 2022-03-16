library ieee;
use ieee.std_logic_1164.all;

entity testedisplay is
    port(
        hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7: out std_logic_vector(6 downto 0)
    );
end testedisplay;

architecture behavior of testedisplay is
begin
    hex0 <= "1000110";
    hex1 <= "0000110";
    hex2 <= "1000111";
    hex3 <= "0000111";
    hex4 <= "0001100";
    hex5 <= "1111111";
    hex6 <= "1111111";
    hex7 <= "1111111";
end behavior;