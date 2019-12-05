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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_clPromotionCode registerNib:[UINib nibWithNibName:@"HomePromotionCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"idhomepromotioncollectcell"];
    
    [_clPromotionCode setDelegate:self];
    [_clPromotionCode setDataSource:self];
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

-(TASK_TYPE)taskType
{
    return _taskType;
}
-(SESSION_TYPE)sessionType
{
    return _sessionType;
}

#pragma mark UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HomePromotionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"idhomepromotioncollectcell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did click Home promotion cell at index %@", indexPath);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Will display home promotion cell at index %@",indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did display home promotion cell at index %@",indexPath);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [collectionView frame].size;
    
    size.height -= 20;
    size.width -= 80;
    
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
