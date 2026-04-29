library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity breathing_driver is
    port (
        clk   : in  std_logic; 
        rst   : in  std_logic; 
        cnt   : in  std_logic_vector(8 downto 0); 
        led   : out std_logic 
    );
end entity breathing_driver;

architecture behavioral of breathing_driver is
   signal pwm_cnt : unsigned(7 downto 0) := (others => '0'); 
   signal duty_cycle : unsigned(7 downto 0);
begin

    process(cnt)
    begin
        if cnt(8) = '0' then
            duty_cycle <= unsigned(cnt(7 downto 0));
        else
            duty_cycle <= not unsigned(cnt(7 downto 0));
        end if;
    end process;

    process(clk, rst)
    begin
        if rst = '1' then
            pwm_cnt <= (others => '1');
        elsif rising_edge(clk) then
            pwm_cnt <= pwm_cnt + 1;
        end if;
    end process;

    led <= '1' when (pwm_cnt < duty_cycle) else '0';

end architecture behavioral;