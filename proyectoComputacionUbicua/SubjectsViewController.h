//
//  SubjectsViewController.h
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 11/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Activity.h"
#import "Calendar.h"
#import "Subject.h"

#import "JsonManager.h"
#import "ServicesManager.h"

@interface SubjectsViewController : UITableViewController{
    IBOutlet UILabel *SubjectName;
    IBOutlet UINavigationItem *navigationBar;
}

@property NSString *subjects;

-(void) saveInSubjects;

@end
