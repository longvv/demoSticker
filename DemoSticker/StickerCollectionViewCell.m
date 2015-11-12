//
//  CollectionViewCell.m
//  DemoSticker
//
//  Created by vu van long on 11/13/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import "StickerCollectionViewCell.h"

@implementation StickerCollectionViewCell

- (void)loadImageAtIndex:(NSInteger)index{
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", (index + 1)]];
    [self.imgStick setImage:image];
}

- (void)selectSticker:(BOOL)isSelected{
    [self.imgSelected setHidden:!isSelected];
}
@end
