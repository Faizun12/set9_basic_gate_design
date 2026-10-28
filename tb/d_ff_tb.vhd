library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_tb is
end d_ff_tb;

architecture sim of d_ff_tb is
  signal CLK, D, Q : std_logic := '0';
  signal done : boolean := false;
begin
  DUT : entity work.d_ff port map (CLK => CLK, D => D, Q => Q);

  clk_proc : process
  begin
    while not done loop
      CLK <= '0'; wait for 5 ns;
      CLK <= '1'; wait for 5 ns;
    end loop;
    wait;
  end process;

  stim : process
  begin
    D <= '1';                                           -- D = 1 before the edge
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q = '1' report "CAPTURE 1 MISMATCH" severity error;
    wait for 2 ns; D <= '0';                            -- change D while CLK = 1
    wait for 1 ns;
    assert Q = '1' report "Q CHANGED WITHOUT EDGE" severity error;
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q = '0' report "CAPTURE 0 MISMATCH" severity error;
    wait for 5 ns; D <= '1';                            -- change D while CLK = 0
    wait for 1 ns;
    assert Q = '0' report "Q CHANGED ON LOW CLK" severity error;
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q = '1' report "CAPTURE 1 AGAIN MISMATCH" severity error;
    report "d_ff_tb finished: edge-triggered behaviour checked." severity note;
    done <= true;
    wait;
  end process;
end sim;
