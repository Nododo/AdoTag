//
//  AdoCell.m
//  CollectionView
//
//  Created by 杜维欣 on 16/7/22.
//  Copyright © 2016年 Nododo. All rights reserved.
//

#import "AdoTagCell.h"

@implementation AdoTagCell

- (IBAction)deleteTag:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    if (self.deleteBlock) {
        self.deleteBlock(weakSelf.deletePath);
    }
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
