library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Basic gate: Y = NOT A
entity not_gate is
  port (A : in  std_logic;
        Y : out std_logic);
end not_gate;

architecture dataflow of not_gate is
begin
  Y <= not A;
end dataflow;
