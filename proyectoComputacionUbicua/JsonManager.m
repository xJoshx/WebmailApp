//
//  JsonManager.m
//  TabedApp
//
//  Created by Ovidiu Moldovan on 07/05/13.
//  Copyright (c) 2013 Ovidiu Moldovan. All rights reserved.
//

#import "JsonManager.h"

@implementation JsonManager

//recuperar la lista de Actividades
-(NSMutableArray*) sacarActividades: (NSDictionary*) lista{
     NSLog(@"Vamos a obtener las actividades. Lista: %@", lista);
    //creamos una array
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    //para cada actividad en la lista
    for (id actividad in lista) {
      //   NSLog(@"\nSe ha recuperado la siguiente actividad:%@\n",[actividad valueForKey:@"Nombre"]);
        //crear un objeto Actividad
        Activity *activ=[[Activity alloc]init];
        //guardar el nombre
        activ.name=[actividad valueForKey:@"Nombre"];
        
        //guardar el link
        activ.link =[actividad valueForKey:@"Link"];
        
        //añadir Actividad a la lista de actividades
        [list addObject:activ];
    }
    //devolver lista
    return list;
}

//recuperar la lista de entradas de Calendario
-(NSMutableArray*) sacarCalendarios: (NSDictionary*) lista{
    NSLog(@"Vamos a obtener las entradas de calendario. Lista: %@", lista);
    
        //creamos una array
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    
    
    //para cadaentrada en la lista
    for (id calendario in lista) {
       //  NSLog(@"\nSe ha recuperado la siguiente entrada:%@\n",[calendario valueForKey:@"Descripcion"]);
        //crear un objeto calendario y guardar sus propiedades, nombre fecha etc.
        
        Calendar *cal=[[Calendar alloc]init];
        cal.name=[calendario valueForKey:@"Nombre"];
        
        //la fecha será en formato string
        cal.date =[calendario valueForKey:@"Fecha"];
        cal.type = [calendario valueForKey:@"Tipo"];
        cal.description = [calendario valueForKey:@"Descripcion"];
        
        //añadir Calendario a la lista de entradas de calendario
        [list addObject:cal];
    }
      //devolver lista
    return list;
    
   }


//devuelve un array con todas las asignaturas
-(NSMutableArray *) parsearJsonAsignaturas:(NSString*) listaAsignaturas{
    NSLog(@"\n Vamos a parsear las asignaturas\n");
    
    //creamos una array para guardar las asignaturas
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    
    //creamos el objeto (parseando) que guardara las asignaturas con codificación UTF8
    NSData *jsonData = [listaAsignaturas dataUsingEncoding:NSUTF8StringEncoding];
    
    //error
    NSError *e=nil;
  
    //creamos el objeto JSON que guardara las asignaturas con codificación UTF8
    NSArray *jsonList = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    
    //si hay un error advertir
    if (!jsonList) {
        NSLog(@"Error parsing JSON: %@", e);
        
    } else{
        
        
        //para cada asignatura de la lista
        for (id asig  in jsonList) {
            NSLog(@"\nSe ha recuperado la siguiente asignatura:%@\n",[asig valueForKey:@"Nombre"]);
            
         //creamos un objeto Asignatura
            Subject *subject=[[Subject alloc]init];
        //le añadimos las propiedades inmediatas
            subject.name =[asig valueForKey:@"Nombre"];
            subject.link=[asig valueForKey:@"Link"];
            //  NSLog(@"\nActividades:\n");
            
           //obtenemos las actividades de la asignatura en formato NSDictionary
            NSDictionary *act=[asig valueForKey:@"Activitidades"];
            //TODO: borrar
               NSLog(@"Parsing Activities JSON: %@", act);
                     
            //si hay actividades guardarlas
            if(act.count>0){
                
                subject.activities=[self sacarActividades:act];
                
                NSLog(@"Activities JSON: %@", subject.activities);
                
                
            }
            
            
            //obtenemos las entradas a calendario de la asignatura en formato NSDictionary
            NSDictionary* cal=[asig valueForKey:@"Calendar"];
            //TODO: borrar
            NSLog(@"Error parsing Calendario JSON: %@", cal);

            
            
            //  si hay entradas de calendario guardar
            if(cal.count>0){
                subject.calendar=[self sacarCalendarios:cal];
                NSLog(@"Error parsing Calendario JSON: %@", subject.calendar);
            }
            
            //añadir asignatura a la lista
            [list addObject:subject];
        }
        
        return list;
    }
    
    return nil;
}

//devuelve un array con todos los mensajes
-(NSMutableArray *) parsearJsonMensajes:(NSString*) listaMensajes{
    
    //creamos una array para guardar los mensajes
    NSMutableArray *list = [[NSMutableArray alloc] init];

    //creamos el objeto (parseando) que guardara los mensajes con codificación UTF8

    NSData *jsonData = [listaMensajes dataUsingEncoding:NSUTF8StringEncoding];
    
           //error
    NSError *e=nil;
    
    //creamos el objeto JSON que guardara los mensajes con codificación UTF8
    NSArray *jsonList = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
   
    //si hay un error advertir
    if (!jsonList) {
        NSLog(@"Error parsing JSON: %@", e);
    
    } else{
        NSLog(@"\nMensajes recuperadas:\n");
        
        //para cada asignatura de la lista
        for (id mensaje  in jsonList) {
           // NSLog(@"\nSe ha recuperado el siguiente mensaje \n del día:%@\n de:%@\n",[mensaje valueForKey:@"Nombre"],[mensaje valueForKey:@"De"]);

            //creamos un nuevo objeto de mensajes
            Messages *m=[[Messages alloc]init];
            
            //guardamos su contenido
            m.Text=[mensaje valueForKey:@"Contenido"];
            m.Sender=[mensaje valueForKey:@"De"];
            m.Date=[mensaje valueForKey:@"Fecha"];
            
            
            [list addObject:m];
        }
        return list;
        
    }
    
    return nil;
}

@end
