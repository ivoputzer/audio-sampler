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
        [self.addIcon setImage:[UIImage imageNamed: @"ic_cross.png"] forState:UIControlStateNormal];
        
        [self.addIcon setTag: 1];
        
        NSMutableArray *samples = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"activeSamples"]];
        
        [samples addObject: self.info];
        
        [defaults setObject:samples forKey:@"activeSamples"];
    }
    else
    {
        [self.addIcon setImage:[UIImage imageNamed: @"ic_plus.png"] forState:UIControlStateNormal];
        
        [self.addIcon setTag: 0];
    }
}

- (IBAction)play:(UIButton*)sender
{
    [self.player play];
}

@end
