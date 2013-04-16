//
//  SamplerMatrixViewController.m
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "SamplerMatrixViewController.h"

@interface SamplerMatrixViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SamplerMatrixViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; return self;
}

- (void)viewDidLoad { [super viewDidLoad]; }

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }


/* --------------------------------- Collection View Delegate  --------------------------------- */


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)index
{
    return [view dequeueReusableCellWithReuseIdentifier:@"SamplerMatrixCell" forIndexPath:index];
}

@end
