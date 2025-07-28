%define SYS_exit        60
%define SYS_open        2
%define SYS_close       3
%define SYS_write       1
%define SYS_clock_gettime 201
%define SYS_openat      257
%define SYS_getdents64  217

section .data
    output_file db "/home/usuario/outfiles/output_asm.txt", 0
    directory_path db "/home", 0
    repeated db "**********************************************************************", 10, 0
    start_time_msg db "Start time logged", 10, 0
    end_time_msg db "End time logged", 10, 0
    exec_time_msg db "Execution time placeholder", 10, 0

section .bss
    start_time resb 16
    end_time resb 16
    buffer resb 1024
    dirbuf resb 4096

global _start

section .text
_start:
    ; Get start time
    mov rax, SYS_clock_gettime
    mov rdi, 1
    lea rsi, [start_time]        
    syscall

    ; Open output file
    mov rax, SYS_open
    lea rdi, [output_file]
    mov rsi, 577
    mov rdx, 0644
    syscall
    mov r12, rax

    ; Write header
    lea rdi, [repeated]
    call write_string
    lea rdi, [start_time_msg]
    call write_string

    ; Scan directory and write names
    lea rdi, [directory_path]
    call scan_directory

    ; Get end time
    mov rax, SYS_clock_gettime
    mov rdi, 1
    lea rsi, [end_time]
    syscall

    ; Write footer
    lea rdi, [end_time_msg]
    call write_string
    lea rdi, [exec_time_msg]
    call write_string

    ; Close file
    mov rax, SYS_close
    mov rdi, r12
    syscall

    ; Exit
    mov rax, SYS_exit
    xor rdi, rdi
    syscall

; -------------------------------------------------------------------

write_string:
    push rdi
    call strlen
    pop rdi
    mov rax, SYS_write
    mov rsi, rdi
    mov rdi, r12
    mov rdx, rax
    mov rax, SYS_write
    syscall
    ret

strlen:
    xor rax, rax
.next:
    cmp byte [rdi + rax], 0
    je .done
    inc rax
    jmp .next
.done:
    ret

; -------------------------------------------------------------------

; Lista arquivos de um diretório simples
scan_directory:
    ; Open directory
    mov rax, SYS_open
    mov rdi, rdi         ; path in RDI
    mov rsi, 0           ; O_RDONLY
    syscall
    mov r13, rax         ; r13 = dirfd

.parse_loop:
    cmp r15, r14
    jge .read_loop       ; se chegou no fim, faz nova leitura

    lea rsi, [dirbuf + r15]           ; rsi aponta para entrada atual
    movzx r8d, word [rsi + 16]        ; d_reclen
    lea rdi, [rsi + 19]               ; d_name

    ; Escreve o nome no arquivo
    call write_string

    ; Nova linha
    mov byte [buffer], 10
    mov rax, SYS_write
    mov rdi, r12
    lea rsi, [buffer]
    mov rdx, 1
    syscall

    add r15, r8d
    jmp .parse_loop
    
    ; Write newline
    mov byte [buffer], 10
    mov rax, SYS_write
    mov rdi, r12
    lea rsi, [buffer]
    mov rdx, 1
    syscall

    add r15, r8d
    jmp .parse_loop

.done:
    ; Close directory
    mov rax, SYS_close
    mov rdi, r13
    syscall
    ret
