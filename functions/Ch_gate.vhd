library ieee;
use ieee.std_logic_1164.all;

entity Ch_Gate is
  port (
    x, y, z: in std_logic_vector(31 downto 0);
    result: out std_logic_vector(31 downto 0)
  );
end entity Ch_Gate;

architecture behavioral of Ch_Gate is
begin
  process(x, y, z)
  begin
    result <= (x and y) xor ((not x) and z);
  end process;
end architecture behavioral;