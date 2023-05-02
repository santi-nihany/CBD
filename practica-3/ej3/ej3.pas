Program ej3;

Const 
    FIN= 'ZZZZ';

Type 
    producto = record 
        cod: string[4];
        nombre: string[15];
        descripcion: string[100];
        stock: integer;
    end;

    productos = file of producto;

procedure leerArchBin(var arch: productos);
var 
    reg: producto;
begin
    Reset(arch);
    while(not(Eof(arch)))do begin
        read(arch, reg);
        WriteLn('Codigo: ', reg.cod);
        WriteLn('Nombre: ', reg.nombre);
        WriteLn('Desc: ', reg.descripcion);
        WriteLn('Stock: ', reg.stock);
        Writeln('-----------------------');
    end;

    Close(arch);
end;

procedure generarBinarioLogico(var archText: Text; var archBin: productos);
var 
    campo: string;
    reg_bin: producto;
    stock: integer; 
begin
    Reset(archText);
    Rewrite(archBin);
    ReadLn(archText, campo);
    while(not (Eof(archText)))do begin
        reg_bin.cod := campo; {asigno codigo}
        ReadLn(archText, campo); {leo nombre}
        reg_bin.nombre:= campo; {asigno nombre}
        ReadLn(archText, campo); {leo descripcion}
        reg_bin.descripcion := campo; {asigno descripcion}
        ReadLn(archText, campo); {leo stock}
        Val(campo, stock);
        reg_bin.stock := stock; {asigno stock}
        Write(archBin,reg_bin); { Escribo en archivo binario }
        ReadLn(archText,campo);
    end;

    Close(archText);
    Close(archBin);
end;

procedure marcarProductos(var arch: productos);
var
    cod: string;
    reg: producto;
begin
    Reset(arch);
    WriteLn('Ingrese el codigo del producto obsoleto (FIN="ZZZZ"): ');
    ReadLn(cod);
    while(cod <> FIN)do begin
        seek(arch,0);
        read(arch,reg);
        while(not(eof(arch)) and (cod <> reg.cod))do read(arch,reg);
        if(cod = reg.cod)then begin
            seek(arch,filePos(arch) - 1);
            reg.stock := -1;
            write(arch,reg);
        end;
        WriteLn('Ingrese el codigo del producto obsoleto (FIN="ZZZZ"): ');
        ReadLn(cod);
    end;
end;

procedure leerProducto (var reg: producto);
begin
    WriteLn('Ingrese el codigo del nuevo producto (FIN="ZZZZ"): ');
    ReadLn(reg.cod);
    if(reg.cod <> FIN) then begin
        WriteLn('Ingrese el nombre del nuevo producto: ');
        ReadLn(reg.nombre);
        WriteLn('Ingrese la descripcion del nuevo producto: ');
        ReadLn(reg.descripcion);
        WriteLn('Ingrese el stock del nuevo producto: ');
        ReadLn(reg.stock);
    end;

end;

procedure altaLogica(var arch: productos);
var
    reg_bin, reg_nue: producto;
begin
    Reset(arch);
    leerProducto(reg_nue);
    While (reg_nue.cod <> FIN) Do Begin
        read(arch,reg_bin);
        While (Not(eof(arch)) And (reg_bin.stock <> -1)) Do
            read(arch,reg_bin);
        if(reg_bin.stock = -1)then 
            seek(arch,FilePos(arch) - 1);
        Write(arch, reg_nue);
        leerProducto(reg_nue);
    End;

end;


procedure generarBinarioListaInv (var archText: Text;var archBin: productos);

Var 
    campo:   string;
    reg_bin:   producto;
    stock:   integer;
Begin
    Reset(archText);
    Rewrite(archBin);
    
    reg_bin.stock :=0;
    Write(archBin,reg_bin); {registro cabecera}

    ReadLn(archText, campo);
    While (Not (Eof(archText))) Do
        Begin
            reg_bin.cod := campo; {asigno codigo}
            ReadLn(archText, campo); {leo nombre}
            reg_bin.nombre := campo; {asigno nombre}
            ReadLn(archText, campo); {leo descripcion}
            reg_bin.descripcion := campo; {asigno descripcion}
            ReadLn(archText, campo); {leo stock}
            Val(campo, stock);
            reg_bin.stock := stock; {asigno stock}
            Write(archBin,reg_bin); { Escribo en archivo binario }
            ReadLn(archText,campo);
        End;
    Close(archText);
    Close(archBin);

end;

procedure bajaListaInv(var arch: productos);
var
    reg,cabe: producto;
    cod: string;
    posLibre: Integer;  
begin
    Reset(arch);
    WriteLn('Ingresar codigo de producto obsoleto (FIN="ZZZZ"):');
    ReadLn(cod);
    while(cod <> FIN) do begin {por cada codigo ingresado}
        seek(arch, 0);
        read(arch, reg);
        cabe := reg; {guardo reg de cabecera}
        while(not(Eof(arch)) and (reg.cod <> cod)) do
            read(arch,reg);
        if(reg.cod = cod)then begin
            posLibre :=  FilePos(arch) -1;
            seek(arch,posLibre);
            write(arch,cabe);
            seek(arch,0);
            reg.stock := posLibre;
            Write(arch, reg);
        end
        else 
            WriteLn('CODIGO DE PRODUCTO NO ENCONTRADO');
        WriteLn('Ingresar codigo de producto obsoleto (FIN="ZZZZ"):');
        ReadLn(cod);
    end;
    Close(arch);
end;

procedure altaListaInv(var arch: productos);
var
    reg_nue, reg_bin: producto;
    posLibre: Integer;
begin
    Reset(arch);
    leerProducto(reg_nue);
    While (reg_nue.cod <> FIN) Do Begin
        seek(arch,0);
        read(arch,reg_bin); {leo cabecera }
        posLibre:= reg_bin.stock; 
        if(posLibre = 0)then
            seek(arch, FileSize(arch)) {posiciono en final de archivo}
        else begin
            seek(arch, posLibre);
            Read(arch, reg_bin); {leo reg libre}
            seek(arch,0);
            write(arch, reg_bin); {reemplazo cabecera}
            seek(arch, posLibre); {posiciono en reg libre}
        end;
        write(arch, reg_nue);
        
        leerProducto(reg_nue);
    End;

    Close(arch);
end;


Var 
    archText: Text;
    archBin: productos;
    pref: string;
Begin
    Assign(archText,'productos.txt');
    Assign(archBin, 'productos.dat');

    WriteLn('Ingresar preferencia: ');
    WriteLn('Logica (L) o Fisica (F) ?');
    ReadLn(pref);

    if(pref = 'L')then begin
        generarBinarioLogico(archText, archBin);
        leerArchBin(archBin);

        marcarProductos(archBin);
        WriteLn('----------------------');
        leerArchBin(archBin);
    
        altaLogica(archBin);
        WriteLn('----------------------');
        leerArchBin(archBin);
    end
    else if (pref = 'F') then begin
        generarBinarioListaInv(archText, archBin);
        leerArchBin(archBin);
        
        bajaListaInv(archBin);
        WriteLn('----------------------');
        leerArchBin(archBin);

        altaListaInv(archBin);
        WriteLn('----------------------');
        leerArchBin(archBin);
    end;

    Writeln('Presione tecla Enter para finalizar');
    ReadLn();
End.