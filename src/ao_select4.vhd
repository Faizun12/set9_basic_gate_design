library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 1-bit AND-OR selector: Y = I0.S0 + I1.S1 + I2.S2 + I3.S3 (one-hot selects)
entity ao_select4 is
  port (I0, I1, I2, I3 : in  std_logic;
        S0, S1, S2, S3 : in  std_logic;
        Y              : out std_logic);
end ao_select4;

architecture structural of ao_select4 is
  signal t0, t1, t2, t3 : std_logic;
begin
  A0 : entity work.and_gate port map (A => I0, B => S0, Y => t0);
  A1 : entity work.and_gate port map (A => I1, B => S1, Y => t1);
  A2 : entity work.and_gate port map (A => I2, B => S2, Y => t2);
  A3 : entity work.and_gate port map (A => I3, B => S3, Y => t3);
  O  : entity work.or4_gate port map (A => t0, B => t1, C => t2, D => t3, Y => Y);
end structural;
