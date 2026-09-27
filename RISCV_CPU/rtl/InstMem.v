module instruction_memory (
    input wire [31:0] address,
    output wire [31:0] instruction
);

    // 4 KB INSTRUCTION MEMORY (1024 words × 32 bits = 4096 bytes)
    reg [31:0] memory [0:1023];

    initial begin
        $readmemh("sample_program_1.hex", memory);
    end
    assign instruction = memory[address[11:2]];

endmodule