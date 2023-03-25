
Program EJ5;

Const 
    FIN =   'zzz';

Type 
    flores =   Record
        nro_esp:   integer;
        alt_max:   integer;
        nombreC:   String;
        nombreV:   String;
        color:   String;
    End;
    arch_flores =   file Of flores;

Procedure leerFlor(Var reg_flores: flores);
Begin
    WriteLn('Ingrese nombre cientifico');
    ReadLn(reg_flores.nombreC);
    If (reg_flores.nombreC <> FIN)Then
        Begin
            WriteLn('Ingrese numero de especie');
            ReadLn(reg_flores.nro_esp);
            WriteLn('Ingrese altura maxima');
            ReadLn(reg_flores.alt_max);
            WriteLn('Ingrese nombre vulgar');
            ReadLn(reg_flores.nombreV);
            WriteLn('Ingrese color');
            ReadLn(reg_flores.color);
        End;
End;

Procedure min_max_altura(Var altura: integer;nombre: String; min_alt: integer;
                         max_alt:integer; min_alt_nombre: String;
                         max_alt_nombre:String);
Begin
    If (altura > max_alt)Then
        Begin
            max_alt := altura;
            max_alt_nombre := nombre;
        End;
    If (altura < min_alt)Then
        Begin
            min_alt := altura;
            min_alt_nombre := nombre;
        End;
End;

Procedure listarArchivo(Var arch: arch_flores);

Var 
    flor:   flores;
Begin
    Reset(arch);
    While (eof(arch)) Do
        Begin
            Read(arch, flor);
            WriteLn('N°: ', flor.nro_esp,' Alt max: ', flor.alt_max,
                    ' Nombre C: '
                    ,flor.nombreC,' Nombre V: ', flor.nombreV,' Color: ', flor.
                    color);
        End;
End;

Var 
    archivo_bin:   arch_flores;
    reg_flores:   flores;
    especies, max_alt, min_alt,opcion:   integer;
    min_alt_nombre, max_alt_nombre:   String;
Begin
    // Inicializadores
    especies := 0;
    min_alt := 999;
    max_alt := -1;
    min_alt_nombre := '';
    max_alt_nombre := '';

    //archivo registros de flores
    Assign(archivo_bin, 'flores');
    Rewrite(archivo_bin);

    // leer until FIN
    leerFlor(reg_flores);
    While (reg_flores.nombreC <> FIN) Do
        Begin
            //contador
            especies := especies + 1;
            //checkear max,min altura
            If (reg_flores.alt_max > max_alt)Then
                Begin
                    max_alt := reg_flores.alt_max;
                    max_alt_nombre := reg_flores.nombreC;
                End;
            If (reg_flores.alt_max < min_alt)Then
                Begin
                    min_alt := reg_flores.alt_max;
                    min_alt_nombre := reg_flores.nombreC;
                End;

            // escribir archivo
            Write(archivo_bin, reg_flores);
            leerFlor(reg_flores);
        End;
    Close(archivo_bin);

    WriteLn('Seleccione una de las siguientes opciones: ');
    WriteLn(
'1) Reportar en pantalla la cantidad total de especies y la especie de menor y de mayor altura a alcanzar'
    );


// WriteLn('2) Listar todo el contenido del archivo de a una especie por línea.');


// WriteLn('3) Modificar el nombre científico de la especie flores cargada como: Victoria amazonia a: Victoria amazonica.');


// WriteLn('4) Añadir una o más especies al final del archivo con sus datos obtenidos por teclado. La carga finaliza al recibir especie “zzz”.');


// WriteLn('5) Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”');
    WriteLn('6) Finalizar.');
    ReadLn(opcion);

    Case opcion Of 
        1:
             Begin
                 WriteLn('Cantidad total de especies: ',especies);
                 WriteLn('Nombre mayor altura maxima: ',max_alt_nombre);
                 WriteLn('Nombre menor altura maxima: ',min_alt_nombre);
             End;
        // 2:
        //      Begin
        //          Assign(archivo_bin, 'flores');
        //          listarArchivo(archivo_bin);

        //      End;
        // 3:   modificarNombre();
        // 4:   anadirespecies(archivo_bin);
        // 5:   convertir_txt(archivo_bin);
        6:   WriteLn('');
        Else   WriteLn('Opcion no disponible');
    End;
End.
