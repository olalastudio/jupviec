//
//  NoticeDetailViewController.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController ()

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBarController.tabBar setHidden:YES];
    self.view.layer.masksToBounds = YES;
    
    [self setTitle:@"Chi tiết"];
    
    [_titleLB setText:[_notifyInfo objectForKey:@"title"]];
    [_notifyDateLB setText:[_notifyInfo objectForKey:@"updated_at"]];
    [_notifyContentTextView setText:[_notifyInfo objectForKey:@"content"]];
    
    if (![[_notifyInfo objectForKey:@"image"] isKindOfClass:[NSString class]] || ![_notifyInfo objectForKey:@"image"])
    {
        [_notifyImageView setHidden:YES];
    }
    if (_imageData)
    {
        [_notifyImageView setImage:[UIImage imageWithData:_imageData]];
    }
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
