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

entity timer is

generic (
            clk_freq_hz_g : natural;   -- Clock frequency [Hz]
                                        -- Natural: non negative integers

            delay_g : time              -- Delay duration
                                        -- Time: type consisting of numerical value + physical unit
        );
port (
            clk_i : in std_ulogic;
            arst_i : in std_ulogic;
            start_i : in std_ulogic;    -- No effect if not done_o
            done_o : out std_ulogic     -- ’1’ when not counting (" not busy ")
     );

end entity timer ;

-- ’time’ signals can be multiplied/divided by integer or real values. Operation's result is again a ’time’ type
-- Source: https://www.vhdl-online.de/courses/system_design/vhdl_language_and_syntax/data_types#data_type_time