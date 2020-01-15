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
    
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titlesArr count];
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
    [cell.titleLabel setText:[titlesArr objectAtIndex:indexPath.row]];
    //    [cell.detailLabel setText:[detailsArr objectAtIndex:indexPath.row]];
    if (_faqCell.isShowContent == YES)
    {
        cell.contentLabel.numberOfLines = 10;
        [cell.contentLabel setText:[contentsArr objectAtIndex:indexPath.row]];
        cell.isShowContent = YES;
    }
    else
    {
        cell.contentLabel.numberOfLines = 0;
        cell.isShowContent = NO;
    }
    
    return cell;
}

- (void)showFAQContentInfo:(NSIndexPath *)indexPath
{
    _faqCell = [_tableView cellForRowAtIndexPath:indexPath];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
