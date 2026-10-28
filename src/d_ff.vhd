library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Rising-edge D flip-flop = master D latch (open while CLK = 0)
--                         + slave  D latch (open while CLK = 1)
entity d_ff is
  port (CLK, D : in  std_logic;
        Q      : out std_logic);
end d_ff;

architecture structural of d_ff is
  signal nclk, m : std_logic;
begin
  U_INV    : entity work.not_gate  port map (A => CLK, Y => nclk);
  U_MASTER : entity work.d_latch   port map (D => D, EN => nclk, Q => m);
  U_SLAVE  : entity work.d_latch   port map (D => m, EN => CLK,  Q => Q);
end structural;
