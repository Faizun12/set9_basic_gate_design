library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Gated D latch: EN = 1 -> Q follows D (transparent), EN = 0 -> Q holds
-- S = D and EN, R = (not D) and EN, then an SR latch
entity d_latch is
  port (D, EN : in  std_logic;
        Q     : out std_logic);
end d_latch;

architecture structural of d_latch is
  signal nd, s, r : std_logic;
begin
  N1 : entity work.not_gate port map (A => D,  Y => nd);
  A1 : entity work.and_gate port map (A => D,  B => EN, Y => s);
  A2 : entity work.and_gate port map (A => nd, B => EN, Y => r);
  L  : entity work.sr_latch port map (S => s, R => r, Q => Q, QN => open);
end structural;
