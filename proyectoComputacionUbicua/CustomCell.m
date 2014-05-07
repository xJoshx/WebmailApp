//
//  CustomCell.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 08/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize cellDate, cellName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
