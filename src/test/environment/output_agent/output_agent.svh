class output_agent extends uvm_agent;
    `uvm_component_utils(output_agent);
    
    virtual output_interface output_i;

    uvm_sequencer #(output_item) seqr; 
    output_driver  drv;
    output_monitor mon;
    
    output_config output_config_h;
    
    function new (string name = "output_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass : output_agent



function void output_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> BUILD <--"), UVM_DEBUG);

    if(!uvm_config_db#(output_config)::get(this, "", "config", output_config_h))
        `uvm_fatal(this.get_name(), "Failed to get config object");
    
    if(!uvm_config_db#(virtual output_interface)::get(this, "", "output_interface", output_i))
        `uvm_fatal(this.get_name(), "Failed to get memory interface");
    
    if(output_config_h.get_is_active() == UVM_ACTIVE) begin
        seqr = uvm_sequencer#(output_item)::type_id::create("output_agent_seqr", this);
        drv  = output_driver::type_id::create("output_agent_driver",  this); 
        uvm_config_db#(virtual output_interface)::set(this, "output_agent_driver*", "output_interface", output_i);
    end
    
    // DEFAULT PASSIVE
    mon = output_monitor::type_id::create("output_agent_monitor",  this);
    uvm_config_db#(virtual output_interface)::set(this, "output_agent_monitor*", "output_interface", output_i);

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> BUILD <--"), UVM_DEBUG);
endfunction : build_phase

function void output_agent::connect_phase(uvm_phase phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> CONNECT <--"), UVM_DEBUG);

    if(output_config_h.get_is_active() == UVM_ACTIVE) begin
        drv.seq_item_port.connect(seqr.seq_item_export);
    end

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> CONNECT <--"), UVM_DEBUG);
endfunction : connect_phase