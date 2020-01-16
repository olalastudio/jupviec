//
//  LoadingViewController.m
//  JupViec
//
//  Created by KienVu on 1/16/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:85.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:0.38]];
}

-(void)show:(UIViewController*)sender
{
    [self performSelectorOnMainThread:@selector(startAnimation) withObject:nil waitUntilDone:NO];
    
    [sender setModalPresentationStyle:UIModalPresentationCurrentContext];
    [sender presentViewController:self animated:NO completion:nil];
}

-(void)dismiss
{
    [self performSelectorOnMainThread:@selector(stopAnimation) withObject:nil waitUntilDone:NO];
}

-(void)startAnimation
{
    [_loadingIndicator startAnimating];
}

-(void)stopAnimation
{
    [_loadingIndicator stopAnimating];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
