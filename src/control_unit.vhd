library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Control unit: opcode decoder made only of NOT / AND / OR gate modules
-- LDI 0001, ADD 0010, NOT 0111, SHL 1000, JZ 1100. Everything else = NOP.
entity control_unit is
  port (OPCODE  : in  std_logic_vector(3 downto 0);
        Z       : in  std_logic;
        SEL_LDI : out std_logic;
        SEL_ADD : out std_logic;
        SEL_NOT : out std_logic;
        SEL_SHL : out std_logic;
        ACC_WE  : out std_logic;   -- write ACC and update Z
        PC_LOAD : out std_logic);  -- JZ taken
end control_unit;

architecture structural of control_unit is
  signal n : std_logic_vector(3 downto 0);        -- inverted opcode bits
  signal ldi, add, inv, shl, jz : std_logic;
begin
  gen : for i in 0 to 3 generate
    NI : entity work.not_gate port map (A => OPCODE(i), Y => n(i));
  end generate;

  -- decoder (one AND4 per instruction)
  D_LDI : entity work.and4_gate port map (A => n(3),      B => n(2),      C => n(1),      D => OPCODE(0), Y => ldi);
  D_ADD : entity work.and4_gate port map (A => n(3),      B => n(2),      C => OPCODE(1), D => n(0),      Y => add);
  D_NOT : entity work.and4_gate port map (A => n(3),      B => OPCODE(2), C => OPCODE(1), D => OPCODE(0), Y => inv);
  D_SHL : entity work.and4_gate port map (A => OPCODE(3), B => n(2),      C => n(1),      D => n(0),      Y => shl);
  D_JZ  : entity work.and4_gate port map (A => OPCODE(3), B => OPCODE(2), C => n(1),      D => n(0),      Y => jz);

  SEL_LDI <= ldi;  SEL_ADD <= add;  SEL_NOT <= inv;  SEL_SHL <= shl;

  -- ACC_WE = ldi + add + not + shl
  W : entity work.or4_gate  port map (A => ldi, B => add, C => inv, D => shl, Y => ACC_WE);
  -- PC_LOAD = jz . Z
  P : entity work.and_gate  port map (A => jz,  B => Z,   Y => PC_LOAD);
end structural;
