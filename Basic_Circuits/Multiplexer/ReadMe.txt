This folder contains verilog code for Multiplexer aka MUX

1.What is a Mux?
Multiplexer(MUX) is a electronic device which selects one of multiple inputs and reflects it in the single output line based on the select line inputs. In simple terms, 
Based on the binary value of the select lines, only one input is selected, and its value appears at the output.

2.How Multiplexers work?
MUX with 'n' number of select lines can select one of 2^n input lines, that is 2^n  : 1
For example, for a 2 input MUX, the number of select lines is 1 and number of output line is 1


                                       -----------------
                                       |               |
                            I0  -------|      MUX      |
                                       |     2 : 1     |------ output
                            I1  -------|               |
                                       |               |
                                       -----------------
                                               |
                                               |
                                              Sel
3.What are the application:
Multiplexers are used in Computer processors to route data from multiple source such as memory, registers, hardware peripheral, I/O devices to CPU based on control signals.
Multiplexers are also used to combine multiple data signals into a single communication channel or transmission medium, enabling efficient utilization 
of the available bandwidth.
