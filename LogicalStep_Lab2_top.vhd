--Members: Nidhi Subrahmanya and Sania Shah (LAB2_REPORT, Team 20, Section 202)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- This design performs the following functions: 
-- 1. Reads an 8-bit switch input (sw). The lower 4 bits (sw(3 downto 0)) are assigned to operand A and the upper 4 bits (sw(7 downto 4)) are assigned to operand B. 
-- 2. A 4-bit full adder (full_adder_4bit) adds these two operands with an initial carry-in of '0'. The result is a 4-bit sum and a carry-out.
-- 3. The 4-bit sum is passed into a SevenSegment decoder that converts the 4-bit value into a 7-bit pattern to drive a seven-segment display. 
-- 4. (Optional) Other components such as segment7_mux, pb_inverters, and logic_processor are declared and commented out since they are not used in this configuration.

---------------------------------------------------------------------------------------------------------------------------------------------------------------

entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 

-- 4-Bit Full Adder Component:
  COMPONENT full_adder_4bit PORT (
	INPUT_A: in STD_LOGIC_VECTOR(3 downto 0);
	INPUT_B: in STD_LOGIC_VECTOR(3 downto 0);
	CARRY_IN: in STD_LOGIC;
	FULL_ADDER_SUM_OUTPUT: out STD_LOGIC_VECTOR(3 downto 0);
	FULL_ADDER_CARRY_OUTPUT: out STD_LOGIC
	);
	end component;

-- 7-Segment Multiplxer Component:  
  component segment7_mux port(
	clk		: in std_logic := '0'; 
	DIN2		: in std_logic_vector(6 downto 0);
	DIN1		: in std_logic_vector(6 downto 0);
	DOUT		: out std_logic_vector(6 downto 0);
	DIG2		: out std_logic;
	DIG1		: out std_logic
	);
 end component;
  
 --Pushbutton Inverters Component:
  component pb_inverters port(
	pb_n : in std_logic_vector(3 downto 0);
	pb : out std_logic_vector (3 downto 0)
	);
 end component;
 
- --Logic Processor Component:
  component logic_processor port (
	logic_in0 : in std_logic_vector(3 downto 0);
	logic_in1 : in std_logic_vector(3 downto 0); 
	logic_select : in std_logic_vector (1 downto 0);
	logic_out : out std_logic_vector (3 downto 0) 
	);
 end component; 
 
  --SevenSegment Decoder Component:
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
 end component;
 
 
-- Signal Declarations or temporary variables to be used
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
-------------------------------------------------------------------------------------------------

	signal hex_A		: std_logic_vector(3 downto 0); --Lower 4 bits from the switch (operand A)
	signal hex_B      : std_logic_vector(3 downto 0); --Upper 4 bits from the switch (operand B)
	
	signal seg7_A     : std_logic_vector(6 downto 0); --7-seg Output from hex_A
	signal seg7_B     : std_logic_vector(6 downto 0); --7-seg output for hex_B
	
	signal pb		   : std_logic_vector(3 downto 0); --processed pushbutton signals
	--signal logic_result		: std_logic_vector (3 downto 0); 
	
	signal FULL_ADDER_SUM: STD_LOGIC_VECTOR(3 downto 0); --4-bit sum from the full adder
	signal FULL_ADDER_CARRY: STD_LOGIC;                  --Carry output from the full adder
	
-- Here the circuit begins

begin
	hex_A <= sw(3 downto 0); --Assign lower 4 bits of sw input to hex_A
	hex_B <= sw(7 downto 4); --Assign upper 4 bits of sw input to hex_B
	
--Component hookup, generate the seven segment coding

--	INST1: SevenSegment port map(hex_A, seg7_A);
--	INST2: SevenSegment port map(hex_B, seg7_B);
--	INST3: segment7_mux port map(
--		clk => clkin_50, 
--		DIN2 => seg7_A,
--		DIN1 => seg7_B,
--		DOUT => seg7_output,
--		DIG2 => seg7_char1,
--		DIG1 => seg7_char2
--);
--	INST4: pb_inverters port map(
--		pb_n => pb_n,
--		pb => pb
--);
--	INST5: logic_processor port map(
--		logic_in0 => hex_A,
--		logic_in1 => hex_B,
--		logic_select => pb(1 downto 0),
--		logic_out => leds(3 downto 0)
--);

	FA: full_adder_4bit PORT MAP (
	INPUT_A =>  hex_A,
	INPUT_B => hex_B,
	CARRY_IN => '0',
	FULL_ADDER_SUM_OUTPUT => FULL_ADDER_SUM,
	FULL_ADDER_CARRY_OUTPUT => FULL_ADDER_CARRY
	);
	
	--Instantiate SevenSegment decoder for the full adder's sum result (SevenSegment decoder converts 4-bit full adder sum (FULL_ADDER_SUM) into a 7-bit pattern that drives the seven-segment display (seg7_data)
	FA_Decoder: SevenSegment port map (
	hex => FULL_ADDER_SUM, --4-bit input from the adder
	sevenseg=> seg7_data   --7-bit output for the display
	);
	
end SimpleCircuit;
