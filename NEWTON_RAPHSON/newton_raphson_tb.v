// testbench
module nr_test;
reg clk;
reg [7:0] data_in;
wire done;
wire [7:0] result;
NEWTON_RAPHSON nr_tb(clk,data_in,done,result);

initial
begin 
clk=1'b0;
#7 data_in=144;
#200 $finish;
end

always 
#5 clk=~clk;

initial
begin
$dumpfile("sr_tb.vcd");
$dumpvars(0,nr_test);
$monitor($time," N=%d X=%d X_NEXT=%d result=%d done=%b",data_in, nr_tb.X, nr_tb.X_NEXT, result, done);
end

endmodule
