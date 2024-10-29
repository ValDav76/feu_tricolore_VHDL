----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2024 01:04:33
-- Design Name: 
-- Module Name: tb_feu_tricolore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_feu_tricolore is
--  Port ( );
end tb_feu_tricolore;

architecture Behavioral of tb_feu_tricolore is

    constant c_CLOCK_PERIOD : time := 83.33 ns; 
    signal clk : std_logic := '0';
    signal btn1 : std_logic := '0'; 
    signal led : std_logic_vector(0 to 4) := "00000"; 
    
    component feu_tricolore is
        Port ( clk : in STD_LOGIC;
           i_btn : in STD_LOGIC;
           o_led : out STD_LOGIC_VECTOR(0 to 4));
    end component feu_tricolore; 
            
    
    begin
    UUT : feu_tricolore
    port map (
      clk     => clk,
      i_btn => btn1,
      o_led => led);
    
    gen_clk : process is
    begin
        wait for c_CLOCK_PERIOD/2;
        clk <= not(clk); 
    end process gen_clk;
    

end Behavioral;
