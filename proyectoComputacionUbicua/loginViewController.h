//
//  loginViewController.h
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 22/04/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ServicesManager.h"
#import "ServicesManager.m"
#import "JsonManager.h"
#import "JsonManager.m"

@interface loginViewController : UIViewController<UITextFieldDelegate> {

    IBOutlet UITextField *textFieldUser, *textFieldPass;
    IBOutlet UIActivityIndicatorView *progressIndicator;
    
}

@property IBOutlet UIButton* loginButton;
@property UIAlertView *alertStatus;
@property bool *terminado;
@property bool *navegar;
@property NSString *user;
@property NSString *password;
@property NSString *subjects;
@property NSString * messages;

@end

