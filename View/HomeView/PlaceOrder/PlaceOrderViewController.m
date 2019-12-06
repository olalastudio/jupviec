//
//  PlaceOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "PlaceOrderCommonTableViewCell.h"

@interface PlaceOrderViewController (){
    NSArray *attributeListDungLe;
    NSArray *attributeListDungDK;
    NSArray *attributeListTongVS;
    NSArray *attributeListJupSofa;
}

@end

@implementation PlaceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tbPlaceOrderContent registerNib:[UINib nibWithNibName:@"CommonCell" bundle:nil] forCellReuseIdentifier:@"idplaceordercommoncell"];
    
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
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"show place order view for task %lu",(unsigned long)_tasktype);
    
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)setTaskType:(TASK_TYPE)type
{
    _tasktype = type;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
            [cell setOderAttribute:ATTRIBUTE_NGAYLAMTRONGTUAN];
            break;
        case ATTRIBUTE_NGAYKHAOSAT:
           [cell setOderAttribute:ATTRIBUTE_NGAYKHAOSAT];
           break;
        case ATTRIBUTE_GIOKHAOSAT:
            [cell setOderAttribute:ATTRIBUTE_GIOKHAOSAT];
            break;
        case ATTRIBUTE_GIOLAMVIEC:
            [cell setOderAttribute:ATTRIBUTE_GIOLAMVIEC];
            break;
        case ATTRIBUTE_DICHVUKEMTHEO:
            [cell setOderAttribute:ATTRIBUTE_DICHVUKEMTHEO];
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
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark - PlaceOrderCommonCellDelegate

@end
