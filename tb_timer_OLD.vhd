-- first testbench used for xilinx ise

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_timer is
end entity;

architecture sim of tb_timer is

   
    constant CLK_FREQ  : natural := 1_000_000; 
    constant DELAY   : time    := 6 us;       
    constant CLK_PERIOD : time := 1 sec / CLK_FREQ;

    signal clk_i   : std_ulogic := '0';
    signal arst_i  : std_ulogic := '0';
    signal start_i : std_ulogic := '0';
    signal done_o  : std_ulogic;

begin

    dut : entity work.timer
        generic map (
            clk_freq_hz_g => CLK_FREQ,
            delay_g       => DELAY
        )
        port map (
            clk_i   => clk_i,
            arst_i  => arst_i,
            start_i => start_i,
            done_o  => done_o
        );

    clk_signal : process begin
            clk_i <= '0';
            wait for CLK_PERIOD / 2;
            clk_i <= '1';
            wait for CLK_PERIOD / 2;
    end process;

    stim : process begin

        arst_i <= '1';
        wait for 2 * CLK_PERIOD;
        arst_i <= '0';
        wait for CLK_PERIOD;

        start_i <= '1';
        wait until rising_edge(clk_i);
        start_i <= '0';

        wait for 10*CLK_PERIOD;  
        start_i <= '1';
        wait until rising_edge(clk_i);
        start_i <= '0';

        wait for 10*CLK_PERIOD;

       wait;
       
    end process;


end;
