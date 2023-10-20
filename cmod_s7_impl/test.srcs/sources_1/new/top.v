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
    input [1:0] btn,
    output [3:0] led,
    input uart_rx,
    output uart_tx
);
  // INTO THE UART, SO OUT FOR US
  wire [7:0] dout_uart;
  wire dout_vld;
  wire dout_rdy;
  // FROM THE UART, SO IN FOR US
  wire [7:0] din_uart;
  wire din_vld;
  
  uart #(
      .CLK_FREQ(12_000_000),
      .BAUD_RATE(115200)
  )  uart1 (
      // Basic
      .clk (clk),
      .rst (!btn[0]),
      // Ports
      .uart_txd (uart_tx),
      .uart_rxd (uart_rx),
      // Input
      .din(dout_uart),
      .din_vld(dout_vld),
      .din_rdy(dout_rdy),
      // Output
      .dout(din_uart),
      .dout_vld(din_vld)
  );

  wire clock_out;
  // Instantiate the Unit Under Test (UUT)
  // Test the clock divider in Verilog
  Clock_divider #(
      .DIVISOR(12_000)
  ) uut (
      .clock_in (clk),
      .clock_out(clock_out)
  );

  wire [7:0] myreg;
  wire out_en;
  system m_system (
      .clk(clock_out),
      .resetn(!btn[0]),
      //.trap (led[3]),
      .out_byte(myreg),
      .out_byte_en(out_en),
      // Output
      .uart_dout(dout_uart),
      .uart_dout_vld(dout_vld),
      .uart_dout_rdy(dout_rdy),
      // Input
      .uart_din(din_uart),
      .uart_din_vld(din_vld)
  );

  assign led[3:0] = myreg[3:0];
endmodule
