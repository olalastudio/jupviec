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

@interface NoticeViewController ()

@end

@implementation NoticeViewController
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    [self showSelectedNotice];
    
    [self.tabBarController.tabBar setHidden:NO];
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
    
    [self showSelectedNotice];
}

-(void)showSelectedNotice
{
    if ([_sgSelection selectedSegmentIndex] == 0)
    {
        NSLog(@"Select Notice list");
        [_tbNotice setHidden:NO];
        [_tbCoupon setHidden:YES];
        
        [_tbNotice reloadData];
    }
    else if ([_sgSelection selectedSegmentIndex] == 1)
    {
        NSLog(@"Select coupon list");
        [_tbNotice setHidden:YES];
        [_tbCoupon setHidden:NO];
        
        [_tbCoupon reloadData];
    }
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView restorationIdentifier] isEqualToString:@"idnoticetable"])
    {
        NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idnoticecell"];
        
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
