//
//  Subject.h
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 12/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject

    @property NSString *name;
    @property NSString *link;
    @property NSMutableArray *activities;
    @property NSMutableArray *calendar;


-(NSMutableArray*)getCalendar;

-(NSMutableArray*)getActivites;

@end



