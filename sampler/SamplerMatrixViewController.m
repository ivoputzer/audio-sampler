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

    self.matrix = [[NSMutableArray alloc] initWithArray: @[]];
    
}


/* --------------------------------- Collection View Delegate  --------------------------------- */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 256;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)index
{
    SamplerMatrixCell *cell = [view dequeueReusableCellWithReuseIdentifier:@"SamplerMatrixCell" forIndexPath:index];
    
    [cell color: [UIColor colorWithRed:35.0f/255.0f green:31.0f/255.0f blue:32.0f/255.0f alpha:1.0]];
    
    return cell;
}

@end
