//
//  ViewController.h
//  JupViec
//
//  Created by KienVu on 11/28/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CommonDefines.h"
#import "WelcomeViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>


@property (strong, nonatomic) UIPageViewController  *pageController;
@property (strong, nonatomic) UIPageControl         *pageControll;

@property (weak, nonatomic) IBOutlet UIView         *contentArea;
@property (weak, nonatomic) IBOutlet UIButton       *btskip;
@property (weak, nonatomic) IBOutlet UIButton       *btStart;

- (IBAction)didPressSkipButton:(id)sender;
- (IBAction)didPressStartButton:(id)sender;

@end

