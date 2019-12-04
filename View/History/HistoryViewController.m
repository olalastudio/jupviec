//
//  HistoryViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HistoryViewController.h"
#import "DetailOrderViewController.h"

@interface HistoryViewController ()
{
    NSMutableArray *_listDungLe;
    NSMutableArray *_listDungDKy;
    NSMutableArray *_listTongVS;
}

@end

@implementation HistoryViewController

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
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailOrderViewController *detailviewController = [self.storyboard instantiateViewControllerWithIdentifier:@"iddetailoder"];
    
    [self.navigationController pushViewController:detailviewController animated:YES];
}
@end
