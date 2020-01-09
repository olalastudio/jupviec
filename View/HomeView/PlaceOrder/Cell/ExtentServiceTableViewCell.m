//
//  ExtentServiceTableViewCell.m
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "ExtentServiceTableViewCell.h"

@implementation ExtentServiceTableViewCell
{
    NSMutableArray  *_extendServices;
}
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _extendServices = [NSMutableArray arrayWithCapacity:0];
    
    [_tbService registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellReuseIdentifier:@"idservicecell"];
    
    [_tbService setDelegate:self];
    [_tbService setDataSource:self];
    [_tbService setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute
{
    _ordeAttribute = attribute;
}

-(void)setOrder:(Order *)order
{
    _order = order;
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _indexPath = index;
}

- (IBAction)didPressAddMoreExtendService:(id)sender
{
    if (_ordeAttribute == ATTRIBUTE_DICHVUKEMTHEO)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didPressAddExtentService:index:)])
        {
            [self.delegate didPressAddExtentService:[NSDictionary dictionary] index:_indexPath];
        }
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = [_tbService dequeueReusableCellWithIdentifier:@"idservicecell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
@end
