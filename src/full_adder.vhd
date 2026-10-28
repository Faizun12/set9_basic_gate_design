library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Full adder = 2 half adders + 1 OR gate
entity full_adder is
  port (A, B, CIN : in  std_logic;
        S, COUT   : out std_logic);
end full_adder;

architecture structural of full_adder is
  signal s1, c1, c2 : std_logic;
begin
  HA1 : entity work.half_adder port map (A => A,  B => B,   S => s1, C => c1);
  HA2 : entity work.half_adder port map (A => s1, B => CIN, S => S,  C => c2);
  O1  : entity work.or_gate    port map (A => c1, B => c2,  Y => COUT);
end structural;
