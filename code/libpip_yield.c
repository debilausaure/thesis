uint32_t yield(uint32_t a, uint32_t b, uint32_t c,
               uint32_t d, uint32_t e)
{
    register uint32_t r asm("eax");

    asm volatile (
        "push  %5;"
        "push  %4;"
        "push  %3;"
        "push  %2;"
        "push  %1;"
        "lcall $0xc0,$0x0;"
        "add   $0x14,%%esp;"
        : "=r" (r)
        :  "r" (a), "r" (b), "r" (c), "r" (d), "r" (e)
        :
    );

    return r;
}
