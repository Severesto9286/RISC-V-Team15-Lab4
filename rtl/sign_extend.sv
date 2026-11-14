module sign_extend(
    input logic [31:0]      instr,
    input logic             immsrc,
    output logic[31:0]      ext_im
);

always_comb begin
    case (immsrc)
        1: imm = instruction[31:20]
        2: imm = {instruc[31],instruc[7],instr[30:25],instr[11:8]} 
    ext_im = {{20{imm[11]}},imm};
end
    

endmodule
