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

@end

@implementation SamplerMatrixCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        NSLog(@"state %d", self.state);
        
        self.state = false;
    }
    
    return self;
}


-(void) color: (UIColor*) color
{
    [self.button setBackgroundColor: color];
}


/* -------------------------------------- Action Events  --------------------------------------- */

- (IBAction)click:(UIButton*)button
{    
    UIColor *color = !self.state
    ? [UIColor colorWithRed:0.0f/255.0f green:187.0f/255.0f blue:226.0f/255.0f alpha:1.0]
    : [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.5];
    // : ;
    
    [self color: color]; self.state = !self.state; // toggler
}

@end
