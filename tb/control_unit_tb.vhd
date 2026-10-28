library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit_tb is
end control_unit_tb;

architecture sim of control_unit_tb is
  signal OPCODE : std_logic_vector(3 downto 0) := x"0";
  signal Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD : std_logic := '0';

  procedure chk(signal OPCODE : out std_logic_vector(3 downto 0); signal Z : out std_logic;
                signal l, a, n, s, w, p : in std_logic;
                op : std_logic_vector(3 downto 0); zv : std_logic;
                el, ea, en, es, ew, ep : std_logic; msg : string) is
  begin
    OPCODE <= op; Z <= zv;
    wait for 10 ns;
    assert l = el and a = ea and n = en and s = es and w = ew and p = ep
      report msg & " MISMATCH" severity error;
  end procedure;
begin
  DUT : entity work.control_unit
    port map (OPCODE => OPCODE, Z => Z, SEL_LDI => SEL_LDI, SEL_ADD => SEL_ADD,
              SEL_NOT => SEL_NOT, SEL_SHL => SEL_SHL, ACC_WE => ACC_WE, PC_LOAD => PC_LOAD);

  stim : process
  begin
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"1", '0', '1','0','0','0','1','0', "LDI");
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"2", '0', '0','1','0','0','1','0', "ADD");
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"7", '0', '0','0','1','0','1','0', "NOT");
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"8", '0', '0','0','0','1','1','0', "SHL");
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"C", '0', '0','0','0','0','0','0', "JZ not taken");
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"C", '1', '0','0','0','0','0','1', "JZ taken");
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"0", '1', '0','0','0','0','0','0', "NOP 0000");
    chk(OPCODE, Z, SEL_LDI, SEL_ADD, SEL_NOT, SEL_SHL, ACC_WE, PC_LOAD, x"F", '1', '0','0','0','0','0','0', "NOP 1111");
    report "control_unit_tb finished: all 8 cases checked." severity note;
    wait;
  end process;
end sim;
