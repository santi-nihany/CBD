
Program ej42;

Const 
    N =   20;
    FIN =   'ZZZ';

Type 

    pelicula =   Record
        cod:   string;
        nombre:   string;
        genero:   string;
        director:   string;
        duracion:   string;
        fecha:   string;
        asistentes:   integer;
    End;

    cine =   file Of pelicula;

    a_cines =   array[1..N] Of cine;
    a_detalles =   array[1..N] Of pelicula;

Procedure leer(Var arch: cine; Var reg: pelicula );
Begin
    If (Not(Eof(arch)))Then
        read(arch,reg)
    Else
        reg.cod := FIN;
End;

Procedure minimo(Var cines: a_cines; Var detalles: a_detalles; Var min: pelicula
                 ;);

Var 
    posMin,i:   integer;
Begin
    min := detalles[1];
    posMin := 1;
    For i:=2 To N Do
        Begin
            If (detalles[i].cod < min.cod)Then
                Begin
                    posMin := i;
                    min := detalles[i];
                End;
        End;
    leer(cines[posMin], detalles[posMin]);
End;

Procedure generarMae(Var cines: a_cines; rutaM: String);

Var 
    M:   cine;
    i:   integer;
    detalles:   a_detalles;
    min,peli:   pelicula;
Begin
    Assign(M, rutaM);
    Rewrite(M);

    For i:=1 To N Do
        Begin
            leer(cines[i], detalles[i]);
        End;

    minimo(cines, detalles, min);

    While (min.cod <> FIN) Do
        Begin
            peli.cod := min.cod;
            peli.nombre := min.nombre;
            peli.genero := min.genero;
            peli.director := min.director;
            peli.duracion := min.duracion;
            peli.fecha := min.fecha;
            peli.asistentes := 0;
            While ((min.cod <> FIN) And (min.cod = peli.cod) ) Do
                Begin
                    peli.asistentes := peli.asistentes + min.asistentes;
                    minimo(cines,detalles,min);
                End;
            write(M, peli);
        End;
    Close(M);
End;

Var 
    cines:   a_cines;
    rutaM:   string;
    i:   integer;
Begin
    For i:=1 To N Do
        Begin
            Assign(cines[i],'det'+ i);
            Reset(cines[i]);

        End;

    generarMae(cines,rutaM);

    For i:=1 To N Do
        Begin
            Close(cines[i]);
        End;

End.
