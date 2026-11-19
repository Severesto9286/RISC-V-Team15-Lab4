module pc_mux (
    input  logic [31:0]              pc,
    input  logic [31:0]              immop,
    input  logic                     pc_src,
    output logic [31:0]              next_pc
);


    logic [31:0] branch_pc;
    logic [31:0] inc_pc;

    assign branch_pc = pc + immop;
    
    assign inc_pc = pc + 32'd4;
    
    assign next_pc = (pc_src) ? branch_pc : inc_pc;

endmodule


module pc_reg (
    input  logic                     clk,
    input  logic                     rst,
    input  logic [31:0]              next_pc,
    output logic [31:0]              pc
);

    always_ff @(posedge clk) begin
        if (rst) 
            pc <= 32'd0;
        else
            pc <= next_pc;
    end

endmodule
