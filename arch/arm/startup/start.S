#include <processor_states.h>

.global _start
.section .head.text
_start:
    mrs r4, cpsr
    bic r4, r4, #PSR_M_MASK
    orr r4, r4, #(PSR_FIQ_SETBIT | PSR_IRQ_SETBIT | PSR_M_SVC)
    msr cpsr_c, r4
    b .