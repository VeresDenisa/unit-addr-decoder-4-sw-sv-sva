class output_item extends uvm_sequence_item;
  `uvm_object_utils(output_item);
  
    rand bit [7:0] rd_data_in;
         bit [4:0] ack_in;

    bit [4:0] sel_en_out;
    bit       wr_rd_s_out;
    bit [7:0] addr_out;
    bit [7:0] wr_data_out;
       
  function new(string name = "output_item");
    super.new(name);
  endfunction : new
endclass : output_item