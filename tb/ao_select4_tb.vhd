library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ao_select4_tb is
end ao_select4_tb;

architecture sim of ao_select4_tb is
  signal I0, I1, I2, I3 : std_logic := '0';
  signal S0, S1, S2, S3 : std_logic := '0';
  signal Y              : std_logic;
begin
  DUT : entity work.ao_select4
    port map (I0 => I0, I1 => I1, I2 => I2, I3 => I3,
              S0 => S0, S1 => S1, S2 => S2, S3 => S3, Y => Y);

  stim : process
  begin
    -- S0 selected: Y follows I0 only
    S0 <= '1'; S1 <= '0'; S2 <= '0'; S3 <= '0';
    I0 <= '1'; I1 <= '0'; I2 <= '0'; I3 <= '0'; wait for 10 ns;
    assert Y = '1' report "S0, I0=1 MISMATCH" severity error;
    I0 <= '0'; I1 <= '1'; I2 <= '1'; I3 <= '1'; wait for 10 ns;
    assert Y = '0' report "S0, I0=0 MISMATCH" severity error;
    -- S1 selected: Y follows I1 only
    S0 <= '0'; S1 <= '1';
    I0 <= '0'; I1 <= '1'; I2 <= '0'; I3 <= '0'; wait for 10 ns;
    assert Y = '1' report "S1, I1=1 MISMATCH" severity error;
    I0 <= '1'; I1 <= '0'; I2 <= '1'; I3 <= '1'; wait for 10 ns;
    assert Y = '0' report "S1, I1=0 MISMATCH" severity error;
    -- S2 selected: Y follows I2 only
    S1 <= '0'; S2 <= '1';
    I0 <= '0'; I1 <= '0'; I2 <= '1'; I3 <= '0'; wait for 10 ns;
    assert Y = '1' report "S2, I2=1 MISMATCH" severity error;
    I0 <= '1'; I1 <= '1'; I2 <= '0'; I3 <= '1'; wait for 10 ns;
    assert Y = '0' report "S2, I2=0 MISMATCH" severity error;
    -- S3 selected: Y follows I3 only
    S2 <= '0'; S3 <= '1';
    I0 <= '0'; I1 <= '0'; I2 <= '0'; I3 <= '1'; wait for 10 ns;
    assert Y = '1' report "S3, I3=1 MISMATCH" severity error;
    I0 <= '1'; I1 <= '1'; I2 <= '1'; I3 <= '0'; wait for 10 ns;
    assert Y = '0' report "S3, I3=0 MISMATCH" severity error;
    -- nothing selected: Y = 0 even if all inputs are 1
    S3 <= '0';
    I0 <= '1'; I1 <= '1'; I2 <= '1'; I3 <= '1'; wait for 10 ns;
    assert Y = '0' report "NO SELECT MISMATCH" severity error;
    report "ao_select4_tb finished: all select cases checked." severity note;
    wait;
  end process;
end sim;
