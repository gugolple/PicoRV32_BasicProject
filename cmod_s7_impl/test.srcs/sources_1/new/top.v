`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2023 06:31:26 AM
// Design Name: 
// Module Name: top
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

module Clock_divider (
    clock_in,
    clock_out
);
    input clock_in;  // input clock on FPGA
    output reg clock_out;  // output clock after dividing the input clock by divisor
    reg [27:0] counter = 28'd0;
    parameter DIVISOR = 28'd2;
    // The frequency of the output clk_out
    //  = The frequency of the input clk_in divided by DIVISOR
    // For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
    // You will modify the DIVISOR parameter value to 28'd50.000.000
    // Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
    always @(posedge clock_in) begin
        counter <= counter + 28'd1;
        if (counter >= (DIVISOR - 1)) counter <= 28'd0;
        clock_out <= (counter < DIVISOR / 2) ? 1'b1 : 1'b0;
    end
endmodule

module top (
    input clk,
    input btn0,
    input btn1,
    output led0,
    output led1,
    output led2,
    output led3, 
    input uart_rx,
    output uart_tx,
    output led0_b,
    output led0_g,
    output led0_r
);
    // Clock divider
    wire clock_out;
    Clock_divider #(
        .DIVISOR(12)
    ) clock_divider_cpu (
        .clock_in (clk),
        .clock_out(clock_out)
    );
    
    // Main system
    wire [7:0] myreg;
    wire out_en;
    wire uart_dout_ctr;
    wire [31:0] irq;
    wire [31:0] eoi;
    wire [6:0] led_vect;
    system m_system (
        .sys_clk(clk),
        .clk(clock_out),
        .resetn(!btn0),
        .out_byte(myreg),
        .out_byte_en(out_en),
        .external_read(external_read),
        // Uart module
        .uart_in(uart_rx),
        .uart_out(uart_tx),
        // Led output
        .led_vect(led_vect)
    );
    
    assign {led3,led2,led1,led0} = led_vect[3:0];
    
    // Just turn off leds
    assign led0_b = !led_vect[4];
    assign led0_g = !led_vect[5];
    assign led0_r = !led_vect[6];
endmodule
