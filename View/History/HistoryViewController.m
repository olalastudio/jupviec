//
//  HistoryViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
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

-(void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tbHistory setDelegate:self];
    [_tbHistory setDataSource:self];
    
    //register cell
    [_tbHistory registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellReuseIdentifier:@"idhistorycell"];
    
    [self initData];
    
    [self getHistory];
}

-(void)initData
{
    if (!_listDungLe) {
        _listDungLe = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    if (!_listDungDKy) {
        _listDungDKy = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    if (!_listTongVS) {
        _listTongVS = [[NSMutableArray alloc] initWithCapacity:0];
    }
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
    if (_selectedType == TYPE_DUNGLE)
    {
        //Dung le
        [_sgSelection setSelectedSegmentIndex:0];
        return _listDungLe;
    }
    else if (_selectedType == TYPE_DUNGDINHKY)
    {
        //dung dinh ky
        [_sgSelection setSelectedSegmentIndex:1];
        return _listDungDKy;
    }
    else if (_selectedType == TYPE_TONGVESINH)
    {
        //tong ve sinh
        [_sgSelection setSelectedSegmentIndex:2];
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
    
    [self.navigationController pushViewController:detailviewController animated:YES];
}

- (IBAction)didSelectHistorySegment:(id)sender
{
    if ([_sgSelection selectedSegmentIndex] == 0)
    {
        _selectedType = TYPE_DUNGLE;
    }
    else if ([_sgSelection selectedSegmentIndex] == 1)
    {
        _selectedType = TYPE_DUNGDINHKY;
    }
    else
    {
        _selectedType = TYPE_TONGVESINH;
    }
    
    [_tbHistory reloadData];
}

#pragma mark - OrderDelegate
-(void)addCompleteOrder:(NSDictionary*)orderInfo
{
    NSString *requestype = [orderInfo objectForKey:ID_REQUEST_TYPE];
    
    [self initData];
    
    if ([requestype isEqualToString:CODE_DINHKY]) {
        [_listDungDKy addObject:orderInfo];
        _selectedType = TYPE_DUNGDINHKY;
    }
    else if ([requestype isEqualToString:CODE_TONGVESINH])
    {
        [_listTongVS addObject:orderInfo];
        _selectedType = TYPE_TONGVESINH;
    }
    else
    {
        [_listDungLe addObject:orderInfo];
        _selectedType = TYPE_DUNGLE;
    }
    
    [_tbHistory reloadData];
}

-(void)didStopOder:(NSDictionary *)resultDic
{
    NSString *type = [resultDic objectForKey:ID_REQUEST_TYPE];
    
    NSArray *oldArray;
    
    //get old list
    if ([type isEqualToString:CODE_SOFA] || [type isEqualToString:CODE_DUNGLE] || [type isEqualToString:CODE_DATLE])
    {
        oldArray = [NSArray arrayWithArray:_listDungLe];
    }
    else if ([type isEqualToString:CODE_DINHKY])
    {
        oldArray = [NSArray arrayWithArray:_listDungDKy];
    }
    else //([type isEqualToString:CODE_TONGVESINH])
    {
        oldArray = [NSArray arrayWithArray:_listTongVS];
    }
    
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
    if ([type isEqualToString:CODE_SOFA] || [type isEqualToString:CODE_DUNGLE] || [type isEqualToString:CODE_DATLE])
    {
        _listDungLe = [[NSMutableArray alloc] initWithArray:newArray];
    }
    else if ([type isEqualToString:CODE_DINHKY])
    {
        _listDungDKy = [[NSMutableArray alloc] initWithArray:newArray];
    }
    else //([type isEqualToString:CODE_TONGVESINH])
    {
        _listTongVS = [[NSMutableArray alloc] initWithArray:newArray];
    }
    
    [_tbHistory reloadData];
}

-(void)didRateOder:(NSDictionary *)resultDic
{
    
}
@end
