//
//  RateViewController.m
//  JupViec
//
//  Created by KienVu on 12/19/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "RateViewController.h"
#import "APIRequest.h"
#import "CommonDefines.h"

@interface RateViewController ()
{
    NSInteger   score;
}

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Đánh giá dịch vụ"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateViewContent];
}

-(void)setUserToken:(NSString*)token
{
    _token = token;
}

-(void)setIDService:(NSString*)idservice
{
    _idservice = idservice;
}

-(void)setServiceInfo:(NSDictionary *)serviceInfo
{
    _serviceInfo = serviceInfo;
}

-(void)updateViewContent
{
    NSNumber *ratescore = [_serviceInfo objectForKey:ID_RATE_SCORE];
    NSString *comment = [_serviceInfo objectForKey:ID_FEEDBACK];
    
    if (ratescore > 0) {
        [_btRate setHidden:YES];
        [_txtComment setText:comment];
        
        [self showRateStar:[ratescore integerValue]];
    }
    else{
        [_btRate setHidden:NO];
        
        [self showRateStar:5];
    }
}

-(void)showRateStar:(NSInteger)score
{
    switch (score) {
        case 1:
            [self didPressStar1:_star1];
            break;
        case 2:
            [self didPressStar2:_star2];
            break;
        case 3:
            [self didPressStar3:_star3];
            break;
        case 4:
            [self didPressStar4:_star4];
            break;
        case 5:
            [self didPressStar5:_star5];
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

-(void)unStarAll
{
    [_star1 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star2 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star3 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star4 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star5 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
}

-(void)starAll
{
    [_star1 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star2 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star3 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star4 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star5 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
}

- (IBAction)didPressStar1:(id)sender
{
    [_star1 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star2 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star3 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star4 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star5 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    
    score = 1;
}

- (IBAction)didPressStar2:(id)sender {
    [_star1 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star2 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star3 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star4 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star5 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    
    score = 2;
}

- (IBAction)didPressStar3:(id)sender {
    [_star1 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star2 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star3 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star4 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    [_star5 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    
    score = 3;
}

- (IBAction)didPressStar4:(id)sender {
    [_star1 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star2 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star3 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star4 setImage:[UIImage imageNamed:@"starfill.png"] forState:UIControlStateNormal];
    [_star5 setImage:[UIImage imageNamed:@"star-1.png"] forState:UIControlStateNormal];
    
    score = 4;
}

- (IBAction)didPressStar5:(id)sender {
    [self starAll];
    
    score = 5;
}

- (IBAction)didPressRateButton:(id)sender
{
    APIRequest *apirequest = [[APIRequest alloc] init];
    
    NSString *content = [_txtComment text];
    NSDictionary *rateInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:score], @"rate_score", content, @"content", nil];
    
    [apirequest requestAPIRateService:_token idService:_idservice rateServiceInfo:rateInfo completionHandler:^(NSDictionary * _Nullable resultDict, NSError * _Nonnull error) {
        
        if (error.code == 200) {
            NSLog(@"rate service successful %@",resultDict);
        }
        else{
            NSLog(@"rate service error %@",error);
        }
    }];
}
@end
