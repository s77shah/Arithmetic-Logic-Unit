--Members: Nidhi Subrahmanya and Sania Shah (LAB2_REPORT, Team 20, Section 202)

library ieee;
use ieee.std_logic_1164.all;

entity logic_processor is
	port (
	logic_in0, logic_in1 : in std_logic_vector(3 downto 0); --4-bit input vectors
	logic_select : in std_logic_vector (1 downto 0);        --2-bit selection input
	logic_out : out std_logic_vector (3 downto 0)           --4-bit output vector
	);
end logic_processor; 

architecture behaviour of logic_processor is 
	--Internal signals for different logic operations
	signal and_result	: std_logic_vector(3 downto 0); --Stores bitwise AND result
	signal or_result	: std_logic_vector(3 downto 0); --Stores bitwise OR result
	signal xor_result	: std_logic_vector(3 downto 0); --Stores bitwise XOR result
	signal xnor_result : std_logic_vector(3 downto 0); --Stores bitwise XNOR result
	
begin 
--perform basic logic operations
	and_result <= logic_in0 AND logic_in1; --performs bitwise AND operation on inputs
	or_result <= logic_in0 OR logic_in1 ; --performs bitwise OR operation on inputs
	xor_result <= logic_in0 XOR logic_in1; --performs bitwise XOR operation on inputs
	xnor_result <= logic_in0 XNOR logic_in1 ; --performs bitwise XNOR operation on inputs
	
--select output based on 'logic_select'
with logic_select(1 downto 0) select
logic_out <=and_result when "00", --AND operation
			 or_result when "01", --OR operation
			 xor_result when "10", --XOR operation
			 xnor_result when "11"; --XNOR operation
end behaviour;

