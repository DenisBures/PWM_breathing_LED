
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity pwm_driver_1 is
    

    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC);
end pwm_driver_1;

architecture Behavioral of pwm_driver_1 is

signal sig_cnt : integer range 0 to G_MAX - 1;

component clk_en is
    generic (G_MAX : positive :=5); 
    Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            ce : out STD_LOGIC
           );
end component clk_en;

component counter is
    generic ( G_BITS : positive := 3 );  --! Default number of bits
    port (
        clk : in  std_logic;                             --! Main clock
        rst : in  std_logic;                             --! High-active synchronous reset
        en  : in  std_logic;                             --! Clock enable input
        cnt : out std_logic_vector(G_BITS - 1 downto 0)  --! Counter value
    );
end component counter;

begin
    synchr_process : process(clk)
        
begin
  if rising_edge(clk) then
    if rst = '1' then
      sig_cnt <= 0;
        
    else
      if sig_cnt < sig_cnt_len - 1 then
        sig_cnt <= sig_cnt + 1;
      else
        sig_cnt <= 0;
      end if;
        
    end if;
  end if;
end process;


end Behavioral;
