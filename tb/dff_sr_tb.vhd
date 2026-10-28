library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_sr_tb is
end dff_sr_tb;

architecture sim of dff_sr_tb is
  signal CLK : std_logic := '0';
  signal RST, EN, D, Q0, Q1 : std_logic := '0';
  signal done : boolean := false;
begin
  DUT0 : entity work.dff_sr generic map (RESET_VAL => '0') port map (CLK, RST, EN, D, Q0);
  DUT1 : entity work.dff_sr generic map (RESET_VAL => '1') port map (CLK, RST, EN, D, Q1);

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
    RST <= '1'; EN <= '0'; D <= '1';                -- reset beats everything
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q0 = '0' and Q1 = '1' report "RESET MISMATCH" severity error;
    RST <= '0'; EN <= '1'; D <= '1';                -- load 1
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q0 = '1' and Q1 = '1' report "LOAD 1 MISMATCH" severity error;
    D <= '0';                                       -- load 0
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q0 = '0' and Q1 = '0' report "LOAD 0 MISMATCH" severity error;
    D <= '1'; EN <= '0';                            -- hold (EN = 0)
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q0 = '0' and Q1 = '0' report "HOLD MISMATCH" severity error;
    RST <= '1';                                     -- reset again
    wait until rising_edge(CLK); wait for 1 ns;
    assert Q0 = '0' and Q1 = '1' report "SECOND RESET MISMATCH" severity error;
    report "dff_sr_tb finished: all checks done." severity note;
    done <= true;
    wait;
  end process;
end sim;
