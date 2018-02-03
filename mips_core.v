/*clock durumuna göre çalışır. 1/0 herşeyin çalıştığı ana yerdir.*/
module mips_core(clock);
input clock;

//wire [31:0] PC;
wire [31:0] instruction;

//wire s_Jump,s_RegWrite,s_ALUSrc,s_RegDst,s_MemtoReg,s_MemRead,s_MemWrite,s_Branch;

//just focus on build mips design 
//////////////////////Read&write example///////////////////////////////////
wire [31:0]read_data_1,read_data_2;
wire [4:0] write_reg, read_reg_1, read_reg_2,tmp_write_reg;
wire [5:0] OP_code;
wire [5:0] FUNC_code;
wire [3:0] ALU_op;
wire signal_Branch,RegWrite,ALUSrc,RegDest,MemtoReg,MemRead,MemWrite,Jump;
wire [4:0] shiftAmount;
wire [15:0] immValue16;
wire [31:0] immValue32;
wire [31:0] tmp_alu_Input;
wire m_zero;
wire [31:0] tmp_write_data;
wire [31:0] tmp_read_data_from_mem;
wire [31:0] shifted2PC;
wire [31:0] PC4;
wire Branch_z_Res;
wire [31:0] tmpPC;
wire [31:0] tmpPC1;
wire [31:0] tmpPC2;

wire [31:0] jump_address;
wire [31:0] j_RA;
//********************************************
assign read_reg_1 = instruction[25:21];		//rs
assign  read_reg_2 = instruction[20:16]; 		//rt
assign  write_reg = instruction[15:11];  		//rd

assign OP_code=instruction[31:26];		//opcode
assign FUNC_code=instruction[5:0];		//funccode
assign shiftAmount=instruction[10:6];	//shmt
assign immValue16=instruction[15:0];		//immValue

//assign write_data = 32'b0;
reg [31:0]PC= 32'b0;			//REG idi**************
reg [31:0] write_data;
mips_instr_mem instructionmem(instruction, PC);

control control1(OP_code,FUNC_code,signal_Branch,ALU_op,RegWrite,ALUSrc,RegDest,MemtoReg,MemRead,MemWrite,Jump);

mux_5bit mux1(tmp_write_reg,read_reg_2,write_reg,RegDest);		//rt or rd

sign_Extender sign1(immValue32,immValue16);

mips_registers register1(read_data_1,read_data_2,write_data,read_reg_1,read_reg_2,tmp_write_reg,RegWrite,clock);////////-----****

mux_32bit mux2(tmp_alu_Input,read_data_2,immValue32,ALUSrc);		//rt or signextend

ALU alu1(ALU_op,read_data_1,tmp_alu_Input,shiftAmount,tmp_write_data,m_zero);

mips_data_mem data1(tmp_read_data_from_mem,tmp_write_data,read_data_2,MemRead,MemWrite);

//mux_32bit mux3(write_data,tmp_write_data,tmp_read_data_from_mem,MemtoReg);////////----*****
always@(*) begin
if(MemtoReg == 1'b1) begin
write_data = tmp_read_data_from_mem;
end
else if(MemtoReg == 1'b0) begin
write_data = tmp_write_data;
end
end

and(Branch_z_Res,m_zero,signal_Branch);

assign PC4 = PC+1;
assign jump_address={PC4[31:28],instruction[25:0],2'b0};
assign j_RA=read_data_1;
assign shifted2PC = PC+1+immValue32;

mux_32bit muxJump(tmpPC1,PC4,shifted2PC,Branch_z_Res);

jump jumpBlock(tmpPC2,OP_code,jump_address,j_RA,Jump);

mux_32bit jMUX(tmpPC,tmpPC1,tmpPC2,Jump);

always@(posedge clock)begin
PC=tmpPC;
end

/*
initial begin
$monitor("OUT %32b  i0  %32b   i1  %32b   SELect %b",write_data,tmp_write_data,tmp_read_data_from_mem,MemtoReg);
end*/
initial begin
$monitor("/INSTRUCTION: %32b/OP_code %6b/FUNC_code %6b/Branch %b/ALU_op %4b/RegWrite %b/ALUSrc %b/RegDest %b/MemtoReg %b/MemRead %b/MemWrite %b/Jump %b/ -RS: %32b/RT: %32b/RD adress: %5b/RESULT %32b",instruction,OP_code,FUNC_code,signal_Branch,ALU_op,RegWrite,ALUSrc,RegDest,MemtoReg,MemRead,MemWrite,Jump,read_data_1,read_data_2,write_reg,write_data);
end


endmodule