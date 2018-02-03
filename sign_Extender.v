/*16 bitlik datayı 32 bite genişletir.*/
module sign_Extender(imm32 , imm16);

input [15:0] imm16;
output [31:0] imm32;

assign imm32={{16{imm16[15]}},imm16};

endmodule