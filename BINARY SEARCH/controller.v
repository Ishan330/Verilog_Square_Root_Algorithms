// controller code
module controller(start,clk,ldLOW,ldHIGH,ldMID2,ldN,clrLOW,clrHIGH,clrMID2,clrN,eq,mid,n,low_sel,high_sel,done,low_gt_high);
input clk,eq,mid,n,start,low_gt_high;
output reg ldLOW,ldHIGH,ldMID2,ldN,clrLOW,clrHIGH,clrMID2,clrN,low_sel,high_sel,done;
reg [2:0] state;
parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101;

always @(posedge clk)
begin
case(state)
S0:if(start)
state<=S1;
S1:state<=S2;
S2:state<=S3;
S3:state<=S4;
S4:if(eq||low_gt_high)
state<=S5;
else 
state<=S3;
S5:state<=S5;
default:state<=S0;
endcase
end

always @(*)
begin
ldLOW=0;
ldHIGH=0;
ldMID2=0;
ldN=0;
clrLOW=0;
clrHIGH=0;
clrMID2=0;
clrN=0;
low_sel=0;
high_sel=0;
done=0;
case(state)
S0:begin ldLOW=0;ldHIGH=0;ldMID2=0;ldN=0;clrLOW=0;clrHIGH=0;clrMID2=0;clrN=0;low_sel=0;high_sel=0;done=0;end
S1:begin ldN=1; end
S2:begin ldLOW=1;ldHIGH=1;low_sel=0;high_sel=0; end
S3:begin ldMID2=1;end
S4:begin
if(n)
begin
ldLOW=1;
low_sel=1;
end
else if(mid)
begin
ldHIGH=1;
high_sel=1;
end
end
S5:begin done=1; end
default:begin ldLOW=0;ldHIGH=0;ldMID2=0;ldN=0;clrLOW=0;clrHIGH=0;clrMID2=0;clrN=0;low_sel=0;high_sel=0;done=0;end
endcase
end

endmodule