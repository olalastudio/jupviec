//
//  HomePromotionTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomePromotionTableViewCell.h"
#import "HomePromotionCollectionViewCell.h"

@implementation HomePromotionTableViewCell
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_clPromotionCode registerNib:[UINib nibWithNibName:@"HomePromotionCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"idhomepromotioncollectcell"];
    
    [_clPromotionCode setDelegate:self];
    [_clPromotionCode setDataSource:self];
    
    [_clPromotionCode setBackgroundColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTaskType:(TASK_TYPE)task
{
    _taskType = task;
}

-(void)setSessionType:(SESSION_TYPE)session
{
    _sessionType = session;
}

-(void)setPromotion:(NSMutableArray *)promotions
{
    _promotionArray = promotions;
}

-(TASK_TYPE)taskType
{
    return _taskType;
}

-(SESSION_TYPE)sessionType
{
    return _sessionType;
}

-(NSMutableArray*)promotions
{
    return _promotionArray;
}

#pragma mark UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_promotionArray count];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HomePromotionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"idhomepromotioncollectcell" forIndexPath:indexPath];
    
    NSDictionary* item = [_promotionArray objectAtIndex:indexPath.row];
    NSString *image = [item objectForKey:@"image"];
    
    if (![image isKindOfClass:[NSNull class]] && ![image isEqualToString:@""])
    {
        if ([JUntil imageExisted:image])
        {
            [cell setPromotionImage:[JUntil pathOfFile:image]];
        }
        else
        {
            image = [image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSString *fileURL = [[IP_SEVER stringByAppendingPathComponent:@"images"] stringByAppendingPathComponent:image];
            
            [JUntil downloadFileFromURL:fileURL completionHandler:^(NSURL * _Nonnull file) {
                NSLog(@"downloaded file %@",file);
                [cell setPromotionImage:[file path]];
            }];
        }
    }
    else{
        [cell setPromotionImage:nil];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectPromotionCode:)])
    {
        [_delegate didSelectPromotionCode:[_promotionArray objectAtIndex:indexPath.row]];
    }
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [collectionView frame].size;
    
    size.height -= 20;
    size.width = 230;
    
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

@end
