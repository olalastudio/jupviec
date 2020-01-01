//
//  NoticeViewController.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "CouponTableViewCell.h"
#import "NoticeDetailViewController.h"
#import "APIRequest.h"
#import "CommonDefines.h"
#import "JUntil.h"

@interface NoticeViewController ()
{
    NSMutableArray *_listNotices;
    NSMutableArray *_listCoupons;
}

@end

@implementation NoticeViewController
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _listNotices = [[NSMutableArray alloc] initWithCapacity:0];
    _listCoupons = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_tbNotice setRestorationIdentifier:@"idnoticetable"];
    [_tbCoupon setRestorationIdentifier:@"idcoupontable"];
    
    [_tbNotice registerNib:[UINib nibWithNibName:@"NoticeCell" bundle:nil] forCellReuseIdentifier:@"idnoticecell"];
    [_tbCoupon registerNib:[UINib nibWithNibName:@"CouponCell" bundle:nil] forCellReuseIdentifier:@"idcouponcell"];
    
    [_tbNotice setDelegate:self];
    [_tbNotice setDataSource:self];
    [_tbCoupon setDelegate:self];
    [_tbCoupon setDataSource:self];
    
    [_tbNotice setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tbCoupon setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
    
    [self showSelectedList];
    
    if ([_listNotices count] == 0) {
        [self getNotice];
    }
    
    if ([_listCoupons count] == 0) {
        [self getCoupon];
    }
}

-(void)setUser:(User *)user
{
    _user = user;
}

- (User *)user
{
    return _user;
}

-(void)getNotice
{
    APIRequest *apirequest = [[APIRequest alloc] init];
    
    [apirequest requestAPIGetAvailableNoti:[_user userToken] completionHandler:^(NSArray * _Nullable resultDict, NSError * _Nonnull error) {
       
        if (error.code == 200) {
            [self showNotice:resultDict];
        }
        else if (error.code == RESPONSE_CODE_NODATA)
        {
            [JUntil showPopup:self responsecode:RESPONSE_CODE_NODATA];
        }
        else if (error.code == RESPONSE_CODE_TIMEOUT)
        {
            [JUntil showPopup:self responsecode:RESPONSE_CODE_TIMEOUT];
        }
        else
        {
            [JUntil showPopup:self responsecode:RESPONSE_CODE_OTHER];
        }
    }];
}

-(void)getCoupon
{
    APIRequest *apirequest = [[APIRequest alloc] init];
}

-(void)showNotice:(NSArray*)notices
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        _listNotices = [NSMutableArray arrayWithArray:notices];
        
         [self showSelectedList];
    });
}

-(void)showCouponView
{
    _selectedNotice = NOTICE_CHOISE_COUPON;
}

-(void)showNoticeView
{
    _selectedNotice = NOTICE_CHOISE_NOTICE;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didSelectNoticeType:(id)sender
{
    if ([_sgSelection selectedSegmentIndex] == 0)
    {
        _selectedNotice = NOTICE_CHOISE_NOTICE;
    }
    else
    {
        _selectedNotice = NOTICE_CHOISE_COUPON;
    }
    
    [self showSelectedList];
}

-(void)showSelectedList
{
    if (_selectedNotice == NOTICE_CHOISE_NOTICE)
    {
        NSLog(@"Select Notice list");
        [_tbNotice setHidden:NO];
        [_tbCoupon setHidden:YES];
        
        [_tbNotice reloadData];
        
        [_sgSelection setSelectedSegmentIndex:0];
    }
    else
    {
        NSLog(@"Select coupon list");
        [_tbNotice setHidden:YES];
        [_tbCoupon setHidden:NO];
        
        [_tbCoupon reloadData];
        
        [_sgSelection setSelectedSegmentIndex:1];
    }
}

-(NSMutableArray*)getSelectedList
{
    if ([_sgSelection selectedSegmentIndex] == 0)
       {
           return _listNotices;
       }
       else if ([_sgSelection selectedSegmentIndex] == 1)
       {
           return _listCoupons;
       }
    
    return [[NSMutableArray alloc] initWithCapacity:0];
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getSelectedList] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView restorationIdentifier] isEqualToString:@"idnoticetable"])
    {
        NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idnoticecell"];
        [cell setNoticeInfo:[_listNotices objectAtIndex:indexPath.row]];
        
        return cell;
    }
    else if ([[tableView restorationIdentifier] isEqualToString:@"idcoupontable"])
    {
        CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idcouponcell"];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView restorationIdentifier] isEqualToString:@"idnoticetable"])
    {
        return 90;
    }
    else if ([[tableView restorationIdentifier] isEqualToString:@"idcoupontable"])
    {
        return 120;
    }
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"idnoticedetail"];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
