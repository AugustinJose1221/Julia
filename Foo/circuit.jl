using ACME
using Plots
circ = @circuit begin
    j_in = voltagesource()
    r1 = resistor(1e3)
    c1 = capacitor(47e-9)
    d1 = diode(is=1e-15)
    d2 = diode(is=1.8e-15)
    j_out = voltageprobe()
    j_in[+] ⟷ r1[1]
    j_in[-] ⟷ gnd
    r1[2] ⟷ c1[1] ⟷ d1[+] ⟷ d2[-] ⟷ j_out[+]
    gnd ⟷ c1[2] ⟷ d1[-] ⟷ d2[+] ⟷ j_out[-]
end

circ = @circuit begin
    j_in = voltagesource(), [-] ⟷ gnd
    r1 = resistor(1e3), [1] ⟷ j_in[+]
    c1 = capacitor(47e-9), [1] ⟷ r1[2], [2] ⟷ gnd
    d1 = diode(is=1e-15), [+] ⟷ r1[2], [-] ⟷ gnd
    d2 = diode(is=1.8e-15), [+] ⟷ gnd, [-] ⟷ r1[2]
    j_out = voltageprobe(), [+] ⟷ r1[2], [-] ⟷ gnd
end
model = DiscreteModel(circ, 1/44100)
y = run!(model, [sin(2π*1000/44100*n) for c in 1:1, n in 0:44099])
plot(y)
