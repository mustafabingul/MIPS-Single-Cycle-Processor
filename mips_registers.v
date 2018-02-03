/*registerdan data okunmak ve yazmak için kullanılan modüldür. read_data_1 ve
read_data_2 ile data okunur, write_data veri yazmak içindir. read_reg_1 ve
read_reg_2 verilerin adresini ifade eder. signal_reg_write register a yazma
işleminin yapılıp yapılmayacağını belirler.*/
module mips_registers
(
	output reg [31:0] read_data_1, read_data_2,
	input [31:0] write_data,
	input [4:0] read_reg_1, read_reg_2, write_reg,
	input signal_reg_write, clk
);
	reg [31:0] registers [31:0];
	
	//1 kere okunuyor. 
	//diğer işlemler register file üstünde yapılıyor.
	initial begin
		$readmemb("C:/Template  sources-20171218/templateForProject03_restored/registers.mem", registers);
	end
	always@(*)begin
		read_data_1 = registers[read_reg_1];
		read_data_2 = registers[read_reg_2];
	end
	
	//combinational block use always @*, assign, = 
	//sequential blocks use always@(posedge clk), <=
	// <= nonblocking, = blocking
	always @(posedge clk) //for combinational 
	//	or always @ (posedge clk) //for sequential
	begin
		if (signal_reg_write) begin
			registers[write_reg] <= write_data;
			
		end
		
	end
	
always@(*)begin
$writememb("C:/Template  sources-20171218/templateForProject03_restored/res_registers.mem", registers);
end
	
	
/*integer i;
	initial begin	
		$display("Reading contents of memory file:");
		for (i=0; i<32; i=i+1) $display("%d:%b", i, registers[i]);
	end	
*/
endmodule