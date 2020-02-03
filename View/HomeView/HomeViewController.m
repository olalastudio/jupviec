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
#import "NoticeDetailViewController.h"

#import "SignInViewController.h"
#import "PlaceOrderViewController.h"
#import "AccountInfoViewController.h"
#import "LoginWithPasswordViewController.h"

#import "HistoryViewController.h"
#import "NoticeViewController.h"
#import "InformationViewController.h"

#import "LoginButton.h"
#import "LoadingViewController.h"

@interface HomeViewController ()
{
    PlaceOrderViewController    *orderview;
    CLLocationManager           *locationmanager;
    CLLocation                  *currentLocation;
}
@end

@implementation HomeViewController
@synthesize user = _user;
@synthesize strUserToken = _strUserToken;
@synthesize strPhoneNum = _strPhoneNum;
@synthesize configurationInfoDict = _configurationInfoDict;

-(void)awakeFromNib
{
    [super awakeFromNib];

    _strUserToken = [[NSUserDefaults standardUserDefaults] objectForKey:ID_USER_TOKEN];
    _strPhoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:ID_USER_PHONENUMBER];
    
    if (_strUserToken && _strPhoneNum && ![_strUserToken isEqualToString:@""] && ![_strPhoneNum isEqualToString:@""])
    {
        _user = [[User alloc] init];
        [_user setUserToken:_strUserToken];
        [_user setUserPhoneNum:_strPhoneNum];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomeTaskCell" bundle:nil] forCellReuseIdentifier:@"idhometaskcell"];
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomePromotionCell" bundle:nil] forCellReuseIdentifier:@"idhomepromotioncell"];
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomePromotionHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"idhomepromotionheadercell"];
    
    [_tbSelectionTask setDelegate:self];
    [_tbSelectionTask setDataSource:self];
    [_tbSelectionTask setBackgroundColor:[UIColor clearColor]];
    [_tbSelectionTask setSeparatorColor:[UIColor clearColor]];
    
    [self getCurrentLocation];
    [self getConfiguration];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Comfortaa-Regular" size:20]}];
    [self.tabBarController setDelegate:self];
    
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = @"";
    }
}

-(void)broadcastUser
{
    if (_user) {
        
        NSArray *navicontrols = [self.tabBarController viewControllers];
        for (UINavigationController *navicontrol in navicontrols) {
        
            UIViewController *viewcontrol = [[navicontrol viewControllers] objectAtIndex:0];
            if ([viewcontrol isKindOfClass:[HistoryViewController class]])
            {
                HistoryViewController *historyview = (HistoryViewController*)viewcontrol;
                [historyview setDefineCodeGetFromServer:[self definesCode:@[ID_REQUEST_TYPE, ID_CLIENT_STATUS, ID_DEFINE_MESSAGE, ID_FEEDBACK_STATUS, ID_REQUEST_STATUS, ID_PAYMENT_STATUS, ID_PAYMENT_METHOD, ID_SERVICE_EXTEND]]];
                [historyview setUser:_user];
            }
            else if ([viewcontrol isKindOfClass:[NoticeViewController class]])
            {
                NoticeViewController *noticeview = (NoticeViewController*)viewcontrol;
                [noticeview setUser:_user];
            }
            else if ([viewcontrol isKindOfClass:[InformationViewController class]])
            {
                InformationViewController* infoVC = (InformationViewController*)viewcontrol;
                [infoVC setUser:_user];
            }
            else if ([viewcontrol isKindOfClass:[HomeViewController class]])
            {
            }
        }
    }
}

-(void)setUser:(User *)user
{
    _user = user;
    _strUserToken = [user userToken];
    _strPhoneNum = [user userPhoneNum];
    
    [[NSUserDefaults standardUserDefaults] setObject:[_user userToken] forKey:ID_USER_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:[_user userPhoneNum] forKey:ID_USER_PHONENUMBER];
    
    [JUntil sendFCMDeviceTokenToServer:_strUserToken];
    
    [self broadcastUser];
}

-(User*)user
{
    return _user;
}

-(void)setStrUserToken:(NSString *)strUserToken
{
    _strUserToken = strUserToken;
    
    if (!_user) {
        _user = [[User alloc] init];
    }
    
    [_user setUserToken:_strUserToken];
    [[NSUserDefaults standardUserDefaults] setObject:_strUserToken forKey:ID_USER_TOKEN];
    
    [JUntil sendFCMDeviceTokenToServer:_strUserToken];
}

-(NSString*)strUserToken
{
    return _strUserToken;
}

-(void)setStrPhoneNum:(NSString *)strPhoneNum
{
    _strPhoneNum = strPhoneNum;
    
    if (!_user) {
        _user = [[User alloc] init];
    }
    
    [_user setUserPhoneNum:_strPhoneNum];
    [[NSUserDefaults standardUserDefaults] setObject:_strPhoneNum forKey:ID_USER_PHONENUMBER];
}

-(NSString*)strPhoneNum
{
    return _strPhoneNum;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
    [self.tabBarController setDelegate:self];
    
    [self showLoginUser];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)showLoginUser
{
    if (_user)
    {
        // user logged in
        [_loginBtn setLoginStatus:STATUS_LOGEDIN];
    }
    else
    {
        [_loginBtn setLoginStatus:STATUS_NONE];
    }
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

-(void)setCouponArray:(NSMutableArray*)coupon
{
    _couponArray = coupon;
}

-(NSMutableArray*)couponDict
{
    return _couponArray;
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
    
}

#pragma mark - Login & out
-(void)logIn:(NSString *)strToken phoneNumber:(NSString *)phonenumber
{
    [self setStrUserToken:strToken];
    [self setStrPhoneNum:phonenumber];
    
    [self broadcastUser];
}

-(BOOL)isLogedIn
{
    if (_user)
    {
        return YES;
    }
    
    return NO;
}

-(void)askForLogIn
{
    UINavigationController *selecteditem = (UINavigationController*)[self.tabBarController selectedViewController];
    [JUntil showPopup:[selecteditem visibleViewController] responsecode:RESPONSE_CODE_NOT_LOGEDIN completionHandler:^(POPUP_ACTION action) {
        
    }];
}

-(void)showAccountView
{
    UIViewController *selectedcontroller = [(UINavigationController*)[[self tabBarController] selectedViewController] visibleViewController];

    if ([selectedcontroller isKindOfClass:[LoginWithPasswordViewController class]])
    {

    }
    else if ([selectedcontroller isKindOfClass:[AccountInfoViewController class]])
    {
        AccountInfoViewController *accountview = (AccountInfoViewController*)selectedcontroller;
        accountview.user = _user;
        accountview.tokenStr = _strUserToken;

        [accountview updateContentView];
    }
    else if ([selectedcontroller isKindOfClass:[LoadingViewController class]])
    {
        selectedcontroller = [(UINavigationController*)[[self tabBarController] selectedViewController] topViewController];
        if ([selectedcontroller isKindOfClass:[AccountInfoViewController class]])
        {
            AccountInfoViewController *accountview = (AccountInfoViewController*)selectedcontroller;
            accountview.user = _user;
            accountview.tokenStr = _strUserToken;
            
            [accountview updateContentView];
        }
    }
}

-(void)logOut
{
    _user = nil;
    _strUserToken = @"";
    _strPhoneNum = @"";
    
    [[NSUserDefaults standardUserDefaults] setObject:_strPhoneNum forKey:ID_USER_PHONENUMBER];
    [[NSUserDefaults standardUserDefaults] setObject:_strUserToken forKey:ID_USER_TOKEN];
}

- (void)switchLoginView:(UIViewController*)sender
{
    if (![_user userNameStr])
    {
//        //view user info
//        LoadingViewController *loadingview = [self.storyboard instantiateViewControllerWithIdentifier:@"idloadingview"];
//        [loadingview show:sender];
        
        APIRequest* api = [[APIRequest alloc]init];
        [api requestAPIGetAccountInfo:[_user userToken] completionHandler:^(User * _Nullable user, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error.code == 200) {
                    user.userToken = [self.user userToken];
                    self->_user = user;
                    [self showAccountView];
//                    [loadingview dismiss];
                }
                else if (error.code == 204)
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
    else
    {
        [self showAccountView];
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
        [cell setPromotion:_couponArray];
        [cell setDelegate:self];
        
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
        [headercell setDelegate:self];
        
        return headercell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SESSION_TASK) //task session
    {
        if ([self isLogedIn])
        {
            orderview = [self.storyboard instantiateViewControllerWithIdentifier:@"idplaceorder"];
            [orderview setUser:_user];
            
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
        else
        {
            [self askForLogIn];
        }
    }
    else if (indexPath.section == SESSION_PROMOTION) //promotion session
    {
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SESSION_TASK)
    {
         return 105;
    }
    else if (indexPath.section == SESSION_PROMOTION)
    {
        return 160;
    }
    
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == SESSION_TASK)
    {
        return 10;
    }
    else if (section == SESSION_PROMOTION)
    {
        return 20;
    }
    
    return 20;
}

#pragma mark - Promotion Delegate Area
-(void)didClickViewMorePromotion
{
    NSLog(@"did click view more promotion");
    
    NSArray *viewcontrollers = [self.tabBarController viewControllers];
    
    for (UINavigationController *item in viewcontrollers)
    {
        UIViewController *selectedview = [(UINavigationController*)item visibleViewController];
        
        if ([selectedview isKindOfClass:[NoticeViewController class]])
        {
            NoticeViewController *noticeview = (NoticeViewController*)selectedview;
            [noticeview showCouponView];
            [noticeview showCoupon:_couponArray];
            [noticeview setUser:_user];
            
            [self.tabBarController setSelectedViewController:item];
            break;
        }
    }
}

-(void)didSelectPromotionCode:(NSDictionary *)promotioncode
{
    NoticeDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"idnoticedetail"];
    [detailViewController setNotifyInfo:promotioncode];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)didCompleteOrder:(NSDictionary *)orderInfo
{
    NSArray *viewcontrollers = [self.tabBarController viewControllers];
    
    for (UINavigationController *item in viewcontrollers)
    {
        UIViewController *selectedview = [(UINavigationController*)item visibleViewController];
        
        if ([selectedview isKindOfClass:[HistoryViewController class]])
        {
            HistoryViewController *historyview = (HistoryViewController*)selectedview;
            [historyview setDefineCodeGetFromServer:[self definesCode:@[ID_REQUEST_TYPE, ID_CLIENT_STATUS, ID_DEFINE_MESSAGE, ID_FEEDBACK_STATUS, ID_REQUEST_STATUS, ID_PAYMENT_STATUS, ID_PAYMENT_METHOD, ID_SERVICE_EXTEND]]];
            [historyview setUser:_user];
            [historyview addCompleteOrder:orderInfo];
            
            [self.tabBarController setSelectedViewController:item];
            break;
        }
    }
}
#pragma mark - tabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *selectedview = [(UINavigationController*)viewController visibleViewController];
    
    if ([selectedview isKindOfClass:[HistoryViewController class]])
    {
        if (![self isLogedIn])
        {
            [self askForLogIn];
            return NO;
        }
    }
    else if ([selectedview isKindOfClass:[LoginWithPasswordViewController class]])
    {
        if ([self isLogedIn])
        {
            AccountInfoViewController *accountview = [self.storyboard instantiateViewControllerWithIdentifier:@"idaccountview"];
            [(UINavigationController*)viewController setViewControllers:@[accountview]];
            [self switchLoginView:accountview];
        }
        else
        {
            LoginWithPasswordViewController *loginview = [self.storyboard instantiateViewControllerWithIdentifier:@"idloginview"];
            [(UINavigationController*)viewController setViewControllers:@[loginview]];
        }
    }
    else if ([selectedview isKindOfClass:[AccountInfoViewController class]])
    {
        AccountInfoViewController *accountview = (AccountInfoViewController*)selectedview;
        accountview.user = _user;
        accountview.tokenStr = _strUserToken;
        
        [accountview updateContentView];
    }
    
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UIViewController *selectedview = [(UINavigationController*)viewController visibleViewController];
    
    if ([selectedview isKindOfClass:[HistoryViewController class]])
    {
        HistoryViewController *historyview = (HistoryViewController*)selectedview;
        
        [historyview setDefineCodeGetFromServer:[self definesCode:@[ID_REQUEST_TYPE, ID_CLIENT_STATUS, ID_DEFINE_MESSAGE, ID_FEEDBACK_STATUS, ID_REQUEST_STATUS, ID_PAYMENT_STATUS, ID_PAYMENT_METHOD, ID_SERVICE_EXTEND]]];
        [historyview setUser:_user];
        NSLog(@"select history tab");
    }
    else if ([selectedview isKindOfClass:[NoticeViewController class]])
    {
        NoticeViewController *noticeview = (NoticeViewController*)selectedview;
        
        [noticeview setUser:_user];
        NSLog(@"select notice tab");
    }
    else if ([selectedview isKindOfClass:[InformationViewController class]])
    {
        InformationViewController* infoVC = (InformationViewController*)selectedview;
        [infoVC setUser:_user];
        NSLog(@"select info tab");
    }
    else if ([selectedview isKindOfClass:[HomeViewController class]])
    {
        NSLog(@"select home view");
    }
}

-(NSMutableDictionary*)definesCode:(NSArray*)codes
{
    NSMutableDictionary *definecodes = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (NSString *code in codes)
    {
        if ([_configurationInfoDict objectForKey:code]) {
            [definecodes setObject:[_configurationInfoDict objectForKey:code] forKey:code];
        }
    }
    
    return definecodes;
}

@end
