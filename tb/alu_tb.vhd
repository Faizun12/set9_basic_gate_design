library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is
end alu_tb;

architecture sim of alu_tb is
  signal ACC, IMM, RESULT : std_logic_vector(7 downto 0) := (others => '0');
  signal SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL : std_logic := '0';

  procedure run(signal ACC, IMM : out std_logic_vector(7 downto 0);
                signal l, a, n, s : out std_logic;
                signal R : in std_logic_vector(7 downto 0);
                acc_v, imm_v : std_logic_vector(7 downto 0); sel : integer;
                exp : std_logic_vector(7 downto 0); msg : string) is
  begin
    ACC <= acc_v; IMM <= imm_v;
    l <= '0'; a <= '0'; n <= '0'; s <= '0';
    case sel is
      when 0 => l <= '1';
      when 1 => a <= '1';
      when 2 => n <= '1';
      when others => s <= '1';
    end case;
    wait for 10 ns;
    assert R = exp report msg & " MISMATCH" severity error;
  end procedure;
begin
  DUT : entity work.alu
    port map (ACC => ACC, IMM => IMM, SEL_LDI => SEL_LDI, SEL_ADD => SEL_ADD,
              SEL_NOT => SEL_NOT, SEL_SHL => SEL_SHL, RESULT => RESULT);

  stim : process
  begin
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"55", x"FF", 0, x"FF", "LDI FF");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"AA", x"00", 0, x"00", "LDI 00");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"00", x"11", 1, x"11", "ADD 0+11");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"77", x"77", 1, x"EE", "ADD 77+77");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"FF", x"01", 1, x"00", "ADD wrap");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"FF", x"00", 2, x"00", "NOT FF");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"00", x"00", 2, x"FF", "NOT 00");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"A5", x"00", 2, x"5A", "NOT A5");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"11", x"00", 3, x"22", "SHL 11");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"80", x"00", 3, x"00", "SHL 80");
    run(ACC, IMM, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, RESULT, x"22", x"00", 3, x"44", "SHL 22");
    report "alu_tb finished: all 11 checks done." severity note;
    wait;
  end process;
end sim;
