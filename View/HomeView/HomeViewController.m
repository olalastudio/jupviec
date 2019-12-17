//
//  HomeViewController.m
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTaskTableViewCell.h"
#import "HomePromotionTableViewCell.h"
#import "HomePromotionHeaderViewCell.h"
#import "SignInViewController.h"

#import "PlaceOrderViewController.h"

@interface HomeViewController ()
{
    PlaceOrderViewController    *orderview;
    CLLocationManager           *locationmanager;
    CLLocation                  *currentLocation;
}
@end

@implementation HomeViewController
@synthesize user = _user;
@synthesize configurationInfoDict = _configurationInfoDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _user = [[User alloc] init];
    
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomeTaskCell" bundle:nil] forCellReuseIdentifier:@"idhometaskcell"];
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomePromotionCell" bundle:nil] forCellReuseIdentifier:@"idhomepromotioncell"];
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomePromotionHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"idhomepromotionheadercell"];
    
    [_tbSelectionTask setDelegate:self];
    [_tbSelectionTask setDataSource:self];
    [_tbSelectionTask setBackgroundColor:[UIColor clearColor]];
    [_tbSelectionTask setSeparatorColor:[UIColor clearColor]];
    
    [self getCurrentLocation];
    [self getConfiguration];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)getCurrentLocation
{
    locationmanager = [[CLLocationManager alloc] init];
    [locationmanager setDelegate:self];
    locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [locationmanager requestLocation];
            break;
        default:
            break;
    }
}

-(void)setConfigurationInfoDict:(NSDictionary *)configurationInfoDict
{
    _configurationInfoDict = configurationInfoDict;
}

-(NSDictionary*)configurationInfoDict
{
    return _configurationInfoDict;
}

-(void)getConfiguration
{
    _serviceInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (_configurationInfoDict) {
        _serviceTypesArr = [_configurationInfoDict objectForKey:@"request_type"];
        if ([_configurationInfoDict objectForKey:@"base_price"]) {
            [_serviceInfo setObject:[_configurationInfoDict objectForKey:@"base_price"] forKey:@"base_price"];
        }
        if ([_configurationInfoDict objectForKey:@"min_price"]) {
            [_serviceInfo setObject:[_configurationInfoDict objectForKey:@"min_price"] forKey:@"min_price"];
        }
        if ([_configurationInfoDict objectForKey:@"base_hour"]) {
            [_serviceInfo setObject:[_configurationInfoDict objectForKey:@"base_hour"] forKey:@"base_hour"];
        }
        if ([_configurationInfoDict objectForKey:@"service_extend"]) {
            [_serviceInfo setObject:[_configurationInfoDict objectForKey:@"service_extend"] forKey:@"service_extend"];
        }
        if ([_configurationInfoDict objectForKey:@"payment_method"]) {
            [_serviceInfo setObject:[_configurationInfoDict objectForKey:@"payment_method"] forKey:@"payment_method"];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"idlogin"])
    {
        SignInViewController* signInVC = segue.destinationViewController;
        signInVC.intActionMode = MODE_REGISTER_NEW_ACC;
    }
}

- (IBAction)didClickLoginButton:(id)sender {
    if (![_user userPhoneNum])
    {
        //change to view register
        [self performSegueWithIdentifier:@"idlogin" sender:self];
    }
}

#pragma mark - LocationManager
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"Current location %@",locations);
    currentLocation = [locations objectAtIndex:0];
    
    if (orderview) {
        [orderview setCurrentLocation:[currentLocation coordinate]];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"request location did fail with error %@",error);
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SESSION_TASK)
    {
        return [_serviceTypesArr count];
    }
    else if (section == SESSION_PROMOTION)
    {
        return 1;
    }
    
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SESSION_TASK) //Task
    {
        HomeTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idhometaskcell"];
        
        NSDictionary *item = [_serviceTypesArr objectAtIndex:indexPath.row];
        NSString *code = [item objectForKey:@"code"];
        NSString *name = [item objectForKey:@"name"];
        
        if ([code isEqualToString:CODE_DUNGLE]) {
            [cell setTaskType:TYPE_DUNGLE];
        }
        else if ([code isEqualToString:CODE_DINHKY])
        {
            [cell setTaskType:TYPE_DUNGDINHKY];
        }
        else if ([code isEqualToString:CODE_TONGVESINH])
        {
            [cell setTaskType:TYPE_TONGVESINH];
        }
        else if ([code isEqualToString:CODE_SOFA])
        {
            [cell setTaskType:TYPE_JUPSOFA];
        }
        
        [cell setDisplayName:name];
        [cell setSessionType:SESSION_TASK];
        
        return cell;
    }
    else if (indexPath.section == SESSION_PROMOTION) //promotion
    {
        HomePromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idhomepromotioncell"];
        [cell setSessionType:SESSION_PROMOTION];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == SESSION_TASK)
    {
        UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
        return headerview;
    }
    else if (section == SESSION_PROMOTION)
    {
        HomePromotionHeaderViewCell *headercell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"idhomepromotionheadercell"];
        return headercell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SESSION_TASK) //task session
    {
        orderview = [self.storyboard instantiateViewControllerWithIdentifier:@"idplaceorder"];
        
        if (currentLocation) {
            [orderview setCurrentLocation:[currentLocation coordinate]];
        }
        
        if (_serviceInfo) {
            orderview.serviceInfo = _serviceInfo;
        }
        
        switch (indexPath.row) {
            case TYPE_DUNGLE:
                [orderview setTaskType:TYPE_DUNGLE];
                break;
            case TYPE_DUNGDINHKY:
                [orderview setTaskType:TYPE_DUNGDINHKY];
            break;
            case TYPE_TONGVESINH:
                [orderview setTaskType:TYPE_TONGVESINH];
            break;
            case TYPE_JUPSOFA:
                [orderview setTaskType:TYPE_JUPSOFA];
            break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:orderview animated:YES];
    }
    else if (indexPath.section == SESSION_PROMOTION) //promotion session
    {
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SESSION_TASK)
    {
         return 100;
    }
    else if (indexPath.section == SESSION_PROMOTION)
    {
        return 150;
    }
    
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == SESSION_TASK)
    {
        return 20;
    }
    else if (section == SESSION_PROMOTION)
    {
        return 30;
    }
    
    return 20;
}

@end
