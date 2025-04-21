#ifndef _KENEX_REGS_ARM_H
#define _KENEX_REGS_ARM_H

struct content_save {
    unsigned long r4;
    unsigned long r5;
    unsigned long r6;
    unsigned long r7;
    unsigned long r8;
    unsigned long r9;

    unsigned long fp;
    unsigned long sp;
    unsigned long pc;
};

#endif /* _KENEX_REGS_ARM_H */