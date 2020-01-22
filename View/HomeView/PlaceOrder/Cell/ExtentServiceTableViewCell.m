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
    [_tbService setBackgroundColor:[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:0.21]];
    _tbService.layer.cornerRadius = 7;
    _tbService.layer.borderWidth = 1;
    _tbService.layer.borderColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:0.51].CGColor;
    
    [_txtTitle setTextColor:UIColorFromRGB(0x000000)];
    
    [self setBackgroundColor:[UIColor whiteColor]];
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
    
    [_tbService reloadData];
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
    return [[_order extraOption] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = [_tbService dequeueReusableCellWithIdentifier:@"idservicecell"];
    [cell setServiceCellType:TYPE_ORDER];
    
    NSDictionary *item = [[_order extraOption] objectAtIndex:indexPath.row];
    [cell setTitle:[item objectForKey:ID_NAME]];
    [cell setIndexPath:indexPath];
    [cell setDelegate:self];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma mark - ServiceCell Delegate
-(void)didClickDeleteServiceAt:(NSIndexPath *)index
{
    NSMutableArray *services = [NSMutableArray arrayWithArray:[_order extraOption]];
    
    [services removeObjectAtIndex:index.row];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didPressDeleteExtendService:index:)]   )
    {
        [_delegate didPressDeleteExtendService:services index:_indexPath];
    }
}
@end
