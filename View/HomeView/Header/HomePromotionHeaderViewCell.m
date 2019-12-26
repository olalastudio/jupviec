//
//  HomePromotionHeaderViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomePromotionHeaderViewCell.h"

@implementation HomePromotionHeaderViewCell
@synthesize delegate = _delegate;

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
