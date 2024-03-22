class output_sequence extends uvm_sequence #(output_item);
    `uvm_object_utils(output_sequence)
    
    output_item item;
    bit [4:0] ack_in = 5'h00;
    
    function new (string name = "output_sequence");
        super.new(name);
    endfunction : new

    extern task body();
    extern function void set_response(bit [4:0] ack_in = 5'h00);
endclass : output_sequence


    
function void output_sequence::set_response(bit [4:0] ack_in = 5'h00);
    this.ack_in  = ack_in;
endfunction : set_response

task output_sequence::body();
    item = output_item::type_id::create("output_item");
    start_item(item);
    assert(item.randomize());
    item.ack_in = ack_in;
    `uvm_info(get_name(), $sformatf("Create: %s", item.convert2string), UVM_FULL);
    finish_item(item);
endtask : body
