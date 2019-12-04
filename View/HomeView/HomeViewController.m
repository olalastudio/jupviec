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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    if (section == 0) {
        return 4;
    }
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HomeTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idhometaskcell"];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        HomePromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idhomepromotioncell"];
        
        return cell;
    }
    
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        HomePromotionHeaderViewCell *headercell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"idhomepromotionheadercell"];
        
        return headercell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    
    return 150;
}
@end
