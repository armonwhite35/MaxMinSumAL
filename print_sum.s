# @author Your Name Here {whitac19@wfu.edu}
# @date Nov. 23, 2021
# @assignment Lab 8
# @file print_sum.s
# @course CSC 250
#
# This program reads a sequence of integers until a negative
# value is entered and displays the current maximum
#
# Compile and run (Linux)
# gcc -no-pie print_sum.s && ./a.out


.text
   .global main               # use main if using C library


main:
   push %rbp                  # save the old frame
   mov  %rsp, %rbp            # create a new frame  

   sub  $16, %rsp             # make some space on the stack (stack alignment)
   movq $0, -8(%rbp)          # first integer, zeroing out memory address
   movq $0, -16(%rbp)         # second integer zeroing out memory address

   
.loop:
   # prompt the user   
   mov  $prompt_format, %rdi  # first printf argument, format string  
   xor  %rax, %rax            # zero out rax  
   call printf                # printf

   # read the value
   mov  $read_format, %rdi    # first scanf argument, format string 
   lea  -8(%rbp), %rsi        # second scanf argument, memory address (causes seg fault if commented out, saves inputed int /address into %rsi)
   xor  %rax, %rax            # zero out rax
   call scanf                 # scanf

   # print to the screen
   movq -8(%rbp), %rax        # integer argument into a temp register

   cmp $0, -8(%rbp)           #comparison for entered value to be less than zero
   jl .end                    #if less than zero, jumps to end of program
   
   add %rax, -16(%rbp)        # integer argument, adds to local sum


   mov  $write_format, %rdi   # first printf argument, format string  
   mov -8(%rbp), %rsi         # second printf argument, the integer  (literally only prints the number given by user)
   mov -16(%rbp), %rdx        # third printf argument, loc sum (purpose: prints actual sum number)
   xor  %rax, %rax            # zero out rax  
   call printf                # printf

   cmp $0, -8(%rbp)           # compares zero to integer
   jge .loop                  # jumps back up to loop unless ineger is negative
   .end:                      # goes to end of program
   
   add  $16, %rsp             # release stack space
   pop  %rbp                  # restore old frame
   ret                        # return to C library to end


.data

read_format:
   .asciz  "%d"

prompt_format:
   .asciz  "Enter an integer -> "

write_format:
   .asciz  "Number you entered: %d, Current sum is %d\n"


