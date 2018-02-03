/*gelen aluop a göre aritmetik ve lojik işlemlerin yapıldığı yerdir.*/
module ALU(ALUop,data1,data2,shmt,dataOut,zero);

input [31:0] data1,data2;
input [3:0]ALUop;
input [4:0]shmt;

output [31:0]dataOut;
output zero;

reg [31:0]tmp_out;
reg tmp_z;


always@(*) begin

if(ALUop==4'b0000)//add-addi-lw-sw
	tmp_out = data1+data2;
	
else if(ALUop==4'b0001)//and-andi
	tmp_out = data1 & data2;
	
else if(ALUop==4'b0010)//or-ori
	tmp_out = data1 | data2;
	
else if(ALUop==4'b0011)//sll
	tmp_out = data2 << shmt;
	
else if(ALUop==4'b0100)//srl
	tmp_out = data2 >> shmt;
	
else if(ALUop==4'b0101)//slt-slti-*sltiu
	tmp_out = (data1<data2);

else if(ALUop==4'b0110)//sub
	tmp_out = $signed(data1)-$signed(data2);

else if(ALUop==4'b1000)//bne
	tmp_out = $signed(data1)-$signed(data2);

else if(ALUop==4'b1001)//beq
	tmp_out = $signed(data1)-$signed(data2);
	
else if(ALUop==4'b1010)//*nor
	tmp_out = ~( data1 | data2 );
	
else if(ALUop==4'b1011)//xor-//xori
	tmp_out = data1 ^ data2;
end

assign zero=(tmp_out==0);
assign dataOut=tmp_out;

endmodule