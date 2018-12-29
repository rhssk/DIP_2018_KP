LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY TOP0_tb IS
END TOP0_tb;

ARCHITECTURE behavior OF TOP0_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT TOP0
    PORT(
        );
    END COMPONENT;

   -- No clocks detected in port list. Replace <clock> below with
   -- appropriate port name

   constant <clock>_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: TOP0 PORT MAP (
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      wait for <clock>_period*10;

      -- insert stimulus here

      wait;
   end process;

END;
