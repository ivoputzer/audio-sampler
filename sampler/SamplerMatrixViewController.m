//
//  SamplerMatrixViewController.m
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "SamplerMatrixViewController.h"
#import "SamplerMatrixCell.h"

@interface SamplerMatrixViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property NSMutableArray *samples;

@property NSMutableArray *matrix;


@end

@implementation SamplerMatrixViewController

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL fileURLWithPath:
                  [[NSBundle mainBundle] pathForResource:@"dp_workit" ofType:@"wav"]];
   
    NSError *error = nil;
        
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    [audio prepareToPlay];
    
    [audio play];
    
    NSLog(@"Error : %@", error);
    
    /*NSString* path = [[NSBundle mainBundle] pathForResource: @"dp_workit" ofType:@"wav"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) NSLog (@"No file");
    
    AVPlayer* player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    
    [player play];
    
    
    /*self.samples = [[NSMutableArray alloc]
                    
        initWithArray: @[
            @{ @"file": @"dp_workit.wav", @"player": @(1) },
            @{ @"file": @"dp_makeit.wav", @"player": @(1) },
            @{ @"file": @"dp_doit.wav", @"player": @(1) },
            @{ @"file": @"dp_makesus.wav", @"player": @(1) }
        ]
    ];
    
    
    
    // [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&amp;error];*/
    
    
}


/* --------------------------------- Collection View Delegate  --------------------------------- */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.samples count] * 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)index
{
    SamplerMatrixCell *cell = [view dequeueReusableCellWithReuseIdentifier:@"SamplerMatrixCell" forIndexPath:index];
    
    [cell color:[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.5]];
    
    return cell;
}

@end
