Program ej1;

Const 
    CAR ='@';
Type 
    str15 = string[15];
    especie = record 
        cod: string[4];
        nombre_v: str15;
        nombre_c: str15;
        alt_prom: real;
        descripcion: string[100];
        zona_geo: str15;
    end;

    plantas = file of especie;

procedure compactarArch(var a: plantas; car:char; var nueArch: plantas);
var
    reg_e: especie; {registro de archivo}
begin
    Rewrite(nueArch);
    read(a, reg_e);
    while(not(eof(a)))do begin
        if(reg_e.cod <> car)then
            Write(a,reg_e);
        Read(a, reg_e);
    end;
end;

procedure marcarReg(var a: plantas; car: char; cod: string);
var
    reg_e: especie; {registro de archivo}
begin
    read(a,reg_e);
    while(not(Eof(a)) and (reg_e.cod <> cod)) do begin
        read(a,reg_e);
    end;
    if(reg_e.cod = cod)then begin
        seek(a, filePos(a) - 1);
        reg_e.cod := car;
        Write(a,reg_e);
    end;
end;

{
    Elimina registros por codigo de archivo tipo 'plantas'. 
    Marca inicialmente los registros a borrar [marcarReg()] 
    y posteriormente compacta el archivo,creando un nuevo 
    archivo sin los registros eliminados [compactarArch()].
}
procedure bajaLogica (var a: plantas; car: char; var nueArch: plantas);
var
    cod: string[4];
begin
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
end;

procedure borrarReg(var a: plantas; cod: string);
var
    reg_e, aux: especie; {registro de archivo y último registro}
    posBorrar: Int64;
begin
    read(a, reg_e);
    while(not(Eof(a)) and (reg_e.cod <> cod))do begin
        Read(a, reg_e);
    end;

    if(reg_e.cod = cod)then begin
        posBorrar:= FilePos(a) - 1;
        seek(a,filesize(a) - 1); {pos último registro}
        read(a, aux);
        seek(a, posBorrar); {pos registro a borrar}
        write(a,aux); {reemplazo registro}
        seek(a,filesize(a) - 1); {pos último registro}
        Truncate(a); {elimino último registro}
    end;
end;

{
    Elimina registros por codigo de archivo tipo 'plantas'.
    Para eliminar los registros copia el último registro del 
    archivo en la posición del registro a borrar y luego
    elimina del archivo el último registro de forma tal de 
    evitar registros duplicados.
}
procedure bajaFisica(var a: plantas);
var 
    cod: string[4];
begin
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

end;

Var 
    a, nueArch: plantas;  
Begin
    Assign(a, 'plantas.dat');
    Assign(nueArch, 'nuevoPlantas.dat');

    bajaLogica(a, CAR, nueArch);
    bajaFisica(a);
End.