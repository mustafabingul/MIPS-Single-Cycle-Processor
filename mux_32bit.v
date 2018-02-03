/*sinyal durumuna göre seçme işlemi yapar.*/
module mux_32bit(Out,Input0,Input1,Select);

input [31:0] Input0,Input1;
output reg [31:0] Out;
input Select;

always@(*)begin
if(Select == 1'b0) begin

 Out=Input0;
end
else if(Select == 1'b1)begin
 Out=Input1;
end
end

endmodule