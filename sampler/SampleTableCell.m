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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"file = %@", self.info[@"file"]];
    
    NSArray *filtered = [[defaults objectForKey:@"activeSamples"] filteredArrayUsingPredicate:filter];

    if ( filtered.count > 0 )
    {
        [self.addIcon setTag: 1];
        
        [self.addIcon setImage:[UIImage imageNamed: @"ic_tick.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.addIcon setTag: 0];

        [self.addIcon setImage:[UIImage imageNamed: @"ic_cross.png"] forState:UIControlStateNormal];
    }
    
    return self;
}

- (IBAction)add:(UIButton*)sender // could become remove
{
    NSLog(@"info %@", self.info[@"file"]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"file = %@", self.info[@"file"]];
    
    NSArray *filtered = [[defaults objectForKey:@"activeSamples"] filteredArrayUsingPredicate:filter];
    
    if ( 0 == self.addIcon.tag )
    {        
        if ( filtered.count > 0 ) return; // we dont wanna add something that exists already
        
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
                
            } completion:^(BOOL finished) { /**/ }];
            
        }];
    }
    else
    {
        NSMutableArray *samples = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"activeSamples"]];
        
        [samples removeObject:self.info];
                
        [defaults setObject:samples forKey:@"activeSamples"];

        [self.addIcon setImage:[UIImage imageNamed: @"ic_cross.png"] forState:UIControlStateNormal];
        
        [self.addIcon setTag: 0];
    }
}

- (IBAction)play:(UIButton*)sender
{
    [self.player play];
}

@end
