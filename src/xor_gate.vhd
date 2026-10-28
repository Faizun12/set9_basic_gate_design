library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Basic gate: Y = A xor B
entity xor_gate is
  port (A, B : in  std_logic;
        Y    : out std_logic);
end xor_gate;

architecture dataflow of xor_gate is
begin
  Y <= A xor B;
end dataflow;
