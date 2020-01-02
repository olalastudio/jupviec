//
//  JButton.m
//  JupViec
//
//  Created by KienVu on 1/2/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "JButton.h"
#import "CommonDefines.h"

@implementation JButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 8;
    self.backgroundColor = UIColorFromRGB(0xFF8957);
}
@end
