#include <common/asm_utils.h>
#include <processor_states.h>

.arm
.section ".head.text","ax"
ENTRY(head)
    mrs r4, cpsr
    bic r4, r4, #PSR_M_MASK
    orr r4, r4, #(PSR_FIQ_SETBIT | PSR_IRQ_SETBIT | PSR_M_SVC)
    msr cpsr, r4

    mrc	p15, 0, r9, c0, c0, 5
    bfc r9, #24, #8

    cmp r9, #0
    bne secondary_wait

    ldr r0, =_vector_start
    MCR p15, 0, r0, c12, c0, 0

    MRC p15, 0, r2, c1, c0, 0
    orr r2, r2, #1
    MCR p15, 0, r2, c1, c0, 0

    ldr r1, =_vector_end

    b start_kenex
ENDPROC(head)

secondary_wait:
    b .

.align 5
.global vector
.section ".vector", "ax"
vector:
    b reset
    b undfi
    b svc_call
    b pabt
    b dabt
    b unused
    b irq_call
    b fiq_call

reset:
    b .
undfi:
    b .
svc_call:
    b .
pabt:
    b .
dabt:
    b .
unused:
    b .
irq_call:
    b .
fiq_call:
    b .
