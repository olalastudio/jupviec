//
//  HomePromotionCollectionViewCell.h
//  JupViec
//
//  Created by KienVu on 12/4/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePromotionCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgPromotion;

-(void)setPromotionImage:(NSString*)imagefile;

@end

NS_ASSUME_NONNULL_END
