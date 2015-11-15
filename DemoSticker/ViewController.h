//
//  ViewController.h
//  DemoSticker
//
//  Created by vu van long on 11/12/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Draggable.h"

@interface ViewController : UIViewController<UIScrollViewDelegate, UIAlertViewDelegate>{
    NSInteger stickerIndex;
    NSTimer* timer;
    BOOL isShowImageEditor;
    BOOL isShowStickEditor;
}

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) Draggable* stick;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAdd;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnReload;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)addSticker:(id)sender;
- (IBAction)saveImage:(id)sender;
- (IBAction)reload:(id)sender;


@end

