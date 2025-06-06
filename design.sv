module traffic_light(input clk,rst,output reg [3:0] light);
  parameter red      = 2'b00;
  parameter orange_1 = 2'b01;
  parameter green    = 2'b10;
  parameter orange_2 = 2'b11;
  
  reg [3:0] count_red;
  reg [2:0] count_orange;
  reg [5:0] count_green;
  
  reg [1:0] ps,ns;
  
  //reset condition
  always@(posedge clk or rst) begin
    if(rst) begin
      ps           <= red;
      count_red    <= 4'd15;
      count_orange <= 3'd5;
      count_green  <= 6'd25;
    end
    else begin
      ps           <= ns;
      case(ns)
        red:      count_red    <= (ps != red)      ? 4'd15 : (count_red - 1);
        orange_1: count_orange <= (ps != orange_1) ? 3'd5  : (count_orange - 1);
        green:    count_green  <= (ps != green)    ? 6'd25 : (count_green - 1);
        orange_2: count_orange <= (ps != orange_2) ? 3'd5  : (count_orange - 1);
      endcase
    end
  end
  
  //setting ns
  always@(ps,count_red,count_green,count_orange) begin
    case(ps)
      red      : ns = (count_red==4'b0000)    ? orange_1 : red;
      orange_1 : ns = (count_orange==3'b000)  ? green    : orange_1;
      green    : ns = (count_green==6'b000000) ? orange_2 : green;
      orange_2 : ns = (count_orange==3'b000)  ? red      : orange_2;
      default  : ns = red;
    endcase
  end
  
  //setting output
  always@(ps) begin
    case(ps)
      red      : light =4'd1;
      orange_1 : light =4'd2;
      green    : light =4'd4;
      orange_2 : light =4'd8;
      default  : light =4'd0;
    endcase
  end    

endmodule


