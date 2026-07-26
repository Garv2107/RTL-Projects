`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 23.07.2026 15:56:24
// Name: Garv Patel
// Module Name: baud_rate_gen
// Project Name: UART Baud tick Generation
//////////////////////////////////////////////////////////////////////////////////


module baud_rate_gen#(parameter CLK_FREQ = 50000000,
                       parameter BAUD_RATE = 9600)(
    input clk,
    input rst,
    input sync_restart,
    output reg baud_tick
    );
    
    localparam BAUD_DIV = CLK_FREQ/BAUD_RATE;
    reg [31:0]counter;
    reg first_tick;

        always@(posedge clk or posedge rst)begin
            if(rst)begin
                counter <= 0;
                baud_tick <= 0;
                first_tick <= 1;
            end
            else if(sync_restart)begin
                counter <= 0;
                baud_tick <= 0;
                first_tick <= 1;
            end
            else begin
                if((first_tick && counter == (BAUD_DIV/2 - 1)) || (!first_tick && counter == BAUD_DIV - 1))begin
                    counter <= 0;
                    baud_tick <= 1;
                    first_tick <= 0;
                end
                else begin
                    baud_tick <= 0;
                    counter <= counter + 1;
                end
            end
        end
endmodule
