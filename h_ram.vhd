library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity h_ram is 
    port (
	       clk: in std_logic;
			 reset: in std_logic;
			 writedata: in std_logic;
			 h0_in,h1_in,h2_in,h3_in,h4_in,h5_in,h6_in,h7_in: in std_logic_vector(31 downto 0);
			 h0_out,h1_out,h2_out,h3_out,h4_out,h5_out,h6_out,h7_out: out std_logic_vector(31 downto 0)
			 );
end entity;

architecture arch of h_ram is 

   type h_values is array(0 to 7) of std_logic_vector(31 downto 0);
	signal h: h_values := (
	                       0  => X"6a09e667",
								  1  => X"bb67ae85",
								  2  => X"3c6ef372",
								  3  => X"a54ff53a",
								  4  => X"510e527f",
								  5  => X"9b05688c",
								  6  => X"1f83d9ab",
								  7  => X"5be0cd19"
								  );
begin

	proc1: process(clk,reset)
   begin
	
	    if reset='1' then 
	    h <= (
		        0  => X"6a09e667",
				  1  => X"bb67ae85",
				  2  => X"3c6ef372",
				  3  => X"a54ff53a",
				  4  => X"510e527f",
				  5  => X"9b05688c",
				  6  => X"1f83d9ab",
				  7  => X"5be0cd19"
				 );
	   else 
	     
		
	   if rising_edge(clk) then
		   if writedata='1' then
			   h(0) <= h0_in;
				h(1) <= h1_in;
				h(2) <= h2_in;
				h(3) <= h3_in;
				h(4) <= h4_in;
				h(5) <= h5_in;
				h(6) <= h6_in;
				h(7) <= h7_in;
			end if;
		end if;
		end if;
		
	
   end process;
 
		      h0_out <= h(0);
				h1_out <= h(1);
				h2_out <= h(2);
				h3_out <= h(3);
				h4_out <= h(4);
				h5_out <= h(5);
				h6_out <= h(6);
				h7_out <= h(7);
			
end architecture;