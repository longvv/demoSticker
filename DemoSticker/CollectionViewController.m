//
//  CollectionViewController.m
//  DemoSticker
//
//  Created by vu van long on 11/13/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import "CollectionViewController.h"
#import "StickerCollectionViewCell.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"StickerCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    int itemInRow = ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) ? 4 : 2;
    int padding = 10;
    float width = (CGRectGetWidth([UIScreen mainScreen].bounds) - padding * (itemInRow - 1)) / itemInRow;
    float height = width;
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell selectSticker:(self.stickerSelectedIndex == indexPath.row)];
    [cell loadImageAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSIndexPath* currentIndex = [NSIndexPath indexPathWithIndex:self.stickerSelectedIndex];
//    StickerCollectionViewCell* currentCell = (StickerCollectionViewCell*)[collectionView cellForItemAtIndexPath:currentIndex];
//    if (currentCell) {
//        [currentCell selectSticker:NO];
//    }
//    
    self.stickerSelectedIndex = indexPath.row;
    [self.collectionView reloadData];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectStickerAtIndex:)]) {
        [self.delegate selectStickerAtIndex:self.stickerSelectedIndex];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
