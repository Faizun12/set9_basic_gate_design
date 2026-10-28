library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity and4_gate_tb is
end and4_gate_tb;

architecture sim of and4_gate_tb is
  signal A, B, C, D, Y : std_logic := '0';
begin
  DUT : entity work.and4_gate port map (A => A, B => B, C => C, D => D, Y => Y);

  stim : process
    variable v : std_logic_vector(3 downto 0);
  begin
    for i in 0 to 15 loop
      v := std_logic_vector(to_unsigned(i, 4));
      A <= v(3); B <= v(2); C <= v(1); D <= v(0);
      wait for 10 ns;
      if i = 15 then
        assert Y = '1' report "1111 MISMATCH" severity error;
      else
        assert Y = '0' report "AND4 should be 0" severity error;
      end if;
    end loop;
    report "and4_gate_tb finished: all 16 combinations checked." severity note;
    wait;
  end process;
end sim;
