-----------------------------------------------------------
-- 
--      Parametric Timer
--
--                                  Clarissa Terragni
--
-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity timer is                         -- Count a specific duration based on clock frequency and time generic.

generic (
            clk_freq_hz_g : natural;    -- Clock frequency [Hz]
                                        -- Natural: non negative integers

            delay_g : time              -- Delay duration
                                        -- Time: type consisting of numerical value + physical unit
        );
port    (
            clk_i : in std_ulogic;
            arst_i : in std_ulogic;
            start_i : in std_ulogic;    -- No effect if not done_o
            done_o : out std_ulogic     -- ’1’ when not counting (" not busy ")
        );

end entity timer ;

architecture Behavioral of timer is

        constant delay_real    : real := real(delay_g) / 1 sec;                 -- VHDL stores time-type as integer in fs. Transf in seconds 
                                                                                -- in order to multiply for clock (Hz)
                                                                                -- ’time’ can be multiplied/divided by integer or real values
                                                                                -- so cast as real (from vhdl-online.de). Do same for frequency
        constant freq_real     : real := real(clk_freq_hz_g);
        constant counter_limit : integer := integer(freq_real * delay_real);    -- Get integer cause it's n° clock cycles


end Behavioral;