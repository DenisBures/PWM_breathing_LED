-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 29 Apr 2026 19:27:51 GMT
-- Request id : cfwk-fed377c2-69f25bb797a9d

library ieee;
use ieee.std_logic_1164.all;

entity tb_PWM_driver_1 is
end tb_PWM_driver_1;

architecture tb of tb_PWM_driver_1 is

    component PWM_driver_1
        port (clk  : in std_logic;
              rst  : in std_logic;
              led_1 : out std_logic);
    end component;

    signal clk  : std_logic;
    signal rst  : std_logic;
    signal led1 : std_logic;

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PWM_driver_1
    port map (clk  => clk,
              rst  => rst,
              led_1 => led1);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        
        rst <= '0';
        wait for 50000 ms;

        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_PWM_driver_1 of tb_PWM_driver_1 is
    for tb
    end for;
end cfg_tb_PWM_driver_1;