if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2023.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/aoreil02/Documents/GitHub/JumboDash"
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- FinalProject_impl_1_cpe.ldc
run_engine_newmsg cpe -f "FinalProject_impl_1.cprj" "mypll.cprj" -a "iCE40UP"  -o FinalProject_impl_1_cpe.ldc
# synthesize top design
file delete -force -- FinalProject_impl_1.vm FinalProject_impl_1.ldc
run_engine_newmsg synthesis -f "FinalProject_impl_1_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o FinalProject_impl_1_syn.udb FinalProject_impl_1.vm] "C:/Users/aoreil02/Documents/GitHub/JumboDash/impl_1/FinalProject_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
