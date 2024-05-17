
Program ej12;

Const 
    N =   10;
    FIN =   9999;

Type 
    empleado_det =   Record
        cod:   integer;
        fecha:   String;
        cantDiasLic:   integer;
    End;

    empleado_mae =   Record
        cod:   Integer;
        nombre:   string;
        apellido:   string;
        fechaNac:   string;
        dir:   string;
        cantHijos:   integer;
        telefono:   string;
        cantDiasVac:   integer;
    End;

    file_mae =   file Of empleado_mae;
    file_det =   file Of empleado_det;

    arch_detalles =   array[1..N] Of file_det;
    arreglo_emp =   array[1..N] Of empleado_det;

Procedure leer(Var det: file_det; Var dato: empleado_det);
Begin
    If (Not(eof(det)))Then
        read(det, dato)
    Else
        dato.cod =   FIN;
End;

Procedure minimo(Var detalles: arch_detalles; Var empleados: arreglo_emp; min:
                 empleado_det);

Var 
    posMin:   integer;
    i:   integer;
Begin
    min := empleados[1];
    posMin := 1;
    For i:=2 To N Do
        Begin
            If (empleados[i].cod < min.cod )Then
                Begin
                    min := empleados[i];
                    posMin := i;
                End;
        End;
    leer(detalles[posMin], empleados[posMin]);
End;

Procedure actualizar(Var M: file_mae; Var detalles: arch_detalles
);

Var 
    reg_mae:   empleado_mae;
    min:   empleado_det;
    empleados:   arreglo_emp;
    i, totalDias:   Integer;
Begin
    For i:=1 To N Do
        Begin
            leer(detalles[i], empleados[i]);
        End;
    minimo(detalles, empleados, min);

    While (min.cod <> FIN) Do
        Begin
            totalDias := 0;
            While (min.cod <> reg_mae.cod) Do
                read(M, reg_mae);
            While ((min.cod = reg_mae.cod) And (min.cod <> FIN)) Do
                Begin
                    totalDias := totalDias + min.cantDiasLic;
                    minimo(detalles, empleados, min);
                End;

            If (totalDias <= reg_mae.cantDiasVac)Then
                Begin
                    reg_mae.cantDiasVac :=  reg_mae.cantDiasVac - totalDias;
                    Seek(M, FilePos(M) - 1);
                    Write(M, reg_mae);
                End
            Else
                WriteLn('error');
        End;
End;

Var 
    M:   file_mae;
    detalles:   arch_detalles;
    i:   integer;
Begin
    Assign(M, 'maestro.dat');
    Reset(M);
    For i:=1 To N Do
        Begin
            Assign(detalles[i],'det' + i);
            Reset(detalles[i]);
        End;

    actualizar(M,detalles);

    Close(M);
    For i:=1 To N Do
        Begin
            Close(detalles[i]);
        End;
End.
