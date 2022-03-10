library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    port(
        in00, in01: in std_logic_vector(6 downto 0);
        SEL_MUX: in std_logic;
        dataout: out std_logic_vector(6 downto 0)
    );
end mux2x1;

architecture behavior of mux2x1 is
begin
    process(SEL_MUX, in00, in01)
    begin
        if SEL_MUX = '0' then
            dataout <= in00;
        elsif SEL_MUX = '1' then
            dataout <= in01;
        end if;
    end process;
end behavior;