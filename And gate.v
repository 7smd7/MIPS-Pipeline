module AndGate(Branch, Zero, AndGateOut);
    input Branch;
    input Zero;
    output reg AndGateOut;
    always @(Branch,Zero) begin
        AndGateOut = Branch && Zero;
    end
endmodule