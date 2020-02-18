//
//  HomePromotionHeaderViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomePromotionHeaderViewCell.h"
#import "CommonDefines.h"

@implementation HomePromotionHeaderViewCell
@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [_txtPromotion setTextColor:UIColorFromRGB(0xE4672D)];
    [_btViewMore setTitleColor:UIColorFromRGB(0x5C5C5C) forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)didPressViewMoreButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickViewMorePromotion)])
    {
        [_delegate didClickViewMorePromotion];
    }
}
@end
