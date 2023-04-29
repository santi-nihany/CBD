Program ej2;

Const 
    FIN = 'ZZZ';
Type 
    cd = record
        cod_autor: string[4];
        nom_autor: string[10];
        nom_disco: string[10];
        genero: string[10];
        cant_vendida: integer;
    end;

    cds = file of cd; 

Procedure leer(var arch: cds; var dato:cd);
begin
    If (Not(EOF(arch))) Then
        read (arch, dato)
    Else
        dato.cod_autor := FIN;
end;
Var 
    archivo_cds: cds;
    archivo_texto: Text;
    cod_autor_act: string[4];
    genero_act: string[10];
    total_genero, total_autor, total_discografica: integer;
    reg_cd: cd;
Begin
    Assign(archivo_texto, 'discografica.txt');
    Rewrite(archivo_texto);
    
    Assign(archivo_cds, 'archivoCds.dat');
    Reset(archivo_cds);

    WriteLn('Discografica bla bla:'); WriteLn;
    leer(archivo_cds, reg_cd); {leo registro}
    total_discografica:=0;
    while(reg_cd.cod_autor <> FIN) do begin {itero por cada codigo de autor}
        cod_autor_act:= reg_cd.cod_autor; {actualizo codigo de autor actual}
        WriteLn('Autor: ', cod_autor_act);
        WriteLn(archivo_texto,'Autor: ', cod_autor_act);
        total_autor:=0;
        while (reg_cd.cod_autor = cod_autor_act) do begin
            genero_act := reg_cd.genero; {actualizo genero actual, específico del autor}
            WriteLn('Genero: ', genero_act); WriteLn;
            WriteLn(archivo_texto, 'Genero: ', genero_act);WriteLn(archivo_texto,'');
            total_genero:=0;
            While (reg_cd.cod_autor = cod_autor_act) and (reg_cd.genero = genero_act) do begin {recorro por genero}
                WriteLn('Nombre disco: ',reg_cd.nom_disco, ' cantidad vendida: ', reg_cd.cant_vendida);
                WriteLn(archivo_texto, 'Nombre disco: ',reg_cd.nom_disco, ' cantidad vendida: ', reg_cd.cant_vendida);
                total_genero:= total_genero + 1;
                total_autor:= total_autor + 1;
                total_discografica := total_discografica + 1;
                leer(archivo_cds, reg_cd); {leo registro}
            end;
            WriteLn('Total Genero: ', total_genero);
            WriteLn(archivo_texto, 'Total Genero: ', total_genero);
        end;
        WriteLn('Total Autor: ', total_autor);
        WriteLn(archivo_texto, 'Total Autor: ', total_autor);
    end;
    WriteLn('Total Discografica: ', total_discografica);
    WriteLn(archivo_texto, 'Total Discografica: ', total_discografica);
End.

