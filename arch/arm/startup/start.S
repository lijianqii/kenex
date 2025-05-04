#include <processor_states.h>

.global head
.section ".head.text","ax"
head:
    mrs r4, cpsr
    bic r4, r4, #PSR_M_MASK
    orr r4, r4, #(PSR_FIQ_SETBIT | PSR_IRQ_SETBIT | PSR_M_ABT)
    msr cpsr, r4
    b .
