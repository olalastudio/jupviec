//
//  ExtendServicePopupController.m
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "ExtendServicePopupController.h"
#import "JButton.h"
#import "PopupView.h"
#import "ServiceCell.h"

@interface ExtendServicePopupController ()

@end

@implementation ExtendServicePopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tbExtendService setDelegate:self];
    [_tbExtendService setDataSource:self];
    
    [_tbExtendService registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellReuseIdentifier:@"idextendservicecell"];
    [_tbExtendService setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tbExtendService setAllowsSelection:YES];
    [_tbExtendService setAllowsMultipleSelection:YES];
    
    [_tbExtendService setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    [self.view setBackgroundColor:[UIColor colorWithRed:85.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:0.38]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
           self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            } completion:^(BOOL finished) {
                self.popupView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)setOrderAttribute:(ORDER_ATTRIBUTE)attribute
{
    _orderAttribute = attribute;
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _index = index;
}

-(void)setOrder:(Order*)order
{
    _order = order;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didClickConfirmButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectExtendService:indexPath:services:)])
    {
        [_delegate didSelectExtendService:_orderAttribute indexPath:_index services:_selectedservice];
    }
    
     [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setTotalService:(NSArray*)totalservice
{
    _totalservice = [NSMutableArray arrayWithArray:totalservice];
}

-(void)setSelectedService:(NSArray*)selectedservice
{
    _selectedservice = [NSMutableArray arrayWithArray:selectedservice];
}

-(BOOL)isSelectedItem:(NSDictionary*)item
{
    NSString *itemcode = [item objectForKey:ID_CODE];
    for (NSDictionary *selecteditem in _selectedservice)
    {
        NSString *selectedcode = [selecteditem objectForKey:ID_CODE];
        if ([itemcode isEqualToString:selectedcode]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_totalservice count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idextendservicecell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setServiceCellType:TYPE_POPUP];
    
    NSDictionary *item = [_totalservice objectAtIndex:indexPath.row];
    [cell setTitle:[item objectForKey:ID_NAME]];

    if ([self isSelectedItem:item]) {
        [cell setIsSelect:YES];
    }else{
        [cell setIsSelect:NO];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = (ServiceCell*)[tableView cellForRowAtIndexPath:indexPath];
        
    if ([cell isSelect])
    {
        [cell setIsSelect:NO];
        NSDictionary *deselectitem = [_totalservice objectAtIndex:indexPath.row];
        [self removeItemFromSelectedService:deselectitem];
    }
    else{
        [cell setIsSelect:YES];
        [_selectedservice addObject:[_totalservice objectAtIndex:indexPath.row]];
    }
    
    NSLog(@"%@",_selectedservice);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = (ServiceCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *deselectitem = [_totalservice objectAtIndex:indexPath.row];
    [self removeItemFromSelectedService:deselectitem];
    
    NSLog(@"%@",_selectedservice);
    
    [cell setIsSelect:NO];
}

-(void)removeItemFromSelectedService:(NSDictionary*)deselectitem
{
    NSString *deselectedcode = [deselectitem objectForKey:ID_CODE];
    int deselectedIndex = 0;
    
    for (int i=0; i<[_selectedservice count];i++)
    {
        NSDictionary *item = [_selectedservice objectAtIndex:i];
        NSString *itemcode = [item objectForKey:ID_CODE];
        
        if ([deselectedcode isEqualToString:itemcode]) {
            deselectedIndex = i;
        }
    }
    
    [_selectedservice removeObjectAtIndex:deselectedIndex];
}
@end
