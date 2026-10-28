library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch_tb is
end d_latch_tb;

architecture sim of d_latch_tb is
  signal D, EN, Q : std_logic := '0';
begin
  DUT : entity work.d_latch port map (D => D, EN => EN, Q => Q);

  stim : process
  begin
    EN <= '1'; D <= '1'; wait for 10 ns;                -- transparent: Q follows D
    assert Q = '1' report "FOLLOW 1 MISMATCH" severity error;
    D <= '0'; wait for 10 ns;
    assert Q = '0' report "FOLLOW 0 MISMATCH" severity error;
    D <= '1'; wait for 10 ns;
    EN <= '0'; wait for 10 ns;                          -- closed: hold 1
    D <= '0'; wait for 10 ns;
    assert Q = '1' report "HOLD 1 MISMATCH" severity error;
    EN <= '1'; wait for 10 ns;                          -- open again
    assert Q = '0' report "REOPEN MISMATCH" severity error;
    EN <= '0'; wait for 10 ns;
    D <= '1'; wait for 10 ns;                           -- closed: hold 0
    assert Q = '0' report "HOLD 0 MISMATCH" severity error;
    report "d_latch_tb finished: follow and hold checked." severity note;
    wait;
  end process;
end sim;
