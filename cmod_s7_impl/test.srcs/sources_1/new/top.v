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
    output uart_tx,
    output led0_b,
    output led0_g,
    output led0_r
);
  
  // INTO THE UART, SO OUT FOR US
  wire [7:0] dout_uart;
  reg dout_vld;
  wire dout_rdy;
  // FROM THE UART, SO IN FOR US
  wire [7:0] din_uart;
  reg [7:0] din_uart_reg;
  wire din_vld;
  `define IRQ_UART 4
  uart #(
      .CLK_FREQ(12_000_000),
      .BAUD_RATE(115200)
  )  uart1 (
      // Basic
      .CLK (clk),
      .RST (btn[0]),
      // Ports
      .UART_TXD (uart_tx),
      .UART_RXD (uart_rx),
      // Input for the module, output for us
      .DIN(dout_uart),
      .DIN_VLD(dout_vld),
      .DIN_RDY(dout_rdy),
      // Output for the module, input for us
      .DOUT(din_uart),
      .DOUT_VLD(din_vld)
  );

  wire clock_out;
  // Instantiate the Unit Under Test (UUT)
  // Test the clock divider in Verilog
  Clock_divider #(
      .DIVISOR(12)
  ) uut (
      .clock_in (clk),
      .clock_out(clock_out)
  );
  

  wire [7:0] myreg;
  wire out_en;
  wire uart_dout_ctr;
  wire [31:0] irq;
  wire [31:0] eoi;
  system m_system (
      .clk(clock_out),
      .resetn(!btn[0]),
      //.trap (led[3]),
      .out_byte(myreg),
      .out_byte_en(out_en),
      .external_read(external_read),
      // Output
      .uart_dout(dout_uart),
      .uart_dout_ctr(uart_dout_ctr),
      .uart_dout_rdy(dout_rdy),
      // Input
      .uart_din(din_uart_reg),
      .uart_din_vld(din_vld),
      // IRQ
	  .irq         (irq),
      .eoi         (eoi)
  );
  
  //Rising edge detector stores
  reg uart_dout_ctr_dly;
  reg dout_rdy_dly;
  // Rising edge detector logic
  assign uart_dout_ctr_pos = uart_dout_ctr && !uart_dout_ctr_dly;
  assign dout_rdy_neg = !dout_rdy && dout_rdy_dly;
  // Single triggering of UART communication logic.
  always @(posedge clk) begin
    // Rising edge detector delayers  
    uart_dout_ctr_dly <= uart_dout_ctr;
    dout_rdy_dly <= dout_rdy;
    // When CPU wants to transmit, we set dout_vld to start a transmission.
    // After we wait until dout_rdy goes negative to stop the signal.
    // This is done to accomodate 2 clock domains working.
    // MUST be done within one logic block, this tells the compiler that
    // it is one single state machine that we want to control.
    if (uart_dout_ctr_pos) begin
        dout_vld <= 1;
    end else if (dout_rdy_neg) begin
        dout_vld <= 0;
    end else if (btn[0]) begin
        dout_vld <= 0;
    end
  end
  
  // This module shall be at least 1 CPU clock cycle high to assert the IRQ
  // Rising edge detector and keeper, for the UART reception to comply with IRQ
  reg uart_datain_interruption_ctr;
  reg uart_datain_interruption_rq;
  reg [1:0] uart_datain_interruption_inter;
  reg din_vld_old;
  always @(posedge clk) begin
    // First accept the reset
    if (btn[0]) begin
        uart_datain_interruption_ctr <= 0;
        uart_datain_interruption_inter <= 0;
        uart_datain_interruption_rq <= 0;
    // Will trigger when data is received
    end else if (din_vld && !din_vld_old && !eoi[`IRQ_UART] && !uart_datain_interruption_rq) begin
        uart_datain_interruption_ctr <= 1; 
        uart_datain_interruption_inter <= 1;
        uart_datain_interruption_rq <= 1;
    // Will wait until next LOW of CPU clock, will set IRQ and keep it HIGH until a full clock cycle.
    end else if (!clock_out && uart_datain_interruption_inter == 1) begin
        uart_datain_interruption_inter <= 2;
    end else if (clock_out & uart_datain_interruption_inter == 2) begin
        uart_datain_interruption_inter <= 3;
    end else if (!clock_out & uart_datain_interruption_inter == 3) begin
        uart_datain_interruption_inter <= 0;
        uart_datain_interruption_ctr <= 0;
    end else if (eoi[`IRQ_UART] && uart_datain_interruption_rq) begin
        uart_datain_interruption_rq <= 0;
    end
    din_vld_old = din_vld;
  end
  
  always @(posedge din_vld) begin
    din_uart_reg <= din_uart;
  end
  
  // Set all the IRQ signals, to 0 to prevent them from activating
  assign irq[31:`IRQ_UART+1] = {1'b0};
  // Signal 4 is set to IRQ_UAR
  assign irq[`IRQ_UART] = uart_datain_interruption_ctr;
  assign irq[`IRQ_UART-1:0] = {1'b0};
  
  assign led[3:0] = {din_vld, dout_vld, uart_datain_interruption_ctr, |eoi};
  
  // Just turn off leds
  assign led0_b = 1'b1;
  assign led0_g = 1'b1;
  assign led0_r = 1'b1;
endmodule
