library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- SR latch from two cross-coupled NOR gates (S = R = 1 is never applied)
--   S = 1, R = 0 -> Q = 1      S = 0, R = 1 -> Q = 0      S = R = 0 -> hold
entity sr_latch is
  port (S, R  : in  std_logic;
        Q, QN : out std_logic);
end sr_latch;

architecture structural of sr_latch is
  signal q_i, qn_i : std_logic;
begin
  G1 : entity work.nor_gate port map (A => R, B => qn_i, Y => q_i);
  G2 : entity work.nor_gate port map (A => S, B => q_i,  Y => qn_i);
  Q  <= q_i;
  QN <= qn_i;
end structural;
