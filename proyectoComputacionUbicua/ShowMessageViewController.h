//
//  ShowMessageViewController.h
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 21/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMessageViewController : UIViewController{

}

@property NSString *messages;

@property IBOutlet UILabel *name;
@property IBOutlet UILabel *date;
@property IBOutlet UITextView *text;

@end
