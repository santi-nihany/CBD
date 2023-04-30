Program ej4;

Const 
    N=20;
    FIN='ZZZZ';
Type 
    pelicula= record
        cod:string[4];
        nombre: string[15];
        genero: string[15];
        director: string[15];
        duracion: integer;
        fecha: string[11];
        asistentes: integer;
    end;

    cine = file of pelicula;
    cines = array[1..N] of cine;

    maestro = file of pelicula;

    peliculas = array[1..N] of pelicula; // registros de N archivos detalle

procedure leer (var arch: cine; var dato: pelicula);
begin
    if(not(EOF(arch)))then
        read(arch,dato)
    else
        dato.cod := FIN;
end;

procedure minimo(var detalles: cines; var pelis: peliculas; var min: pelicula);
var 
    i,posMin: integer;
begin
    min:= pelis[1];
    posMin:= 1;
    for i:=2 to N do begin
        if(pelis[i].cod < min.cod)then begin
            min:= pelis[i];
            posMin:= i;
        end;
    end;
    leer(detalles[posMin],pelis[posMin]);
end;

Procedure crearMaestro(var M: maestro; var detalles: cines);
var 
    i:integer;
    pelis: peliculas;
    min, peli: pelicula;
begin
    {inicializar archivos}
    Rewrite(M);
    for i:=1 to N do begin
        Reset(detalles[i]);
        leer(detalles[i],pelis[i]);
    end;
    {buscar cod de pelicula minimo}
    minimo(detalles,pelis,min);
    {iterar por cada codigo}
    while (min.cod <> FIN) do begin
        {asigno valores a peli (registro en maestro)}
        peli.cod := min.cod;
        peli.nombre := min.nombre;
        peli.nombre := min.nombre;
        peli.genero := min.genero;
        peli.director := min.director;
        peli.duracion := min.duracion;
        peli.fecha := min.fecha;
        peli.asistentes := 0;
        {iterar por cada codigo igual}
        while ((peli.cod = min.cod) and (min.cod <> FIN)) do begin
            {sumar asistentes de pelicula}
            peli.asistentes:= peli.asistentes + min.asistentes;
            minimo(detalles, pelis, min);
        end;
        {escribir en maestro}
        write(M,peli);      
    end;
end;
Var 
    detalles: cines;
    M: maestro;
    i:integer;
    nombre_arch: string;
Begin
    Assign(M, 'maestro.dat');
    
    for i:=1 to N do begin
      WriteLn('Ingrese el nombre del archivo detalle ',i);
      ReadLn(nombre_arch);
      Assign(detalles[i],nombre_arch);
    end;

    crearMaestro(M,detalles);

    Close(M);

    For i:=1 To N Do
    Begin
        Close(detalles[i]);
    End;

End.