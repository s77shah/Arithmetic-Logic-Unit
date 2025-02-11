--Members: Nidhi Subrahmanya and Sania Shah (LAB2_REPORT, Team 20, Section 202)

library ieee;
use ieee.std_logic_1164.all;

entity hex_mux is 
port (
	hex_num3, hex_num2, hex_num1, hex_num0: in std_logic_vector (3 downto 0); --4 input 4-bit hex values
	mux_select                            : in std_logic_vector (1 downto 0); --2-bit selection input
	hex_out                               : out std_logic_vector (3 downto 0) --4-bit output hex value
);
end hex_mux;

architecture mux_logic of hex_mux is

begin
--Multiplexer Logic: selects one of the four hex inputs based on the mux_select signal
with mux_select(1 downto 0) select
hex_out <=hex_num0 when "00",
			 hex_num1 when "01",
			 hex_num2 when "10",
			 hex_num3 when "11";
end mux_logic;
