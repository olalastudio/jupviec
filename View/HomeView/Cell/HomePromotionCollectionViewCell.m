//
//  HomePromotionCollectionViewCell.m
//  JupViec
//
//  Created by KienVu on 12/4/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomePromotionCollectionViewCell.h"

@implementation HomePromotionCollectionViewCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // shadow
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = true;
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0);
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.6;
    self.layer.masksToBounds = false;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor clearColor]];
}

-(void)setPromotionImage:(NSString*)imagefile
{
    if (imagefile){
        UIImage *image = [UIImage imageWithContentsOfFile:imagefile];
        [_imgPromotion setImage:image];
    }
    else{
        [_imgPromotion setImage:[UIImage imageNamed:@"makhuyenmai.png"]];
    }
}
@end
