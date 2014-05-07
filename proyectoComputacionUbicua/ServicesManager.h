//
//  ServicesManager.h
//  TabedApp
//
//  Created by Ovidiu Moldovan on 07/05/13.
//  Copyright (c) 2013 Ovidiu Moldovan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServicesManager : NSObject

-(NSString*) descargarAsignaturas: (NSString*) usu segundo:(NSString*) pw;
-(NSString*) descargarMensajes: (NSString*) usu segundo:(NSString*) pw;
-(Boolean) guardarAsignaturas:(NSString*) asignaturas;
-(Boolean) guardarMensajes:(NSString*) mensajes;
-(NSString*) recuperarAsignaturas;
-(NSString*) recuperarMensajes;



@end
