//
//  NoticeDetailViewController.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "CommonDefines.h"
#import "JView.h"
#import "JUntil.h"

@interface NoticeDetailViewController ()

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBarController.tabBar setHidden:YES];
    self.view.layer.masksToBounds = YES;
    
    [self setTitle:@"Chi tiết"];
    
    [_titleLB setTextColor:UIColorFromRGB(0x000000)];
    [_contentLB setTextColor:UIColorFromRGB(0x5C5C5C)];
    [_notifyDateLB setTextColor:UIColorFromRGB(0xACB3BF)];
    [_separatorline setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
    
    _notifyImageView.layer.cornerRadius = 10;
    _notifyImageView.layer.masksToBounds = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[_notifyInfo objectForKey:@"type"] isEqualToString:@"notify"])
    {
        _imageviewTopConstraint.constant = 0;
        _imageviewHeightConstraint.constant = 1;
        [_contentView layoutIfNeeded];
        
        _notifyImageView.layer.borderWidth = 0;
        _notifyImageView.layer.borderColor = [UIColor clearColor].CGColor;
        
        [_notifyImageView setImage:nil];
    }
    else
    {
        if (!_imageData)
        {
            UIImage *defaultImage = [UIImage imageNamed:@"makhuyenmai.png"];
            [_notifyImageView setImage:defaultImage];
        }
        else
        {
            [_notifyImageView setImage:[UIImage imageWithData:_imageData]];
        }
        
        _imageviewTopConstraint.constant = 25;
        _imageviewHeightConstraint.constant = 230;
        [_contentView layoutIfNeeded];
        
        _notifyImageView.layer.borderWidth = 1;
        _notifyImageView.layer.borderColor = UIColorFromRGB(0xF0F0F0).CGColor;
    }
    
    [_titleLB setText:[_notifyInfo objectForKey:@"title"]];
    [_contentLB setText:[_notifyInfo objectForKey:@"content"]];
    
    NSString *strdate = [_notifyInfo objectForKey:@"expired_date"];
    NSDate *date = [JUntil dateFromString:strdate];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE, dd/MM/yyyy"];
    [format setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
    
    [_notifyDateLB setText:[format stringFromDate:date]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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
