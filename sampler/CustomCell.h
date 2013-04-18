//
//  CustomCell.h
//  sampler
//
//  Created by Nico Santoro on 15/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *trackLabel; // todo : make this private, and add a setter method
@protocol GestureDelegate;

@interface CustomCell : UITableViewCell 

@property (weak) __weak id<GestureDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *trackLabel;

- (void)setup;

@end


@protocol GestureDelegate <NSObject>

@optional
-(void)deleteBundle;

@end
