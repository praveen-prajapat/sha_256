library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is

   port( 
	   clk: in std_logic;
		reset: in std_logic;
	   mux_p: in std_logic;	
		write_data_h: in std_logic;
		write_data_w: in std_logic;
		count: in integer;
		h0_o,h1_o,h2_o,h3_o,h4_o,h5_o,h6_o,h7_o: out std_logic_vector(31 downto 0)
		);
		
end entity datapath;

architecture arch of datapath is

	signal w,w7,w2,w16,w15,k: std_logic_vector(31 downto 0);
	signal a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in: std_logic_vector(31 downto 0);
	signal a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out: std_logic_vector(31 downto 0);
	signal w_out: std_logic_vector(31 downto 0);
	signal out_m: std_logic_vector(31 downto 0);

   signal r1, r2, r3, r4, r5, r6: std_logic_vector(31 downto 0);
   signal a1, a2, a3, a4, a5, a6, a7: std_logic_vector(31 downto 0);
   signal t1, t2: std_logic_vector(31 downto 0);
	
   component tibit32_adder is
      port(i1, i2 : in std_logic_vector(31 downto 0);
           s: out std_logic_vector(31 downto 0)
      );
   end component;
	
	component mux is 
      port ( din1,din0 : in std_logic_vector (31 downto 0);
       sel : in std_logic;
		 dout : out std_logic_vector (31 downto 0));

   end component;
   
   component Maj_Gate is
      port (x, y, z: in std_logic_vector(31 downto 0);
            result: out std_logic_vector(31 downto 0)
      );
   end component;
   
   component func4 is
      port( inp: in std_logic_vector(31 downto 0); outp: out std_logic_vector(31 downto 0)
      );
   end component;
   
   component func3 is
      port( inp: in std_logic_vector(31 downto 0); outp: out std_logic_vector(31 downto 0)
      );
   end component;
   
   component func2 is
      port( inp: in std_logic_vector(31 downto 0); outp: out std_logic_vector(31 downto 0)
      );
   end component;
   
   component func1 is
      port( inp: in std_logic_vector(31 downto 0); outp: out std_logic_vector(31 downto 0)
      );
   end component;
   
   component Ch_Gate is
      port (x, y, z: in std_logic_vector(31 downto 0); result: out std_logic_vector(31 downto 0)
      );
   end component;
	component h_ram is 
		 port (
				 clk: in std_logic;
				 reset: in std_logic;
				 writedata: in std_logic;
				 h0_in,h1_in,h2_in,h3_in,h4_in,h5_in,h6_in,h7_in: in std_logic_vector(31 downto 0);
				 h0_out,h1_out,h2_out,h3_out,h4_out,h5_out,h6_out,h7_out: out std_logic_vector(31 downto 0)
				 );
   end component;
	component w_ram is 
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
	end component;
	component k_ram is
		port (
				dataindex: in integer;
				dataout: out std_logic_vector(31 downto 0)
				);
	end component;
	component m_ram is 
		 port (
				 clk: in std_logic;
				 m_count: in integer;
				 
				 --read data
				 m_out: out std_logic_vector(31 downto 0)
				 );
	end component;

begin


   --registers
	   ram_k: k_ram port map(count,k);
		ram_w: w_ram port map(clk,reset,count,
		                  write_data_w,
								w_out,
								w,w7,w2,w16,w15
								);
								
		ram_h: h_ram port map(clk,reset,write_data_h,
		                  a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out,
		                  a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in	                  
								);
								
		ram_m: m_ram port map(clk,count,out_m);

   -- expansion block
	   small_sigma_0: func3 port map(w15,r1);
		small_sigma_1: func4 port map(w2,r2);
		
		add_1: tibit32_adder port map(r1, w16, r3);
		add_2: tibit32_adder port map(r2, w7, r4);
		add_3: tibit32_adder port map(r3, r4, r5);
		
		mux1: mux port map(r5,out_m,mux_p,w_out);
		

	-- compression block
      choose: Ch_Gate port map(e_in, f_in, g_in, a2);
      majority: Maj_Gate port map(a_in, b_in, c_in, a4);
      cap_sigma_1: func2 port map(c_in, a1);
      cap_sigma_0: func1 port map(a_in, a3);
   
      add1: tibit32_adder port map(k, h_in, a5);
      add2: tibit32_adder port map(a1, a2, a6);
      add3: tibit32_adder port map(a3, a4, t2);
   
      add4: tibit32_adder port map(a5, a6, a7);
      add5: tibit32_adder port map(w, a7, t1);
   
      add6: tibit32_adder port map(t1, d_in, e_out);
      add7: tibit32_adder port map(t2, t1, a_out);
   
      b_out <= a_in;
      c_out <= b_in;
      d_out <= c_in;
      f_out <= e_in;
      g_out <= f_in;
      h_out <= g_in; 

      h0_o	<= a_in;
	   h1_o	<= b_in;
	   h2_o	<= c_in;
		h3_o	<= d_in;
		h4_o	<= e_in;
		h5_o	<= f_in;
		h6_o	<= g_in;
		h7_o	<= h_in;	

end architecture;
