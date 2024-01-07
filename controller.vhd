library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
entity controller is
  		
    port(clk: in std_logic; 
	      reset: in std_logic;
			enable: in std_logic;
			done: out std_logic;
			hash_out: out std_logic_vector(255 downto 0));
	 
end entity;

architecture control of controller is
    
    signal count_c : integer := 0;
    signal status : std_logic := '0';
    signal mux_c : std_logic := '0';
    signal data_write_h : std_logic := '0';
    signal data_write_w : std_logic := '0';
    signal h0_o, h1_o, h2_o, h3_o, h4_o, h5_o, h6_o, h7_o : std_logic_vector(31 downto 0);

    component datapath is
      port( 
            clk : in std_logic;
            reset : in std_logic;
            mux_p : in std_logic;
            write_data_h : in std_logic;
            write_data_w : in std_logic;
            count : in integer;
            h0_o, h1_o, h2_o, h3_o, h4_o, h5_o, h6_o, h7_o : out std_logic_vector(31 downto 0)
        );
    end component; 

begin

    data_path : datapath port map(clk, reset, mux_c, data_write_h, data_write_w, count_c, h0_o, h1_o, h2_o, h3_o, h4_o, h5_o, h6_o, h7_o);

    proc_1 : process(clk, reset, enable)
    begin    
        
        
        if enable = '1' then 
            if status = '0' then
                if reset = '1' then
                    count_c <= 0;
                    status <= '0';
                    mux_c <= '0';
                    data_write_h <= '0';
                    data_write_w <= '0';
                else 
                    if rising_edge(clk) then
                        if count_c < 16 then
                            
                           -- expansion
                           mux_c <= '0';
                           data_write_w <= '1';
                            -- compression
                            data_write_h <= '1';
                            
                        else
                            
                            -- expansion
                            mux_c <= '1';
                            data_write_w <= '1';
                            -- compression
                            data_write_h <= '1';
                         
                            -- output
                            if count_c = 63 then
                                hash_out <= h0_o & h1_o & h2_o & h3_o & h4_o & h5_o & h6_o & h7_o;
                                
										  count_c <= -1;
										  status <= '1';
                            end if;
                            
                        end if;
                        done <= status;
                        count_c <= count_c + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

end control;
