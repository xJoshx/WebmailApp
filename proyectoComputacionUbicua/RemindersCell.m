//
//  RemindersCell.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 04/06/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "RemindersCell.h"

@implementation RemindersCell

@synthesize Title, Content;

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
