
Program ej6;

Type 
    libro =   Record
        ISBN:   integer;
        titulo:   string;
        anio:   integer;
        editorial:   String;
        genero:   String;
    End;
    fLibros =   file Of libro;

Var 
    librosTxt:   Text;
    librosBin:   fLibros;
    reg_libro:   libro;
Begin
    Assign(librosTxt,'libros.txt');
    Assign(librosBin,'libros.dat');
    Reset(librosTxt);
    Rewrite(librosBin);
    While (Not(eof(librosTxt))) Do
        Begin
            Writeln('HOLLAAAAASKNJNSAONOABFAEJBFIHEW');
            ReadLn(librosTxt, reg_libro.ISBN, reg_libro.titulo);
            ReadLn(librosTxt, reg_libro.anio, reg_libro.editorial);
            ReadLn(librosTxt, reg_libro.genero);
            Writeln(reg_libro.ISBN,'',reg_libro.titulo,'',reg_libro.anio,'',
                    reg_libro.editorial,
                    '',reg_libro.genero);
            Write(librosBin, reg_libro);
        End;
    Readln();
    close(librosTxt);
    close(librosBin);

End.
