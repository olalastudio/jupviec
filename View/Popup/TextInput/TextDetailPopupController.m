//
//  TextDetailPopupController.m
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "TextDetailPopupController.h"
#import "PopupView.h"

@interface TextDetailPopupController ()
{
    NSInteger keyboardheight;
}

@end

@implementation TextDetailPopupController
@synthesize delegate = _delegate;
@synthesize index = _index;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_txtTitle setText:@"Số nhà,căn hộ"];
    [_txtContent setText:_strContent];
    [_txtCurrentLocation setText:_strCurrentLocation];
    
    [_txtTitle setFont:[UIFont fontWithName:@"Roboto" size:14]];
    [_txtContent setFont:[UIFont fontWithName:@"Roboto" size:14]];
    [_txtCurrentLocation setFont:[UIFont fontWithName:@"Roboto" size:14]];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:85.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:0.38]];
    
    self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    
    [self registerFromKeyboardNotification];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
           self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            } completion:^(BOOL finished) {
                self.popupView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [self unregisterFromKeyboardNotification];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setOrderAttribute:(ORDER_ATTRIBUTE)type
{
    _orderAttribute = type;
}

-(ORDER_ATTRIBUTE)orderAttribute
{
    return _orderAttribute;
}

-(void)setIndexPath:(NSIndexPath*)index
{
    _index = index;
}

-(NSIndexPath*)index
{
    return _index;
}

-(void)setPopupContent:(NSString *)str
{
    _strContent = str;
}

-(void)setPopupCurrentLocation:(NSString *)str
{
    _strCurrentLocation = str;
}

- (IBAction)didPressClosePopupButtom:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didPressConfirmButtom:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didPressConfirmDetailPopup:index:withReturnValue:)])
        {
            [self.delegate didPressConfirmDetailPopup:self.orderAttribute index:self.index withReturnValue:[self.txtContent text]];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)registerFromKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)unregisterFromKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification*)notification
{
    NSDictionary *userinfo = [notification userInfo];
    NSValue *keyboardbeginrect = [userinfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *keyboardendrect = [userinfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect beginrect = [keyboardbeginrect CGRectValue];
    CGRect endrect = [keyboardendrect CGRectValue];
 
    keyboardheight = beginrect.origin.y - endrect.origin.y;
    
    if (keyboardheight > self.popupView.frame.origin.y)
    {
        _verticalConstraint.constant = self.popupView.frame.origin.y - keyboardheight;
    }
    
    [self.view layoutIfNeeded];
}

-(void)keyboardDidHide:(NSNotification*)notification
{
    NSDictionary *userinfo = [notification userInfo];
    NSValue *keyboardbeginrect = [userinfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *keyboardendrect = [userinfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect beginrect = [keyboardbeginrect CGRectValue];
    CGRect endrect = [keyboardendrect CGRectValue];
    
    keyboardheight = endrect.origin.y - beginrect.origin.y;
    
    _verticalConstraint.constant = 0;
    
    [self.view layoutIfNeeded];
}
@end
