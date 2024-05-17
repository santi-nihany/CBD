{
    Se cuenta con un archivo que almacena información sobre especies de plantas originarias de
    Europa, de cada especie se almacena: código especie, nombre vulgar, nombre científico, altura
    promedio, descripción y zona geográfica. El archivo no está ordenado por ningún criterio.
    Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
    teclado los códigos de especies a eliminar.
        a. Implemente una alternativa para borrar especies, que inicialmente marque los
        registros a borrar y posteriormente compacte el archivo, creando un nuevo archivo
        sin los registros eliminados.
        b. Implemente otra alternativa donde para quitar los registros se deberá copiar el
        último registro del archivo en la posición del registro a borrar y luego eliminar del
        archivo el último registro de forma tal de evitar registros duplicados.
    Nota: Las bajas deben finalizar al recibir el código 100000
}

Program ej1;
Const 
    FIN='1000';
Type
    especie = record
        cod: string;
        nombreV: string;
        nombreC: string;
        altProm: real;
        desc: string;
        zonaG: string;
    end;

    fileEspecies = file of especie;

procedure marcarReg(var arch: fileEspecies; cod: string);
begin
    seek(arch, 0);
    while((not(eof(arch))) and (reg.cod <> cod))do
        read(arch, reg);
    if(reg.cod = cod)then begin
        reg.cod:= '@';
        seek(arch, filepos(arch)-1);
        Write(arch, reg);
    end;

end;

procedure eliminarA(var arch: fileEspecies; var nueArch: fileEspecies);
var 
    cod: string;
    reg: especie;
begin
    Reset(arch);
    Rewrite(nueArch);

    { marcar registros a eliminar }
    Writeln('Ingrese codigo a eliminar: ');
    Readln(cod);
    while(cod <> FIN)do begin
        marcarReg(arch, cod);
        Writeln('Ingrese codigo a eliminar: ');
        Readln(cod);
    end;
    
    { generar nuevo archivo }
    seek(arch, 0);
    if(not(eof(arch)))then 
        read(arch, reg);
    while(not(eof(arch))) do begin
        if(reg.cod <> '@')then 
            write(nueArch,reg);
        read(arch,reg);
    end;

    Close(arch);
    Close(nueArch);
end;

procedure eliminarB(var arch: fileEspecies);
var 
    reg: especie;
    cod: string;
begin
    Reset(arch);
    
    Writeln('Ingrese codigo a eliminar: ');
    Readln(cod);
    while(cod <> FIN)do begin
        seek(arch,0);
        while((not(eof(arch))) and (cod <> reg.cod ))do 
            read(arch, reg);
        if(cod = reg.cod)then begin
            posE:= filePos(arch) - 1;
            seek(arch, FileSize(arch) - 1);
            read(arch, aux);
            seek(arch, posE);
            write(arch, aux);
            seek(arch, FileSize(arch) - 1);
            Truncate(a);
        end;
        Writeln('Ingrese codigo a eliminar: ');
        Readln(cod);
    end;

    Close(arch);
end;

var 
    arch, nueArch: fileEspecies;
Begin
    Assign(arch,'especies.dat');
    Assign(nueArch,'nuevoEspecies.dat');

    eliminarA(arch, nueArch);

    eliminarB(arch)
End.