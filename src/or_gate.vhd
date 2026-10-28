library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Basic gate: Y = A or B
entity or_gate is
  port (A, B : in  std_logic;
        Y    : out std_logic);
end or_gate;

architecture dataflow of or_gate is
begin
  Y <= A or B;
end dataflow;
