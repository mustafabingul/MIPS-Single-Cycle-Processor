/*instructionların okunduğu modüldür. program_counter e göre instruction ı ayarlar.*/
module mips_instr_mem(instruction, program_counter);
input [31:0] program_counter;
output [31:0] instruction;

reg [31:0] instr_mem [255:0];

initial begin
	$readmemb("C:/Template  sources-20171218/templateForProject03_restored/instruction.mem", instr_mem);
end

assign instruction = instr_mem[program_counter];

endmodule