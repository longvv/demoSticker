//
//  ViewController.m
//  DemoSticker
//
//  Created by vu van long on 11/12/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<StickerDelegate>

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
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.image = [UIImage imageNamed:@"img_beach.jpg"];
        [self.scrollView addSubview:self.imageView];
    }
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
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", (index + 1)]];
    [self.stick setImage:image];
}

- (void)saveImageFinished{
    [[[UIAlertView alloc] initWithTitle:@"Congratulation!" message:@"Your picture was saved into system photo library. You can view it right now!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (IBAction)addSticker:(id)sender {
    CollectionViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    controller.delegate = self;
    controller.stickerSelectedIndex = stickerIndex;
    [self.navigationController pushViewController:controller animated:YES];
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
    [self.scrollView setZoomScale:1.0];
}
@end
