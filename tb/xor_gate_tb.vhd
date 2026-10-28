library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate_tb is
end xor_gate_tb;

architecture sim of xor_gate_tb is
  signal A, B, Y : std_logic := '0';
begin
  DUT : entity work.xor_gate port map (A => A, B => B, Y => Y);

  stim : process
  begin
    A <= '0'; B <= '0'; wait for 10 ns;
    assert Y = '0' report "00 MISMATCH" severity error;
    A <= '0'; B <= '1'; wait for 10 ns;
    assert Y = '1' report "01 MISMATCH" severity error;
    A <= '1'; B <= '0'; wait for 10 ns;
    assert Y = '1' report "10 MISMATCH" severity error;
    A <= '1'; B <= '1'; wait for 10 ns;
    assert Y = '0' report "11 MISMATCH" severity error;
    report "xor_gate_tb finished: truth table checked." severity note;
    wait;
  end process;
end sim;
