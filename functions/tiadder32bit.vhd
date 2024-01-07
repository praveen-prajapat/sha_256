library ieee;
use ieee.std_logic_1164.all;

entity tibit32_adder is
    port(i1, i2 : in std_logic_vector(31 downto 0);
         s     : out std_logic_vector(31 downto 0));
end entity tibit32_adder;

architecture add32 of tibit32_adder is
    signal C : std_logic_vector(31 downto 0); -- Extended by 1 bit for the carry out of MSB
begin 
    s(0) <= i1(0) xor i2(0);
    C(0) <= i1(0) and i2(0);
    
    rcplane: for i in 1 to 31 generate -- Changed the loop range from 1 to 31
        s(i)   <= i1(i) xor i2(i) xor C(i-1);
        C(i)   <= (i1(i) and i2(i)) or (C(i-1) and (i1(i) xor i2(i)));
    end generate;
end add32;
