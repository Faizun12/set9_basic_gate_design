library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Basic gate: Y = A and B
entity and_gate is
  port (A, B : in  std_logic;
        Y    : out std_logic);
end and_gate;

architecture dataflow of and_gate is
begin
  Y <= A and B;
end dataflow;
