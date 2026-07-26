`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Create Date: 23.07.2026 16:09:27
// Name: Garv Patel
// Module Name: UART_tx
// Project Name:UART Transmittor
//////////////////////////////////////////////////////////////////////////////////


module UART_tx(
    input clk,
    input rst,
    input baud_tick,
    input tx_start,
    input [7:0]data_in,
    output reg tx,
    output reg busy,
    output reg done
    );
    
    reg [7:0]shift_reg;
    reg [2:0]counter;
    
    reg [1:0]state;
    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;
    
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            state <= IDLE;
            tx <= 1;
            busy <= 0;
            done <= 0;
            counter <= 0;
            shift_reg <= 0;
         end
         
         else begin
         case(state)
            IDLE:begin
                tx <= 1;
                busy <= 0;
                done <= 0;
                
                if(tx_start)begin
                    shift_reg <= data_in;
                    counter <= 0;
                    busy <= 1;
                    state <= START;
                end
            end
            
            START:begin
                tx <= 0;
                
                if(baud_tick) begin
                    state <= DATA;
                end
            end
            
            DATA:begin
               if (baud_tick) begin
                    tx <= shift_reg[counter];
                    if (counter == 7) begin
                        counter <= 0;
                        state <= STOP;
                     end
                    else begin
                        counter <= counter + 1;
                    end
                end 
            end
            
            STOP:begin
                tx <= 1;
                if(baud_tick)begin
                    done <= 1;
                    state <= IDLE;
                end
            end
        endcase
        end
    end
endmodule