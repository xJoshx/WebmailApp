//
//  JsonManager.h
//  TabedApp
//
//  Created by Ovidiu Moldovan on 07/05/13.
//  Copyright (c) 2013 Ovidiu Moldovan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subject.h"
#import "Calendar.h"
#import "Activity.h"
#import "Messages.h"

@interface JsonManager : NSObject

-(NSMutableArray*) sacarActividades: (NSDictionary*) lista;
-(NSMutableArray*) sacarCalendarios: (NSDictionary*) lista;
-(NSMutableArray *) parsearJsonMensajes:(NSString*) listaMensajes;
-(NSMutableArray *) parsearJsonAsignaturas:(NSString*) listaAsignaturas;
@end
