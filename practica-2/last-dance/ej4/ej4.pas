{
    Una cadena de cines de renombre desea administrar la asistencia del público a las
    diferentes películas que se exhiben actualmente. Para ello cada cine genera
    semanalmente un archivo indicando: código de película, nombre de la película, género,
    director, duración, fecha y cantidad de asistentes a la función. Se sabe que la cadena
    tiene 20 cines. Escriba las declaraciones necesarias y un procedimiento que reciba los
    20 archivos y un String indicando la ruta del archivo maestro y genere el archivo
    maestro de la semana a partir de los 20 detalles (cada película deberá aparecer una
    vez en el maestro con los datos propios de la película y el total de asistentes que tuvo
    durante la semana). Todos los archivos detalles vienen ordenados por código de
    película. Tenga en cuenta que en cada detalle la misma película aparecerá tantas
    veces como funciones haya dentro de esa semana.
}

Program ej4;
Const 
    N=20;
    FIN='ZZZ';
Type
    peliculaDet = record
        cod: string;
        nombre: string;
        genero: string;
        director: string;
        duracion: integer;
        fecha: string;
        asistentes: integer;
    end;

    peliculaMae = record
        cod: string;
        nombre: string;
        genero: string;
        director: string;
        duracion: integer;
        asistentes: integer;
    end;

    fileDet = file Of peliculaDet;
    fileMae = file of peliculaMae;

    a_detalles = array[1..N] of fileDet;
    a_actuales = array[1..N] of peliculaDet;
Procedure leer(Var arch:fileDet; Var dato: peliculaDet);
Begin
    If (Not(eof(arch)))Then
        read(arch, dato)
    Else
        dato.cod := FIN;
End;

procedure minimo(var detalles: a_detalles; var actuales: a_actuales; var min: peliculaDet);
var
    i,posMin: integer;
begin
    min:= actuales[1];
    posMin:=1;
    for i:=2 to N do begin
        if(actuales[i].cod < min.cod) then begin
            posMin:=i;
            min:= actuales[i];
        end;
    end;
    leer(detalles[posMin],actuales[posMin]);
end;

procedure merge(var M: fileMae; var detalles: a_detalles);
var 
    min:peliculaDet;
    actuales: a_actuales;
    i:integer;
    regM: peliculaMae;
begin
    min.cod:= FIN;
    Rewrite(M);
    for i:=1 to N do begin
        Reset(detalles[i]);
        leer(detalles[i], actuales[i]);
    end;

    minimo(detalles,actuales, min);
    while(min.cod <> FIN)do begin
        regM.cod:= min.cod;
        regM.nombre := min.nombre;
        regM.genero := min.genero;
        regM.director := min.director;
        regM.duracion := min.duracion;
        regM.asistentes := 0;
        while(min.cod <> FIN) and (min.cod = regM.cod )do begin
            regM.asistentes := regM.asistentes + min.asistentes;
            minimo(detalles, actuales, min);
        end;
        Write(M,regM);
    end;

    Close(M);
    For i:=1 To N Do
    Begin
        Close(detalles[i]);
    End;

end;

Var
    M: fileMae;
    detalles: a_detalles;
    i: integer;
    nombreDet: string;
Begin
    Assign(M, 'maestro.dat');
    for i:=1 to N do begin
        ReadLn(nombreDet);
        Assign(detalles[i], nombreDet);
    end;
    merge(M, detalles);
End.