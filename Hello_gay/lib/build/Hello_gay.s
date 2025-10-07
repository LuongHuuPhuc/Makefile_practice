	.file	"Hello_gay.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Hello, GAY !\0"
	.text
	.globl	hello_Gay
	.def	hello_Gay;	.scl	2;	.type	32;	.endef
	.seh_proc	hello_Gay
hello_Gay:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	call	puts
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev3, Built by MSYS2 project) 14.2.0"
	.def	puts;	.scl	2;	.type	32;	.endef
