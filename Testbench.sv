`timescale 1s/1s

module tb_traffic_light();

  reg clk;
  reg rst;
  wire [3:0] light;

  traffic_light dut (clk,rst,light);

  always #0.5 clk = ~clk;
  
  initial begin
    $monitor($time, " clk=%0b rst=%0b light=%0d",clk,rst,light);
    $dumpfile("dump.vcd");
    $dumpvars;
    clk=1'b0; rst=1'b1;  
    #5 rst=1'b0;
    #400 $finish();
  end
endmodule
