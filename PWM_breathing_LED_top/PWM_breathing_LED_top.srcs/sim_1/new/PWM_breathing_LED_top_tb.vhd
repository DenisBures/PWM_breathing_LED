library ieee;
use ieee.std_logic_1164.all;

entity tb_PWM_breathing_LED_top is
end tb_PWM_breathing_LED_top;

architecture tb of tb_PWM_breathing_LED_top is

    component PWM_breathing_LED_top
        port (clk  : in std_logic;
              btnu : in std_logic;
              sw   : in std_logic_vector (7 downto 0);
              led1 : out std_logic;
              led2 : out std_logic;
              seg  : out std_logic_vector (6 downto 0);
              an   : out std_logic_vector (7 downto 0);
              dp   : out std_logic);
    end component;

    signal clk  : std_logic;
    signal btnu : std_logic;
    signal sw   : std_logic_vector (7 downto 0);
    signal led1 : std_logic;
    signal led2 : std_logic;
    signal seg  : std_logic_vector (6 downto 0);
    signal an   : std_logic_vector (7 downto 0);
    signal dp   : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PWM_breathing_LED_top
    port map (clk  => clk,
              btnu => btnu,
              sw   => sw,
              led1 => led1,
              led2 => led2,
              seg  => seg,
              an   => an,
              dp   => dp);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        btnu <= '0';
        sw <= (others => '0');

        -- Reset generation
        --  ***EDIT*** Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        btnu <= '1';
        wait for 100 ns;
        btnu <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_PWM_breathing_LED_top of tb_PWM_breathing_LED_top is
    for tb
    end for;
end cfg_tb_PWM_breathing_LED_top;