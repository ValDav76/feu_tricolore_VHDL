----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2024 23:19:11
-- Design Name: 
-- Module Name: feu_tricolore - Behavioral
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

entity feu_tricolore is
    Port ( clk : in STD_LOGIC;
           i_btn : in STD_LOGIC;
           o_led : out STD_LOGIC_VECTOR(0 to 4));
end feu_tricolore;

architecture Behavioral of feu_tricolore is
    constant delay_pietons : natural := 5000;
    constant delay_warning_pietons : natural := 2000;
    constant delay_voiture : natural := 6000;
    constant delay_warning_voiture : natural := 2000; 
    
    signal clk_1KHz : std_LOGIC := '0'; 
    signal enable_state : std_LOGIC_VECTOR(0 to 1) := "00"; 
    signal test : std_LOGIC := '0';
    signal led : std_logic_vector(0 to 4) := "00000";
    signal i_btn_sync1, i_btn_sync2 : std_logic := '0';
    signal compteur_signal : natural := 0;


begin
    
    gen_clk : process(clk)
        variable compteur : natural := 0; 
    begin
        if rising_edge(clk) then
            compteur := compteur + 1;
            if compteur=12000 then
                compteur := 0;
                clk_1KHz <= not(clk_1KHz);
            end if;
        end if;     
    end process gen_clk; 
    
    gen_signal : process(clk_1KHz)
        
    begin
        if rising_edge(clk_1KHz) then
            i_btn_sync1 <= i_btn;
            i_btn_sync2 <= i_btn_sync1;
            compteur_signal <= compteur_signal + 1;
            if compteur_signal=delay_pietons-1 then
                enable_state <= "01";
            elsif compteur_signal = delay_warning_pietons+delay_pietons-1 then
                enable_state <= "10";
            elsif compteur_signal = delay_warning_pietons+delay_pietons-1+delay_voiture then
                enable_state <= "11";
            elsif compteur_signal = delay_warning_pietons+delay_pietons-1+delay_voiture+delay_warning_voiture then
                enable_state <= "00"; 
                compteur_signal <= 0;
            end if;
            if (i_btn_sync1 = '1' and i_btn_sync2 = '0' and enable_state = "10") then
                compteur_signal <= delay_warning_pietons + delay_pietons - 1 + delay_voiture - 1;
            end if; 
        end if; 
    end process gen_signal;
    
    gestion_etat : process(clk_1KHz)
    begin
        if rising_edge(clk_1KHz) then
            case enable_state is -- 0 (green) and 1 (red) are for pietons & 2 (green), 3 (orange) and 4 (red) are for cars
                when "00" =>
                    led <= "10001"; 
                when "01" =>
                    led <= "01001";
                when "10" =>
                    led <= "01100";
                when "11" =>
                    led <= "01010";
                 when others =>
                    led <= "00000";
                end case; 
        end if; 
    end process gestion_etat;
    o_led <= led; 
end Behavioral;