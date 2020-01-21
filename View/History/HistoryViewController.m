//
//  HistoryViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "LoadingViewController.h"
#import "APIRequest.h"

@interface HistoryViewController ()
{
    NSMutableArray *_listData;
}

@end

@implementation HistoryViewController
@synthesize user = _user;

-(void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tbHistory setDelegate:self];
    [_tbHistory setDataSource:self];
    
    [_tbHistory setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //register cell
    [_tbHistory registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellReuseIdentifier:@"idhistorycell"];
    [_tbHistory setBackgroundColor:[UIColor whiteColor]];
    
    [self initData];
    [self getHistory];
    
    [self configPullToRefreshControl];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Comfortaa-Regular" size:20]}];
}

-(void)initData
{
    if (!_listData) {
        _listData = [[NSMutableArray alloc] initWithCapacity:0];
    }
}

-(void)configPullToRefreshControl
{
    UIRefreshControl *refreshControll = [[UIRefreshControl alloc] init];
    [refreshControll addTarget:self action:@selector(willRefreshContent) forControlEvents:UIControlEventValueChanged];
    
    _tbHistory.refreshControl = refreshControll;
}

-(void)willRefreshContent
{
    if (_user)
    {
        APIRequest *apirequest = [[APIRequest alloc] init];
        [apirequest requestAPIGetAllRequests:[_user userToken] completionHandler:^(NSArray * _Nullable resultDict, NSError * _Nonnull error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tbHistory.refreshControl endRefreshing];
                
                if (error.code == 200) { //sucess
                    [self showHistory:resultDict];
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
            });
        }];
    }
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
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)setUser:(User *)user
{
    _user = user;
}

-(User*)user
{
    return _user;
}

-(void)setDefineCodeGetFromServer:(NSDictionary *)codes
{
    _definesCode = [[NSMutableDictionary alloc] initWithDictionary:codes];
}

-(void)getHistory
{
    if (_user)
    {
        APIRequest *apirequest = [[APIRequest alloc] init];
        
        LoadingViewController *loadingview = [self.storyboard instantiateViewControllerWithIdentifier:@"idloadingview"];
        [loadingview show:self];
        
        [apirequest requestAPIGetAllRequests:[_user userToken] completionHandler:^(NSArray * _Nullable resultDict, NSError * _Nonnull error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [loadingview dismiss];
                
                if (error.code == 200) { //sucess
                    [self showHistory:resultDict];
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
            });
        }];
    }
}

//"updated_at" = "2020-01-07T09:01:49.544+0000";
-(void)showHistory:(NSArray*)arrayHistory
{
    _listData = [self sortArray:arrayHistory];
    
    [_tbHistory reloadData];
}

-(NSMutableArray*)sortArray:(NSArray*)array
{
    NSArray *sortedarray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
    {
        static NSDateFormatter *dateFormatter = nil;

        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        }

        NSString *date1String = [obj1 valueForKey:ID_UPDATE_DATE];
        NSString *date2String = [obj2 valueForKey:ID_UPDATE_DATE];

        NSDate *date1 = [dateFormatter dateFromString:date1String];
        NSDate *date2 = [dateFormatter dateFromString:date2String];

        return [date1 compare:date2];
    }];
    
    NSMutableArray *sortedlist = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = [sortedarray count] - 1; i >= 0; i--)
    {
        [sortedlist addObject:[sortedarray objectAtIndex:i]];
    }
    
    return sortedlist;
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
    return _listData;
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
    [cell setDefineCodeGetFromServer:[NSMutableDictionary dictionaryWithDictionary:_definesCode]];
    [cell setHistoryData:item];
 
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [[self showSelectedList] objectAtIndex:indexPath.row];
    
    DetailOrderViewController *detailviewController = [self.storyboard instantiateViewControllerWithIdentifier:@"iddetailoder"];
    
    [detailviewController setDelegate:self];
    [detailviewController setUser:_user];
    [detailviewController setDetailInfo:item];
    [detailviewController setDefineCodeGetFromServer:_definesCode];
    
    [self.navigationController pushViewController:detailviewController animated:YES];
}

#pragma mark - OrderDelegate
-(void)addCompleteOrder:(NSDictionary*)orderInfo
{
    [self initData];
    
    [_listData addObject:orderInfo];
    
    _listData = [self sortArray:_listData];
    
    [_tbHistory reloadData];
}

-(void)didStopOder:(NSDictionary *)resultDic
{
    NSArray *oldArray;
    
    //get old list
    oldArray = [NSArray arrayWithArray:_listData];
    
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:0];
    NSString *findID = [resultDic objectForKey:ID_SERVICE];
    
    //update new value
    for (NSDictionary* item in oldArray)
    {
        NSString *itemID = [item objectForKey:ID_SERVICE];
        
        if ([findID isEqualToString:itemID])
        {
            [newArray addObject:resultDic];
        }
        else{
            [newArray addObject:item];
        }
    }
    
    //update back old list
    _listData = [[NSMutableArray alloc] initWithArray:newArray];
    
    _listData = [self sortArray:_listData];
    
    [_tbHistory reloadData];
}

-(void)didRateOder:(NSDictionary *)resultDic
{
    NSArray *oldArray;
    
    //get old list
    oldArray = [NSArray arrayWithArray:_listData];
    
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:0];
    NSString *findID = [resultDic objectForKey:ID_SERVICE];
    
    //update new value
    for (NSDictionary* item in oldArray)
    {
        NSString *itemID = [item objectForKey:ID_SERVICE];
        
        if ([findID isEqualToString:itemID])
        {
            [newArray addObject:resultDic];
        }
        else{
            [newArray addObject:item];
        }
    }
    
    //update back old list
    _listData = [[NSMutableArray alloc] initWithArray:newArray];
    
    _listData = [self sortArray:_listData];
    
    [_tbHistory reloadData];
}
@end
