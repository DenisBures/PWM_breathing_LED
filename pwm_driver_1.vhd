library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity breathing_driver is
    generic (
        G_PWM_WIDTH : integer := 8 
    );
    port (
        clk   : in  std_logic; 
        rst   : in  std_logic; 
        cnt   : in  std_logic_vector(G_PWM_WIDTH downto 0); 
        led   : out std_logic 
    );
end entity breathing_driver;

architecture behavioral of breathing_driver is
    signal s_pwm_cnt    : unsigned(G_PWM_WIDTH-1 downto 0) := (others => '0');
    signal s_duty_cycle : unsigned(G_PWM_WIDTH-1 downto 0);
begin


    s_duty_cycle <= unsigned(cnt(G_PWM_WIDTH-1 downto 0)) when (cnt(G_PWM_WIDTH) = '0') else
                    not unsigned(cnt(G_PWM_WIDTH-1 downto 0));

    
    p_pwm : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_pwm_cnt <= (others => '0');
                led       <= '0';
            else
                
                s_pwm_cnt <= s_pwm_cnt + 1;

                if s_pwm_cnt < s_duty_cycle then
                    led <= '1';
                else
                    led <= '0';
                end if;
            end if;
        end if;
    end process p_pwm;

end architecture behavioral;
