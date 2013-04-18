//
//  CustomCell.h
//  sampler
//
//  Created by Nico Santoro on 15/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GestureDelegate;

@interface BundleTableCell : UITableViewCell

@property (weak) __weak id<GestureDelegate> delegate;

- (BundleTableCell*) withInfo:(NSDictionary*) info;

@end

@protocol GestureDelegate <NSObject>

-(void)deleteBundle;

@end
