//
//  AdoCell.h
//  CollectionView
//
//  Created by 杜维欣 on 16/7/22.
//  Copyright © 2016年 Nododo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdoTagCell : UICollectionViewCell

@property (nonatomic,copy) void(^deleteBlock)(NSIndexPath *deletePath);
@property (nonatomic,strong)NSIndexPath *deletePath;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end
