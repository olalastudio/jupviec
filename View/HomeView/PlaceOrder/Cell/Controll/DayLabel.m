//
//  DayLabel.m
//  JupViec
//
//  Created by KienVu on 12/12/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DayLabel.h"

@implementation DayLabel
@synthesize delegate = _delegate;
@synthesize selected = _selected;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //code here
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _selected = NO;
    _dayInWeek = DAY_NONE;
    
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
}

-(BOOL)selected
{
    return _selected;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_selected) {
        _selected = NO;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    else{
        _selected = YES;
        [self setBackgroundColor:[UIColor orangeColor]];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectDayLabel:)]) {
        [_delegate didSelectDayLabel:_dayInWeek];
    }
    
    [self setNeedsDisplay];
}
@end
