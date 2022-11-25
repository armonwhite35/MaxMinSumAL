# @author Your Name Here {whitac19@wfu.edu}
# @date Nov. 23, 2021
# @assignment Lab 8
# @file max_two.s
# @course CSC 250
#
# This program reads two integers and displays the larger
#
# Compile and run (Linux)
# gcc -no-pie max_two.s && ./a.out


.text
   .global main               # use main if using C library


main:
   push %rbp                  # save the old frame
   mov  %rsp, %rbp            # create a new frame  

   sub  $16, %rsp             # make some space on the stack (stack alignment)

   # prompt the user
   mov  $prompt_format, %rdi  # first printf argument, format string  
   xor  %rax, %rax            # zero out rax  
   call printf                # printf

   # read the value
   mov  $read_format, %rdi    # first scanf argument, format string 
   lea  -8(%rbp), %rsi        # second scanf argument, memory address
   lea -16(%rbp), %rdx        # third scanf argument, memory address

   xor  %rax, %rax            # zero out rax
   call scanf                 # scanf

   mov -8(%rbp), %rax         # moves local int to rcx for comparison
   cmp -16(%rbp), %rax        # compares value in rsi to value in rdi
   jg .getLarge               # jumps to getLarge
   mov -16(%rbp), %rax        # moves local int to rcx for comparison, if value in rsi is not greater

.getLarge:

   # print to the screen
   mov  $write_format, %rdi   # first printf argument, format string  
   mov -8(%rbp), %rsi         # second printf argument, the first integer 
   mov -16(%rbp), %rdx        # third printf argument, the second integer
   mov %rax, %rcx             # copys rcx into rax
   xor  %rax, %rax            # zero out rax  
   call printf                # printf

   add  $16, %rsp             # release stack space
   pop  %rbp                  # restore old frame
   ret                        # return to C library to end

   
   
   


.data

read_format:
   .asciz  "%d %d"

prompt_format:
   .asciz  "Enter two integers -> "

write_format:
   .asciz  "You entered %d and %d, the larger integer is %d\n"


