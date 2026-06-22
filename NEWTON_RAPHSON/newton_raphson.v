// NEWTON RAPHSON METHOD
module NEWTON_RAPHSON(clk,data_in,done,result);
input clk;
input [7:0] data_in;
output reg done;
output reg [7:0] result;
reg [7:0] N,X;
wire [7:0] X_NEXT;
parameter S0=0, S1=1, S2=2, S3=3;
reg [1:0] state;
assign X_NEXT=(X+N/X)/2;
always @(posedge clk)
begin
case(state)
S0:
begin
N<=data_in;
if(data_in==0)
begin
result<=0;
state<=S3;
end
else
state<=S1;
end
S1:
begin
state<=S2;
X<=(N/2)+1;
end
S2:
begin
if(X_NEXT==X||X_NEXT+1==X||X_NEXT==X+1)
begin
result<=(X < X_NEXT) ? X : X_NEXT;
state<=S3;
end
else
begin
X<=X_NEXT;
state<=S2;
end
end
S3:
begin
state<=S3;
end
default:state<=S0;
endcase
end

always @(*)
begin
done=0;
case(state)
S3: done=1;
default: done=0;
endcase
end

endmodule
