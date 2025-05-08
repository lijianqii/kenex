#ifndef KENEX_ASM_UTILS_H
#define KENEX_ASM_UTILS_H

#ifndef ASM_NL
#define ASM_NL ;
#endif

#ifndef ENTRY
#define ENTRY(sym) \
    .align 4, 0x90 ASM_NL \
    .global sym ASM_NL \
    sym:
#endif

#ifndef ENDPROC
#define ENDPROC(sym) \
    .type sym, %function ASM_NL \
    .size sym, .-sym
#endif

#endif /* KENEX_ASM_UTILS_H */