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

- (id)initWithFrame:(CGRect)frame { self = [super initWithFrame:frame]; return self; }

-(void) color: (UIColor*) color { [self.button setBackgroundColor: color]; }

/* -------------------------------------- Action Events  --------------------------------------- */

- (IBAction)click:(UIButton*)button
{
    [self.delegate cell:self index:self.index];
}

@end
