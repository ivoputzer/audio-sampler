//
//  BundleTableCell.m
//  sampler
//
//  Created by Ivo von Putzer on 18/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "BundleTableCell.h"

@interface BundleTableCell()

@property (nonatomic) NSArray* info;

@end

@implementation BundleTableCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BundleTableCell*)setInfo:(NSArray*)info
{
    self.info = info;
    return self;
}

- (IBAction)insertToSampler:(id)sender {
}

- (IBAction)playInstrumentSelected:(id)sender {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
