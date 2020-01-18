//
//  FAQViewController.m
//  JupViec
//
//  Created by Khanhlt on 1/15/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()

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
    
    [_tableView setBackgroundColor:[UIColor whiteColor]];
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
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"FAQTableViewCell" bundle:nil] forCellReuseIdentifier:@"faqcell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"faqcell"];
    }
    [cell setDelegate:self];
    cell.indexPath = indexPath;
    [cell.titleLabel setText:[[_faqArr objectAtIndex:indexPath.row]objectForKey:@"title"]];
    //    [cell.detailLabel setText:[detailsArr objectAtIndex:indexPath.row]];
    if (_faqCell.isShowContent == YES)
    {
        cell.contentLabel.numberOfLines = 10;
        [cell.contentLabel setText:[[_faqArr objectAtIndex:indexPath.row]objectForKey:@"content"]];
        cell.isShowContent = YES;
        [cell.showContentBtn setImage:[UIImage imageNamed:@"Polygon 7.png"] forState:UIControlStateNormal];
    }
    else
    {
        cell.contentLabel.numberOfLines = 0;
        cell.isShowContent = NO;
        [cell.showContentBtn setImage:[UIImage imageNamed:@"Polygon 6.png"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)showFAQContentInfo:(NSIndexPath *)indexPath
{
    _faqCell = [_tableView cellForRowAtIndexPath:indexPath];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
