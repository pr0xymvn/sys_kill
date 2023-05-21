BITS 64

extern printf

global _main

section .rodata
	pid_get db 'PID => %d', 10
	kill_result db 'Killing of pid => %d', 10

section .text

_main:
	jmp _push_rsp_pid


_push_rsp_pid:
	mov rax, 39
	syscall
	mov rdx, rax
	jmp _print_pid


_print_pid:
	mov rdi, pid_get
	mov rsi, rdx
	call printf
	syscall
	jmp _kill_pid
	
	
_kill_pid:
	mov rax, 62
	mov rdi, rdx
	mov rsi, 0
	syscall
	jmp _print_killing

_print_killing:
	mov rdi, kill_result
	mov rsi, rdx
	syscall
	jmp _exit

_exit:
	mov rax, 0x3C
	mov rdi, 0
	syscall
