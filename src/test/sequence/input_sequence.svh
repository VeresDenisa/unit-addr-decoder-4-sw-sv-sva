class input_sequence extends uvm_sequence #(input_item);
    `uvm_object_utils(input_sequence)
    
    input_item item;
    
    function new (string name = "input_sequence");
        super.new(name);
    endfunction : new

    extern task body();
endclass : input_sequence


task input_sequence::body();
    item = input_item::type_id::create("input_item");
    start_item(item);
    assert(item.randomize());
    finish_item(item);
endtask : body
