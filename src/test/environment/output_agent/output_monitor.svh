class output_monitor extends uvm_monitor;
    `uvm_component_utils(output_monitor)
    
    virtual output_interface output_i;
    
    uvm_analysis_port #(output_item) an_port;
    
    output_item item;
    
    function new (string name = "output_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new
    
    extern function void build_phase (uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass : output_monitor



function void output_monitor::build_phase (uvm_phase phase);
    super.build_phase(phase);  
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> BUILD <--"), UVM_DEBUG);
    
    item = new("output_item");
    an_port = new("mon_an_port", this);
    
    if(!uvm_config_db#(virtual output_interface)::get(this, "", "output_interface", output_i))
        `uvm_fatal(this.get_name(), "Failed to get memory interface");  

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> BUILD <--"), UVM_DEBUG); 
endfunction : build_phase

task output_monitor::run_phase(uvm_phase phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> RUN <--"), UVM_DEBUG);

    forever begin : forever_monitor
        @(output_i.monitor);
        output_i.receive(item);
        `uvm_info(get_name(), $sformatf("Monitore: %s", item.convert2string), UVM_MEDIUM);
        an_port.write(item);
    end : forever_monitor
    
    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> RUN <--"), UVM_DEBUG);
endtask : run_phase
