library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity pwm_driver_2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           nwm : in STD_LOGIC_VECTOR (7 downto 0);
           led : out STD_LOGIC);
end pwm_driver_2;

architecture Behavioral of pwm_driver_2 is
component clk_en is
    generic (G_MAX : positive :=300_000); 
    Port ( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            ce : out STD_LOGIC
           );
end component clk_en;	
component counter is
    generic ( G_BITS : positive := 8 );  --! Default number of bits
    port (
        clk : in  std_logic;                             --! Main clock
        rst : in  std_logic;                             --! High-active synchronous reset
        en  : in  std_logic;                             --! Clock enable input
        cnt : out std_logic_vector(G_BITS - 1 downto 0)  --! Counter value
    );
end component counter;	
begin

process (clk) 
	begin
		if rising_edge(clk) then  
        if rst = '1' then    
           led      <= '0';
        end if;
        end if;
        
	end process;

												

end Behavioral;
