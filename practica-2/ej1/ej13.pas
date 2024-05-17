
Program ej13;

Const 
    FIN =   9999;

Type 
    regDet =   Record
        cod:   integer;
        fecha:   string;
        diasLic:   integer;
    End;

    empleado =   Record
        cod:   integer;
        nombre:   string;
        apellido:   string;
        cantVac:   integer;
    End;

    archMae =   file Of empleado;
    archDet =   file Of regDet;

    detalles =   array[1..N] Of archDet;
    empleados =   array[1..N] Of empleado;

Procedure leer(Var arch: archDet; Var reg: regDet);
Begin
    If (Not(eof(arch)))Then
        read(arch,reg)
    Else
        reg.cod := FIN;
End;

Procedure minimo (Var a_detalles: detalles; Var a_actuales: empleados; Var min:
                  regDet);

Var 
    i,posMin:   integer;
Begin
    min := a_actuales[1];
    posMin := 1;
    For i:=2 To N Do
        Begin
            If (a_actuales[i].cod < min)Then
                Begin
                    min := a_actuales[i];
                    posMin := i;
                End;
        End;
    leer(a_detalles[posMin],a_actuales[posMin]);
End;

Procedure actualizar(Var M: archMae; Var a_detalles:detalles);

Var 
    i:   integer;
    a_actuales:   empleados;
    min:   regDet;
    regM:   empleado;
Begin
    For i:=1 To N Do
        Begin
            leer(a_detalles[i], a_actuales[i]);
        End;

    minimo(a_detalles,a_actuales,min);
    While (min.cod <> FIN) Do
        Begin
            cantTotal := 0;
            regM.cod := 999;
            aux.cod := min.cod;
            While (min.cod <> regM.cod) Do
                read(archMae,regM);

            If (min.cod = regM.cod)Then
                Begin
                    While ((min.cod <> FIN ) And (min.cod = aux.cod)) Do
                        Begin
                            cantTotal := cantTotal + min.diasLic;
                            minimo(a_detalles,a_actuales,min);
                        End;
                    regM.cantVac := regM.cantVac - cantTotal;
                    seek(filePos(M)-1);
                    Write(M,regM);
                End;
        End;
End;



Var 
    M:   archMae;
    a_detalles:   detalles;
    i:   integer;


Begin
    Assign(M, 'maestro.dat');
    Reset(M);

    For i:=1 To N Do
        Begin
            Assign(a_detalles[i], 'det'+i);
            Reset(a_detalles[i]);
        End;

    actualizar(M,a_detalles);

    Close(M);

    For i:=1 To N Do
        Begin
            Close(a_detalles[i]);
        End;

End.
