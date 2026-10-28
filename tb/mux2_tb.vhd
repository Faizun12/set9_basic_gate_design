library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_tb is
end mux2_tb;

architecture sim of mux2_tb is
  signal A, B, S, Y : std_logic := '0';
begin
  DUT : entity work.mux2 port map (A => A, B => B, S => S, Y => Y);

  stim : process
  begin
    S <= '0'; A <= '0'; B <= '1'; wait for 10 ns;
    assert Y = '0' report "S=0 A=0 MISMATCH" severity error;
    S <= '0'; A <= '1'; B <= '0'; wait for 10 ns;
    assert Y = '1' report "S=0 A=1 MISMATCH" severity error;
    S <= '1'; A <= '1'; B <= '0'; wait for 10 ns;
    assert Y = '0' report "S=1 B=0 MISMATCH" severity error;
    S <= '1'; A <= '0'; B <= '1'; wait for 10 ns;
    assert Y = '1' report "S=1 B=1 MISMATCH" severity error;
    report "mux2_tb finished: all cases checked." severity note;
    wait;
  end process;
end sim;
