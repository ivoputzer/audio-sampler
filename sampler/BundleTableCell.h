//
//  BundleTableCell.h
//  sampler
//
//  Created by Ivo von Putzer on 18/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BundleTable;

@interface BundleTableCell : UITableViewCell

@property (weak) __weak id<BundleTable> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *typeOfInstrument;
@property (nonatomic) int tag;

@end

@protocol BundleTable <NSObject>

@optional
-(void)cellClickedWithTag:(int)tag andUrl:(NSString*)typeOfInstrument;

@end

