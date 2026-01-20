library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer_formal is                              -- work best if PSL is bound in a wrapper entity
end entity;

architecture formal of timer_formal is

  -- Use small, fixed generics for formal
  constant CLK_FREQ_HZ : natural := 10;
  constant DELAY_T     : time    := 5 sec;

  signal clk_i   : std_ulogic := '0';
  signal arst_i  : std_ulogic := '1';
  signal start_i : std_ulogic := '0';
  signal done_o  : std_ulogic;

  constant CLK_PERIOD : time := 1 sec / CLK_FREQ_HZ;
  constant COUNTER_LIMIT : natural := natural(DELAY_T / CLK_PERIOD);

begin

  -- Clock
  clk_i <= not clk_i after CLK_PERIOD / 2;

  -- DUT
  dut : entity work.timer
    generic map (
      clk_freq_hz_g => CLK_FREQ_HZ,
      delay_g       => DELAY_T
    )
    port map (
      clk_i   => clk_i,
      arst_i  => arst_i,
      start_i => start_i,
      done_o  => done_o
    );

  
  -- Reset is eventually released
  psl assume always eventually arst_i = '0';

  
  -- start_i is only asserted when idle
  psl assume always (start_i = '1' -> done_o = '1');

  -- start_i is a single-cycle pulse
  psl assume always (start_i = '1' -> next(start_i) = '0');


  -- 1) After start, timer becomes busy
  psl BusyAfterStart :
    assert always (start_i = '1' -> next(done_o = '0'));

  -- 2) done_o stays low while counting
  psl BusyUntilDone :
    assert always (
      (done_o = '0') -> next(done_o = '0' or done_o = '1')
    );

  -- 3) done_o reasserts exactly after COUNTER_LIMIT + 1 cycles
  psl DoneAfterExactDelay :
    assert always (
      start_i = '1' ->
        next[COUNTER_LIMIT+1](done_o = '1')
    );

end architecture;
