//////////////////////////////////////////////////////////////////////////////////
// Name: Garv Patel
// Create Date: 22.07.2026 16:18:39
// Design Name: Asynchronous FIFO
// Module Name: asyn_FIFO: 
//////////////////////////////////////////////////////////////////////////////////


module asyn_FIFO#(parameter DATA_WIDTH = 8,
                  parameter DEPTH = 64,
                  parameter ADDR_WIDTH = 6)(
    input wr_en,
    input rd_en,
    input [DATA_WIDTH - 1:0]data_in,
    output reg [DATA_WIDTH - 1:0]data_out,
    input wr_clk,
    input rd_clk,
    output full,
    output empty,
    input rst
    );
    
    // Binary pointers (ADDR_WIDTH bits + 1 wrap bit)
    reg [ADDR_WIDTH:0]wr_ptr_bin; //Binary Write Pointer 
    wire[ADDR_WIDTH:0]wr_ptr_gry; //Gray Write Pointer
    
    reg [ADDR_WIDTH:0]rd_ptr_bin; //Binary Read Pointer
    wire [ADDR_WIDTH:0]rd_ptr_gry; //Gray Read Pointer
    
    reg [DATA_WIDTH - 1:0]mem[DEPTH - 1:0];
    
    reg [ADDR_WIDTH:0]wr_ptr_gry_syn1;
    reg [ADDR_WIDTH:0]wr_ptr_gry_syn2;
    
    reg [ADDR_WIDTH:0]rd_ptr_gry_syn1;
    reg [ADDR_WIDTH:0]rd_ptr_gry_syn2;
    
    always@(posedge wr_clk or posedge rst)begin  //WRITE Logic
        if(rst)
            wr_ptr_bin <= 0;
         else begin
            if(wr_en && !full)begin
                mem[wr_ptr_bin[ADDR_WIDTH - 1:0]] <= data_in;
                wr_ptr_bin <= wr_ptr_bin + 1; 
            end
         end   
    end
    
    always@(posedge rd_clk or posedge rst)begin  //READ Logic
        if(rst)begin
            rd_ptr_bin <= 0;
            data_out <=0;
        end
        else begin
            if(rd_en && !empty)begin
                data_out <= mem[rd_ptr_bin[ADDR_WIDTH - 1:0]];
                rd_ptr_bin <= rd_ptr_bin + 1;
            end
        end
    end
     assign wr_ptr_gry = (wr_ptr_bin >> 1) ^ wr_ptr_bin;
     assign rd_ptr_gry = (rd_ptr_bin >> 1) ^ rd_ptr_bin;
     
    //First Synchronizer  Write - Read Sync
     always@(posedge rd_clk or posedge rst)begin
        if(rst)begin
            wr_ptr_gry_syn1 <= 0;
            wr_ptr_gry_syn2 <= 0; 
        end
        else begin
            wr_ptr_gry_syn1 <= wr_ptr_gry;
            wr_ptr_gry_syn2 <= wr_ptr_gry_syn1;
        end
     end
     
     //Second Synchronizer  Read - Write Sync
     always@(posedge wr_clk or posedge rst)begin
        if(rst)begin
            rd_ptr_gry_syn1 <= 0;
            rd_ptr_gry_syn2 <= 0; 
        end
        else begin
            rd_ptr_gry_syn1 <= rd_ptr_gry;
            rd_ptr_gry_syn2 <= rd_ptr_gry_syn1;
        end
     end
     
     // Gray Code Conversion
     assign empty = (rd_ptr_gry == wr_ptr_gry_syn2);
     assign full = (wr_ptr_gry == {~rd_ptr_gry_syn2[ADDR_WIDTH:ADDR_WIDTH - 1],rd_ptr_gry_syn2[ADDR_WIDTH - 2:0]});
endmodule
