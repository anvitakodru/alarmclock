
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company:

// Engineer:

//

// Create Date: 19.11.2019 07:30:49

// Design Name:

// Module Name: alarm_clock

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



module alarm_clock (

 input reset,  

 input clk,  //10MHz clock

 input [1:0] H_in1, //0 to 2

 input [3:0] H_in0, //0 to 9

 input [3:0] M_in1, //0 to5

 input [3:0] M_in0, //0 to 9

 input LD_time,  //if 1 , set time

 input   LD_alarm,  //if 1, then set alarm

 input   STOP_al,  // if 1, then stop alarm

 input   AL_ON,  // if high then alarm starts

 output reg Alarm ,//high if the alarm time equals the current time, and AL_ON is high.  remain high, until STOP_al goes high

 output [1:0]  H_out1, //0 to2



 output [3:0]  H_out0, //0 to 9

 output [3:0]  M_out1,  // 0 to 5

 output [3:0]  M_out0, //0 to 9

 output [3:0]  S_out1, // 0 to 5

 output [3:0]  S_out0  //0 to 9

 );



 // internal signal

 reg clk_1s = 1'b0;

 reg [28:0]count=0;

 reg [5:0] tmp_hour, tmp_minute, tmp_second;

 reg [1:0] c_hour1,a_hour1;

 reg [3:0] c_hour0,a_hour0;

 reg [3:0] c_min1,a_min1;

 reg [3:0] c_min0,a_min0;

 reg [3:0] c_sec1,a_sec1;

 reg [3:0] c_sec0,a_sec0;



 

//mod10 function

 function [3:0] mod_10;

 input [5:0] number;

 begin

 mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));

 end

 endfunction

 



//clock reset, larm set etc



 always @(posedge clk_1s or posedge reset )

 begin

 if(reset) begin

 a_hour1 <= 2'b00;

 a_hour0 <= 4'b0000;

 a_min1 <= 4'b0000;

 a_min0 <= 4'b0000;

 a_sec1 <= 4'b0000;

 a_sec0 <= 4'b0000;

 tmp_hour <= H_in1*10 + H_in0;

 tmp_minute <= M_in1*10 + M_in0;

 tmp_second <= 0;

 end

 else begin

 if(LD_alarm) begin

 a_hour1 <= H_in1;

 a_hour0 <= H_in0;

 a_min1 <= M_in1;

 a_min0 <= M_in0;

 a_sec1 <= 4'b0000;

 a_sec0 <= 4'b0000;

 end

 if(LD_time) begin

 tmp_hour <= H_in1*10 + H_in0;

 tmp_minute <= M_in1*10 + M_in0;

 tmp_second <= 0;

 end

 else begin  // LD_time =0

 tmp_second <= tmp_second + 1;

 if(tmp_second >=59) begin

 tmp_minute <= tmp_minute + 1;

 tmp_second <= 0;

 if(tmp_minute >=59) begin

 tmp_minute <= 0;

 tmp_hour <= tmp_hour + 1;

 if(tmp_hour >= 24) begin

 tmp_hour <= 0;

 end

 end

 end



 end

 end

 end

 

//creating 1 sec clock

 always @(posedge clk or posedge reset)

 begin

 if(reset)

 begin

 count <= 0;

 clk_1s <= 0;

 end

 else begin

 

if(count<5)

count=count+1'b1;



else

begin

clk_1s=~clk_1s;

count=0;

end



end



 end

 

//clock output

 always @(*) begin



 if(tmp_hour>=20) begin

 c_hour1 = 2;

 end

 else begin

 if(tmp_hour >=10)

 c_hour1  = 1;

 else

 c_hour1 = 0;

 end

 c_hour0 = tmp_hour - c_hour1*10;

 c_min1 = mod_10(tmp_minute);

 c_min0 = tmp_minute - c_min1*10;

 c_sec1 = mod_10(tmp_second);

 c_sec0 = tmp_second - c_sec1*10;

 end



 assign H_out1 = c_hour1; // the most significant hour digit of the clock

 assign H_out0 = c_hour0; // the least significant hour digit of the clock

 assign M_out1 = c_min1; // the most significant minute digit of the clock

 assign M_out0 = c_min0; // the least significant minute digit of the clock

 assign S_out1 = c_sec1; // the most significant second digit of the clock

 assign S_out0 = c_sec0; // the least significant second digit of the clock





//Alarm



 always @(posedge clk_1s or posedge reset) begin

 if(reset)

 Alarm <=0;

 else begin

 if({a_hour1,a_hour0,a_min1,a_min0,a_sec1,a_sec0}=={c_hour1,c_hour0,c_min1,c_min0,c_sec1,c_sec0})

 begin

 if(AL_ON) Alarm <= 1;

 end

 if(STOP_al) Alarm <=0;

 end

 end

 

endmodule