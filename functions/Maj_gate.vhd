library ieee;
use ieee.std_logic_1164.all;

entity Maj_Gate is
  port (
    x, y, z: in std_logic_vector(31 downto 0);
    result: out std_logic_vector(31 downto 0)
  );
end entity Maj_Gate;

architecture behavioral of Maj_Gate is
begin
  process(x, y, z)
  begin
    result <= (x and y) xor (x and z) xor (y and z);
  end process;
end architecture behavioral;