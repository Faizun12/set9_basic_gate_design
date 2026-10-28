library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 8-bit ALU: ripple-carry adder (ADD), 8 NOT gates (NOT), shift wiring (SHL),
-- and an AND-OR selector per bit (chooses LDI / ADD / NOT / SHL result)
entity alu is
  port (ACC     : in  std_logic_vector(7 downto 0);
        IMM     : in  std_logic_vector(7 downto 0);
        SEL_LDI : in  std_logic;
        SEL_ADD : in  std_logic;
        SEL_NOT : in  std_logic;
        SEL_SHL : in  std_logic;
        RESULT  : out std_logic_vector(7 downto 0));
end alu;

architecture structural of alu is
  signal sum_s, not_s, shl_s : std_logic_vector(7 downto 0);
begin
  ADDER : entity work.ripple_adder
    generic map (N => 8)
    port map (A => ACC, B => IMM, CIN => '0', SUM => sum_s, COUT => open);

  gen : for i in 0 to 7 generate
    NG : entity work.not_gate port map (A => ACC(i), Y => not_s(i));
    SEL : entity work.ao_select4
      port map (I0 => IMM(i), I1 => sum_s(i), I2 => not_s(i), I3 => shl_s(i),
                S0 => SEL_LDI, S1 => SEL_ADD, S2 => SEL_NOT, S3 => SEL_SHL,
                Y => RESULT(i));
  end generate;

  -- SHL: shift left by 1, 0 enters the LSB (just wiring)
  shl_s <= ACC(6 downto 0) & '0';
end structural;
