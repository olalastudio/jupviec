//
//  DetailOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DetailOrderViewController.h"

@interface DetailOrderViewController ()

@end

@implementation DetailOrderViewController
@synthesize user = _user;
@synthesize DetailInfo = _DetailInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
