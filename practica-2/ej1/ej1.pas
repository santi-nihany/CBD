Program ej1;
const 
    valoralto = 9999;
    N = 10;
Type
    empleado = record
        cod: integer;
        nombre: string;
        apellido: string;
        fechaNac: string;
        direccion: string;
        cantHijos: integer;
        telefono: string;
        cantVacaciones: integer;
    end;
    
    actualizacion = record 
        cod:integer;
        fecha:string;
        diasLicencia:integer;
    end;

    maestro = file of empleado;
    detalle = file of actualizacion;

    actualizaciones = array[1..N] of actualizacion; // registro actualizacion actual de N archivos
    detalles = array[1..N] of detalle; // N archivos detalle recibidos
Procedure leer(var det: detalle; var reg_d: actualizacion);
begin
    if Not(EOF(det))then 
    begin
        read(det,reg_d);
    end
    else
        reg_d.cod:= valoralto;
end;

Procedure minimo(var detalles: detalles; var acts: actualizaciones; var min: actualizacion);
var
    i, posMin:integer;
begin
    min:= acts[1];
    posMin:=1;
    for i:=2 to N do 
    begin
        if(acts[i].cod < min.cod) then
        begin
            min:= acts[i];
            posMin:= i;
        end;
    end;
    leer(detalles[posMin], acts[posMin]);
end;

Procedure actualizar(var M: maestro; var dets: detalles; var arch_error: Text);
var
    i, totalDias: integer;
    acts: actualizaciones;
    min:actualizacion;
    reg_m: empleado;
begin
    reg_m.cod:= valoralto;
    for i:=1 to N do 
    begin
      Reset(dets[i]); {se abren los archivos detalle}
      leer(dets[i],acts[i]) {se lee el primer elemento de cada uno}
    end;
    Reset(M);
    ReWrite(arch_error);
    minimo(dets, acts, min); {se busca el detalle con codigo minimo}
    
    While(min.cod <> valoralto) do 
    begin
        totalDias:= 0;
        while (min.cod <> reg_m.cod) do 
            read(M, reg_m); {buscar codigo de detalle en archivo maestro}
        while(reg_m.cod = min.cod) and (min.cod <> valoralto) do
        begin
            totalDias := totalDias + min.diasLicencia;
            minimo(dets,acts,min);
        end;
        if(totalDias > reg_m.cantVacaciones) then
            WriteLn(arch_error, reg_m.cod, reg_m.nombre, reg_m.apellido, reg_m.cantVacaciones, totalDias) {escribir error en .txt}
        else begin
            reg_m.cantVacaciones := reg_m.cantVacaciones - totalDias;
            seek(M, filepos(M)-1); {se reubica el puntero en el maestro}
            write(M, reg_m); {se actualiza cantVacaciones en archivo maestro}
        end; 
    end;

    close(M);
    close(arch_error);
    
    for i:=1 to N do 
        Close(dets[i]);
end;
Var
    arch_maestro: maestro;
    i : integer;
    nombreDet: String;
    a_detalles: detalles;
    arch_error: Text; 
Begin
    Assign(arch_maestro, 'empleados.dat');
    
    Assign(arch_error, 'error.txt');

    for i:=1 to N do 
    begin
      WriteLn('Ingrese el nombre del archivo detalle');
      readln(nombreDet);
      Assign(a_detalles[i], nombreDet);
    end;
    actualizar(arch_maestro,a_detalles, arch_error);

    For i:=1 To N Do
    Begin
        Close(a_detalles[i]);
    End;
    Close(arch_maestro);
    Close(arch_error);
End.