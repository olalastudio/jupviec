//
//  ViewController.h
//  JupViec
//
//  Created by KienVu on 11/25/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "WelcomeViewController.h"

@interface ViewController : UIViewController<UIPageViewControllerDelegate, UIPageViewControllerDataSource,WelcomeViewControllerDelegate>
{
    NSMutableArray *_itemList;
}

@property (strong, nonatomic) UIPageViewController  *pageController;
@property (strong, nonatomic) UIPageControl         *pageControll;

@end

