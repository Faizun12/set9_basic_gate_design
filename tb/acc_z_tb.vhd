library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_z_tb is
end acc_z_tb;

architecture sim of acc_z_tb is
  signal CLK, RESET, WE, Z : std_logic := '0';
  signal D, ACC : std_logic_vector(7 downto 0) := (others => '0');
  signal done : boolean := false;
begin
  DUT : entity work.acc_z port map (CLK => CLK, RESET => RESET, WE => WE, D => D, ACC => ACC, Z => Z);

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
    RESET <= '1'; WE <= '0'; D <= x"AA";                  -- 1. reset: ACC=00, Z=1
    wait until rising_edge(CLK); wait for 1 ns;
    assert ACC = x"00" and Z = '1' report "RESET MISMATCH" severity error;
    RESET <= '0'; WE <= '1'; D <= x"1E";                  -- 2. load 1E: Z=0
    wait until rising_edge(CLK); wait for 1 ns;
    assert ACC = x"1E" and Z = '0' report "LOAD 1E MISMATCH" severity error;
    WE <= '0'; D <= x"AA";                                -- 3. hold
    wait until rising_edge(CLK); wait for 1 ns;
    assert ACC = x"1E" and Z = '0' report "HOLD MISMATCH" severity error;
    WE <= '1'; D <= x"00";                                -- 4. load 00: Z=1
    wait until rising_edge(CLK); wait for 1 ns;
    assert ACC = x"00" and Z = '1' report "LOAD 00 MISMATCH" severity error;
    D <= x"80";                                           -- 5. load 80: Z=0
    wait until rising_edge(CLK); wait for 1 ns;
    assert ACC = x"80" and Z = '0' report "LOAD 80 MISMATCH" severity error;
    WE <= '0'; D <= x"00";                                -- 6. hold, Z must stay 0
    wait until rising_edge(CLK); wait for 1 ns;
    assert ACC = x"80" and Z = '0' report "HOLD (D=00) MISMATCH" severity error;
    RESET <= '1';                                         -- 7. reset again
    wait until rising_edge(CLK); wait for 1 ns;
    assert ACC = x"00" and Z = '1' report "SECOND RESET MISMATCH" severity error;
    report "acc_z_tb finished: all checks done." severity note;
    done <= true;
    wait;
  end process;
end sim;
