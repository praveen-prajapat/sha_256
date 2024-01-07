library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity w_ram is 
    port (
	       clk: in std_logic;
			 reset: in std_logic;
			 w_count: in integer;
			 
			 --write data
			 write_data: in std_logic;
			 w_in_j:in std_logic_vector(31 downto 0);
			 
			 
			 --read data
			 w_out,w2_out,w7_out,w15_out,w16_out: out std_logic_vector(31 downto 0)
			 );
end entity;

architecture arch of w_ram is

    type w_values is array (0 to 63) of std_logic_vector(31 downto 0);
	 signal w: w_values := (others => (others => '0')); 
	 
begin
    proc1: process(clk,reset)
	 begin
	     if reset='1' then
		     w <= (others => (others => '0'));
			  
		  else 
			  if rising_edge(clk) then 
					if write_data ='1' then
					  w(w_count)<= w_in_j(31 downto 0); -- count starts from 0 and goes to 63 
					end if;
		     end if; 
			  end if;
			    		   
	 end process;
	 
	  w_out<= w(w_count);
	  
    proc2: process(w_count)
	 begin
	    if w_count > 15 then
		     w2_out<= w(w_count-2);
			  w7_out<= w(w_count-7);
			  w15_out<= w(w_count-15);
			  w16_out<= w(w_count-16);
		 else
		     w2_out<= (others => '0');
			  w7_out<= (others => '0');
			  w15_out<= (others => '0');
			  w16_out<= (others => '0');
		 end if;
		 
	 end process;
	 
end architecture;