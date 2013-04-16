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

- (BOOL)collectionView:(UICollectionView *)view didDeselectItemAtIndexPath:(NSIndexPath *)index
{
    SamplerMatrixCell *cell = [view dequeueReusableCellWithReuseIdentifier:@"SamplerMatrixCell" forIndexPath:index];
    
    [cell color:nil];
    
    return true;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 256;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)index
{
    return [view dequeueReusableCellWithReuseIdentifier:@"SamplerMatrixCell" forIndexPath:index];
}

@end
