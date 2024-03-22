class virtual_sequence extends uvm_sequence;
    `uvm_object_utils(virtual_sequence);
    `uvm_declare_p_sequencer(virtual_sequencer);
    
    output_sequence output_seq;  
    output_item request;
    
    function new (string name = "virtual_sequence");
        super.new(name);
    endfunction : new
        
    extern task pre_body();
    extern task body();  
endclass : virtual_sequence

    
    
task virtual_sequence::pre_body();
    output_seq = output_sequence::type_id::create("output_seq");
    request = output_item::type_id::create("request");
endtask : pre_body
    
task virtual_sequence::body();
    fork
        `uvm_info(get_name(), "WE GET HERE ONCE - CORRECT!", UVM_DEBUG);
        forever begin
            `uvm_info(get_name(), "WE DON'T GET HERE!", UVM_DEBUG);
            p_sequencer.output_seqr.fifo.get(request);
            `uvm_info(get_name(), $sformatf("WE DON'T GET HERE EITHER! %s", request.convert2string()), UVM_DEBUG);
            output_seq.set_response(request.sel_en_out);
            output_seq.start(p_sequencer.output_seqr);
        end
    join_none
endtask : body
