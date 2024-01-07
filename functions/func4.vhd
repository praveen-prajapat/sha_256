library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity func4 is
port( inp:in std_logic_vector(31 downto 0); outp: out std_logic_vector(31 downto 0));
end func4;
architecture bhv of func4 is
signal A_BAR, B_BAR, C_BAR : std_logic_vector(31 downto 0);
begin


A_BAR <= std_logic_vector(unsigned(inp) ror 17);
B_BAR <= std_logic_vector(unsigned(inp) ror 19);
C_BAR <= std_logic_vector(unsigned(inp) srl 10);

  process(A_BAR, B_BAR, C_BAR)
  begin
    for i in 0 to 31 loop
      outp(i) <= A_BAR(i) xor B_BAR(i) xor C_BAR(i);
    end loop;
  end process;

end bhv;