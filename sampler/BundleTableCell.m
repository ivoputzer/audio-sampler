//
//  BundleTableCell.m
//  sampler
//
//  Created by Ivo von Putzer on 18/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "BundleTableCell.h"
#import <AVFoundation/AVFoundation.h>

@interface BundleTableCell()

@property (strong, nonatomic) AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation BundleTableCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]; return self;
}

-(BundleTableCell*)withInfo:(NSDictionary *)info
{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:info[@"file"] ofType:@"wav"]];
    
    [self setPlayer:[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil]]; [self.player prepareToPlay];

    // todo : check if image is in defaults[samples] aready
    
    [self.icon setImage:[UIImage imageNamed:info[@"icon"]]];
     
    [self.name setText:info[@"name"]];
    
    return self;
}

- (IBAction)add:(UIButton*)sender // could become remove
{
    // todo : save to samples defaults
}

- (IBAction)play:(UIButton*)sender
{
    [self.player play];
}

@end
