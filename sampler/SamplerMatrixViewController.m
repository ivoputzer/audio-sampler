//
//  SamplerMatrixViewController.m
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "SamplerMatrixViewController.h"
#import "SamplerMatrixCell.h"

@interface SamplerMatrixViewController () <UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate, SamplerMatrixDelegate>


@property NSMutableArray *matrix; // holds the pointers for all cells

@property (strong, nonatomic) NSMutableArray *audio; // holds the audio instances to play

@property NSTimer *timer;

@property int current; // [0-15] -> if 15 reset to 0

@end

@implementation SamplerMatrixViewController

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; return self;
}

- (void)loadAudio: (NSArray*) files
{
    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger i, BOOL *stop) {
        
        NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:obj ofType:@"wav"]];
        
        AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
               
        [self.audio insertObject:audio atIndex:i];
        
        [audio prepareToPlay];
        
    }];
        
    for ( int i = 0; i < [self.audio count] * 16; i++) self.matrix[i] = @(NO); // default values for the matrix
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMatrix:[[NSMutableArray alloc] initWithArray:@[]]];
    
    [self setAudio: [[NSMutableArray alloc] initWithArray:@[]]];
    
    [self loadAudio: @[
     @"dp_workit",
     @"dp_makeit",
     @"dp_doit",
     @"dp_makesus",

     @"b_tam", // tamburine
     @"b_clap", // hands clap
     @"b_hh", // hihat - normal
     @"b_hh2", // hihat - accent 
     @"b_snare", // snare
     @"b_bass", // bass open
     
     @"ruben_bass", // bass tight
     @"ruben_synth" // bass tight

     
     ]];
}

-(void)viewDidAppear:(BOOL)animated { [self startAudio]; }

-(void)viewDidDisappear:(BOOL)animated { [self stopAudio]; }

-(void) playAudio
{     
    [self.audio enumerateObjectsUsingBlock:^(AVAudioPlayer *audio, NSUInteger index, BOOL *stop) {
             
        if ( [self.matrix[self.current + index * 16] boolValue] )
        {
            // if ([audio isPlaying]){[audio setCurrentTime:0]; }else{ [audio play]; }
            
            [audio setCurrentTime:0]; [audio play];
        }
     
    }];
    
    [self setCurrent: self.current < 15 ? self.current +1 : 0];

}

- (void) startAudio
{
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(playAudio) userInfo:nil repeats:true]];
}

-(void) stopAudio
{
    [self.timer invalidate]; [self setTimer:nil];
}

/* ---------------------------------- Sampler Matrix Delegate ---------------------------------- */

// -(void)update: (SemplerMatrixCell*) cell atIndex:(NSInteger*) i status: (BOOL) status {}


/* --------------------------------- Collection View Delegate  --------------------------------- */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.audio count] * 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)index
{
    SamplerMatrixCell *cell =
        [view dequeueReusableCellWithReuseIdentifier:@"SamplerMatrixCell" forIndexPath:index];
    
    cell.index = index.row; cell.delegate = self;
        
    [cell color:[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.5]];
    
    return cell;
}

-(void) cell:(SamplerMatrixCell*)cell index:(int)index;
{
    self.matrix[index] = @(![self.matrix[index] boolValue]);

    //NSLog(@"indice : %d status : %@", index, self.matrix[index]);
    
    
    UIColor *color = [self.matrix[index] boolValue]
        ? [UIColor colorWithRed:0.0f/255.0f green:187.0f/255.0f blue:226.0f/255.0f alpha:1.0]
        : [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.5];
    
    [cell color:color];
}

@end
