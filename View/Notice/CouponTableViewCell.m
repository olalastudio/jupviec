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
    
    NSString *image = [_couponInfo objectForKey:@"image"];
    
    if (![image isKindOfClass:[NSNull class]] && ![image isEqualToString:@""])
    {
        if ([JUntil imageExisted:image])
        {
            [_imageView setImage:[UIImage imageWithContentsOfFile:[JUntil pathOfFile:image]]];
        }
        else
        {
            image = [image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSString *fileURL = [[IP_SEVER stringByAppendingPathComponent:@"images"] stringByAppendingPathComponent:image];
            
            [JUntil downloadFileFromURL:fileURL completionHandler:^(NSURL * _Nonnull file) {
                NSLog(@"downloaded file %@",file);
                [self.imageView setImage:[UIImage imageWithContentsOfFile:[file path]]];
            }];
        }
    }
    else{
        [_imageView setImage:[UIImage imageNamed:@"makhuyenmai.png"]];
    }
    
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
