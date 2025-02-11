--Members: Nidhi Subrahmanya and Sania Shah (LAB2_REPORT, Team 20, Section 202)
library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4bit is
port(
	INPUT_A, INPUT_B: in STD_LOGIC_VECTOR(3 downto 0); --4-bit input vectors
	CARRY_IN:in STD_LOGIC; --carry-in input for the first time
	FULL_ADDER_SUM_OUTPUT: out STD_LOGIC_VECTOR(3 downto 0); --4-bit sum output
	FULL_ADDER_CARRY_OUTPUT: out STD_LOGIC --Carry-out output (final carry)
	);
	end full_adder_4bit;
	
 architecture Structural of full_adder_4bit is
	--Declare the 1-bit full adder component
 component full_adder_1bit is
 PORT (
 	INPUT_A, INPUT_B, CARRY_IN: in STD_LOGIC;
	FULL_ADDER_SUM_OUTPUT, FULL_ADDER_CARRY_OUTPUT: out STD_LOGIC
	);
	end component;
	--Intermediate carry signals between the 1-bit adders
	signal C: STD_LOGIC_VECTOR(2 downto 0);
	
	begin 
	-- First full adder: use the external CARRY_IN and produce the first carry bit. 
	INST0: full_adder_1bit port map( 
	INPUT_A => INPUT_A(0), 
	INPUT_B => INPUT_B(0), 
	CARRY_IN => CARRY_IN, 
	FULL_ADDER_SUM_OUTPUT => FULL_ADDER_SUM_OUTPUT(0), 
	FULL_ADDER_CARRY_OUTPUT => C(0) 
	); 
	-- Second full adder: carry in comes from previous adder's carry. 
	INST1: full_adder_1bit port map( INPUT_A => INPUT_A(1), 
	INPUT_B => INPUT_B(1), CARRY_IN => C(0), 
	FULL_ADDER_SUM_OUTPUT => FULL_ADDER_SUM_OUTPUT(1), 
	FULL_ADDER_CARRY_OUTPUT => C(1) 
	); 
	-- Third full adder: chain the carry. 
	INST2: full_adder_1bit port map( 
	INPUT_A => INPUT_A(2), 
	INPUT_B => INPUT_B(2), 
	CARRY_IN => C(1), 
	FULL_ADDER_SUM_OUTPUT => FULL_ADDER_SUM_OUTPUT(2), 
	FULL_ADDER_CARRY_OUTPUT => C(2) 
	); 
	-- Fourth full adder: its carry out goes directly to the output port. (Most significant bit)
	INST3: full_adder_1bit port map( 
	INPUT_A => INPUT_A(3), 
	INPUT_B => INPUT_B(3), 
	CARRY_IN => C(2), 
	FULL_ADDER_SUM_OUTPUT => FULL_ADDER_SUM_OUTPUT(3), 
	FULL_ADDER_CARRY_OUTPUT => FULL_ADDER_CARRY_OUTPUT  
	);
	end Structural;