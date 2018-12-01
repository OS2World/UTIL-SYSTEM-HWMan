.586
.MODEL FLAT,SYSCALL
   ASSUME ds:FLAT
   ASSUME es:FLAT

.DATA
defString DB 'unknown CPU',0

.CODE
cpuGetBrandString PROC PUBLIC USES ebx esi edi,buf:DWORD,buflen:DWORD
   mov ecx,buflen
   cmp ecx,48
   jbe end
   mov edi,buf
   mov eax,80000000h
   cpuid
   cmp eax,80000004h
   jb short @F
   mov eax,80000002h
   cpuid
   mov [edi],eax
   mov [edi+4],ebx
   mov [edi+8],ecx
   mov [edi+12],edx
   add edi,16
   mov eax,80000003h
   cpuid
   mov [edi],eax
   mov [edi+4],ebx
   mov [edi+8],ecx
   mov [edi+12],edx
   add edi,16
   mov eax,80000004h
   cpuid
   mov [edi],eax
   mov [edi+4],ebx
   mov [edi+8],ecx
   mov [edi+12],edx
   add edi,15
eos:
   cmp BYTE PTR [edi],' '
   jne terminate
   dec edi
   jmp eos
terminate:
   inc edi
   xor eax,eax
   mov BYTE PTR [edi],al
   jmp end
@@:
   mov ecx,buflen

   mov eax,ds
   mov es,eax
   xor eax,eax
   lea edi,defString

   cld
   repnz scasb

   mov eax,buflen
   sub eax,ecx
   mov ecx,eax

   lea esi,defString
   mov edi,buf

   cld
   rep movsb
   
end:
   ret
cpuGetBrandString ENDP

END

