library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Accumulator (8 flip-flops, reset 0x00) and Z flag (1 flip-flop, reset 1)
-- Z input = NOR of all bits of the value being written (OR4 + OR4 -> OR -> NOT)
entity acc_z is
  port (CLK, RESET : in  std_logic;
        WE         : in  std_logic;
        D          : in  std_logic_vector(7 downto 0);
        ACC        : out std_logic_vector(7 downto 0);
        Z          : out std_logic);
end acc_z;

architecture structural of acc_z is
  signal lo, hi, any_s, zero_s : std_logic;
begin
  gen : for i in 0 to 7 generate
    FF : entity work.dff_sr
      generic map (RESET_VAL => '0')
      port map (CLK => CLK, RST => RESET, EN => WE, D => D(i), Q => ACC(i));
  end generate;

  OLO : entity work.or4_gate port map (A => D(0), B => D(1), C => D(2), D => D(3), Y => lo);
  OHI : entity work.or4_gate port map (A => D(4), B => D(5), C => D(6), D => D(7), Y => hi);
  OAN : entity work.or_gate  port map (A => lo,   B => hi,   Y => any_s);
  NZ  : entity work.not_gate port map (A => any_s, Y => zero_s);

  ZFF : entity work.dff_sr
    generic map (RESET_VAL => '1')
    port map (CLK => CLK, RST => RESET, EN => WE, D => zero_s, Q => Z);
end structural;
