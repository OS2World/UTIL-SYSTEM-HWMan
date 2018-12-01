#ifndef __EXCEPT_H__
#define __EXCEPT_H__

#define INCL_BASE
#include <os2.h>
#include <setjmp.h>

typedef struct _EXCEPTIONREGISTRATIONRECORD2
{
    EXCEPTIONREGISTRATIONRECORD reg;
    jmp_buf                                 jmp;
} EXCEPTIONREGISTRATIONRECORD2, *PEXCEPTIONREGISTRATIONRECORD2;

extern ULONG APIENTRY ExceptionHandler(
                                    PEXCEPTIONREPORTRECORD pRep,
                                    PEXCEPTIONREGISTRATIONRECORD2 pReg,
                                    PCONTEXTRECORD pCtx,
                                    PVOID pDispCtx);

#define TRY(except)                                                                     \
{                                                                                              \
    EXCEPTIONREGISTRATIONRECORD2 except={0};                                \
    except.reg.ExceptionHandler = (ERR)ExceptionHandler;                       \
    DosSetExceptionHandler((PEXCEPTIONREGISTRATIONRECORD)&except);   \
    if (setjmp(except.jmp) == 0) {

#define CATCH()                                                                          \
    } else {

#define ENDTRY(except)                                                                     \
    }                                                                                               \
    DosUnsetExceptionHandler((PEXCEPTIONREGISTRATIONRECORD)&except);    \
}

#endif
