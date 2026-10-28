library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_latch_tb is
end sr_latch_tb;

architecture sim of sr_latch_tb is
  signal S, R, Q, QN : std_logic := '0';
begin
  DUT : entity work.sr_latch port map (S => S, R => R, Q => Q, QN => QN);

  stim : process
  begin
    S <= '1'; R <= '0'; wait for 10 ns;                 -- set
    assert Q = '1' and QN = '0' report "SET MISMATCH" severity error;
    S <= '0'; R <= '0'; wait for 10 ns;                 -- hold 1
    assert Q = '1' and QN = '0' report "HOLD 1 MISMATCH" severity error;
    S <= '0'; R <= '1'; wait for 10 ns;                 -- reset
    assert Q = '0' and QN = '1' report "RESET MISMATCH" severity error;
    S <= '0'; R <= '0'; wait for 10 ns;                 -- hold 0
    assert Q = '0' and QN = '1' report "HOLD 0 MISMATCH" severity error;
    report "sr_latch_tb finished: set, reset and hold checked." severity note;
    wait;
  end process;
end sim;
