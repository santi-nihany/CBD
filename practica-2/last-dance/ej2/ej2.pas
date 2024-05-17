











{
    Se necesita contabilizar los CD vendidos por una discográfica. Para ello se dispone de
    un archivo con la siguiente información: código de autor, nombre del autor, nombre
    disco, género y la cantidad vendida de ese CD. Realizar un programa que muestre un
    listado como el que se detalla a continuación. Dicho listado debe ser mostrado en
    pantalla y además listado en un archivo de texto. En el archivo de texto se debe listar
    nombre del disco, nombre del autor y cantidad vendida. El archivo origen está
    ordenado por código de autor, género y nombre disco.
    Autor: _____
    Género: ----------
    Nombre Disco: ---------- cantidad vendida: ------------
    Nombre Disco: ---------- cantidad vendida: ------------
    Total Género:
    Género:----------
    Nombre Disco: ---------- cantidad vendida: ------------
    …….
    Total Autor:
    Total Discográfica:
}

Program ej2;

Const 
    FIN =   'ZZZ';

Type 
    CD =   Record
        codA:   string;
        nombreA:   string;
        nombreD:   string;
        genero:   string;
        cantV:   integer;
    End;

    fMaestro =   file Of CD;

Procedure leer(Var arch: fMaestro; Var dato: CD);
Begin
    If (Not(eof(arch)))Then
        read(arch,dato)
    Else
        dato.codA := FIN;
End;

Var 
    M:   fMaestro;
    archTexto:   Text;
    regM,act:   CD;
    totalDiscografica, totalAutor, totalGenero:   integer;

Begin
    Assign(M, 'discos.dat');
    Assign(archTexto, 'discos.txt');
    Reset(M);
    Rewrite(archTexto);

    totalDiscografica := 0;
    leer(M, regM);
    While (regM.codA <> FIN) Do
        Begin
            Writeln('Autor: ', regM.nombreA);
            Writeln(archTexto, 'Autor: ', regM.nombreA);
            act.codA := regM.codA;
            totalAutor := 0;
            While ((act.codA = regM.codA) And (regM.codA <> FIN)) Do
                Begin
                    Writeln('Genero: ', regM.genero);
                    Writeln(archTexto, 'Genero: ', regM.genero);
                    act.genero := regM.genero;
                    totalGenero := 0;
                    While ((act.codA = regM.codA) And (act.genero = regM.genero)
                          And (regM.codA <> FIN)) Do
                        Begin
                            Writeln('Disco: ', regM.nombreD,
                                    ' cantidad vendida: ', regM.cantV);
                            Writeln(archTexto, 'Disco: ', regM.nombreD,
                                    ' cantidad vendida: ', regM.cantV);
                            totalDiscografica := totalDiscografica + regM.cantV;
                            totalGenero := totalGenero + regM.cantV;
                            totalAutor := totalAutor + regM.cantV;
                            leer(M, regM);
                        End;
                    Writeln('Total Genero: ', totalGenero);
                    Writeln(archTexto, 'Total Genero: ', totalGenero);
                End;
            Writeln('Total Autor: ', totalAutor);
            Writeln(archTexto, 'Total Autor: ', totalAutor);
        End;
    Writeln('Total Discografica: ', totalDiscografica);
    Writeln(archTexto, 'Total Discografica: ', totalDiscografica);

    Close(M);
    Close(archTexto);
End.
