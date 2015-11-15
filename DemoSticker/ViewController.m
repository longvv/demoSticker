//
//  ViewController.m
//  DemoSticker
//
//  Created by vu van long on 11/12/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "CLImageEditor.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<StickerDelegate, CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.delegate = self;
    stickerIndex = -1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginMoveEvent) name:@"BeginTouchMove" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endMoveEvent) name:@"EndTouchMove" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (isShowImageEditor) {
        return;
    }
    if (isShowStickEditor) {
        isShowStickEditor = NO;
        return;
    }
    
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.image = [UIImage imageNamed:@"img_beach_1.jpg"];
        [self.scrollView setZoomScale:5];
        [self.scrollView addSubview:self.imageView];
    }
    [self zoomOut];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beginMoveEvent{
    [self.scrollView setScrollEnabled:NO];
}

- (void)endMoveEvent{
    [self.scrollView setScrollEnabled:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)selectStickerAtIndex:(NSInteger)index{
    stickerIndex = index;
    if (!self.stick) {
        self.stick = [[Draggable alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.stick.contentMode = UIViewContentModeScaleAspectFill;
        [self.stick setUserInteractionEnabled:YES];
        [self.view addSubview:self.stick];
    }
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", (index + 1)]];
    [self.stick setImage:image];
}

- (void)saveImageFinished{
    [[[UIAlertView alloc] initWithTitle:@"Congratulation!" message:@"Your picture was saved into system photo library. You can view it right now!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (void)zoomOut{
    [self.imageView setImage:[UIImage imageNamed:@"img_beach_1.jpg"]];
    [self.btnAdd setEnabled:NO];
    [self.btnEdit setEnabled:NO];
    [self.btnReload setEnabled:NO];
    [self.btnSave setEnabled:NO];
    
    [UIView animateWithDuration:3.0 delay:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
        [self.imageView setImage:[UIImage imageNamed:@"img_beach_2.jpg"]];
        [self.scrollView setZoomScale:1];
    } completion:^(BOOL finished) {
        [self.btnAdd setEnabled:YES];
        [self.btnEdit setEnabled:YES];
        [self.btnReload setEnabled:YES];
        [self.btnSave setEnabled:YES];
    }];
}

- (IBAction)addSticker:(id)sender {
    CollectionViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    controller.delegate = self;
    controller.stickerSelectedIndex = stickerIndex;
    isShowStickEditor = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)editImage:(id)sender {
    [self pushedEditBtn];
}

- (IBAction)saveImage:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:[img CGImage] orientation:(ALAssetOrientation)[img imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Oop!" message:@"An error occurs while image is processing. Please try to again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Congratulation!" message:@"Your picture was saved into system photo library. You can view it right now!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
    }];
}

- (IBAction)reload:(id)sender {
    [self.stick removeFromSuperview];
    self.stick = nil;
    stickerIndex = -1;
    
    [self.scrollView setZoomScale:5];
    [self zoomOut];
}

#pragma mark- CLImageEditor delegate
- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    _imageView.image = image;
    [editor dismissViewControllerAnimated:YES completion:^{
        isShowImageEditor = NO;
    }];
}

- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    isShowImageEditor = NO;
}

- (void)pushedEditBtn
{
    if(_imageView.image){
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:_imageView.image delegate:self];
        [self presentViewController:editor animated:YES completion:nil];
        isShowImageEditor = YES;
    }
}
@end
