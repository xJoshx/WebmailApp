//
//  CustomCell.h
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 08/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* cellName;
@property (nonatomic, weak) IBOutlet UILabel* cellDate;

@end
