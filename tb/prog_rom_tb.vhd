library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity prog_rom_tb is
end prog_rom_tb;

architecture sim of prog_rom_tb is
  signal ADDR  : std_logic_vector(3 downto 0) := (others => '0');
  signal INSTR : std_logic_vector(11 downto 0);
  type rom_t is array (0 to 15) of std_logic_vector(11 downto 0);
  constant EXP : rom_t := (x"1FF", x"700", x"C05", x"277", x"277", x"211",
                           x"800", x"C00", x"800", others => x"000");
begin
  DUT : entity work.prog_rom port map (ADDR => ADDR, INSTR => INSTR);

  stim : process
  begin
    for i in 0 to 15 loop
      ADDR <= std_logic_vector(to_unsigned(i, 4));
      wait for 10 ns;
      assert INSTR = EXP(i) report "ROM MISMATCH at address " & integer'image(i) severity error;
    end loop;
    report "prog_rom_tb finished: all 16 addresses checked." severity note;
    wait;
  end process;
end sim;
