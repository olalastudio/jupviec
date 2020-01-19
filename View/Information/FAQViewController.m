//
//  FAQViewController.m
//  JupViec
//
//  Created by Khanhlt on 1/15/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()
{
    NSIndexPath *selectedIndex;
}

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"Câu hỏi thường gặp"];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    
    [_tableView registerNib:[UINib nibWithNibName:@"FAQTableViewCell" bundle:nil] forCellReuseIdentifier:@"faqcell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_faqArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAQTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"faqcell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDelegate:self];
    cell.indexPath = indexPath;
    [cell.titleLabel setText:[[_faqArr objectAtIndex:indexPath.row]objectForKey:@"title"]];
    
    if (selectedIndex.row == indexPath.row && selectedIndex.section == 1)
    {
        cell.contentLabel.numberOfLines = 20;
        [cell.contentLabel setText:[[_faqArr objectAtIndex:indexPath.row]objectForKey:@"content"]];
        cell.isShowContent = YES;
        [cell.showContentBtn setImage:[UIImage imageNamed:@"Polygon 7.png"] forState:UIControlStateNormal];
    }
    else
    {
        cell.contentLabel.numberOfLines = 0;
        [cell.contentLabel setText:@""];
        cell.isShowContent = NO;
        [cell.showContentBtn setImage:[UIImage imageNamed:@"Polygon 6.png"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAQTableViewCell *selectCell = [_tableView cellForRowAtIndexPath:indexPath];
    
    if (selectCell.isShowContent == NO)
    {
        selectedIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
    }
    else{
        selectedIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    }
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)showFAQContentInfo:(NSIndexPath *)indexPath
{
    FAQTableViewCell *selectCell = [_tableView cellForRowAtIndexPath:indexPath];
    
    if (selectCell.isShowContent == YES)
    {
        selectedIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
    }
    else{
        selectedIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    }
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
