//
//  DayLabel.m
//  JupViec
//
//  Created by KienVu on 12/12/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DayLabel.h"
#import "CommonDefines.h"

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
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:0.51].CGColor;
    self.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:0.21];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
}

-(BOOL)isSelected
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
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:0.21];
    }
    else{
        _selected = YES;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor *selectedcolor = UIColorFromRGB(0xFF7E46);
        self.backgroundColor = selectedcolor;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectDayLabel:)]) {
        [_delegate didSelectDayLabel:_dayInWeek];
    }
    
    [self setNeedsDisplay];
}

-(void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    NSLog(@"");
}
@end
