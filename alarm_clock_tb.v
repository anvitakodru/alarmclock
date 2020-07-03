
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company:

// Engineer:

//

// Create Date: 19.11.2019 14:57:30

// Design Name:

// Module Name: actb

// Project Name:

// Target Devices:

// Tool Versions:

// Description:

//

// Dependencies:

//

// Revision:

// Revision 0.01 - File Created

// Additional Comments:

//

//////////////////////////////////////////////////////////////////////////////////





module alarm_clock_tb();

 reg reset;

 reg clk;

 reg [1:0] H_in1;

 reg [3:0] H_in0;

 reg [3:0] M_in1;

 reg [3:0] M_in0;

 reg LD_time;

 reg LD_alarm;

 reg STOP_al;

 reg AL_ON;



 // Outputs

 wire Alarm;

 wire [1:0] H_out1;

 wire [3:0] H_out0;

 wire [3:0] M_out1;

 wire [3:0] M_out0;

 wire [3:0] S_out1;

 wire [3:0] S_out0;



 // Instantiate the Unit Under Test (UUT)

 alarm_clock a (

 .reset(reset),

 .clk(clk),

 .H_in1(H_in1),

 .H_in0(H_in0),

 .M_in1(M_in1),

 .M_in0(M_in0),

 .LD_time(LD_time),

 .LD_alarm(LD_alarm),

 .STOP_al(STOP_al),

 .AL_ON(AL_ON),

 .Alarm(Alarm),

 .H_out1(H_out1),

 .H_out0(H_out0),

 .M_out1(M_out1),

 .M_out0(M_out0),

 .S_out1(S_out1),

 .S_out0(S_out0)

 );

 // clock 10Hz

 initial begin

  clk = 0;

  forever #50 clk = ~clk;

 end

 initial begin

 // Initialize Inputs

 reset = 1;

 H_in1 = 0;

 H_in0 = 1;

 M_in1 = 0;

 M_in0 = 0;

 LD_time = 0;

 LD_alarm = 0;

 STOP_al = 0;

 AL_ON = 0;

 // Wait 100 ns for global reset to finish

 #1000;

      reset = 0;

 H_in1 = 0;

 H_in0 = 1;

 M_in1 = 0;

 M_in0 = 1;

 LD_time = 0;

 LD_alarm = 1;

 STOP_al = 0;

 AL_ON = 1;

 #1000;

 reset = 0;

 H_in1 = 0;

 H_in0 = 1;

 M_in1 = 0;

 M_in0 = 0;

 LD_time = 1;

 LD_alarm = 0;

 STOP_al = 0;

 AL_ON = 1;
 
 #1000;
 
  reset = 0;
 
  H_in1 = 0;
 
  H_in0 = 1;
 
  M_in1 = 0;
 
  M_in0 = 0;
 
  LD_time = 0;
 
  LD_alarm = 0;
 
  STOP_al = 0;
 
  AL_ON = 1;

 wait(Alarm); // wait until Alarm signal is high when the alarm time equals clock time

 #1000

 STOP_al = 1; // pulse high the STOP_al to push low the Alarm signal

 #1000

 STOP_al = 0;

 H_in1 = 0;

 H_in0 = 4;

 M_in1 = 4;

 M_in0 = 5;

 LD_time = 1;

 LD_alarm = 0;

 #1000

 STOP_al = 0;

 H_in1 = 0;

 H_in0 = 4;

 M_in1 = 5;

 M_in0 = 5;

 LD_alarm = 1;

 LD_time = 0;

 wait(Alarm); // wait until Alarm signal is high when the alarm time equals clock time

 #1000

 STOP_al = 1;

 end

     

endmodule