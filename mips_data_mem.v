/*data ların tutulduğu memory bloğudur. sinyallerine göre yazılma işlemi
yada okunma işlemi yapılacağı belirlenir. Verinin kendisini ve verinin yazılacağı adres
bilgisini aynı zamanda sinyal durumuna göre belli adres deki datayı okuma işlemini sağlar.*/
module mips_data_mem (read_data, mem_address, write_data, sig_mem_read, sig_mem_write);
output [31:0] read_data;
input [31:0] mem_address;
input [31:0] write_data;
input sig_mem_read;
input sig_mem_write;

reg [31:0] data_mem  [255:0];
reg [31:0] read_data;

initial begin
	$readmemb("C:/Template  sources-20171218/templateForProject03_restored/data.mem", data_mem);
end

always @(mem_address or write_data or sig_mem_read or sig_mem_write) begin
	if (sig_mem_read) begin
		read_data <= data_mem[mem_address];
	end
	
	if (sig_mem_write) begin
		data_mem[mem_address] <= write_data[31:0];
		
	end
end

always@(*)begin
$writememb("C:/Template  sources-20171218/templateForProject03_restored/res_data.mem", data_mem);
end
/*integer i;
	initial begin	
		$display("Reading contents of DATA file:");
		for (i=0; i<256; i=i+1) $display("%d:%b", i, data_mem[i]);
	end
*/

endmodule