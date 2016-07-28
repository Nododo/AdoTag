//
//  AdoTagLayout.h
//  CollectionView
//
//  Created by 杜维欣 on 16/7/22.
//  Copyright © 2016年 Nododo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AdoTagAlignmentLeft,
    AdoTagAlignmentRight,
} AdoTagAlignment;

@interface AdoTagLayout : UICollectionViewFlowLayout

@property (nonatomic,assign)AdoTagAlignment tagAlignment;   //default is left

@end
