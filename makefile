# makefile
# Erstellt von IBM WorkFrame/2 MakeMake um 21:11:28 am 2 Juli 2012
#
# Diese Make-Datei enth„lt folgende Aktionen:
#  Compile::C++ Compiler

.SUFFIXES:

.SUFFIXES: .cpp .obj .idl .rc .res

!IFDEF DEBUG
CFLAGS=-Ti
LFLAGS=-de -db
!ELSE
CFLAGS=-O
LFLAGS=
!ENDIF

.idl.cpp:
       @echo " Compile::SOM Compiler "
       sc.exe -C200000 -S200000 -sxc;xh;xih $<

.cpp.obj:
       @echo " Compile::C++ Compiler "
       icc.exe -Q -Sp2 -D__IBMC__ -W2 $(CFLAGS) -Gm -Gd -Ge- -G5 -C $<

hwman.dll: hwman.obj {$(LIB)}somtk.lib hwman.def
       @echo " Link::Linker "
       -7 ilink.exe -nol -nobas $(LFLAGS) -dll -packc -packd -e:2 -m -o:$@ $**
       dllrname.exe $@ CPPOM30=OS2OM30 /n /q

hwman.obj: hwman.cpp

hwman.cpp: hwman.idl

