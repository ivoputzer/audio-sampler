//
//  SamplerMatrixViewController.m
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Ivo von Putzer. All rights reserved.
//

#define OFFSET 3
#define HEIGHT_LABEL 60

#import "SamplerMatrixViewController.h"

#import "SamplerMatrixCell.h"

@interface SamplerMatrixViewController () <UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate, SamplerMatrixDelegate, UIScrollViewDelegate>

@property NSMutableArray *matrix; // holds the pointers for all cells

@property (strong, nonatomic) NSMutableArray *audio; // holds the audio instances to play

@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic) BOOL statusShowInstruments;

@property int current; // [0-15] -> if 15 reset to 0
@property (weak, nonatomic) IBOutlet UIView *viewInstruments;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewInstruments;

@property (weak, nonatomic) IBOutlet UIView *timeline;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonShowHideInstruments;

@end

@implementation SamplerMatrixViewController

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; return self;
}
- (IBAction)closeButton:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"SCROLLING, %f", scrollView.contentOffset.y);
    if(scrollView != self.scrollViewInstruments) [self.scrollViewInstruments setContentOffset:scrollView.contentOffset];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self setMatrix:[[NSMutableArray alloc] initWithArray:@[]]];
    
    [self setAudio: [[NSMutableArray alloc] initWithArray:@[]]];
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self loadAudio: [defaults objectForKey:@"activeSamples"] ];
    
    [self.scrollViewInstruments setContentSize:CGSizeMake(self.viewInstruments.frame.size.width, self.viewInstruments.frame.size.height)];
    [self.scrollViewInstruments setDelegate:self];
    
    [self drawLabel:[defaults objectForKey:@"activeSamples"]];
}


- (IBAction)showInstruments:(id)sender {
    self.statusShowInstruments = !self.statusShowInstruments;
    
    NSLog(@"ACTIVE %d", self.statusShowInstruments);
    
    (self.statusShowInstruments)?[self.buttonShowHideInstruments setTitle:@"Hide Instruments"]:[self.buttonShowHideInstruments setTitle:@"Show Instruments"];
    
    [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{[self.scrollViewInstruments setFrame:CGRectOffset(self.scrollViewInstruments.frame, (self.statusShowInstruments)?280:-280, 0)];} completion:nil];
    
    
}


-(void)drawLabel:(NSArray*)samples
{    
    for (int i = 0; i<samples.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell.png"]];
        if (i == 0) {
            
            [imageView setFrame:CGRectMake(self.viewInstruments.frame.origin.x+4, 0, self.viewInstruments.frame.size.width, HEIGHT_LABEL)];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.viewInstruments.frame.origin.x+4, 0, self.viewInstruments.frame.size.width, HEIGHT_LABEL)];
            
            label.text = samples[i][@"name"];
            //[label setBackgroundColor:[UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:0.5]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor whiteColor]];
            
            [self.viewInstruments addSubview:imageView];
            [self.viewInstruments addSubview:label];
            
        }
        else{
            
            CGRect frame = CGRectMake(self.viewInstruments.frame.origin.x+4, HEIGHT_LABEL*i+OFFSET*i, self.viewInstruments.frame.size.width, HEIGHT_LABEL);
            
            [imageView setFrame:frame];
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            
            label.text = samples[i][@"name"];
            //[label setBackgroundColor:[UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:0.5]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor whiteColor]];
            
            [self.viewInstruments addSubview:imageView];
            [self.viewInstruments addSubview:label];
        }
    }
    
    
}

-(UIImage *) screenshot
{
    
    CGRect rect;
    rect=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (IBAction)shareButton:(id)sender {
        NSString *textToShare;
            textToShare = [NSString stringWithFormat:
                           @"Hey I'm using Audio-Sampler!"];
    [self.timeline setAlpha:0];
        NSArray *activityToShare = @[textToShare,[self screenshot]];
    [self.timeline setAlpha:1];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated { [self startAudio]; }

-(void)viewDidDisappear:(BOOL)animated
{    
    // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // [defaults setObject:self.matrix forKey:@"matrix"];
    
    [self stopAudio];
}

- (void)pushAudio:(NSString*) path // adds a single audio file to the (self.audio) array
{
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:path ofType:@"wav"]];
    
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [self.audio insertObject:audio atIndex: self.audio.count];
    
    [audio prepareToPlay];
}

- (void)loadAudio: (NSArray*) samples
{
    [samples enumerateObjectsUsingBlock:^(NSDictionary *sample, NSUInteger i, BOOL *stop){
        
        [self pushAudio: sample[@"file"]];
    
    }];
    
    for ( int i = 0; i < [self.audio count] * 16; i++) self.matrix[i] = @(NO); // default values for the matrix
}

-(void) playAudio
{    
    [self.audio enumerateObjectsUsingBlock:^(AVAudioPlayer *audio, NSUInteger index, BOOL *stop) {
             
        if ( [self.matrix[self.current + index * 16] boolValue] )
        {
            if ( [audio isPlaying] ) { [audio setCurrentTime:0]; }else{ [audio play]; }
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
