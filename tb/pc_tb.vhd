library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc_tb is
end pc_tb;

architecture sim of pc_tb is
  signal CLK, RESET, LOAD : std_logic := '0';
  signal ADDR, PC_OUT : std_logic_vector(3 downto 0) := (others => '0');
  signal done : boolean := false;
begin
  DUT : entity work.pc port map (CLK => CLK, RESET => RESET, LOAD => LOAD, ADDR => ADDR, PC_OUT => PC_OUT);

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
    RESET <= '1';                                         -- 1. reset: PC = 0
    wait until rising_edge(CLK); wait for 1 ns;
    assert PC_OUT = x"0" report "RESET MISMATCH" severity error;
    RESET <= '0';
    for i in 1 to 3 loop                                  -- 2. count 1,2,3
      wait until rising_edge(CLK); wait for 1 ns;
      assert to_integer(unsigned(PC_OUT)) = i report "COUNT MISMATCH" severity error;
    end loop;
    LOAD <= '1'; ADDR <= x"5";                            -- 3. jump to 5
    wait until rising_edge(CLK); wait for 1 ns;
    assert PC_OUT = x"5" report "JUMP MISMATCH" severity error;
    LOAD <= '0';                                          -- 4. continue 6
    wait until rising_edge(CLK); wait for 1 ns;
    assert PC_OUT = x"6" report "AFTER JUMP MISMATCH" severity error;
    LOAD <= '1'; ADDR <= x"F";                            -- 5. jump to 15, then wrap
    wait until rising_edge(CLK); wait for 1 ns;
    LOAD <= '0';
    wait until rising_edge(CLK); wait for 1 ns;
    assert PC_OUT = x"0" report "WRAP MISMATCH" severity error;
    report "pc_tb finished: all checks done." severity note;
    done <= true;
    wait;
  end process;
end sim;
