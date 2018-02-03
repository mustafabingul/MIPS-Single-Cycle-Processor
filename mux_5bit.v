/*sinyal durumuna göre seçme işlemi yapar.*/
module mux_5bit(Out5,Input5_0,Input5_1,Select);

input[4:0]Input5_0,Input5_1;
output [4:0]Out5;
input Select;

assign Out5=Select?Input5_1:Input5_0;

endmodule