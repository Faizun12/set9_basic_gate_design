library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 4-bit program counter: 4 flip-flops + ripple-adder incrementer + 4 mux2
entity pc is
  port (CLK, RESET : in  std_logic;
        LOAD       : in  std_logic;                     -- 1 = jump (JZ taken)
        ADDR       : in  std_logic_vector(3 downto 0);  -- jump target
        PC_OUT     : out std_logic_vector(3 downto 0));
end pc;

architecture structural of pc is
  signal cur, inc, nxt : std_logic_vector(3 downto 0);
begin
  INCR : entity work.ripple_adder
    generic map (N => 4)
    port map (A => cur, B => "0001", CIN => '0', SUM => inc, COUT => open);

  gen : for i in 0 to 3 generate
    MX : entity work.mux2
      port map (A => inc(i), B => ADDR(i), S => LOAD, Y => nxt(i));
    FF : entity work.dff_sr
      generic map (RESET_VAL => '0')
      port map (CLK => CLK, RST => RESET, EN => '1', D => nxt(i), Q => cur(i));
  end generate;

  PC_OUT <= cur;
end structural;
