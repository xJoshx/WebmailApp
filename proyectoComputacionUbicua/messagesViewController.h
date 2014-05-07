//
//  messagesViewController.h
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 01/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messagesViewController : UITableViewController{
    
    IBOutlet UILabel* nameLabel;
    
    IBOutlet UILabel* dateLabel;
    
    IBOutlet UIStoryboardSegue* paso;
 
}

@property (nonatomic, strong) NSString *messages;


@end
