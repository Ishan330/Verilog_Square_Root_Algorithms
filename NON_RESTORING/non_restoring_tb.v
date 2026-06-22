// testbench
module nonrest_test;
reg clk, start;
reg [7:0] N;
wire done;
wire [3:0] Q;
non_restoring_sqrt DUT(clk,start,N,done,Q);

initial 
begin
clk=1'b0;
start=0;
N=0;
#3 N=144;
#4 start=1;
#10 start=0;
#200 $finish;
end

always
#5 clk=~clk;

initial
begin
$dumpfile("nonrest_test.vcd");
$dumpvars(0,nonrest_test);
$monitor($time, " N=%d count=%d pair=%b R=%d trial=%d Q=%d done=%b",N,DUT.count,DUT.next_pair,DUT.R,DUT.trial,Q,done);
end

endmodule


