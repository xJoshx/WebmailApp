//
//  CustomScheduleCell.h
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 12/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScheduleCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel* cellName;
@property (nonatomic, weak) IBOutlet UILabel* cellDate;
@property (nonatomic, weak) IBOutlet UILabel* cellLink;
@end
