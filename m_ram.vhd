library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity m_ram is 
    port (
	       clk: in std_logic;
			 m_count: in integer;
			 
			 --read data
			 m_out: out std_logic_vector(31 downto 0)
			 );
end entity;

architecture arch of m_ram is

--    variable count: integer:=0;
  signal m_out_internal: std_logic_vector(31 downto 0);
    type m_values is array (0 to 15) of std_logic_vector(31 downto 0);
	 signal m: m_values := (
								  0  => X"56234567",
								  1  => X"80780000",
								  2  =>  X"00000000",
								  3  =>  X"00000000",
								  4  =>  X"00000000",
								  5  =>  X"00000000",
								  6  =>  X"00000000",
								  7  =>  X"00000000",
								  8  =>  X"00000000",
								  9  =>  X"00000000",
								  10  =>  X"00000000",
								  11  =>  X"00000000",
								  12  =>  X"00000000",
								  13  =>  X"00000000",
								  14  =>  X"00000000",
								  15  => X"00000020"
									); 
	 
begin

     process(m_count)
    begin
        
            if m_count >= 0 and m_count <= 15 then
                m_out_internal <= m(m_count);
            else
                m_out_internal <= (others => '0');
            end if;
     
    end process;

    m_out <= m_out_internal;
end architecture;