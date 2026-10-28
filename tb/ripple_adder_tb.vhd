library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ripple_adder_tb is
end ripple_adder_tb;

architecture sim of ripple_adder_tb is
  signal A, B, SUM : std_logic_vector(7 downto 0) := (others => '0');
  signal CIN, COUT : std_logic := '0';

  procedure check(signal A, B : out std_logic_vector(7 downto 0); signal CIN : out std_logic;
                  signal SUM : in std_logic_vector(7 downto 0); signal COUT : in std_logic;
                  a_v, b_v : integer; c_v : integer) is
    variable t : integer := a_v + b_v + c_v;
  begin
    A <= std_logic_vector(to_unsigned(a_v, 8));
    B <= std_logic_vector(to_unsigned(b_v, 8));
    if c_v = 1 then CIN <= '1'; else CIN <= '0'; end if;
    wait for 10 ns;
    assert to_integer(unsigned(SUM)) = t mod 256 report "SUM MISMATCH" severity error;
    assert (COUT = '1') = (t >= 256)             report "COUT MISMATCH" severity error;
  end procedure;
begin
  DUT : entity work.ripple_adder generic map (N => 8)
        port map (A => A, B => B, CIN => CIN, SUM => SUM, COUT => COUT);

  stim : process
  begin
    check(A, B, CIN, SUM, COUT, 0,   0,   0);
    check(A, B, CIN, SUM, COUT, 1,   1,   0);
    check(A, B, CIN, SUM, COUT, 16#77#, 16#77#, 0);
    check(A, B, CIN, SUM, COUT, 16#EE#, 16#11#, 0);
    check(A, B, CIN, SUM, COUT, 255, 1,   0);   -- carry out, sum wraps to 0
    check(A, B, CIN, SUM, COUT, 255, 255, 1);
    check(A, B, CIN, SUM, COUT, 16#0F#, 16#01#, 1);
    report "ripple_adder_tb finished: all checks done." severity note;
    wait;
  end process;
end sim;
