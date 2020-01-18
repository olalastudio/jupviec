//
//  InformationViewController.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationTableViewCell.h"
#import "InformationDetailViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [_tbInformation setDelegate:self];
    [_tbInformation setDataSource:self];
    
    [_tbInformation setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Comfortaa-Regular" size:20]}];
    
    _informationArr = [NSArray arrayWithObjects:@"Câu hỏi thường gặp", @"Pháp lý", @"Góp Ý", @"Liên hệ", nil];
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
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_informationArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setText:[_informationArr objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:16]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [_tbInformation cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"Câu hỏi thường gặp"]) {
        LoadingViewController *loadingview = [self.storyboard instantiateViewControllerWithIdentifier:@"idloadingview"];
        [loadingview show:self];
        APIRequest* api = [[APIRequest alloc]init];
        [api requestAPIGetFAQ:^(NSArray * _Nullable resultData, NSError * _Nonnull err) {
            [loadingview dismiss];
            dispatch_async(dispatch_get_main_queue(), ^{
                FAQViewController* faqVC = [self.storyboard instantiateViewControllerWithIdentifier:@"idfaqviewcontroller"];
                faqVC.faqArr = resultData;
                [self.navigationController pushViewController:faqVC animated:YES];
            });
        }];        
    }
    else if ([cell.textLabel.text isEqualToString:@"Góp Ý"])
    {
        FeedbackViewController* feedbackVC = [self.storyboard instantiateViewControllerWithIdentifier:@"idfeedback"];
        [feedbackVC setUser:_user];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }
    
}
@end
