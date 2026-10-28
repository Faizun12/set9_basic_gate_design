library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 4-input AND built from three 2-input AND gates
entity and4_gate is
  port (A, B, C, D : in  std_logic;
        Y          : out std_logic);
end and4_gate;

architecture structural of and4_gate is
  signal t1, t2 : std_logic;
begin
  G1 : entity work.and_gate port map (A => A,  B => B,  Y => t1);
  G2 : entity work.and_gate port map (A => C,  B => D,  Y => t2);
  G3 : entity work.and_gate port map (A => t1, B => t2, Y => Y);
end structural;
