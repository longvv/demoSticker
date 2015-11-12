//
//  CollectionViewController.h
//  DemoSticker
//
//  Created by vu van long on 11/13/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StickerDelegate

- (void)selectStickerAtIndex:(NSInteger)index;

@end

@interface CollectionViewController : UICollectionViewController
@property (assign, nonatomic) NSInteger stickerSelectedIndex;
@property (weak, nonatomic) id delegate;
- (IBAction)back:(id)sender;
- (IBAction)done:(id)sender;
@end
