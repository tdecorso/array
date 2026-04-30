	.file	"bench.c"
	.text
	.p2align 4
	.type	bench_cmp_long, @function
bench_cmp_long:
.LFB23:
	.cfi_startproc
	movq	(%rsi), %rax
	cmpq	%rax, (%rdi)
	setg	%al
	setl	%dl
	movzbl	%dl, %edx
	movzbl	%al, %eax
	subl	%edx, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	bench_cmp_long, .-bench_cmp_long
	.p2align 4
	.type	bench_percentile.constprop.0, @function
bench_percentile.constprop.0:
.LFB27:
	.cfi_startproc
	mulsd	.LC0(%rip), %xmm0
	cvttsd2sil	%xmm0, %eax
	cmpl	$999998, %eax
	jg	.L6
	movslq	%eax, %rdx
	pxor	%xmm2, %xmm2
	pxor	%xmm1, %xmm1
	movq	(%rdi,%rdx,8), %rcx
	cvtsi2sdl	%eax, %xmm2
	movq	8(%rdi,%rdx,8), %rdx
	subq	%rcx, %rdx
	cvtsi2sdq	%rdx, %xmm1
	subsd	%xmm2, %xmm0
	mulsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rcx, %xmm1
	addsd	%xmm1, %xmm0
	ret
.L6:
	pxor	%xmm0, %xmm0
	cvtsi2sdq	7999992(%rdi), %xmm0
	ret
	.cfi_endproc
.LFE27:
	.size	bench_percentile.constprop.0, .-bench_percentile.constprop.0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"bench: malloc failed\n"
.LC2:
	.string	"Array alloc+free"
.LC3:
	.string	"\033[1m\n\n=== %s ===\n\n\033[0m"
.LC8:
	.string	"  p50 : %6.2f ns\n"
.LC9:
	.string	"  p90 : %6.2f ns\n"
.LC10:
	.string	"  p99 : %6.2f ns\n"
.LC12:
	.string	"Array append (no resize)"
.LC14:
	.string	"Array append (resize)"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB15:
	.section	.text.startup,"ax",@progbits
.LHOTB15:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB25:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	$100, %ebx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
.L9:
	movl	$416, %edi
	call	malloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L8
	movl	sink(%rip), %eax
	addl	$1, %eax
	movl	%eax, sink(%rip)
	call	free@PLT
	subl	$1, %ebx
	jne	.L9
	movl	$8000000, %edi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L99
	movq	%rax, %r13
	leaq	8000000(%rax), %r15
	leaq	32(%rsp), %r12
.L14:
	movq	%r12, %rsi
	movl	$1, %edi
	movl	$100, %ebx
	call	clock_gettime@PLT
	imulq	$1000000000, 32(%rsp), %r14
	addq	40(%rsp), %r14
.L13:
	movl	$416, %edi
	call	malloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L12
	movl	sink(%rip), %eax
	addl	$1, %eax
	movl	%eax, sink(%rip)
	call	free@PLT
	subl	$1, %ebx
	jne	.L13
	movq	%r12, %rsi
	movl	$1, %edi
	addq	$8, %r13
	call	clock_gettime@PLT
	imulq	$1000000000, 32(%rsp), %rax
	addq	40(%rsp), %rax
	subq	%r14, %rax
	movq	%rax, -8(%r13)
	cmpq	%r15, %r13
	jne	.L14
	leaq	bench_cmp_long(%rip), %rcx
	movl	$8, %edx
	movl	$1000000, %esi
	movq	%rbp, %rdi
	call	qsort@PLT
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movsd	.LC4(%rip), %xmm0
	movq	%rbp, %rdi
	call	bench_percentile.constprop.0
	movsd	.LC5(%rip), %xmm3
	mulsd	%xmm0, %xmm3
	movsd	.LC6(%rip), %xmm0
	call	bench_percentile.constprop.0
	mulsd	.LC5(%rip), %xmm0
	movq	%xmm0, %rbx
	movsd	.LC7(%rip), %xmm0
	call	bench_percentile.constprop.0
	leaq	.LC8(%rip), %rdi
	movl	$1, %eax
	movsd	%xmm0, 8(%rsp)
	movapd	%xmm3, %xmm0
	call	printf@PLT
	movq	%rbx, %xmm0
	movl	$1, %eax
	leaq	.LC9(%rip), %rdi
	call	printf@PLT
	movsd	.LC5(%rip), %xmm2
	mulsd	8(%rsp), %xmm2
	leaq	.LC10(%rip), %rdi
	movl	$1, %eax
	movapd	%xmm2, %xmm0
	call	printf@PLT
	movq	%rbp, %rdi
	call	free@PLT
.L11:
	movl	$416, %edi
	call	malloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L15
	movdqa	.LC11(%rip), %xmm0
	addq	$16, %r15
	movups	%xmm0, (%rax)
.L15:
	xorl	%ebx, %ebx
	jmp	.L18
.L17:
	movq	(%rdi), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, (%rdi)
	movl	%ebx, (%r15,%rax,4)
.L16:
	movl	sink(%rip), %eax
	addl	(%r15,%rbx,4), %eax
	addq	$1, %rbx
	movl	%eax, sink(%rip)
	cmpq	$100, %rbx
	je	.L100
.L18:
	testq	%r15, %r15
	je	.L16
	movq	-8(%r15), %rax
	leaq	-16(%r15), %rdi
	cmpq	%rax, -16(%r15)
	jne	.L17
	leaq	16(,%rax,8), %rsi
	leaq	(%rax,%rax), %rbp
	call	realloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L16
	movq	%rbp, 8(%rax)
	leaq	16(%rax), %r15
	jmp	.L17
.L100:
	movl	$8000000, %edi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L101
	movq	%rax, 8(%rsp)
	leaq	8000000(%rax), %rax
	leaq	32(%rsp), %r12
	movq	%rax, 16(%rsp)
.L26:
	movq	%r12, %rsi
	movl	$1, %edi
	movl	$100, %ebx
	call	clock_gettime@PLT
	imulq	$1000000000, 32(%rsp), %r14
	addq	40(%rsp), %r14
	movq	%r14, 24(%rsp)
.L25:
	testq	%r15, %r15
	je	.L21
	movq	$0, -16(%r15)
.L21:
	xorl	%r14d, %r14d
	jmp	.L24
	.p2align 4,,10
	.p2align 3
.L23:
	movq	(%rdi), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, (%rdi)
	movl	%r14d, (%r15,%rax,4)
.L22:
	movl	sink(%rip), %eax
	addl	(%r15,%r14,4), %eax
	addq	$1, %r14
	movl	%eax, sink(%rip)
	cmpq	$100, %r14
	je	.L102
.L24:
	testq	%r15, %r15
	je	.L22
	movq	-8(%r15), %rax
	leaq	-16(%r15), %rdi
	cmpq	%rax, -16(%r15)
	jne	.L23
	leaq	16(,%rax,8), %rsi
	leaq	(%rax,%rax), %r13
	call	realloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L22
	movq	%r13, 8(%rax)
	leaq	16(%rax), %r15
	jmp	.L23
.L102:
	subl	$1, %ebx
	jne	.L25
	movq	%r12, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	24(%rsp), %rdx
	imulq	$1000000000, 32(%rsp), %rax
	addq	40(%rsp), %rax
	subq	%rdx, %rax
	movq	8(%rsp), %rdx
	movq	%rax, (%rdx)
	addq	$8, %rdx
	movq	%rdx, 8(%rsp)
	cmpq	%rdx, 16(%rsp)
	jne	.L26
	leaq	bench_cmp_long(%rip), %rcx
	movl	$8, %edx
	movl	$1000000, %esi
	movq	%rbp, %rdi
	call	qsort@PLT
	leaq	.LC12(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movsd	.LC4(%rip), %xmm0
	movq	%rbp, %rdi
	call	bench_percentile.constprop.0
	movsd	.LC5(%rip), %xmm3
	mulsd	%xmm0, %xmm3
	movsd	.LC6(%rip), %xmm0
	call	bench_percentile.constprop.0
	mulsd	.LC5(%rip), %xmm0
	movq	%xmm0, %rbx
	movsd	.LC7(%rip), %xmm0
	call	bench_percentile.constprop.0
	leaq	.LC8(%rip), %rdi
	movl	$1, %eax
	movsd	%xmm0, 8(%rsp)
	movapd	%xmm3, %xmm0
	call	printf@PLT
	movq	%rbx, %xmm0
	movl	$1, %eax
	leaq	.LC9(%rip), %rdi
	call	printf@PLT
	movsd	.LC5(%rip), %xmm4
	mulsd	8(%rsp), %xmm4
	leaq	.LC10(%rip), %rdi
	movl	$1, %eax
	movapd	%xmm4, %xmm0
	call	printf@PLT
	movq	%rbp, %rdi
	call	free@PLT
.L20:
	testq	%r15, %r15
	je	.L34
	leaq	-16(%r15), %rdi
	call	free@PLT
.L34:
	movl	$56, %edi
	call	malloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L27
	movdqa	.LC13(%rip), %xmm0
	addq	$16, %r15
	movups	%xmm0, (%rax)
.L27:
	xorl	%ebx, %ebx
	jmp	.L30
.L29:
	movq	(%rdi), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, (%rdi)
	movl	%ebx, (%r15,%rax,4)
.L28:
	movl	sink(%rip), %eax
	addl	(%r15,%rbx,4), %eax
	addq	$1, %rbx
	movl	%eax, sink(%rip)
	cmpq	$1000, %rbx
	je	.L103
.L30:
	testq	%r15, %r15
	je	.L28
	movq	-8(%r15), %rax
	leaq	-16(%r15), %rdi
	cmpq	%rax, -16(%r15)
	jne	.L29
	leaq	16(,%rax,8), %rsi
	leaq	(%rax,%rax), %rbp
	call	realloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L28
	movq	%rbp, 8(%rax)
	leaq	16(%rax), %r15
	jmp	.L29
.L103:
	movl	$8000000, %edi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L104
	movq	%rax, 8(%rsp)
	leaq	8000000(%rax), %rax
	leaq	32(%rsp), %r12
	movq	%rax, 24(%rsp)
.L42:
	movq	%r12, %rsi
	movl	$1, %edi
	movl	$100, %ebx
	call	clock_gettime@PLT
	imulq	$1000000000, 32(%rsp), %r14
	addq	40(%rsp), %r14
	movq	%r14, 16(%rsp)
.L41:
	testq	%r15, %r15
	je	.L36
	leaq	-16(%r15), %rdi
	call	free@PLT
.L36:
	movl	$56, %edi
	call	malloc@PLT
	movq	%rax, %r15
	testq	%rax, %rax
	je	.L37
	movdqa	.LC13(%rip), %xmm1
	addq	$16, %r15
	movups	%xmm1, (%rax)
.L37:
	xorl	%r14d, %r14d
	jmp	.L40
	.p2align 4,,10
	.p2align 3
.L39:
	movq	(%rdi), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, (%rdi)
	movl	%r14d, (%r15,%rax,4)
.L38:
	movl	sink(%rip), %eax
	addl	(%r15,%r14,4), %eax
	addq	$1, %r14
	movl	%eax, sink(%rip)
	cmpq	$1000, %r14
	je	.L105
.L40:
	testq	%r15, %r15
	je	.L38
	movq	-8(%r15), %rax
	leaq	-16(%r15), %rdi
	cmpq	%rax, -16(%r15)
	jne	.L39
	leaq	16(,%rax,8), %rsi
	leaq	(%rax,%rax), %r13
	call	realloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L38
	movq	%r13, 8(%rax)
	leaq	16(%rax), %r15
	jmp	.L39
.L105:
	subl	$1, %ebx
	jne	.L41
	movq	%r12, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	16(%rsp), %rdx
	imulq	$1000000000, 32(%rsp), %rax
	addq	40(%rsp), %rax
	subq	%rdx, %rax
	movq	8(%rsp), %rdx
	movq	%rax, (%rdx)
	movq	24(%rsp), %rax
	addq	$8, %rdx
	movq	%rdx, 8(%rsp)
	cmpq	%rax, %rdx
	jne	.L42
	leaq	bench_cmp_long(%rip), %rcx
	movl	$8, %edx
	movl	$1000000, %esi
	movq	%rbp, %rdi
	call	qsort@PLT
	leaq	.LC14(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movsd	.LC4(%rip), %xmm0
	movq	%rbp, %rdi
	call	bench_percentile.constprop.0
	movsd	.LC5(%rip), %xmm3
	mulsd	%xmm0, %xmm3
	movsd	.LC6(%rip), %xmm0
	call	bench_percentile.constprop.0
	mulsd	.LC5(%rip), %xmm0
	movq	%xmm0, %rbx
	movsd	.LC7(%rip), %xmm0
	call	bench_percentile.constprop.0
	leaq	.LC8(%rip), %rdi
	movl	$1, %eax
	movsd	%xmm0, 8(%rsp)
	movapd	%xmm3, %xmm0
	call	printf@PLT
	movq	%rbx, %xmm0
	movl	$1, %eax
	leaq	.LC9(%rip), %rdi
	call	printf@PLT
	movsd	.LC5(%rip), %xmm5
	mulsd	8(%rsp), %xmm5
	leaq	.LC10(%rip), %rdi
	movl	$1, %eax
	movapd	%xmm5, %xmm0
	call	printf@PLT
	movq	%rbp, %rdi
	call	free@PLT
.L35:
	testq	%r15, %r15
	je	.L43
	leaq	-16(%r15), %rdi
	call	free@PLT
.L43:
	xorl	%edi, %edi
	movl	sink(%rip), %eax
	call	exit@PLT
.L99:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
	jmp	.L11
.L104:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
	jmp	.L35
.L101:
	movq	stderr(%rip), %rcx
	movl	$21, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
	jmp	.L20
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB25:
.L8:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	xorl	%edx, %edx
	movl	%edx, 0
	ud2
.L12:
	xorl	%eax, %eax
	movl	%eax, 0
	ud2
	.cfi_endproc
.LFE25:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE15:
	.section	.text.startup
.LHOTE15:
	.globl	sink
	.bss
	.align 4
	.type	sink, @object
	.size	sink, 4
sink:
	.zero	4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1093567614
	.align 8
.LC4:
	.long	0
	.long	1071644672
	.align 8
.LC5:
	.long	1202590843
	.long	1065646817
	.align 8
.LC6:
	.long	1717986918
	.long	1072588390
	.align 8
.LC7:
	.long	2061584302
	.long	1072672276
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC11:
	.quad	0
	.quad	100
	.align 16
.LC13:
	.quad	0
	.quad	10
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
