//
//  HistoryViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HistoryViewController.h"
#import "DetailOrderViewController.h"
#import "APIRequest.h"

@interface HistoryViewController ()
{
    NSMutableArray *_listDungLe;
    NSMutableArray *_listDungDKy;
    NSMutableArray *_listTongVS;
}

@end

@implementation HistoryViewController
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tbHistory setDelegate:self];
    [_tbHistory setDataSource:self];
    
    //register cell
    [_tbHistory registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellReuseIdentifier:@"idhistorycell"];
    
    _listDungLe = [[NSMutableArray alloc] initWithCapacity:0];
    _listDungDKy = [[NSMutableArray alloc] initWithCapacity:0];
    _listTongVS = [[NSMutableArray alloc] initWithCapacity:0];
 
    [self getHistory];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
//Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwOTQ5MTc1MDA0IiwiZXhwIjoxNTc3NTMwMzYyfQ.CQ1wtBt4_om0h2Z0quWVhLrXlXpYA5cGyszCOEa48twhD7Fn5WRXQbHRYa9_XAEClGo_0UgcwF3dLL81egi1DA

-(void)getHistory
{
    if (_user)
    {
        APIRequest *apirequest = [[APIRequest alloc] init];
        
        [apirequest requestAPIGetAllRequests:[_user userToken] completionHandler:^(NSArray * _Nullable resultDict, NSError * _Nonnull error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error.code == 200) { //sucess
                    [self showHistory:resultDict];
                }
            });
        }];
    }
}

-(void)showHistory:(NSArray*)arrayHistory
{
    _listDungLe = [NSMutableArray arrayWithArray:arrayHistory];
    
    [_tbHistory reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSMutableArray*)showSelectedList
{
    if ([_sgSelection selectedSegmentIndex] == 0)
    {
        //Dung le
        return _listDungLe;
    }
    else if ([_sgSelection selectedSegmentIndex] == 1)
    {
        //dung dinh ky
        return _listDungDKy;
    }
    else if ([_sgSelection selectedSegmentIndex] == 3)
    {
        //tong ve sinh
        return _listTongVS;
    }

    return [NSMutableArray arrayWithCapacity:0];
}

#pragma mark - TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self showSelectedList] count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *strIdentify = @"idhistorycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentify];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [[self showSelectedList] objectAtIndex:indexPath.row];
    
    DetailOrderViewController *detailviewController = [self.storyboard instantiateViewControllerWithIdentifier:@"iddetailoder"];
    [detailviewController setUser:_user];
    [detailviewController setDetailInfo:item];
    
    [self.navigationController pushViewController:detailviewController animated:YES];
}
@end
