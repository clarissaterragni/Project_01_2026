-------------------------------------------------------------------------------------
-- 
--      Parametric Timer
--
--                                  Clarissa Terragni
--
-------------------------------------------------------------------------------------
-- For assumptions made during my reasonings, please refer to assumptions.md file
-------------------------------------------------------------------------------------


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
            done_o : out std_ulogic     -- ’1’ when not counting ("not busy")
        );

end entity timer ;

architecture Behavioral of timer is

        constant delay_real    : real := real(delay_g) / 1 sec;                 -- VHDL stores time-type as integer in fs. Transf in seconds 
                                                                                -- in order to multiply for clock (Hz)
                                                                                -- ’time’ can be multiplied/divided by integer or real values
                                                                                -- so cast as real (from vhdl-online.de). Do same for frequency

        constant freq_real     : real := real(clk_freq_hz_g);                   -- Constant cause generics fixed per instance (don't change at runtime)

        constant counter_limit : integer := integer(freq_real * delay_real);    -- Get integer cause it's n° clock cycles

        signal counter_value   : integer range 0 to counter_limit := 0;         -- Initialised to 0
        signal not_counting    : std_ulogic := '1';                             -- Unless I'm counting, it's not busy

begin

        done_o <= not_counting;         -- if counting '0', if not counting '1'

        counting : process(clk_i) begin         -- MISSING RESET                        

                if rising_edge(clk_i) then        

                        if (not_counting = '1') then                            -- wasn't already counting
                                counter_value <= 0;                             -- reset counter to 0

                                if (start_i) = '1' then                         -- start_i sampled on rising edges of clk
                                        not_counting <= '0';                    -- Counting starts on clock cycle following start_i high
                                end if;

                        else                                                    -- already counting
                                if (counter_value < counter_limit) then
                                        counter_value <= counter_value + 1;     -- increment counter
                                else
                                        counter_value <= 0;                     -- end of delay period
                                        not_counting <= '1';                    -- signal to output done_o       
                                end if;
                        end if;
                end if;

        end process counting;
end Behavioral;