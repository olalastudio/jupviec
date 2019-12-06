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

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user = [[User alloc]init];
    
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomeTaskCell" bundle:nil] forCellReuseIdentifier:@"idhometaskcell"];
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomePromotionCell" bundle:nil] forCellReuseIdentifier:@"idhomepromotioncell"];
    [_tbSelectionTask registerNib:[UINib nibWithNibName:@"HomePromotionHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"idhomepromotionheadercell"];
    
    [_tbSelectionTask setDelegate:self];
    [_tbSelectionTask setDataSource:self];
    [_tbSelectionTask setBackgroundColor:[UIColor clearColor]];
    [_tbSelectionTask setSeparatorColor:[UIColor clearColor]];
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
    if (![user userPhoneNum])
    {
        //change to view register
        [self performSegueWithIdentifier:@"idlogin" sender:self];
    }
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
        return 4;
    }
    else if (section == SESSION_PROMOTION)
    {
        return 1;
    }
    
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //promotion
    if (indexPath.section == SESSION_PROMOTION)
    {
        HomePromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idhomepromotioncell"];
        [cell setSessionType:SESSION_PROMOTION];
        
        return cell;
    }
    
    //Task
    HomeTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idhometaskcell"];
    
    switch (indexPath.row) {
        case TYPE_DUNGLE:
            [cell setTaskType:TYPE_DUNGLE];
            break;
        case TYPE_DUNGDINHKY:
            [cell setTaskType:TYPE_DUNGDINHKY];
            break;
        case TYPE_TONGVESINH:
            [cell setTaskType:TYPE_TONGVESINH];
            break;
        case TYPE_JUPSOFA:
            [cell setTaskType:TYPE_JUPSOFA];
            break;
        default:
            break;
    }
    
    [cell setSessionType:SESSION_TASK];
    
    return cell;
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
    NSLog(@"did select row at index %@",indexPath);
    
    if (indexPath.section == SESSION_TASK) //task session
    {
        PlaceOrderViewController *oderview = [self.storyboard instantiateViewControllerWithIdentifier:@"idplaceorder"];
        
        switch (indexPath.row) {
            case TYPE_DUNGLE:
                [oderview setTaskType:TYPE_DUNGLE];
                break;
            case TYPE_DUNGDINHKY:
                [oderview setTaskType:TYPE_DUNGDINHKY];
            break;
            case TYPE_TONGVESINH:
                [oderview setTaskType:TYPE_TONGVESINH];
            break;
            case TYPE_JUPSOFA:
                [oderview setTaskType:TYPE_JUPSOFA];
            break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:oderview animated:YES];
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
