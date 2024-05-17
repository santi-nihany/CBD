
Program ej1;

Const 
    N =   10;
    FIN =   9999;

Type 
    empleadoDet =   Record
        cod:   integer;
        fecha:   string;
        cantDiasLic:   integer;
    End;

    empleado =   Record
        cod:   integer;
        nombre:   string;
        apellido:   string;
        fechaN:   string;
        dir:   string;
        cantH:   integer;
        telefono:   string;
        cantVac:   integer;
    End;

    fDetalle =   file Of empleadoDet;
    fMaestro =   file Of empleado;

    a_detalles =   array[1..N] Of fDetalle;
    a_actuales =   array[1..N] Of empleadoDet;

Procedure leer(Var arch: fDetalle; Var dato: empleadoDet);
Begin
    If (Not(eof(arch)))Then
        read(arch, dato)
    Else
        dato.cod := FIN;
End;

Procedure minimo(Var detalles: a_detalles; Var actuales: a_actuales; Var min:
                 empleadoDet);

Var 
    i,posMin:   integer;
Begin
    posMin := 1;
    min := actuales[1];
    For i:=2 To N Do
        Begin
            If (actuales[i].cod > min.cod )Then
                Begin
                    posMin := i;
                    min := actuales[i];
                End;
        End;
    leer(detalles[posMin], actuales[posMin]);
End;

Procedure actualizar(Var M: fMaestro; Var detalles: a_detalles; Var archTexto:
                     Text);

Var 
    actuales:   a_actuales;
    min:   empleadoDet;
    i,totalDias:   integer;
    regM:   empleado;
Begin
    regM.cod := FIN;
    Reset(M);
    Rewrite(archTexto);
    For i:=1 To N Do
        Begin
            Reset(detalles[i]);
            leer(detalles[i], actuales[i]);
        End;

    minimo(detalles,actuales, min);

    While (min.cod <> FIN) Do
        Begin
            totalDias := 0;
            While ((Not(eof(M))) And (min.cod <> regM.cod) ) Do
                read(M,regM);
            While ((regM.cod = min.cod) And (min.cod <> FIN)) Do
                Begin
                    totalDias := totalDias + min.cantDiasLic;
                    minimo(detalles, actuales, min);
                End;
            If (regM.cantVac >= totalDias) Then
                Begin
                    regM.cantVac := regM.cantVac - totalDias;
                    Seek(M, FilePos(M)-1);
                    Write(M, regM);
                End
            Else
                Writeln(archTexto, regM.cod, regM.nombre, regM.apellido,
                        regM.cantVac, min.cantDiasLic);
        End;
    Close(M);
    Close(archTexto);
    For i:=1 To N Do
        Begin
            Close(detalles[i]);
        End;
End;

Var 
    M:   fMaestro;
    detalles:   a_detalles;
    i:   integer;
    archTexto:   Text;
    nombreDet:   string;
Begin
    Assign(M, 'maestro.dat');
    Assign(archTexto, 'error.txt');
    For i:=1 To N Do
        Begin
            Writeln('Ingrese nombre detalle ', i);
            Readln(nombreDet);
            Assign(detalles[i],nombreDet);
        End;
    actualizar(M,detalles,archTexto);
End.
