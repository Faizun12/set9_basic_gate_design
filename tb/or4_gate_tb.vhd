library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity or4_gate_tb is
end or4_gate_tb;

architecture sim of or4_gate_tb is
  signal A, B, C, D, Y : std_logic := '0';
begin
  DUT : entity work.or4_gate port map (A => A, B => B, C => C, D => D, Y => Y);

  stim : process
    variable v : std_logic_vector(3 downto 0);
  begin
    for i in 0 to 15 loop
      v := std_logic_vector(to_unsigned(i, 4));
      A <= v(3); B <= v(2); C <= v(1); D <= v(0);
      wait for 10 ns;
      if i = 0 then
        assert Y = '0' report "0000 MISMATCH" severity error;
      else
        assert Y = '1' report "OR4 should be 1" severity error;
      end if;
    end loop;
    report "or4_gate_tb finished: all 16 combinations checked." severity note;
    wait;
  end process;
end sim;
