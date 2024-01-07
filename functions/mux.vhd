library ieee;
use ieee.std_logic_1164.all;

entity mux is 
    port (
        din1, din0 : in std_logic_vector(31 downto 0);
        sel : in std_logic;
        dout : out std_logic_vector(31 downto 0)
    );
end entity mux;

architecture behaviour of mux is 
    signal temp : std_logic_vector(31 downto 0);
begin
    process(sel,din1,din0)
    begin 
        if sel = '0' then 
            temp <= din0;
        else 
            temp <= din1;
        end if;
    end process;

    dout <= temp;
end architecture behaviour;
