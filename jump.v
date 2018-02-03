/*jump sinyaline göre jump yada jumpregister adresşnş ayarlar.*/
module jump(Out,code,j_adress,j_rs,j_signal);
	
output reg [31:0] Out;
input [5:0]code;
input [31:0]j_adress,j_rs;
input j_signal;

always@(*)begin

if(code==6'b000010 && j_signal==1'b1)begin//j
	Out = j_adress;
end
else if(code==6'b0 && j_signal==1'b1)begin//jr
	Out = j_rs;
end
end
	
endmodule