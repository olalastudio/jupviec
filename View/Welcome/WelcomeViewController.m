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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (_index) {
        case 0:
            [_txtWelcome setText:[NSString stringWithFormat:@"Vì cuộc sống tốt đẹp hơn"]];
            break;
        case 1:
            [_txtWelcome setText:[NSString stringWithFormat:@"Tìm dịch vụ giúp việc \ncực nhanh chỉ với 3 thao tác"]];
            break;
        case 2:
            [_txtWelcome setText:[NSString stringWithFormat:@"Không ngừng cải tiến nâng cao chất lượng dịch vụ"]];
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
@end
