//
//  ViewController.m
//  Sampler
//
//  Created by Ivo von Putzer on 15/04/13.
//  Copyright (c) 2013 Ivo von Putzer. All rights reserved.
//

#import "ViewController.h"
#import "BundleTableCell.h"
#import "SampleTableCell.h"
#import "SamplerMatrixViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) SamplerMatrixViewController* sampleMatrixViewController;

@property (strong, nonatomic) NSMutableArray* bundles;

@property (strong, nonatomic) NSMutableArray* samples;

@property (weak, nonatomic) IBOutlet UITableView *samplesTable;
@property (weak, nonatomic) IBOutlet UIImageView *second_table;

@property (weak, nonatomic) IBOutlet UITableView *bundlesTable;

@property (weak, nonatomic) IBOutlet UIView *samplesTableLabel;
@property (weak, nonatomic) IBOutlet UIView *viewSamplesTable;

@property (weak, nonatomic) IBOutlet UILabel *bundleName;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureDetected:)];
    
    [self.viewSamplesTable addGestureRecognizer:gesture];
    
    [self.navigationController.navigationBar setTintColor: [UIColor grayColor]];
     
    [self setBundles: [[NSMutableArray alloc] initWithArray:@[
        @{
            @"bundle" : @"Drum Acoustic",
            @"icon": @"bundle_ic_drum.png",
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
            @"icon": @"bundle_ic_drum.png",
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
        },
        @{
            @"bundle" : @"Synth Kit",
            @"icon": @"bundle_ic_synth.png",
            @"files" : @[
                 @{@"name": @"Poliphony 1 - c2", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_1_c2"},
                 @{@"name": @"Poliphony 5 - c4", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_5_c4"},
                 @{@"name": @"Poliphony 7 - c2", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_7_c2"},
                 @{@"name": @"Poliphony 7 - c3", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_7_c3"},
                 @{@"name": @"Poliphony 7 - c4", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_7_c4"},
                 @{@"name": @"Poliphony 9 - c2", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_9_c2"},
                 @{@"name": @"Poliphony 9 - c4", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_9_c4"},
                 @{@"name": @"Poliphony 13 - c4", @"icon": @"bundle_ic_synth.png", @"file": @"bundle_synth_kit_poly_13_c4"}
            ]
        },
                       
        @{
            @"bundle" : @"Trumpet Kit",
            @"icon": @"bundle_ic_trumpet.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
        },
                       
        @{
            @"bundle" : @"Windbell Kit",
            @"icon": @"bundle_ic_windbell.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
        },

       @{
            @"bundle" : @"Flute Kit",
            @"icon": @"bundle_ic_flute.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
       },
                       
       @{
            @"bundle" : @"Sax Kit",
            @"icon": @"bundle_ic_sax.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
       },
       
       @{
            @"bundle" : @"Violin Kit",
            @"icon": @"bundle_ic_violin.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
       },
        
       @{
                       
            @"bundle" : @"Bells Kit",
            @"icon": @"bundle_ic_bell.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
        },
        
        @{
            @"bundle" : @"Acoustic Guitar Kit",
            @"icon": @"bundle_ic_guitar.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
        },
        
        @{
            @"bundle" : @"Electric Guitar Kit",
            @"icon": @"bundle_ic_ac_guitar.png",
            @"files" : @[
                @{@"name": @"Electric Hi-Hat (open)", @"icon": @"bundle_ic_hihat.png", @"file": @"bundle_drum_kit_el_hihat_open"},
                @{@"name": @"Electric Snare", @"icon": @"bundle_ic_snare.png", @"file": @"bundle_drum_kit_el_snare"}
            ]
        }

    ]]];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.bundles forKey:@"bundles"];
    
    [defaults setObject:@[] forKey:@"activeSamples"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return (self.bundlesTable == table) ? self.bundles.count : self.samples.count;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)index
{
    if ( self.bundlesTable == table) // the one on the left
    {       
        
        BundleTableCell *cell = [table dequeueReusableCellWithIdentifier:@"BundleTableCell" forIndexPath:index];
        
        if (cell == nil) {
            cell = [[BundleTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BundleTableCell"];

        }

        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        return [cell withInfo:self.bundles[index.row]];
    }
    else
    {     
        SampleTableCell *cell = [table dequeueReusableCellWithIdentifier:@"SampleTableCell" forIndexPath:index];
        
        return [cell withInfo:self.samples[index.row]];
    }
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)index
{
    if ( self.bundlesTable == table){ [self selectBundle: index.row]; }
}

-(void) selectBundle: (NSInteger) selection
{
    [self.samplesTable setHidden: false];
    [self.second_table setHidden: false]; // todo : do this just once

    [self.samplesTableLabel setHidden:false]; // todo : do this just once

    [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.viewSamplesTable setFrame:CGRectOffset(self.viewSamplesTable.frame, -300, 0)];
    } completion:^(BOOL finished) {
        /**/
    }];

    [self.bundleName setText: self.bundles[selection][@"bundle"]]; // fuck off, never change this again
    
    [self setSamples: [[NSMutableArray alloc] initWithArray: self.bundles[selection][@"files"]]];
    
    [self.samplesTable reloadData];
}

- (void)swipeGestureDetected:(UISwipeGestureRecognizer*)sender
{    
    [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^ { [self.viewSamplesTable setFrame:CGRectOffset(self.viewSamplesTable.frame, 300, 0)];} completion:^ (BOOL finished){/**/}];
}

@end
