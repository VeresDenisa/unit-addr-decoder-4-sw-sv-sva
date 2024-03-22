class output_sequencer extends uvm_sequencer #(output_item);
  `uvm_component_utils(output_sequencer);
  
  uvm_analysis_export   #(output_item) export_port;
  uvm_tlm_analysis_fifo #(output_item) fifo;
  
  function new (string name = "output_sequencer", uvm_component parent = null);
    super.new(name, parent);
    
    export_port = new("export_port", this);    
    fifo        = new("fifo",        this);
  endfunction : new
  
  extern function void connect_phase(uvm_phase phase);
endclass : output_sequencer
    
    
function void output_sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  export_port.connect(fifo.analysis_export);
endfunction :connect_phase