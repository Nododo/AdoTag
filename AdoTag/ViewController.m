//
//  ViewController.m
//  CollectionView
//
//  Created by 杜维欣 on 16/7/22.
//  Copyright © 2016年 Nododo. All rights reserved.
//

#import "ViewController.h"
#import "AdoTagCell.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (nonatomic,strong)NSMutableArray *sizes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sizes.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdoTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nododo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1];
    cell.tagLabel.text = [NSString stringWithFormat:@"tag-%zd",indexPath.row];
    cell.deletePath = indexPath;
    cell.deleteBlock = ^(NSIndexPath *deletePath) {
        [self.sizes removeObjectAtIndex:deletePath.item];
        [self.mainCollectionView reloadData];
    };
    return cell;
}

- (NSMutableArray *)sizes {
    if (!_sizes) {
        self.sizes = [NSMutableArray array];
        for (int i = 0; i < 100; i ++) {
            NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake(arc4random_uniform(100) + 90, 60)];
            [_sizes addObject:sizeValue];
        }
    }
    return _sizes;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sizes[indexPath.item] CGSizeValue];
}

@end
