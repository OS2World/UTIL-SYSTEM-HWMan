#include "except.h"

ULONG APIENTRY ExceptionHandler(
                                    PEXCEPTIONREPORTRECORD pRep,
                                    PEXCEPTIONREGISTRATIONRECORD2 pReg,
                                    PCONTEXTRECORD pCtx,
                                    PVOID pDispCtx)
{
    if (pRep->fHandlerFlags & (EH_EXIT_UNWIND|EH_UNWINDING|EH_NESTED_CALL))
    {
        return XCPT_CONTINUE_SEARCH;
    }

    switch (pRep->ExceptionNum)
    {
        case XCPT_ACCESS_VIOLATION:
        case XCPT_ILLEGAL_INSTRUCTION:
        case XCPT_PRIVILEGED_INSTRUCTION:
        case XCPT_INVALID_LOCK_SEQUENCE:
        case XCPT_INTEGER_DIVIDE_BY_ZERO:
        case XCPT_INTEGER_OVERFLOW:
        case XCPT_FLOAT_DIVIDE_BY_ZERO:
        case XCPT_FLOAT_OVERFLOW:
        case XCPT_FLOAT_UNDERFLOW:
        case XCPT_FLOAT_INVALID_OPERATION:
        case XCPT_FLOAT_DENORMAL_OPERAND:
        case XCPT_FLOAT_INEXACT_RESULT:
        case XCPT_FLOAT_STACK_CHECK:
            longjmp(pReg->jmp,1);

        default:
            break;
    }
    return XCPT_CONTINUE_SEARCH;
}

