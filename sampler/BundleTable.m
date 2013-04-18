//
//  BundleTable.m
//  sampler
//
//  Created by Ivo von Putzer on 18/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "BundleTable.h"

@interface BundleTable ()

@end

@implementation BundleTable

- (id)initWithStyle:(UITableViewStyle)style { self = [super initWithStyle:style]; return self; }

- (void)viewDidLoad { [super viewDidLoad]; }

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return 5; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
