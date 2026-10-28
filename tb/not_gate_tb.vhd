library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate_tb is
end not_gate_tb;

architecture sim of not_gate_tb is
  signal A, Y : std_logic := '0';
begin
  DUT : entity work.not_gate port map (A => A, Y => Y);

  stim : process
  begin
    A <= '0'; wait for 10 ns;
    assert Y = '1' report "0 MISMATCH" severity error;
    A <= '1'; wait for 10 ns;
    assert Y = '0' report "1 MISMATCH" severity error;
    report "not_gate_tb finished: truth table checked." severity note;
    wait;
  end process;
end sim;
