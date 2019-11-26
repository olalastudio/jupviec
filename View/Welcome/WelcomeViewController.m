//
//  WelcomeViewController.m
//  JupViec
//
//  Created by KienVu on 11/25/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_btStart setHidden:YES];
    [_btskip setHidden:NO];
    [_txtWelcome setHidden:NO];
    
    [_txtWelcome setText:[NSString stringWithFormat:@"Welcome view %ld",(long)_index]];
    
    switch (_index) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            [_btStart setHidden:NO];
            [_btskip setHidden:YES];
            break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didPressSkipButton:(id)sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(getStart)]) {
        [_delegate getStart];
    }
}

- (IBAction)didPressStartButton:(id)sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(getStart)]) {
        [_delegate getStart];
    }
}
@end
