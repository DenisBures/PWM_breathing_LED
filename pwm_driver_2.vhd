library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_driver_2 is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        sw_i   : in  std_logic_vector(7 downto 0);
        led    : out std_logic
    );
end entity PWM_driver_2;

architecture structural of PWM_driver_2 is
    signal s_cnt_expanded : std_logic_vector(8 downto 0);
begin

    s_cnt_expanded <= '0' & sw_i;

    pwm_core_inst : entity work.breathing_driver
        generic map (
            G_PWM_WIDTH => 8
        )
        port map (
            clk => clk,
            rst => rst,
            cnt => s_cnt_expanded, 
            led => led            
        );

end architecture structural;
