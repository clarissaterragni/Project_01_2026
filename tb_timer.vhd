library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_timer is
    generic (
      clk_freq_hz_g : natural := 10_000_000;
      delay_g       : time    := 6 us;
      runner_cfg    : string  := ""
    );
end entity tb_timer;

architecture sim of tb_timer is

      constant CLK_PERIOD : time := 1 sec / clk_freq_hz_g;

      signal clk_i   : std_ulogic := '0';
      signal arst_i  : std_ulogic := '0';
      signal start_i : std_ulogic := '0';
      signal done_o  : std_ulogic;

begin
  
      dut : entity work.timer
        generic map (
          clk_freq_hz_g => clk_freq_hz_g,
          delay_g       => delay_g
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

  ------------------------------------------------------------------------------
  -- Main test process (VUnit)
  ------------------------------------------------------------------------------
  main : process
      variable t_start : time;
  begin

  test_runner_setup(runner, runner_cfg);

    arst_i <= '1';
    wait for 2 * CLK_PERIOD;
    arst_i <= '0';
    wait for CLK_PERIOD;

    check_equal(done_o, '1', "Timer should be idle after reset");

    
    wait until rising_edge(clk_i);
    start_i <= '1';
    wait until rising_edge(clk_i);
    start_i <= '0';
    wait until rising_edge(clk_i);   -- Had error: added for correct done_o
    
    t_start := now;
    check_equal(done_o, '0', "Timer should be busy after start");

    wait until done_o = '1';

    check_equal(now - t_start, delay_g, msg => "done_o asserted at correct delay");
    -- if correct: get green script when run .py file
    
    report "Test completed successfully" severity note;
    
    test_runner_cleanup(runner);

  end process;
end architecture sim;
