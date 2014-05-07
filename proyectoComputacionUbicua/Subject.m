//
//  Subject.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 12/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "Subject.h"

@implementation Subject

@synthesize activities, calendar, link, name;

-(NSMutableArray*)getCalendar{
    return self.calendar;
}


-(NSMutableArray*)getActivites{
    return self.activities;
}



@end
