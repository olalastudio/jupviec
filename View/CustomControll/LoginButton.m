//
//  LoginButton.m
//  testimageview
//
//  Created by Olala on 12/30/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "LoginButton.h"

@implementation LoginButton

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
    
    _loginstatus = STATUS_NONE;
    
}

-(void)setLoginStatus:(LOGINSTATUS)status
{
    _loginstatus = status;
    
    if (status == STATUS_LOGEDIN)
    {
        [self setImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];

        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
        self.imageView.layer.borderColor = [UIColor blueColor].CGColor;
        self.imageView.layer.borderWidth = 2.0;
        self.imageView.clipsToBounds = YES;
        
        CGRect rect = self.frame;
        rect.size.height = 50;
        rect.size.width = 50;
        
        [self setFrame:rect];
    }
    else
    {
        [self setImage:nil forState:UIControlStateNormal];
        [self setTitle:@"Đăng Nhập" forState:UIControlStateNormal];
        [self setTintColor:[UIColor blackColor]];
        [self sizeToFit];
    }
}

-(LOGINSTATUS)loginStatus
{
    return _loginstatus;
}
@end
