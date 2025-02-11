--Members: Nidhi Subrahmanya and Sania Shah (LAB2_REPORT, Team 20, Section 202)

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is
port(
	INPUT_A: in STD_LOGIC; --1-bit input A
	INPUT_B: in STD_LOGIC; --1-bit input B
	CARRY_IN: in STD_LOGIC; --1-bit carry input 
	FULL_ADDER_SUM_OUTPUT: out STD_LOGIC; --1-bit sum output
	FULL_ADDER_CARRY_OUTPUT: out STD_LOGIC --1-bit carry output
);
end full_adder_1bit;

architecture behavior of full_adder_1bit is 
begin
	FULL_ADDER_SUM_OUTPUT <= INPUT_A XOR INPUT_B XOR CARRY_IN; --sum output calculated using XOR logic
	FULL_ADDER_CARRY_OUTPUT <= ((INPUT_A AND INPUT_B) OR (CARRY_IN AND (INPUT_A XOR INPUT_B))); --carry output based on diagram provided in lab manual
end behavior;