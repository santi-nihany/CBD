
Program ej22;

Type 
    cd =   Record
        codAutor:   string;
        nombreAutor:   string;
        nombreCD:   string;
        generoCD:   string;
        cantVendida:   integer;
    End;

    cds =   file Of cd;

Procedure listar(Var arch: cds);

Var 
    reg, aux:   cd;
    totalDiscografica, totalGenero, totalAutor:   integer;
Begin
    totalDiscografica := 0;
    read(arch, reg);
    While (Not eof(arch)) Do
        Begin
            totalAutor := 0;
            Writeln('Autor: ', reg.nombreAutor);
            aux.cod := reg.codAutor;
            While ((reg.codAutor = aux.cod) And ((Not eof(arch)))) Do
                Begin
                    totalGenero := 0;
                    WriteLn('Genero: ', reg.generoCD);
                    aux.generoCD := reg.generoCD;
                    While ((reg.codAutor = aux.cod) And ((Not eof(arch))) And (
                          aux.generoCD = aux.generoCD)) Do
                        Begin
                            Writeln('Nombre disco: ', reg.nombreCD,
                                    ' cant vendida: ', reg.cantVendida);
                            totalGenero := totalGenero + 1;
                            read(arch,reg);
                        End;
                    totalAutor := totalAutor + totalGenero;
                    WriteLn('Total Genero: ', totalGenero);
                End;
            WriteLn('Total Autor: ', totalAutor);
            totalDiscografica := totalDiscografica + totalAutor;
        End;
    WriteLn('Total Discografica: ', totalDiscografica);
End;

Var 
    arch:   cds;
Begin
    Assign(arch, 'cds.dat');
    Reset(arch);
    listar(arch);
    Close(arch);
End.
