//
//  HistoryViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
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
    for (NSDictionary *item in arrayHistory)
    {
        NSString *requestType = [item objectForKey:ID_REQUEST_TYPE];
        
        if ([requestType isEqualToString:CODE_DINHKY])
        {
            [_listDungDKy addObject:item];
        }
        else if ([requestType isEqualToString:CODE_TONGVESINH])
        {
            [_listTongVS addObject:item];
        }
        else
        {
            [_listDungLe addObject:item];
        }
    }
    
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
    else if ([_sgSelection selectedSegmentIndex] == 2)
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *strIdentify = @"idhistorycell";
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentify];
 
    NSDictionary *item = [[self showSelectedList] objectAtIndex:indexPath.row];
    [cell setHistoryData:item];
 
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
    [detailviewController loadView];
    
    [detailviewController setUser:_user];
    [detailviewController setDetailInfo:item];
    
    [self.navigationController pushViewController:detailviewController animated:YES];
}

- (IBAction)didSelectHistorySegment:(id)sender
{
    [_tbHistory reloadData];
}
@end
