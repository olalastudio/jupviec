//
//  ViewController.m
//  JupViec
//
//  Created by KienVu on 11/25/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //show welcome view at the first launch
    [self setupWelcomeView];
}

-(void)setupWelcomeView
{
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    WelcomeViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    
    [self.pageController didMoveToParentViewController:self];
    [self addPageControll];
}

-(WelcomeViewController*)viewControllerAtIndex:(NSInteger)index
{
    WelcomeViewController *welcomeViewController = [self.storyboard instantiateViewControllerWithIdentifier:ID_WELCOME_VIEW];
    [welcomeViewController setIndex:index];
    [welcomeViewController setDelegate:self];
    [welcomeViewController.view setFrame:[self.view frame]];
    
    return welcomeViewController;
}

-(void)addPageControll
{
    self.pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    [self.pageControll setTintColor:[UIColor blueColor]];
    [self.pageControll setPageIndicatorTintColor:[UIColor grayColor]];
    [self.pageControll setHidesForSinglePage:YES];
    [self.pageControll setNumberOfPages:3];
    [self.pageControll setCurrentPage:0];
    
    [self.pageControll sizeToFit];
    
    CGRect frame = [self.pageControll frame];
    frame.origin.x = (self.view.frame.size.width - frame.size.width)/2;
    
    [self.pageControll setFrame:frame];
    
    [self.view addSubview:self.pageControll];
}

#pragma mark - PageViewDelegate
-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    WelcomeViewController *welcomeviewcontroller = (WelcomeViewController*)pendingViewControllers[0];
    
    [self.pageControll setCurrentPage:[welcomeviewcontroller index]];
    [self.pageControll updateCurrentPageDisplay];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [(WelcomeViewController*)viewController index];
    
    index++;
    if (index > 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [(WelcomeViewController*)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

#pragma mark -
#pragma mark WelcomeViewDelegate
-(void)getStart
{
    NSLog(@"did press start or skip");
    
    UITabBarController *tabController = (UITabBarController*)[self.storyboard instantiateViewControllerWithIdentifier:@"idTabBarView"];
    
    [self presentViewController:tabController animated:NO completion:^{
        
    }];
    
    [self.pageController removeFromParentViewController];
    [self.pageController.view removeFromSuperview];
    [self.pageControll removeFromSuperview];
}

@end
