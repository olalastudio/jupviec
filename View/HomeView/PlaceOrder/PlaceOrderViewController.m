//
//  PlaceOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "ConfirmOrderViewController.h"
#import <GoogleMaps/GoogleMaps.h>

#import "JUntil.h"

@interface PlaceOrderViewController (){
    NSArray *attributeListDungLe;
    NSArray *attributeListDungDK;
    NSArray *attributeListTongVS;
    NSArray *attributeListJupSofa;
}

@end

@implementation PlaceOrderViewController
@synthesize order = _order;
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tbPlaceOrderContent registerNib:[UINib nibWithNibName:@"CommonCell" bundle:nil] forCellReuseIdentifier:@"idplaceordercommoncell"];
    [_tbPlaceOrderContent registerNib:[UINib nibWithNibName:@"TimeSelectionCell" bundle:nil] forCellReuseIdentifier:@"idplaceordertimeselectioncell"];
    [_tbPlaceOrderContent registerNib:[UINib nibWithNibName:@"DaySelectionCell" bundle:nil] forCellReuseIdentifier:@"idplaceorderdayselectioncell"];
    
    [_tbPlaceOrderContent setDelegate:self];
    [_tbPlaceOrderContent setDataSource:self];
    
    [_tbPlaceOrderContent setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    attributeListDungLe = @[[NSNumber numberWithInt:ATTRIBUTE_DIADIEM],
                      [NSNumber numberWithInt:ATTRIBUTE_SONHACANHO],
                      [NSNumber numberWithInt:ATTRIBUTE_NGAYLAMVIEC],
                      [NSNumber numberWithInt:ATTRIBUTE_GIOLAMVIEC],
                      [NSNumber numberWithInt:ATTRIBUTE_DICHVUKEMTHEO],
                      [NSNumber numberWithInt:ATTRIBUTE_HINHTHUCTHANHTOAN],
                      [NSNumber numberWithInt:ATTRIBUTE_GHICHU]];
    
    attributeListDungDK = @[[NSNumber numberWithInt:ATTRIBUTE_DIADIEM],
                            [NSNumber numberWithInt:ATTRIBUTE_SONHACANHO],
                            [NSNumber numberWithInt:ATTRIBUTE_NGAYLAMVIEC],
                            [NSNumber numberWithInt:ATTRIBUTE_NGAYLAMTRONGTUAN],
                            [NSNumber numberWithInt:ATTRIBUTE_GIOLAMVIEC],
                            [NSNumber numberWithInt:ATTRIBUTE_DICHVUKEMTHEO],
                            [NSNumber numberWithInt:ATTRIBUTE_HINHTHUCTHANHTOAN],
                            [NSNumber numberWithInt:ATTRIBUTE_GHICHU]];
    
    attributeListTongVS = @[[NSNumber numberWithInt:ATTRIBUTE_DIADIEM],
                            [NSNumber numberWithInt:ATTRIBUTE_SONHACANHO],
                            [NSNumber numberWithInt:ATTRIBUTE_NGAYKHAOSAT],
                            [NSNumber numberWithInt:ATTRIBUTE_GIOKHAOSAT],
                            [NSNumber numberWithInt:ATTRIBUTE_GHICHU]];
    
    attributeListJupSofa = @[[NSNumber numberWithInt:ATTRIBUTE_DIADIEM],
                            [NSNumber numberWithInt:ATTRIBUTE_SONHACANHO],
                            [NSNumber numberWithInt:ATTRIBUTE_NGAYLAMVIEC],
                            [NSNumber numberWithInt:ATTRIBUTE_GIOLAMVIEC],
                             [NSNumber numberWithInt:ATTRIBUTE_BANGGIADICHVU],
                            [NSNumber numberWithInt:ATTRIBUTE_GHICHU]];
    
    _order = [[Order alloc] init];
    
    [_order setOrderType:_tasktype];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];

    switch (_tasktype) {
        case TYPE_DUNGLE:
            [self setTitle:@"Dùng lẻ"];
            break;
        case TYPE_DUNGDINHKY:
            [self setTitle:@"Dùng định kỳ"];
            break;
        case TYPE_TONGVESINH:
            [self setTitle:@"Tổng vệ sinh"];
            break;
        case TYPE_JUPSOFA:
            [self setTitle:@"Đặt JupSofa"];
            break;
        default:
            break;
    }
    
    [self calculatePrice];
}

-(void)setTaskType:(TASK_TYPE)type
{
    _tasktype = type;
    
    [_order setOrderType:type];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)calculatePrice
{
    double baseHour = [[_serviceInfo objectForKey:ID_BASE_HOUR] doubleValue];
    double basePrice = [[_serviceInfo objectForKey:ID_BASE_PRICE] unsignedIntValue];
    double minPrice = [[_serviceInfo objectForKey:ID_MIN_PRICE] unsignedIntValue];
    
    NSArray *extendSerivce = [_order extraOption];
    double workhour = [_order workHour];
    double totalMoney;
    
    if (workhour >= baseHour) {
        totalMoney = workhour * minPrice;
    }else{
        totalMoney = workhour * basePrice;
    }
    
    for (NSDictionary *item in extendSerivce) {
        double extendprice = [[item objectForKey:ID_PRICE] doubleValue];
        totalMoney += extendprice;
    }
    
    [_txtTotalMoneyValue setText:[NSString stringWithFormat:@"%.3fđ/%.1fh",totalMoney,workhour]];
    
    [_order setTotalMoney:totalMoney];
    
    return totalMoney;
}

-(NSArray*)getlistDichVu
{
    switch (_tasktype) {
        case TYPE_DUNGLE:
            return attributeListDungLe;
            break;
        case TYPE_DUNGDINHKY:
            return attributeListDungDK;
            break;
        case TYPE_TONGVESINH:
            return attributeListTongVS;
            break;
        case TYPE_JUPSOFA:
            return attributeListJupSofa;
            break;
        default:
            break;
    }
    
    return nil;
}

-(void)setCurrentLocation:(CLLocationCoordinate2D)currentlocation
{
    _location = currentlocation;
    
    GMSGeocoder*  geocoder = [[GMSGeocoder alloc] init];
    
    [geocoder reverseGeocodeCoordinate:currentlocation completionHandler:^(GMSReverseGeocodeResponse * _Nullable response, NSError * _Nullable error) {
        GMSAddress* address = [response firstResult];
        NSArray* lines = [address lines];
        NSString *strLocation = [lines componentsJoinedByString:@" "];
        [[self order] setWorkAddress:strLocation];
        [[self tbPlaceOrderContent] reloadData];
    }];
}

- (IBAction)didPressNextToConfirmOrder:(id)sender
{
    ConfirmOrderViewController *confirmorderview = [self.storyboard instantiateViewControllerWithIdentifier:@"idconfirmorder"];
    [confirmorderview setOrder:_order];
    [confirmorderview setUser:_user];
    
    [self.navigationController pushViewController:confirmorderview animated:YES];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getlistDichVu] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceOrderCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idplaceordercommoncell"];
    [cell setDelegate:self];
    [cell setIndexPath:indexPath];
    [cell setOrder:_order];
    [cell setServiceInfo:_serviceInfo];
    
    NSNumber *row = [[self getlistDichVu] objectAtIndex:indexPath.row];
    
    switch ([row intValue]) {
        case ATTRIBUTE_DIADIEM:
            [cell setOderAttribute:ATTRIBUTE_DIADIEM];
            break;
        case ATTRIBUTE_SONHACANHO:
            [cell setOderAttribute:ATTRIBUTE_SONHACANHO];
            break;
        case ATTRIBUTE_NGAYLAMVIEC:
            [cell setOderAttribute:ATTRIBUTE_NGAYLAMVIEC];
            break;
        case ATTRIBUTE_NGAYLAMTRONGTUAN:
        {
            DaySelectionTableViewCell *daycell = [tableView dequeueReusableCellWithIdentifier:@"idplaceorderdayselectioncell"];
            [daycell setDelegate:self];
            [daycell setOderAttribute:ATTRIBUTE_NGAYLAMTRONGTUAN];
            [daycell setIndexPath:indexPath];
            [daycell setOrder:_order];
            
            return daycell;
        }
            break;
        case ATTRIBUTE_NGAYKHAOSAT:
           [cell setOderAttribute:ATTRIBUTE_NGAYKHAOSAT];
           break;
        case ATTRIBUTE_GIOKHAOSAT:
        {
            TimeSelectionTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:@"idplaceordertimeselectioncell"];
            [timeCell setDelegate:self];
            [timeCell setOderAttribute:ATTRIBUTE_GIOKHAOSAT];
            [timeCell setIndexPath:indexPath];
            [timeCell setOrder:_order];
            
            [self calculatePrice];
            
            return timeCell;
        }
            break;
        case ATTRIBUTE_GIOLAMVIEC:
        {
            TimeSelectionTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:@"idplaceordertimeselectioncell"];
            [timeCell setDelegate:self];
            [timeCell setOderAttribute:ATTRIBUTE_GIOLAMVIEC];
            [timeCell setIndexPath:indexPath];
            [timeCell setOrder:_order];
            
            [self calculatePrice];
            
            return timeCell;
        }
            break;
        case ATTRIBUTE_DICHVUKEMTHEO:
        {
            [cell setOderAttribute:ATTRIBUTE_DICHVUKEMTHEO];
            [self calculatePrice];
        }
            break;
        case ATTRIBUTE_HINHTHUCTHANHTOAN:
            [cell setOderAttribute:ATTRIBUTE_HINHTHUCTHANHTOAN];
            break;
        case ATTRIBUTE_BANGGIADICHVU:
            [cell setOderAttribute:ATTRIBUTE_BANGGIADICHVU];
            break;
        case ATTRIBUTE_GHICHU:
            [cell setOderAttribute:ATTRIBUTE_GHICHU];
            break;
        default:
            break;
    }
    
    [cell reloadViewContent];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *row = [[self getlistDichVu] objectAtIndex:indexPath.row];
    
    switch ([row intValue]) {
        case ATTRIBUTE_GIOKHAOSAT:
            return 110;
            break;
        case ATTRIBUTE_NGAYLAMTRONGTUAN:
            return 120;
            break;
        case ATTRIBUTE_GHICHU:
            return 198;
            break;
        default:
            break;
    }
    
    return 88;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    headerview.backgroundColor = [UIColor clearColor];
    
    return headerview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

#pragma mark - PlaceOrderCommonCellDelegate
-(void)didPressCellAtIndexPath:(NSIndexPath *)index attributeType:(ORDER_ATTRIBUTE)attribute
{
    NSLog(@"did press on order cell %lu",(unsigned long)attribute);
    
    switch (attribute) {
        case ATTRIBUTE_DIADIEM:
        {
            MapsViewController *mapsview = [self.storyboard instantiateViewControllerWithIdentifier:@"idmapview"];
            [mapsview setSelectedLocation:_location];
            
            UIViewController *topview = [self.navigationController topViewController];
            
            if (![topview isKindOfClass:[MapsViewController class]])
            {
                [self.navigationController pushViewController:mapsview animated:YES];
            }
        }
            break;
        case ATTRIBUTE_SONHACANHO:
        {
            TextDetailPopupController *detailpopup = [self.storyboard instantiateViewControllerWithIdentifier:@"idtextdetailpopup"];
            [detailpopup setDelegate:self];
            [detailpopup setOrderAttribute:ATTRIBUTE_SONHACANHO];
            [detailpopup setPopupCurrentLocation:[_order workAddress]];
            [detailpopup setPopupContent:[_order homeNumber]];
            [detailpopup setIndex:index];
            
            [self setModalPresentationStyle:UIModalPresentationCurrentContext];
            [self presentViewController:detailpopup animated:YES completion:nil];
        }
            break;
        case ATTRIBUTE_NGAYLAMVIEC:
        {
            [self didClickChangeDaySelection:ATTRIBUTE_NGAYLAMVIEC index:index];
        }
            break;
        case ATTRIBUTE_NGAYLAMTRONGTUAN:
            break;
        case ATTRIBUTE_NGAYKHAOSAT:
        {
            [self didClickChangeDaySelection:ATTRIBUTE_NGAYKHAOSAT index:index];
        }
            break;
        case ATTRIBUTE_GIOKHAOSAT:
        {
            
        }
            break;
        case ATTRIBUTE_GIOLAMVIEC:
            break;
        case ATTRIBUTE_DICHVUKEMTHEO:
            break;
        case ATTRIBUTE_HINHTHUCTHANHTOAN:
            break;
        case ATTRIBUTE_BANGGIADICHVU:
            break;
        case ATTRIBUTE_GHICHU:
            break;
        default:
            break;
    }
}

#pragma mark - TimeSelectionCell Delegate
-(void)didClickWorkTimeSelection:(ORDER_ATTRIBUTE)attribute index:(NSIndexPath *)index
{
    NSLog(@"did change time");
    DateTimePickerPopupController *timepicker = [self.storyboard instantiateViewControllerWithIdentifier:@"iddatetimepicker"];
    [timepicker setOrderAttribute:attribute];
    [timepicker setOrder:_order];
    [timepicker setIndexPath:index];
    [timepicker setDelegate:self];
    
    [self setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self presentViewController:timepicker animated:YES completion:nil];
}

-(void)didClickWorkHourSelection:(ORDER_ATTRIBUTE)attribute index:(NSIndexPath *)index
{
    NSLog(@"did change hour");
}

-(void)didClickChangeDaySelection:(ORDER_ATTRIBUTE)sender index:(NSIndexPath *)index
{
    NSLog(@"did click change day");
    
    DateTimePickerPopupController *datepicker = [self.storyboard instantiateViewControllerWithIdentifier:@"iddatetimepicker"];
    [datepicker setOrderAttribute:sender];
    [datepicker setOrder:_order];
    [datepicker setIndexPath:index];
    [datepicker setDelegate:self];
    
    [self setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self presentViewController:datepicker animated:YES completion:nil];
}

-(void)didSelectDayOfTheWeek:(NSMutableArray *)dayofweeks
{
    [_order setWorkDayInWeek:dayofweeks];
}
#pragma mark - MapsCell Delegate

#pragma mark - Payment Delegate
-(void)didSelectPaymentMethod:(NSDictionary *)code index:(NSIndexPath *)index
{
    [_order setPaymentMethod:code];
    
    [_tbPlaceOrderContent reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)didSelectExtentService:(NSDictionary *)code index:(NSIndexPath *)index
{
    [_order setExtraOption:[NSMutableArray arrayWithObjects:code, nil]];
    
    [_tbPlaceOrderContent reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Popup Delegate
-(void)didPressConfirmDetailPopup:(ORDER_ATTRIBUTE)sender index:(NSIndexPath *)index withReturnValue:(NSString *)str
{
    switch (sender)
    {
        case ATTRIBUTE_SONHACANHO:
        {
            [_order setHomeNumber:str];
        }
            break;
        default:
            break;
    }
    
    [_tbPlaceOrderContent reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)didSelectDate:(ORDER_ATTRIBUTE)sender date:(NSDate *)date indexPath:(NSIndexPath *)index
{
    switch (sender)
    {
        case ATTRIBUTE_NGAYLAMVIEC:
        case ATTRIBUTE_NGAYLAMTRONGTUAN:
        {
            [_order setWorkDate:date];
        }
            break;
        case ATTRIBUTE_NGAYKHAOSAT:
        {
            [_order setDayOfExamine:date];
        }
            break;
        default:
            break;
    }
    
    [_tbPlaceOrderContent reloadData];
}

-(void)didSelectTime:(ORDER_ATTRIBUTE)sender indexPath:(NSIndexPath *)index workTime:(NSDate *)worktime
{
    switch (sender) {
        case ATTRIBUTE_GIOLAMVIEC:
        {
            [_order setWorkTime:worktime];
        }
            break;
        case ATTRIBUTE_GIOKHAOSAT:
        {
            [_order setTimeOfExamine:[NSMutableDictionary dictionaryWithDictionary:worktime]];
        }
            break;
        default:
            break;
    }
    
    [_tbPlaceOrderContent reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}
@end
