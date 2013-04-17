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
               
        [self.audio insertObject: audio atIndex:i];
        
        [audio prepareToPlay];
        
    }];
    
    AVAudioPlayer * player = self.audio[1];
    
    [player play];
    
    [player setNumberOfLoops: 30];
    
    
    
    
    int limit = [self.audio count] * 16;
    
    for ( int i = 0; i < limit; i++) self.matrix[i] = @(NO); // default values
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMatrix:[[NSMutableArray alloc] initWithArray:@[]]];
    
    [self setAudio: [[NSMutableArray alloc] initWithArray:@[]]];
    
    [self loadAudio: @[@"dp_workit", @"dp_makeit", @"dp_doit", @"dp_makesus"]];
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
    
    cell.index = index.row;
    
    cell.delegate = self;
    
    cell.status = [self.matrix[index.row] boolValue];
    
    [cell color:[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.5]];
    
    return cell;
}

-(void) cell:(SamplerMatrixCell*)cell status:(BOOL)status index:(int)index;
{
    self.matrix[index] = @(![self.matrix[index] boolValue]);

    NSLog(@"indice : %d status : %@", index, self.matrix[index]);
    
    
    UIColor *color = [self.matrix[index] boolValue]
        ? [UIColor colorWithRed:0.0f/255.0f green:187.0f/255.0f blue:226.0f/255.0f alpha:1.0]
        : [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.5];
    
    [cell color:color];
}

@end
