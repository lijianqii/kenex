#ifndef _KENEX_PROCESSOR_STATES_H
#define _KENEX_PROCESSOR_STATES_H

#define PSR_M_MASK 0x0000001F
#define PSR_M_USR  0x00000010
#define PSR_M_FIQ  0x00000011
#define PSR_M_IRQ  0x00000012
#define PSR_M_SVC  0x00000013
#define PSR_M_MON  0x00000016
#define PSR_M_ABT  0x00000017
#define PSR_M_HYP  0x0000001A
#define PSR_M_UND  0x0000001B
#define PSR_M_SYS  0x0000001F

#define PSR_ABT_SETBIT 0x00000100
#define PSR_IRQ_SETBIT 0x00000080
#define PSR_FIQ_SETBIT 0x00000040

#endif /* _KENEX_PROCESSOR_STATES_H */