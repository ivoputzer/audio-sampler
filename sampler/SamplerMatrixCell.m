//
//  SamplerMatrixCell.m
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "SamplerMatrixCell.h"

@interface SamplerMatrixCell()

@property (weak, nonatomic) IBOutlet UIImageView *image;

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
    [self.image setAlpha:1];
}

/* --- Action Events --- */

- (IBAction)click:(UIButton*)button
{
    [button setBackgroundColor:[UIColor colorWithRed:35.0f/255.0f green:31.0f/255.0f blue:32.0f/255.0f alpha:1.0]];
    
    
    /*if(tones[[button getI]][[button getJ]]){
     

    }
    else {
        [button setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:187.0f/255.0f blue:226.0f/255.0f alpha:1.0]];
    }
    tones[[button getI]][[button getJ]] = tones[[button getI]][[button getJ]] ? false : true;*/
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
