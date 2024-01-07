library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity func2 is
port( inp:in std_logic_vector(31 downto 0); outp: out std_logic_vector(31 downto 0));
end func2;
architecture bhv of func2 is
signal A_BAR, B_BAR, C_BAR : std_logic_vector(31 downto 0);
begin

--Rotate right by 6
A_BAR <= std_logic_vector(unsigned(inp) ror 6);
B_BAR <= std_logic_vector(unsigned(inp) ror 11);
C_BAR <= std_logic_vector(unsigned(inp) ror 25);

  process(A_BAR, B_BAR, C_BAR)
  begin
    for i in 0 to 31 loop
      outp(i) <= A_BAR(i) xor B_BAR(i) xor C_BAR(i);
    end loop;
  end process;

end bhv;