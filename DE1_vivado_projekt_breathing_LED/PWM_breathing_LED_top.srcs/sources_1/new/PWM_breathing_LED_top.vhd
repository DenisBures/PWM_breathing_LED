
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PWM_breathing_LED_top is
    Port ( clk : in STD_LOGIC;
           btnu : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (7 downto 0);
           led_1 : out STD_LOGIC;
           led_2 : out STD_LOGIC;
           seg : out std_logic_vector (6 downto 0);
           an : out std_logic_vector (7 downto 0);
           dp : out std_logic
           );
end PWM_breathing_LED_top;

architecture Behavioral of PWM_breathing_LED_top is

component PWM_driver_1 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led1 : out STD_LOGIC);
end component PWM_driver_1;

component PWM_driver_2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (7 downto 0));
end component PWM_driver_2;

component display_driver is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           anode : out STD_LOGIC_VECTOR (1 downto 0));
end component display_driver;

begin

PWM_driver_1_0 : PWM_driver_1
    port map (
        clk => clk,
        rst => btnu,
        led1 => led_1
        );
        
PWM_driver_2_0 : PWM_driver_2
    port map (        
        clk => clk,
        rst => btnu,
        sw => sw,
        led => led_2
        );

display_driver_0 : display_driver
    port map (
        clk => clk,
        rst => btnu,
        data => sw,
        seg => seg,
        anode => an (1 downto 0)
        );
an(7 downto 2) <= b"11_1111";
dp <= '1';            

end Behavioral;
