library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- NOR gate = OR gate followed by NOT gate: Y = NOT (A OR B)
entity nor_gate is
  port (A, B : in  std_logic;
        Y    : out std_logic);
end nor_gate;

architecture structural of nor_gate is
  signal t : std_logic;
begin
  O1 : entity work.or_gate  port map (A => A, B => B, Y => t);
  N1 : entity work.not_gate port map (A => t, Y => Y);
end structural;
