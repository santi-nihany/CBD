{
    Una zapatería cuenta con 20 locales de ventas. Cada local de ventas envía un listado
    con los calzados vendidos indicando: código de calzado, número y cantidad vendida
    del mismo.
    El archivo maestro almacena la información de cada uno de los calzados que se
    venden, para ello se registra el código de calzado, número, descripción, precio unitario,
    color, el stock de cada producto y el stock mínimo.
    Escriba el programa principal con la declaración de tipos necesaria y realice un
    proceso que reciba los 20 detalles y actualice el archivo maestro con la información
    proveniente de los archivos detalle. Tanto el maestro como los detalles se encuentran
    ordenados por el código de calzado y el número.
    Además, se deberá informar qué calzados no tuvieron ventas y cuáles quedaron por
    debajo del stock mínimo. Los calzados sin ventas se informan por pantalla, mientras
    que los calzados que quedaron por debajo del stock mínimo se deben informar en un
    archivo de texto llamado calzadosinstock.txt.
    Nota: tenga en cuenta que no se realizan ventas si no se posee stock.
}
Program ej3;
const
    N= 20;
    FIN='ZZZ';
Type
    calzadoDet = record
        cod: string;
        numero: real;
        cantV: integer;
    end;

    calzadoMae = record
        cod: string;
        numero: real;
        desc:string;
        precio: real;
        color: string;
        stock: integer;
        stockMin: integer;
    end;

    fileDet = file of calzadoDet;
    fileMae =   file Of calzadoMae;

    a_detalles = array[1..N] of fileDet;
    a_actuales =   array[1..N] Of calzadoDet;

procedure leer(var arch:fileDet; var dato: calzadoDet);
begin
    if(not(eof(arch)))then
        read(arch, dato)
    else
        dato.cod:= FIN;
end;

procedure minimo(var detalles: a_detalles; var actuales: a_actuales; min: calzadoDet);
Var
    i,posMin: integer;
begin
    posMin:= 1;
    min:= actuales[1];
    for i:= 2 to N do begin
        if(((actuales[i].cod = min.cod) and (actuales[i].numero < min.numero)) or (actuales[i].cod < min.cod))then begin
            posMin:= i;
            min:= actuales[i];
        end;
    end;
    leer(detalles[posMin],actuales[posMin]);
end;
procedure actualizar(var M: fileMae;var detalles: a_detalles; var archTexto: Text);
var
    i: integer;
    actuales: a_actuales;
    min: calzadoDet;
    regM:calzadoMae;
begin
    min.cod:=FIN;
    Reset(M);
    Rewrite(archTexto);
    for i:=1 to N do begin
        Reset(detalles[i]);
        leer(detalles[i],actuales[i]);
    end;

    minimo(detalles, actuales, min);
    
    while(min.cod <> FIN) do begin
        if(not(eof(M))) then read(M, regM);
        while((regM.cod <> min.cod) and (regM.numero <> min.numero) and (not(eof(M))))do begin
            Writeln('El calzado con código ', regM.cod,' y numero ',regM.numero, 'no tuvo ventas.');
            read(M,regM);
        end;

        while((min.cod <> FIN)and (min.cod = regM.cod) and (min.numero = regM.numero)) do begin
            if(regM.stock >= min.cantV)then
                regM.stock:= regM.stock - min.cantV
            else
                Writeln('Stock no disponible');
            minimo(detalles, actuales, min);
        end;
        if(regM.stock < regM.stockMin) then 
            Writeln(archTexto, regM.cod, regM.numero, regM.stock);
        seek(M, filepos(M)-1);
        Write(M,regM);
    end;
    Close(M);
    Close(archTexto);
    for i:=1 to N do begin
        Close(detalles[i]);
    end;
end;
Var 
    archTexto: Text;
    M: fileMae;
    detalles: a_detalles;
    i:integer;
    nombreDet:String;
Begin
    Assign(M, 'maestro.dat');
    Assign(archTexto,'calzadosinstock.txt');
    for i:=1 to N do begin
        Writeln('Ingrese el nombre del archivo detalle ', i);
        Readln(nombreDet);
        Assign(detalles[i], nombreDet);
    end;

    actualizar(M, detalles, archTexto);
End.
