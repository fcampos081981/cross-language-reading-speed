section .data
    output_file db "/home/usuario/outfiles/output_c.txt", 0
    exec_times_file db "/home/usuario/execution_times.txt", 0
    directory_path db "/home", 0
    repeated db "**********************************************************************", 0
    start_time_msg db "Start: ", 0
    end_time_msg db "End: ", 0
    exec_time_msg db "Execution time: ", 0
    memory_usage_msg db "Memory usage (in bytes): ", 0
    cpu_user_time_msg db "CPU time in user mode: ", 0
    cpu_kernel_time_msg db "Kernel Mode CPU Time: ", 0
    file_list_msg db "File with listed files: ", 0
    newline db 10, 0

section .bss
    start_time resb 20
    end_time resb 20
    duration resq 1
    memory_usage resq 1
    utime resq 1
    stime resq 1
    buffer resb 1024

section .text
    global _start

_start:
    ; Get start time
    mov rax, 201                 ; syscall: clock_gettime
    mov rdi, 1                   ; CLOCK_MONOTONIC
    lea rsi, [start_time]        ; Pointer to start_time
    syscall

    ; Open output file
    mov rax, 2                   ; syscall: open
    lea rdi, [output_file]       ; File path
    mov rsi, 577                 ; Flags: O_WRONLY | O_CREAT | O_TRUNC
    mov rdx, 0644                ; Permissions
    syscall
    mov r12, rax                 ; Save file descriptor

    ; Write repeated line to file
    lea rdi, [repeated]          ; Pointer to repeated string
    call write_string

    ; Write start time message
    lea rdi, [start_time_msg]
    call write_string

    ; Write start time
    lea rdi, [start_time]
    call write_string

    ; Perform directory scan (simplified)
    lea rdi, [directory_path]
    call scan_directory

    ; Get end time
    mov rax, 201                 ; syscall: clock_gettime
    mov rdi, 1                   ; CLOCK_MONOTONIC
    lea rsi, [end_time]          ; Pointer to end_time
    syscall

    ; Write end time message
    lea rdi, [end_time_msg]
    call write_string

    ; Write end time
    lea rdi, [end_time]
    call write_string

    ; Calculate execution time (simplified)
    ; (end_time - start_time)
    ; Write execution time message
    lea rdi, [exec_time_msg]
    call write_string

    ; Write execution time (placeholder)
    lea rdi, [buffer]
    mov rsi, 10
    call write_number

    ; Close file
    mov rax, 3                   ; syscall: close
    mov rdi, r12                 ; File descriptor
    syscall

    ; Exit program
    mov rax, 60                  ; syscall: exit
    xor rdi, rdi                 ; Exit code 0
    syscall

; Function: write_string
; Writes a null-terminated string to the output file
write_string:
    mov rax, 1                   ; syscall: write
    mov rdi, r12                 ; File descriptor
    mov rdx, rsi                 ; Length of string
    syscall
    ret

; Function: write_number
; Converts a number to a string and writes it to the output file
write_number:
    ; Placeholder implementation
    ret

; Function: scan_directory
; Recursively scans a directory and writes file paths to the output file
scan_directory:
    ; Placeholder implementation
    ret