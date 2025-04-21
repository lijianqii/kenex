#ifndef _KENEX_ARCH_THREAD_H
#define _KENEX_ARCH_THREAD_H

#include <regs.h>
#include <common.h>


struct thread_info {
    char name[THREAD_NAME_LEN];
    void *stack __attribute__((aligned(4096)));
    struct content_save content;
};

#endif /* _KENEX_ARCH_THREAD_H */