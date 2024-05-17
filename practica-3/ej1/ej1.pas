
Program ej1;

Const 
    CAR =   '@';

Type 
    str15 =   string[15];
    especie =   Record
        cod:   string[4];
        nombre_v:   str15;
        nombre_c:   str15;
        alt_prom:   real;
        descripcion:   string[100];
        zona_geo:   str15;
    End;

    plantas =   file Of especie;

Procedure compactarArch(Var a: plantas; car:char; Var nueArch: plantas);

Var 
    reg_e:   especie; {registro de archivo}
Begin
    Rewrite(nueArch);
    read(a, reg_e);
    While (Not(eof(a))) Do
        Begin
            If (reg_e.cod <> car)Then
                Write(nueArch,reg_e);
            Read(a, reg_e);
        End;
End;

Procedure marcarReg(Var a: plantas; car: char; cod: String);

Var 
    reg_e:   especie; {registro de archivo}
Begin
    read(a,reg_e);
    While (Not(Eof(a)) And (reg_e.cod <> cod)) Do
        Begin
            read(a,reg_e);
        End;
    If (reg_e.cod = cod)Then
        Begin
            seek(a, filePos(a) - 1);
            reg_e.cod := car;
            Write(a,reg_e);
        End;
End;



{
    Elimina registros por codigo de archivo tipo 'plantas'. 
    Marca inicialmente los registros a borrar [marcarReg()] 
    y posteriormente compacta el archivo,creando un nuevo 
    archivo sin los registros eliminados [compactarArch()].
}
Procedure bajaLogica (Var a: plantas; car: char; Var nueArch: plantas);

Var 
    cod:   string[4];
Begin
    Reset(a);
    WriteLn('Ingrese codigo a eliminar: ');
    ReadLn(cod);
    While (cod <> 'ZZZZ') Do
        Begin
            marcarReg(a, CAR, cod);
            WriteLn('Ingrese codigo a eliminar: ');
            ReadLn(cod);
        End;

    compactarArch(a, CAR, nueArch);

    Close(a);
    Close(nueArch);
End;

Procedure borrarReg(Var a: plantas; cod: String);

Var 
    reg_e, aux:   especie; {registro de archivo y último registro}
    posBorrar:   Int64;
Begin
    read(a, reg_e);
    While (Not(Eof(a)) And (reg_e.cod <> cod)) Do
        Begin
            Read(a, reg_e);
        End;

    If (reg_e.cod = cod)Then
        Begin
            posBorrar := FilePos(a) - 1;
            seek(a,filesize(a) - 1); {pos último registro}
            read(a, aux);
            seek(a, posBorrar); {pos registro a borrar}
            write(a,aux); {reemplazo registro}
            seek(a,filesize(a) - 1); {pos último registro}
            Truncate(a); {elimino último registro}
        End;
End;



{
    Elimina registros por codigo de archivo tipo 'plantas'.
    Para eliminar los registros copia el último registro del 
    archivo en la posición del registro a borrar y luego
    elimina del archivo el último registro de forma tal de 
    evitar registros duplicados.
}
Procedure bajaFisica(Var a: plantas);

Var 
    cod:   string[4];
Begin
    Reset(a);
    WriteLn('Ingrese codigo a eliminar: ');
    ReadLn(cod);
    While (cod <> 'ZZZZ') Do
        Begin
            borrarReg(a,cod);
            WriteLn('Ingrese codigo a eliminar: ');
            ReadLn(cod);
        End;

    Close(a);

End;

Var 
    a, nueArch:   plantas;
Begin
    Assign(a, 'plantas.dat');
    Assign(nueArch, 'nuevoPlantas.dat');

    bajaLogica(a, CAR, nueArch);
    bajaFisica(a);
End.
