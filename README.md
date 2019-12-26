# Digital-Systems-Design-Final-Assignement
A Morse code encoder implemented using VHDL.
------------------ELEC3342 Final Assignment README-------------------------
---------------------------------------------------------------------------
The purpose of this file is to encode 8 bit ASCII alphabetical characters
into their corresponding Morse code. The attached in this folder are the report
and the .vhd file.

Input: 	Clr - clears and resets the encoder
	Clk - its the clock
	Din - 8 bit ASCII
	Den - Validates input
Output:	Sout - Serial morse code output meant to form the waveform of morse code. 

There is only one .vhd file for the encoder as the entire program is on this file. This made
it significantly easier to troubleshoot. Also attached is the testbench. This was straight
forward, clock was generated then the clear asserted followed by the appropriate
data in and data enables as well as a simulation end signal. There are also extra signals that
within the test bench and regular encoder file that were used for troubleshooting purposes.
These can be engaged by uncommenting them from both files if desired. 

Limitations: 
 	- Sentences should finish being sent before the next one is recieved.
	- The letter E should not come after a space.
	- The current delay from period recieval to beginning of transmission is
	  one length of the first character of a sentence to be output.
	- The current characters supported are space, A, B, C, D, E, F, and period.
	- It can currently support sentences of up to length 16 characters right now
	  with the ability to increase that by changing only a few numbers in the code.
  - Sentences can be up to 16 characters long, this can be easily adjusted in the
    file, however. 
    
    The ASCII comes in and is then written to a FIFO holding the values until the
    period is recieved signifying the end of a sentence. The FIFO then writes to an
    FSM which holse the waveform in std_logic_vector form as well as the length of the
    waveform. The length is sent to a counter to count the number of clocks equal to
    the length of the characters waveform while the serial output uses this counter
    to put at the appropriate std_logic bit of the waveform.
    
    An FSM was chosen to add the letter gaps prior to characters if the prior character
    is not a word gap. A FIFO was chosen for its ability to hold values and then, well,
    first in first out.
