//
//  TextDetailPopupView.m
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
}
@end
