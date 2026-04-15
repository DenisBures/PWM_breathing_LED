
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity pwm_driver_1 is
    

    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC);
end pwm_driver_1;

architecture Behavioral of pwm_driver_1 is
--Konstanty    
    constant C_PWM_WIDTH     : positive := 8;  
    constant C_BREATH_MAX    : integer  := 1_000_000;

    signal sig_cnt  : integer range 0 to C_BREATH_MAX - 1;

--Signály
    signal s_ce_pwm    : std_logic;
    signal s_pwm_cnt   : std_logic_vector(C_PWM_WIDTH - 1 downto 0);
    signal s_duty_cycle: unsigned(C_PWM_WIDTH - 1 downto 0) := (others => '0');
    signal s_direction : std_logic := '0'; -- 0 = nahoru, 1 = dolů

signal sig_cnt : integer range 0 to C_BREATH_MAX - 1;

component clk_en is
    generic (G_MAX : positive :=5); 
    Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            ce : out STD_LOGIC
           );
end component clk_en;

component counter is
    generic ( G_BITS : positive := 3 );  
    port (
        clk : in  std_logic;                             
        rst : in  std_logic;                             
        en  : in  std_logic;                             
        cnt : out std_logic_vector(G_BITS - 1 downto 0)  
    );
end component counter;   
    
begin
    CE_PWM : clk_en 
        generic map(G_MAX => 4) 
        port map(clk => clk, 
                 rst => rst, 
                 ce => s_ce_pwm);
        
    PWM_CNT_INST : counter 
        generic map(G_BITS => C_PWM_WIDTH)
        port map(clk => clk, 
                 rst => rst, 
                 en => s_ce_pwm, 
                 cnt => s_pwm_cnt); 
    
synchr_process : process(clk)  
begin
  if rising_edge(clk) then
            if rst = '1' then
                sig_cnt <= 0;
                s_duty_cycle <= (others => '0');
                s_direction <= '0';
            else
                -- Čítač rychlosti dýchání
                if sig_cnt < C_BREATH_MAX - 1 then
                    sig_cnt <= sig_cnt + 1;
                else
                    sig_cnt <= 0;
                    
                    --nádech/výdech
                    if s_direction = '0' then 
                        if s_duty_cycle = 254 then 
                            s_direction <= '1'; 
                        end if;
                        s_duty_cycle <= s_duty_cycle + 1;
                    else 
                        if s_duty_cycle = 1 then 
                            s_direction <= '0'; 
                        end if;
                        s_duty_cycle <= s_duty_cycle - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    
    -- Porovnáváme běžící čítač s naší aktuální "dýchající" střídou
    led <= '1' when (unsigned(s_pwm_cnt) < s_duty_cycle) else '0';


end Behavioral;
