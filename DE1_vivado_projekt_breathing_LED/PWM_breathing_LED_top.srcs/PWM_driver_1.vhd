

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;



entity PWM_driver_1 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led1 : out STD_LOGIC);
end PWM_driver_1;

architecture Behavioral of PWM_driver_1 is
    component clk_en is
        generic ( G_MAX : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;

    component counter is
        generic ( G_BITS : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            en  : in  std_logic;
            cnt : out std_logic_vector(8 downto 0)
        );
    end component counter;
    
    component breathing_driver is
    port (
        clk : in std_logic;
        rst : in std_logic;
        cnt : in std_logic_vector(8 downto 0);
        led : out std_logic
        );
    end component breathing_driver;        
        
      signal sig_en     : std_logic;
      signal sig_digit  : std_logic_vector( 8 downto 0);
begin

  clock_0 : clk_en
        generic map ( G_MAX => 600_000 )  
        port map (                
           clk => clk,             
           rst => rst,
           ce  => sig_en
        );

    counter_0 : counter
        generic map ( G_BITS => 9 )
        port map (
           clk => clk,
           rst => rst,
           en  => sig_en,
           cnt => sig_digit
        );
    breathing_driver_0 : breathing_driver
        port map (
           clk => clk,
           rst => rst,
           cnt => sig_digit,
           led => led1
        );
           
end Behavioral;
