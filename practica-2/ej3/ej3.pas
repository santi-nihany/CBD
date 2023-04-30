Program ej3; 

// Const 
//     N=20;
//     FIN='ZZZ';
// Type 
//     calzado_det = record
//         cod: string[4];
//         numero: integer;
//         cant_vendida: integer;
//     end;

//     calzado_mae = record 
//         cod: string[4];
//         numero: integer;
//         desc: string[30];
//         precio: real;
//         color: string[10];
//         stock: integer;
//         stock_min: integer;
//     end;

//     maestro = file of calzado_mae;
//     detalle = file of calzado_det;

//     detalles = array[1..N] of detalle;
//     locales = array[1..N] of calzado_det; {contiene registro actual de cada local de venta}

// procedure leer(var arch: detalle; var reg_det: calzado_det);
// begin
//     If (Not(EOF(arch))) then 
//         read(arch,reg_det)
//     else 
//         reg_det.cod:= FIN;
// end;

// procedure minimo(var a_detalles: detalles; var a_locales: locales; var reg_min: calzado_det);
// var
//     i, pos_min: integer;
// begin
//     reg_min:= a_locales[1];
//     pos_min:=1;
//     for i:=2 to N do begin
//         if(a_locales[i].cod < reg_min.cod) then begin
//             reg_min:= a_locales[i];
//             pos_min:=i;
//         end;
//     end;
//     leer(a_detalles[pos_min],a_locales[pos_min]);
// end;

// procedure actualizar(var arch_mae: maestro; var a_detalles: detalles; var arch_texto: Text );
// var 
//     i, cant_total_codigo: integer;
//     min: calzado_det;
//     reg_mae: calzado_mae;
//     a_locales: locales; 
// begin
//     reg_mae.cod := FIN;
//     for i:=1 to N do begin
//         Reset(a_detalles[i]);
//         leer(a_detalles[i], a_locales[i]);
//     end;
//     Reset(arch_mae);
//     Rewrite(arch_texto);

//     minimo(a_detalles, a_locales, min); {busco codigo minimo en archivos detalle}

//     while(min.cod <> FIN) do begin 
//         cant_total_codigo:=0;
//         while(min.cod <> reg_mae.cod) do {busco calzado en arch maestro} 
//             leer_mae(arch_mae, reg_mae);
//         while (reg_mae.cod = min.cod) and (min.cod <> FIN) do begin {busco en locales si se repite el codigo }
//             if(cant_total_codigo <= reg_mae.stock) then begin
//                 cant_total_codigo:= cant_total_codigo + min.cant_vendida;
//             end
//             else 
//                 WriteLn('NO se pudo procesar la venta del calzado ',reg_mae.cod, ' por falta de stock');
//             minimo(a_detalles,a_locales,min);
//         end;
//         if(reg_mae.stock < reg_mae.stock_min)then
//             WriteLn(arch_texto,reg_mae.cod);
//         reg_mae.stock:= reg_mae.stock - cant_total_codigo;
//         seek(arch_mae, filepos(M)-1);
//         write(arch_mae,reg_mae);
//     end;
// end;

// Var 
//     arch_mae: maestro;
//     arch_detalle: detalle;
//     arch_texto: Text;
//     a_detalles: detalles;
//     reg_det: calzado_det;
//     reg_mae: calzado_mae;
//     i:integer;
//     nombreDet: String;
Begin

//     Assign(arch_mae,'calzados.dat');
    
//     Assign(arch_texto,'calzadosinstock.txt');
    
//     for i:=1 to N do begin
//         WriteLn('Ingrese el nombre del archivo detalle');
//         readln(nombreDet);
//         Assign(a_detalles[i], nombreDet);
//     end;

//     actualizar(arch_mae, a_detalles, arch_texto);

//     for i:=1 to N do begin
//         Close(a_detalles[i]);
//     end;
//     Close(arch_mae);
//     Close(arch_texto);
End.