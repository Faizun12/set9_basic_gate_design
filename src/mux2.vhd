library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 2:1 multiplexer from gates: Y = A when S = 0, Y = B when S = 1
entity mux2 is
  port (A, B, S : in  std_logic;
        Y       : out std_logic);
end mux2;

architecture structural of mux2 is
  signal ns, t1, t2 : std_logic;
begin
  N1 : entity work.not_gate port map (A => S,  Y => ns);
  A1 : entity work.and_gate port map (A => A,  B => ns, Y => t1);
  A2 : entity work.and_gate port map (A => B,  B => S,  Y => t2);
  O1 : entity work.or_gate  port map (A => t1, B => t2, Y => Y);
end structural;
