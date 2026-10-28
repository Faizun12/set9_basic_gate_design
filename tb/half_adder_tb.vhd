library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_tb is
end half_adder_tb;

architecture sim of half_adder_tb is
  signal A, B, S, C : std_logic := '0';
begin
  DUT : entity work.half_adder port map (A => A, B => B, S => S, C => C);

  stim : process
  begin
    A <= '0'; B <= '0'; wait for 10 ns;
    assert S = '0' and C = '0' report "00 MISMATCH" severity error;
    A <= '0'; B <= '1'; wait for 10 ns;
    assert S = '1' and C = '0' report "01 MISMATCH" severity error;
    A <= '1'; B <= '0'; wait for 10 ns;
    assert S = '1' and C = '0' report "10 MISMATCH" severity error;
    A <= '1'; B <= '1'; wait for 10 ns;
    assert S = '0' and C = '1' report "11 MISMATCH" severity error;
    report "half_adder_tb finished: truth table checked." severity note;
    wait;
  end process;
end sim;
