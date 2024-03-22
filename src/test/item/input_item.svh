class input_item extends uvm_sequence_item;
  `uvm_object_utils(input_item);
  
    rand bit       enable_in;
    rand bit       wr_rd_op;
    rand bit       valid_in;
    rand bit [7:0] addr_in;
    rand bit [7:0] op_id_in;
    rand bit [7:0] wr_data_in;

    bit       ready_out;
    bit [7:0] rd_data_out;
    bit [7:0] done_op_id;
       
  function new(string name = "input_item");
    super.new(name);
  endfunction : new
endclass : input_item