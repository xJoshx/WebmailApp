//
//  ServicesManager.m
//  TabedApp
//
//  Created by Ovidiu Moldovan on 07/05/13.
//  Copyright (c) 2013 Ovidiu Moldovan. All rights reserved.
//

#import "ServicesManager.h"

@implementation ServicesManager


-(NSString*) descargarAsignaturas: (NSString*) usu segundo:(NSString*) pw{

    //ASignaturas
    NSString* url2=[NSString stringWithFormat:@"http://lab.gipsyz.com/services/asignaturas.py?user=%@&pw=%@", usu, pw];
    //textViewResultado.text=
    NSURL* url3=[NSURL URLWithString:url2];
    NSString* asig=[NSString stringWithContentsOfURL:url3 encoding:NSISOLatin1StringEncoding error:nil];
   
    return [asig stringByReplacingOccurrencesOfString:@"\n" withString:@""] ;
    


}

-(NSString*) descargarMensajes: (NSString*) usu segundo:(NSString*) pw{
    //MENSAJES
    NSString* url=[NSString stringWithFormat:@"http://lab.gipsyz.com/services/mensajes.py?user=%@&pw=%@", usu, pw];
    //textViewResultado.text=
    NSURL* url1=[NSURL URLWithString:url];
    NSString* mess=[NSString stringWithContentsOfURL:url1 encoding:NSISOLatin1StringEncoding error:nil];
    
    return [mess stringByReplacingOccurrencesOfString:@"\n" withString:@""] ;

}

-(Boolean) guardarAsignaturas:(NSString*) asignaturas{
    
    [[NSUserDefaults standardUserDefaults] setObject:asignaturas forKey:@"asignaturas"];
    
    return true;
}


-(Boolean) guardarMensajes:(NSString*) mensajes{
    
[[NSUserDefaults standardUserDefaults] setObject:mensajes forKey:@"mensajes"];

    return true;
}


-(NSString*) recuperarAsignaturas{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"asignaturas"];
}
-(NSString*) recuperarMensajes{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mensajes"];
}

@end
