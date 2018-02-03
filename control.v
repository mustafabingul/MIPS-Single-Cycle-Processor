/*gelen opcode ve functioncoduna göre data path de kullanılacak sinyaleri üretir.*/
module control(
OP_code,
FUNC_code,
signal_Branch,
ALU_op,
RegWrite,
ALUSrc,
RegDest,
MemtoReg,
MemRead,
MemWrite,
Jump);

input [5:0]OP_code,FUNC_code;

output [3:0] ALU_op;
output RegWrite,ALUSrc,RegDest,MemtoReg,MemRead,MemWrite,Jump,signal_Branch;

reg [3:0]tmp_ALUop;

assign RegWrite = (OP_code != 6'b101011)&& 	
						(OP_code != 6'b101000)&&	
						(OP_code != 6'b000100)&&	
						(OP_code != 6'b000101)&&	
						(OP_code != 6'b000010)&&	
						(!((OP_code==6'd0) &&  (FUNC_code==6'b001000)));	//sw-//sb-//beq-//bne-//j-//jr

assign ALUSrc = (OP_code!=6'b000000)&&
					 (OP_code!=6'b000100)&&
					 (OP_code!=6'b000101);
assign RegDest = (OP_code==6'b000000);
assign MemtoReg = (OP_code==6'b100011)||	
						(OP_code==6'b100000);	//lw-//lb;

assign MemRead = (OP_code==6'b100011)||	
						(OP_code==6'b100000);	//lw-//lb
						
assign MemWrite = (OP_code==6'b101011)|| 	
						(OP_code==6'b101000); 	//sw-//sb
						
assign signal_Branch = (OP_code == 6'b000100)||	
					 (OP_code == 6'b000101);		//beq-//bne;
assign Jump = (OP_code==6'b000010)||
				  (OP_code==6'b000011);				//j-//jal

					 
					 
always @(*) begin

if((OP_code==6'b0 && FUNC_code==6'b100000)|| 
	(OP_code==6'b001000)||		
	(OP_code == 6'b101011)||
	(OP_code==6'b100011)||(OP_code==6'b001001))	//add-//addi-//sw-//lw-//*addiu
	tmp_ALUop=4'b0000;//0
	
else if((OP_code==6'b0 && FUNC_code==6'b100100)||	
		  (OP_code==6'b001100))		//and-//andi
	tmp_ALUop=4'b0001;//1
	
else if((OP_code==6'b0 && FUNC_code==6'b100101)||
			(OP_code==6'b001101))	//or-//ori
	tmp_ALUop=4'b0010;//2
	
else if((OP_code==6'b0 && FUNC_code==6'b0))//sll
	tmp_ALUop=4'b0011;//3
	
else if((OP_code==6'b0 && FUNC_code==6'b000010))//srl
	tmp_ALUop=4'b0100;//4
	
else if((OP_code==6'b0 && FUNC_code==6'b101010)||
		  (OP_code==6'b001010)||(OP_code==6'b001011))//slt-//slti-//*sltiu
	tmp_ALUop=4'b0101;//5
	
else if((OP_code==6'b0 && FUNC_code==6'b100010)||
		  (OP_code==6'b0 && FUNC_code==6'b100011))//sub-//*subu
	tmp_ALUop=4'b0110;//6
	
else if(OP_code==6'b000101)//bne
	tmp_ALUop=4'b1000;//8
	
else if(OP_code==6'b000100)//beq
	tmp_ALUop=4'b1001;//9

else if(FUNC_code==6'b100111)//*nor
	tmp_ALUop=4'b1010;//10
	
else if((OP_code==6'b0 && FUNC_code==6'b100110)||
		  (OP_code==6'b001110))//*xor-//*xori
	tmp_ALUop=4'b1011;//11
end

assign ALU_op=tmp_ALUop;

endmodule