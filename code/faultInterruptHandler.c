void faultInterruptHandler(int_ctx_t *ctx)
{
	DEBUG(TRACE, "Received fault int n°%d\n", ctx->int_no);
	DEBUG(TRACE, "Error code is : %x\n", ctx->err_code);

	user_ctx_t uctx;
	uctx.eip = ctx->eip;
	uctx.regs = ctx->regs;
	uctx.eflags = ctx->eflags;
	uctx.regs.esp = ctx->useresp;
	uctx.valid = 1;

	// TODO The below code could be written in Coq

	page currentPartDesc = getCurPartition();

	interruptMask currentPartitionIntState = get_self_int_state();
	unsigned saveIndex;
	if (currentPartitionIntState == 0) {
		saveIndex = CLI_SAVE_INDEX;
	}
	else {
		saveIndex = STI_SAVE_INDEX;
	}
	page currentPageDir  = getPd(currentPartDesc);
	propagateFault(currentPartDesc, currentPageDir, ctx->int_no,
	               saveIndex, getNbLevel(), currentPartitionIntState,
	               currentPartitionIntState, &uctx);
}

void propagateFault(page callerPartDesc,
                    page callerPageDir,
                    unsigned targetInterrupt,
                    unsigned callerContextSaveIndex,
                    unsigned nbL,
                    interruptMask flagsOnYield,
                    interruptMask flagsOnWake,
                    user_ctx_t *callerInterruptedContext)
{
	yield_checks rc = getParentPartDescCont(callerPartDesc,
	                                        callerPageDir,
	                                        targetInterrupt,
	                                        callerContextSaveIndex,
	                                        nbL,
	                                        flagsOnYield,
	                                        flagsOnWake,
	                                        callerInterruptedContext);
	switch(rc) {
		case coq_FAIL_UNAVAILABLE_CALLER_VIDT:
		case coq_FAIL_CALLER_CONTEXT_SAVE:
			getTargetVidtCont(getParent(callerPartDesc),
			                  callerPageDir,
			                  getVaddrVIDT(),
			                  0,
			                  targetInterrupt,
			                  nbL,
			                  getIndexOfAddr(getVaddrVIDT(), levelMin),
			                  flagsOnYield,
			                  flagsOnWake,
			                  0);
			break;
		case coq_FAIL_ROOT_CALLER:
			// Fault inside the root partition
			// Guru meditation
			for(;;);
			break;
		default:
			// Be sure to handle the root case differently, 
			// as it has no parent
			page parentPartDesc = getParent(callerPartDesc);
			// We are still trying to save the faulting
			// partition's context, even though it is very
			// unlikely the partition will ever wake up again
			// TODO is it worth a try ?
			propagateFault(parentPartDesc,
			               callerPageDir,
			               DOUBLE_FAULT_LEVEL,
			               callerContextSaveIndex,
			               nbL,
			               flagsOnYield,
			               flagsOnWake,
			               callerInterruptedContext);
			break;
	}
}
