class virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(virtual_sequencer);
  
  output_sequencer output_seqr;
  
  function new (string name = "virtual_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
endclass : virtual_sequencer