class output_driver extends uvm_driver #(output_item);
    `uvm_component_utils(output_driver);

    virtual output_interface output_i;

    output_item item;

    function new (string name = "output_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new 

    extern function void build_phase (uvm_phase phase);
    extern task reset_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
endclass : output_driver



function void output_driver::build_phase (uvm_phase phase);
    super.build_phase(phase);  
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> BUILD <--"), UVM_DEBUG);

    if(!uvm_config_db#(virtual output_interface)::get(this, "", "output_interface", output_i))
        `uvm_fatal(this.get_name(), "Failed to get reset interface");

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> BUILD <--"), UVM_DEBUG);
endfunction : build_phase

task output_driver::reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> RESET <--"), UVM_DEBUG);
    
    phase.raise_objection(this);

    output_i.rd_data_in  <= 8'h00;
    output_i.ack_in      <= 5'd0;
    output_i.sel_en_out  <= 5'd0;
    output_i.wr_rd_s_out <= 1'b0;
    output_i.addr_out    <= 8'h00;
    output_i.wr_data_out <= 8'h00;

    phase.drop_objection(this);

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> RESET <--"), UVM_DEBUG);
    endtask : reset_phase

task output_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);  
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> MAIN <--"), UVM_DEBUG);

    forever begin : send_loop
        seq_item_port.get_next_item(item);
        
        output_i.send(item);
        `uvm_info(get_name(), $sformatf("Drive: %s", item.convert2string), UVM_LOW);
        
        seq_item_port.item_done();
    end : send_loop
    
    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> MAIN <--"), UVM_DEBUG);
endtask : main_phase