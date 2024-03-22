import uvm_pkg::*;
`include "uvm_macros.svh"
 
import test_pack::*;

module testbench;  
    bit clk;
    bit rst_n;
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    input_interface  input_i(clk);
    output_interface output_i(clk);
    
    addr_decoder_top DUT(
        .clk(clk),
        .rst_n(input_i.rst_n),

        .enable_in(input_i.enable_in),
        .wr_rd_op(input_i.wr_rd_op),
        .valid_in(input_i.valid_in),
        .addr_in(input_i.addr_in), 
        .op_id_in(input_i.op_id_in),
        .wr_data_in(input_i.wr_data_in),
        .rd_data_in(output_i.rd_data_in),
        .ack_in(output_i.ack_in),

        .ready_out(input_i.ready_out),
        .rd_data_out(input_i.rd_data_out),
        .done_op_id(input_i.done_op_id),

        .sel_en_out(output_i.sel_en_out),
        .wr_rd_s_out(output_i.wr_rd_s_out),
        .addr_out(output_i.addr_out),
        .wr_data_out(output_i.wr_data_out)
    );
    
    initial begin
        uvm_config_db#(virtual input_interface):: set(null, "uvm_test_top.env.input_agent*",  "input_interface",  input_i);
        uvm_config_db#(virtual output_interface)::set(null, "uvm_test_top.env.output_agent*", "output_interface", output_i);
    end
    
    initial begin
        run_test();
    end
    
    initial begin 
        $dumpfile("dump.vcd"); $dumpvars;
    end
endmodule : testbench