/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_130(char*, char *);
extern void execute_131(char*, char *);
extern void execute_127(char*, char *);
extern void execute_128(char*, char *);
extern void execute_129(char*, char *);
extern void execute_15(char*, char *);
extern void execute_16(char*, char *);
extern void execute_18(char*, char *);
extern void execute_19(char*, char *);
extern void execute_24(char*, char *);
extern void execute_26(char*, char *);
extern void execute_28(char*, char *);
extern void execute_37(char*, char *);
extern void execute_38(char*, char *);
extern void execute_32(char*, char *);
extern void execute_33(char*, char *);
extern void execute_58(char*, char *);
extern void execute_60(char*, char *);
extern void execute_98(char*, char *);
extern void execute_99(char*, char *);
extern void execute_100(char*, char *);
extern void execute_101(char*, char *);
extern void execute_102(char*, char *);
extern void execute_103(char*, char *);
extern void execute_106(char*, char *);
extern void execute_108(char*, char *);
extern void execute_124(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_8(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[30] = {(funcp)execute_130, (funcp)execute_131, (funcp)execute_127, (funcp)execute_128, (funcp)execute_129, (funcp)execute_15, (funcp)execute_16, (funcp)execute_18, (funcp)execute_19, (funcp)execute_24, (funcp)execute_26, (funcp)execute_28, (funcp)execute_37, (funcp)execute_38, (funcp)execute_32, (funcp)execute_33, (funcp)execute_58, (funcp)execute_60, (funcp)execute_98, (funcp)execute_99, (funcp)execute_100, (funcp)execute_101, (funcp)execute_102, (funcp)execute_103, (funcp)execute_106, (funcp)execute_108, (funcp)execute_124, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_8};
const int NumRelocateId= 30;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/TB_nanoprocessor_behav/xsim.reloc",  (void **)funcTab, 30);
	iki_vhdl_file_variable_register(dp + 19664);
	iki_vhdl_file_variable_register(dp + 19720);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/TB_nanoprocessor_behav/xsim.reloc");
}

void simulate(char *dp)
{
	iki_schedule_processes_at_time_zero(dp, "xsim.dir/TB_nanoprocessor_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern int xsim_argc_copy ;
extern char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/TB_nanoprocessor_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/TB_nanoprocessor_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/TB_nanoprocessor_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
