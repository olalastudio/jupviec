//
//  CouponTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "CouponTableViewCell.h"
#import "CommonDefines.h"
#import "JUntil.h"

@implementation CouponTableViewCell
@synthesize imageView = _imageView;

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // shadow
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = true;
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIColorFromRGB(0xF0F0F0).CGColor;
    
    [_titleLB setTextColor:UIColorFromRGB(0xFF7E46)];
    [_dateLB setTextColor:UIColorFromRGB(0xACB3BF)];
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.y += 12;
    frame.size.height -= 2*12;
    
    [super setFrame:frame];
}

-(NSDictionary*)notifyCoupon
{
    return _couponInfo;
}

- (void)setNotifyCoupon:(NSDictionary *)notifyInfo
{
    _couponInfo = notifyInfo;
    [_titleLB setText:[_couponInfo objectForKey:@"content"]];
    [_dateLB setText:[_couponInfo objectForKey:@"updated_at"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![[[self notifyCoupon] objectForKey:@"image"] isKindOfClass:[NSNull class]])
        {
            NSString* urlStr = [[IP_SEVER stringByAppendingPathComponent:@"images"]stringByAppendingPathComponent:[self->_couponInfo objectForKey:@"image"]];
            NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://112.78.4.173/images/5e15b6832256d83a391b1bd1-5e132985e5dc10455476d9cf-Screenshot%20from%202019-09-03%2004-42-39.png"]];
            self.imageData = imageData;
            UIImage *img = [UIImage imageWithData:imageData];
            [self.imageView setImage:img];
        }
        else
        {
            
        }
    });
    
    [self reloadContentView];
}

-(void)reloadContentView
{
    NSString *title = [_couponInfo objectForKey:@"title"];
    NSString *strdate = [_couponInfo objectForKey:@"expired_date"];
    
    [_titleLB setText:title];
    
    NSDate *date = [JUntil dateFromString:strdate];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE, dd/MM/yyyy"];
    [format setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
    
    [_dateLB setText:[format stringFromDate:date]];
}

@end
