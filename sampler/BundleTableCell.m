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
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic) BOOL swipe;

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation BundleTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]; return self;
}

- (BundleTableCell*) withInfo: (NSDictionary*) info
{
    [self.deleteButton setAlpha:0];
    
    [self.bundleName setText: info[@"bundle"]];
        
    [self.icon setImage:[UIImage imageNamed:info[@"icon"]]];
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    
    [self addGestureRecognizer:gesture];
    
    return self;
}

- (void)longPressDetected:(UISwipeGestureRecognizer*)sender
{
    self.swipe = !self.swipe;
    
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^ { [self.deleteButton setAlpha:self.swipe];} completion:^ (BOOL finished){/**/}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
