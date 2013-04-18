//
//  SamplerMatrixViewController.m
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Ivo von Putzer. All rights reserved.
//

#import "SamplerMatrixViewController.h"

#import "SamplerMatrixCell.h"

@interface SamplerMatrixViewController () <UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate, SamplerMatrixDelegate>

@property NSMutableArray *matrix; // holds the pointers for all cells

@property (strong, nonatomic) NSMutableArray *audio; // holds the audio instances to play

@property (strong, nonatomic) NSTimer *timer;

@property int current; // [0-15] -> if 15 reset to 0

@property (weak, nonatomic) IBOutlet UIView *timeline;

@end

@implementation SamplerMatrixViewController

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; return self;
}

- (void)pushAudio:(NSString*) path // adds a single audio file to the (self.audio) array
{
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:path ofType:@"wav"]];
        
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [self.audio insertObject:audio atIndex: self.audio.count];
        
    [audio prepareToPlay];
}

- (void)loadAudio: (NSArray*) files
{
    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger i, BOOL *stop) { [self pushAudio: obj]; }];
        
    for ( int i = 0; i < [self.audio count] * 16; i++) self.matrix[i] = @(NO); // default values for the matrix
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self setMatrix:[[NSMutableArray alloc] initWithArray:@[]]];
    
    [self setAudio: [[NSMutableArray alloc] initWithArray:@[]]];
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // va cambiato!! (defaults-samples) deve contenere un array di samples selezionati dall'utente
    _bundleSelected = [defaults integerForKey:@"bundle"];
    
    NSLog(@"bundleSelected: %d", _bundleSelected); // not pass the bundle but the samples already!--- IMPORTANT!
    
    [self loadAudio: [[[defaults objectForKey:@"bundles"] objectAtIndex:_bundleSelected]  objectForKey:@"files"]];
    
    /*
     when saving to phone user defaults we better save the state and samples that have been added last
     */

    // NSArray *matrix = [defaults objectForKey:@"matrix"];
    
    // if ( matrix.count == self.audio.count * 16 ) { [self.matrix addObjectsFromArray: matrix]; }
}

-(void)viewDidAppear:(BOOL)animated { [self startAudio]; }

-(void)viewDidDisappear:(BOOL)animated
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.matrix forKey:@"matrix"];
    
    [self stopAudio];
}

-(void) playAudio
{    
    [self.audio enumerateObjectsUsingBlock:^(AVAudioPlayer *audio, NSUInteger index, BOOL *stop) {
             
        if ( [self.matrix[self.current + index * 16] boolValue] )
        {
            if ( [audio isPlaying] ) { [audio setCurrentTime:0]; }else{ [audio play]; } // [audio setCurrentTime:0]; [audio play];
        }
     
    }];
    
    [self setCurrent: self.current < 15 ? self.current +1 : 0];
}

-(void) startTimeline
{     
    [UIView transitionWithView:self.timeline duration:0.125 options: UIViewAnimationOptionCurveLinear
     
    animations:^{
        
        [self.timeline setAlpha:0];
    }
    
    completion:^(BOOL finished) {
        
        [self.timeline setFrame:CGRectOffset(self.timeline.frame, -964, 0)];
        
        [UIView transitionWithView:self.timeline duration:0.125 options: UIViewAnimationOptionCurveLinear
         
        animations:^{
                    
            [self.timeline setAlpha:1];
        }
         
        completion:^(BOOL finished) {
        
            [UIView transitionWithView:self.timeline duration:15*0.25 options: UIViewAnimationOptionCurveLinear

            animations:^{
                
                [self.timeline setFrame:CGRectOffset(self.timeline.frame, 964, 0)];
            }
             
            completion:^(BOOL finished) {
            
                [self startTimeline];
            
            }];
        
        }];
        
    }];
}

- (void) startAudio
{  
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(playAudio) userInfo:nil repeats:true]];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self startTimeline];
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
    //NSLog(@"self.audio: %d", self.audio.count);
    
    // NSLog(@"%d", [self.audio count] * 16);

    return [self.audio count] * 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)index
{
    SamplerMatrixCell *cell =
        [view dequeueReusableCellWithReuseIdentifier:@"SamplerMatrixCell" forIndexPath:index];
    
    cell.index = index.row;
    
    cell.delegate = self;
        
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
