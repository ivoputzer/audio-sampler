//
//  SamplerMatrixCell.h
//  sampler
//
//  Created by Ivo von Putzer on 16/04/13.
//  Copyright (c) 2013 Nico Santoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SamplerMatrixCell : UICollectionViewCell

@property BOOL status;

@property int index;

@property id delegate;

-(void) color: (UIColor*)color;

@end

@protocol SamplerMatrixDelegate <NSObject>

-(void)cell:(SamplerMatrixCell*)cell index:(int)index;

@end
