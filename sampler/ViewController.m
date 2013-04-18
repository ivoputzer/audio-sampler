//
//  ViewController.m
//  Sampler
//
//  Created by Nico Santoro on 15/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "BundleTableCell.h"
#import "SamplerMatrixViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* objects;
@property (strong, nonatomic) NSMutableArray* bundles;
@property (strong, nonatomic) NSMutableArray* instruments;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *recButton;
@property (weak, nonatomic) SamplerMatrixViewController* sampleMatrixViewController;
@property (weak, nonatomic) IBOutlet UILabel *bundleLabel;

@property (weak, nonatomic) IBOutlet UITableView *previewTable;
@property (weak, nonatomic) IBOutlet UITableView *KitTable;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    [self setObjects: [[NSMutableArray alloc] initWithArray:@[
                       
       @{ @"track": @"draftpunk", @"dirname" : @"draftpunk" }
    
    ]]];     
     
    [self setBundles: [[NSMutableArray alloc] initWithArray:@[
        @{
            @"bundle" : @"Drum Acoustic",
            @"icon": @"",
            @"files" : @[
               @{@"name":@"Acoustic Crash", @"icon":@"bundle_ic_ride.png", @"file" : @"bundle_drum_kit_ac_crash"},
               @{@"name":@"Acoustic Hi-Hat", @"icon":@"bundle_ic_hihat.png", @"file" : @"bundle_drum_kit_ac_hihat"},
               @{@"name":@"Acoustic Kick", @"icon":@"bundle_ic_kick.png", @"file" : @"bundle_drum_kit_ac_kick"},
               @{@"name":@"Acoustic Rim", @"icon":@"bundle_ic_snare.png", @"file" : @"bundle_drum_kit_ac_rim"},
               @{@"name":@"Acoustic Snare", @"icon":@"bundle_ic_snare.png", @"file" : @"bundle_drum_kit_ac_snare"},
            ]
        },
                           
        @{
            @"bundle" : @"Drum Electric",
            @"icon": @"",
            @"files" : @[
               @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
               @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"},
               @{@"name": @"Electric Hi-Hat", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat"},
               @{@"name": @"Electric Tom 1", @"icon": @"bundle_ic_tom.png", @"file": @"bundle_drum_kit_el_tom1"},
               @{@"name": @"Electric Tom 2", @"icon": @"bundle_ic_tom.png", @"file": @"bundle_drum_kit_el_tom2"},
               @{@"name": @"Electric Tom 3", @"icon": @"bundle_ic_tom.png", @"file": @"bundle_drum_kit_el_tom3"},
               @{@"name": @"Electric Tom 4", @"icon": @"bundle_ic_tom.png", @"file": @"bundle_drum_kit_el_tom4"},
               @{@"name": @"Electric Kick", @"icon": @"bundle_ic_kick.png", @"file": @"bundle_drum_kit_el_cick"},
            ]
        }
    ]]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setObject:self.bundles forKey:@"bundles"];
    
}

-(void)showInstrumentTable
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"bundleSelected: %d", [defaults integerForKey:@"bundle"]);
    
    self.instruments = [[NSMutableArray alloc]initWithArray:[[[defaults objectForKey:@"bundles"] objectAtIndex:[defaults integerForKey:@"bundle"]]  objectForKey:@"files"]];
    
    self.bundleLabel.text = self.bundles[[defaults integerForKey:@"bundle"]][@"bundle"];
    [self.previewTable reloadData];
    //NSLog(@"SELF.INSTRUMENT: %@", self.instruments);
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
}

- (IBAction)startRecording:(id)sender {
    
    BOOL animation = [sender tag];
    
    [sender setTag:![sender tag]];
    
    if(!animation){
        
        [self.recButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        
        NSLog(@"startRecording");
        audioRecorder = nil;
        
        // Init audio with record capability
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        
        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
        if(recordEncoding == ENC_PCM)
        {
            [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
            [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
            [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
            [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
            [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
            [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
        }
        else
        {
            NSNumber *formatObject;
            
            switch (recordEncoding) {
                case (ENC_AAC):
                    formatObject = [NSNumber numberWithInt: kAudioFormatMPEG4AAC];
                    break;
                case (ENC_ALAC):
                    formatObject = [NSNumber numberWithInt: kAudioFormatAppleLossless];
                    break;
                case (ENC_IMA4):
                    formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
                    break;
                case (ENC_ILBC):
                    formatObject = [NSNumber numberWithInt: kAudioFormatiLBC];
                    break;
                case (ENC_ULAW):
                    formatObject = [NSNumber numberWithInt: kAudioFormatULaw];
                    break;
                default:
                    formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
            }
            
            [recordSettings setObject:formatObject forKey: AVFormatIDKey];
            [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
            [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
            [recordSettings setObject:[NSNumber numberWithInt:12800] forKey:AVEncoderBitRateKey];
            [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
            [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityHigh] forKey: AVEncoderAudioQualityKey];
        }
        
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentDirectory = paths[0];
        
        NSString* databaseFile = [documentDirectory stringByAppendingPathComponent:@"provaRec"];
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@", databaseFile]];
        
        
        NSError *error = nil;
        audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
        
        if ([audioRecorder prepareToRecord] == YES){
            [audioRecorder record];
        }else {
            int errorCode = CFSwapInt32HostToBig ([error code]);
            NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
            
        }
        NSLog(@"recording");
    }else{
        [self.recButton setImage:[UIImage imageNamed:@"rec.png"] forState:UIControlStateNormal];
        NSLog(@"stopRecording");
        [audioRecorder stop];
        NSLog(@"stopped");
    }
    
}

- (IBAction)playRecording:(id)sender {
    
    BOOL animation = [sender tag];
    
    [sender setTag:![sender tag]];
    
    if(!animation){
        
        [self.playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        
        NSLog(@"playRecording");
        // Init audio with playback capability
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentDirectory = paths[0];
        
        NSString* databaseFile = [documentDirectory stringByAppendingPathComponent:@"provaRec"];
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@", databaseFile]];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        
        [audioPlayer addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:nil];
        
        [audioPlayer setDelegate:self];
        NSLog(@"Duration: %f", audioPlayer.duration);
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
        NSLog(@"playing");
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [audioPlayer pause];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*COMMIT*/

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return (self.KitTable == table) ? self.bundles.count : self.instruments.count;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)index
{
    if ( self.KitTable == table ) // the one on the left
    {        
        CustomCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:index];
        
        cell.trackLabel.text = self.bundles[index.row][@"bundle"]; return cell; /* todo : implement right method */
    }
    else
    {     
        BundleTableCell *cell = [table dequeueReusableCellWithIdentifier:@"BundleTableCell" forIndexPath:index];
                
        return [cell withInfo:self.instruments[index.row]];        
    }
}

-(void)cellClickedWithTag:(int)tag andUrl:(NSString *)typeOfInstrument
{
    NSLog(@"Cella cliccata con TAG: %d, con il corrispondente URL della traccia: %@",tag,typeOfInstrument);
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

-(void)showAlert:(NSDictionary*)element
{
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:element[@"name"] message:@"Ciao" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    //[alert show];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.KitTable) {
        NSLog(@"La cella %d è stata cliccata", indexPath.row );
        
        [self showAlert:self.bundles[indexPath.row]];
        
        NSUserDefaults *prefBundleSelected = [NSUserDefaults standardUserDefaults];
        [prefBundleSelected setInteger:indexPath.row forKey:@"bundle"];
        
        [self showInstrumentTable];
    }
    
}


@end
