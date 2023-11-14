`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 07:24:21 PM
// Design Name: 
// Module Name: selector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module selector #(
    parameter [31:0]  MEM_MIN = 32'h ffff_ffff,
    parameter [31:0]  MEM_MAX = 32'h ffff_ffff
) (
    // Input from memory
    input     [31:0]  mem_la_addr,
    // Output
    output            enable
);
    assert (MEM_MIN <= MEM_MAX);
    assign enable = mem_la_addr >= MEM_MIN && mem_la_addr <= MEM_MAX;
endmodule
