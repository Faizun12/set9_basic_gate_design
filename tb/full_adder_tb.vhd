library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_tb is
end full_adder_tb;

architecture sim of full_adder_tb is
  signal A, B, CIN, S, COUT : std_logic := '0';
begin
  DUT : entity work.full_adder port map (A => A, B => B, CIN => CIN, S => S, COUT => COUT);

  stim : process
  begin
    -- A B CIN -> S COUT  (all 8 rows of the truth table)
    A <= '0'; B <= '0'; CIN <= '0'; wait for 10 ns;
    assert S = '0' and COUT = '0' report "000 MISMATCH" severity error;
    A <= '0'; B <= '0'; CIN <= '1'; wait for 10 ns;
    assert S = '1' and COUT = '0' report "001 MISMATCH" severity error;
    A <= '0'; B <= '1'; CIN <= '0'; wait for 10 ns;
    assert S = '1' and COUT = '0' report "010 MISMATCH" severity error;
    A <= '0'; B <= '1'; CIN <= '1'; wait for 10 ns;
    assert S = '0' and COUT = '1' report "011 MISMATCH" severity error;
    A <= '1'; B <= '0'; CIN <= '0'; wait for 10 ns;
    assert S = '1' and COUT = '0' report "100 MISMATCH" severity error;
    A <= '1'; B <= '0'; CIN <= '1'; wait for 10 ns;
    assert S = '0' and COUT = '1' report "101 MISMATCH" severity error;
    A <= '1'; B <= '1'; CIN <= '0'; wait for 10 ns;
    assert S = '0' and COUT = '1' report "110 MISMATCH" severity error;
    A <= '1'; B <= '1'; CIN <= '1'; wait for 10 ns;
    assert S = '1' and COUT = '1' report "111 MISMATCH" severity error;
    report "full_adder_tb finished: all 8 combinations checked." severity note;
    wait;
  end process;
end sim;
