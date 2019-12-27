//
//  JNavigationViewController.m
//  JupViec
//
//  Created by KienVu on 12/27/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "JNavigationViewController.h"

@interface JNavigationViewController ()

@end

@implementation JNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *attr = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    [[self navigationBar] setTitleTextAttributes:attr];
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
