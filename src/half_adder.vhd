library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Half adder: S = A xor B, C = A and B
entity half_adder is
  port (A, B : in  std_logic;
        S, C : out std_logic);
end half_adder;

architecture structural of half_adder is
begin
  X1 : entity work.xor_gate port map (A => A, B => B, Y => S);
  A1 : entity work.and_gate port map (A => A, B => B, Y => C);
end structural;
