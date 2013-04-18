//
//  BundleTableCell.m
//  sampler
//
//  Created by Ivo von Putzer on 18/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "SampleTableCell.h"

#import <AVFoundation/AVFoundation.h>

@interface SampleTableCell()

@property (strong, nonatomic) AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *addIcon;

@property NSDictionary *info;

@property (weak, nonatomic) IBOutlet UILabel *activationFlag;

@end

@implementation SampleTableCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]; return self;
}

-(SampleTableCell*)withInfo:(NSDictionary *)info
{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:info[@"file"] ofType:@"wav"]];
        
    [self setPlayer:[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil]]; [self.player prepareToPlay];
    
    [self setInfo:info];
    
    [self.icon setImage:[UIImage imageNamed:info[@"icon"]]];
     
    [self.name setText:info[@"name"]];
    
    return self;
}

- (IBAction)add:(UIButton*)sender // could become remove
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( 0 == self.addIcon.tag )
    {
        [self.addIcon setImage:[UIImage imageNamed: @"ic_tick.png"] forState:UIControlStateNormal];
        
        [self.addIcon setTag: 1];
        
        NSMutableArray *samples = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"activeSamples"]];
        
        [samples addObject: self.info];
        
        [defaults setObject:samples forKey:@"activeSamples"];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.activationFlag setAlpha:1];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.activationFlag setAlpha:0];
                
            } completion:^(BOOL finished) { /* f*** u in your blurry ass */ }];

        }];        
    }
    else
    {
        [self.addIcon setImage:[UIImage imageNamed: @"ic_cross.png"] forState:UIControlStateNormal];
        
        [self.addIcon setTag: 0];
    }
}

- (IBAction)play:(UIButton*)sender
{
    [self.player play];
}

@end
