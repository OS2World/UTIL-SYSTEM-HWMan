# makefile
# Erstellt von IBM WorkFrame/2 MakeMake um 21:11:28 am 2 Juli 2012
#
# Diese Make-Datei enth„lt folgende Aktionen:
#  Compile::C++ Compiler

.SUFFIXES:

.SUFFIXES: .asm .cpp .obj .idl .rc .res

!IFDEF DEBUG
AFLAGS=+Od
CFLAGS=-Ti
LFLAGS=-de -db

!ELSE
AFLAGS=-Od
CFLAGS=-O
LFLAGS=
!ENDIF

.idl.cpp:
       @echo " Compile::SOM Compiler "
       sc.exe -C200000 -S200000 -sxc;xh;xih $<

.asm.obj:
       @echo " Assemble::Assembler "
       alp.exe -Mb +Fl -Li -Lr +Ls +Lm $(AFLAGS) $<

.cpp.obj:
       @echo " Compile::C++ Compiler "
       icc.exe -Q -Sp2 -D__IBMC__ -W2 $(CFLAGS) -Gm -Gd -Ge- -G5 -C $<

.rc.res:
       @echo " Compile::Resource Compiler "
       rc.exe -n -r $<
       

LIBS = somtk.lib
OBJS = hwman.obj devcpu.obj datacls.obj except.obj helpers.obj
DEF  = hwman.def
RES  = resources.res

hwman.dll: $(OBJS) $(RES) $(DEF)
       @echo " Link::Linker "
       -7 ilink.exe -nol -nobas $(LFLAGS) -dll -packc -packd -e:2 -m -o:$@ $(OBJS) $(LIBS) $(DEF)
       rc.exe -n -x2 $(RES) $@
       dllrname.exe $@ CPPOM30=OS2OM30 /n /q
       emxupd.exe $@ $(OS2_SHELL:CMD.EXE=DLL)

hwman.obj: hwman.cpp wpcdrom.xh

except.obj: except.cpp

helpers.obj: helpers.asm

hwman.cpp: hwman.idl

devcpu.cpp: devcpu.idl

datacls.cpp: datacls.idl

devcpu.obj: devcpu.cpp

resources.res: resources.rc resources.dlg


# WPDevCDRom class:
# the IDL file "wpcdrom.idl" (and consequently the public header file)
# is missing from the toolkit, fortunately the IDL file is simple enough to reconstruct
wpcdrom.xh: wpcdrom.idl
       @echo " Compile::SOM Compiler "
       sc.exe -C200000 -S200000 -sxh $?

