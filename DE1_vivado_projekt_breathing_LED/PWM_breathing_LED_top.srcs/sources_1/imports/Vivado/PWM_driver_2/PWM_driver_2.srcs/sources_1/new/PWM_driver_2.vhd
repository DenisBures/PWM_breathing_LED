
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PWM_driver_2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (7 downto 0));
end PWM_driver_2;

architecture Behavioral of PWM_driver_2 is

component breathing_driver is
    port (
        clk   : in  std_logic; 
        rst   : in  std_logic; 
        cnt   : in  std_logic_vector(8 downto 0); 
        led   : out std_logic 
    );
end component breathing_driver;

signal s_cnt_expanded : std_logic_vector(8 downto 0);

begin

s_cnt_expanded <= '0' & sw;

breathing_driver_0 : breathing_driver 
    port map ( 
        clk => clk,
        rst => rst,
        cnt => s_cnt_expanded,
        led => led
    );
                 
end Behavioral;
