//
//  CustomCell.m
//  sampler
//
//  Created by Nico Santoro on 15/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import "BundleTableCell.h"

@interface BundleTableCell()

@property (weak, nonatomic) IBOutlet UILabel *bundleName;

@end

@implementation BundleTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]; return self;
}

- (BundleTableCell*) withInfo: (NSDictionary*) info
{
    [self.bundleName setText: info[@"name"]];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    [self addGestureRecognizer:gesture];
    
    return self;
}

- (void)longPressDetected:(UILongPressGestureRecognizer*)sender
{
    NSLog(@"LONG-PRESSED");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
