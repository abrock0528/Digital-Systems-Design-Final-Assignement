----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2019 10:28:27 PM
-- Design Name: 
-- Module Name: tb_mcencoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_mcencoder is
end tb_mcencoder;

architecture tb of tb_mcencoder is

    component mcencoder
        port (din     : in std_logic_vector (7 downto 0);
              sout   : out std_logic;
              clk : in  std_logic;
              clr     : in  std_logic;
              den : in std_logic);
--              testfifo : out std_logic_vector(7 downto 0);
  --            ren : out std_logic;
    --          FSM2SRout : out std_logic_vector(14 downto 0);
      --        lengthout : out integer;
        --      lengthcounterout : out integer;
          --    shiftout : out std_logic_vector(14 downto 0));
    end component;

    signal din     : std_logic_vector (7 downto 0);
    signal sout   : std_logic;
    signal clk : std_logic;
    signal clr     : std_logic;
    signal den : std_logic;
--    signal testfifo : std_logic_vector(7 downto 0);
  --  signal ren : std_logic;
    --signal FSM2SRout : std_logic_vector(14 downto 0);
--    signal lengthout : integer;
  --  signal lengthcounterout : integer;
    --signal shiftout : std_logic_vector(14 downto 0);
    constant period : time := 20.833 us; -- for 48k Hz clk
    signal tbclk : std_logic := '0';
    signal SimEnded : std_logic := '0';

begin

    dut : mcencoder
    port map (din    => din,
              sout   => sout,
              clk => clk,
              clr     => clr,
              den => den);
--              testfifo => testfifo,
  --            ren => ren,
    --          FSM2SRout => FSM2SRout,
      --        lengthout => lengthout,
        --      lengthcounterout => lengthcounterout,
          --    shiftout => shiftout);

    -- Clock generation
    process
    begin
        tbclk <= not tbclk; 
        wait for Period/2; 
        if SimEnded = '1' then
            tbclk <= '0';
            wait;
        end if;
        clk <= tbclk;
    end process;

    stimuli : process

    begin

        clr <= '1';
        wait for 100 ns;
        clr <= '0';
        wait for 100 ns;
       
        den<= '1';
        din <= x"41";
        wait for period;
        din <= x"20";
        wait for period;
        din <= x"42";
        wait for period;
        din <= x"45";
        wait for 2*period;
        din <= x"2E";
        wait for period;
        den <= '0';
        wait for 80*period;
        den <= '1';
        din <= x"43";
        wait for period;
        din <= x"2E";
        wait for period;
        den <= '0';
        wait for 100*period;
        SimEnded <= '1';
        wait;
    end process;

end tb;

