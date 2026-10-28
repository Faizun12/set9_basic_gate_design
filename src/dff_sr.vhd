library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- D flip-flop with synchronous active-high reset and enable, built from gates + d_ff
--   enable : mux2 chooses between hold (Q) and new data (D)
--   reset  : AND with NOT RST (reset value 0) or OR with RST (reset value 1)
entity dff_sr is
  generic (RESET_VAL : std_logic := '0');
  port (CLK, RST, EN, D : in  std_logic;
        Q               : out std_logic);
end dff_sr;

architecture structural of dff_sr is
  signal q_s, m, d_in, nrst : std_logic;
begin
  MX : entity work.mux2 port map (A => q_s, B => D, S => EN, Y => m);

  r0 : if RESET_VAL = '0' generate
    N1 : entity work.not_gate port map (A => RST, Y => nrst);
    A1 : entity work.and_gate port map (A => m, B => nrst, Y => d_in);
  end generate;

  r1 : if RESET_VAL = '1' generate
    O1 : entity work.or_gate port map (A => m, B => RST, Y => d_in);
  end generate;

  FF : entity work.d_ff port map (CLK => CLK, D => d_in, Q => q_s);
  Q <= q_s;
end structural;
