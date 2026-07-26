`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Create Date: 24.07.2026 17:26:31
// Name: Garv Patel
// Module Name: UART_rx
// Project Name: UART Receiver
//////////////////////////////////////////////////////////////////////////////////


module UART_rx(
    input clk,
    input rst,
    input baud_tick,
    input rx,
    output reg [7:0]data_out,
    output reg rx_done,
    output reg busy,
    output reg start_edge
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
            busy <= 0;
            rx_done <= 0;
            counter <= 0;
            data_out <= 0;
            shift_reg <= 0;
            start_edge <= 0;
        end
    else begin
    rx_done <= 0;
    start_edge <= 0;
    case(state)
        IDLE:begin
    
            busy <= 0;
            if(rx == 0)begin
                busy <= 1;
                counter <= 0;
                state <= START;
                start_edge <= 1;
            end
        end
        
        START:begin
            if(baud_tick)begin
                if(rx == 0)begin
                    state <= DATA;
                    counter <= 0;
                    shift_reg <= 0;
                end
                else begin
                    state <= IDLE; 
                    busy <= 0;   
                end
            end
        end
        
        DATA:begin
            if(baud_tick)begin
                shift_reg[counter] <= rx;
                
                if(counter == 7)begin
                    state <= STOP;
                    counter <= 0;
                end
                else begin
                    counter <= counter + 1;
                end
            end
        end
        
        STOP:begin
            if(baud_tick)begin
                if(rx == 1)begin
                    data_out <= shift_reg;
                    rx_done <= 1;
                end
                
                busy <= 0;
                state <= IDLE;
            end
        end   
     endcase
     end
     end
endmodule