//
//  SamplerMatrixCell.m
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "SamplerMatrixCell.h"

@interface SamplerMatrixCell()

@property (weak, nonatomic) IBOutlet UIButton *button;

@property BOOL state;

@end

@implementation SamplerMatrixCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame]; if (self) self.state = false; return self;    
}


-(void) color: (UIColor*) color
{    
    [self.button setBackgroundColor: color];
}

/* --- Action Events --- */

- (IBAction)click:(UIButton*)button
{    
    UIColor *color = self.state
    ? [UIColor colorWithRed:35.0f/255.0f green:31.0f/255.0f blue:32.0f/255.0f alpha:1.0]
    : [UIColor colorWithRed:0.0f/255.0f green:187.0f/255.0f blue:226.0f/255.0f alpha:1.0];
    
    [self color: color]; self.state = !self.state; // toggler
}

@end
