//
//  LoadingViewController.h
//  JupViec
//
//  Created by KienVu on 1/16/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

-(void)show:(UIViewController*)sender;
-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
