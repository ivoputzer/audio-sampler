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
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameSampler;

@end

@implementation BundleTableCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]; return self;
}

-(BundleTableCell*)withInfo:(NSArray *)info
{
    return self;
}
- (IBAction)add:(id)sender {
}
- (IBAction)play:(id)sender {
}

/* add */

/* play */


/*- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}*/

@end
