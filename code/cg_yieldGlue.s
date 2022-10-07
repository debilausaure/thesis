cg_yieldGlue:
	; interrupts are not cleared upon call gate entry.
	; this might create a situation where an interrupt
	; occurs in kernelland
	;
	; Fortunately, this situation can be avoided on return
	; (even if we use retf which does not restore eflags)
	; since sti is only effective upon execution of the next
	; instruction.
	;
	; The reason why we are not using a retf is to unify the
	; different ways of calling a control flow transfer
	cli

	; pop eip in eax
	pop eax
	; pop cs in edx
	pop edx

	; first, copy the arguments higher on the stack

	; set esp where the args should be copied in order to save esi, edi
	; we need 11 dwords free (eflags + cs + eip + pusha 8 dwords )
	; stack top is currently at ss + esp + 5
	; so we set esp to esp + 11 * 4
	sub esp, 11 * 4

	; we are going to modify esi, edi and eflags
	; those are not scratch registers so we need to
	; save them first
	push esi
	push edi
	pushfd

	; clear direction flag so esi and edi are incremented with movsd
	cld
	; set destination before our pushes on the stack
	lea edi, [esp + 3 * 4]
	; set source 11 dwords higher
	lea esi, [edi + 11 * 4]
	; repeat for 5 args
	mov ecx, 5
	; copy
	rep movsd

	; restore previously saved registers
	popfd
	pop edi
	pop esi

	; go down the stack to replace the args we copied
	; hopefully it doesn't mess up eflags
	add esp, (11 + 5) * 4
	; push EFLAGS, replacing the first argument
	pushf
	; push cs
	push edx
	; push eip
	push eax
	; clean cloberred registers
	; in case we trigger a context change
	xor eax, eax
	xor ecx, ecx
	xor edx, edx
	; push general purpose registers (8 dwords)
	pushad

	; save the context pointer into EAX
	mov eax, esp

	; go back to the stack top
	sub esp,  5 * 4

	; push the context pointer
	push eax

	; enforce interrupts if needed
	call fix_eflags_gate_ctx
	; call C handler (gate_ctx_t *, arg1, ..., arg%2)
	call yieldGlue

	; skip pointer to the context and args
	; and jump to the general purpose registers to save
	; called function return values
	add esp, (5 + 1 + 8) * 4
	; we save the return values on top of the previous values
	; explicitly push EAX ECX EDX (as per linux calling conventions)
	push eax
	push ecx
	push edx
	; jump to the top of the general purpose registers
	; (skip EBX ESP EBP ESI EDI)
	sub esp, 5 * 4
	; restore general purpose registers
	popad
	; we are left with the iretable structure
	iret
