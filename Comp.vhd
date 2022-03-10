library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity Comp is
    port(
        USER: in std_logic_vector(3 downto 0);
        CODE: in std_logic_vector(3 downto 0);
        ISEQUAL: out std_logic);
end Comp;

architecture behavior of Comp is
begin
    process(USER, CODE)
    begin
        if USER = CODE then
            ISEQUAL <= '1';
        else
            ISEQUAL <= '0';
        end if;
    end process;
end behavior;