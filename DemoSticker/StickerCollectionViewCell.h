//
//  CollectionViewCell.h
//  DemoSticker
//
//  Created by vu van long on 11/13/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgStick;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelected;

- (void)selectSticker:(BOOL)isSelected;
- (void)loadImageAtIndex:(NSInteger)index;
@end
