//
//  TextDetailPopupController.h
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

@protocol TextDetailPopupDelegate <NSObject>

-(void)didPressConfirmDetailPopup:(ORDER_ATTRIBUTE)sender index:(NSIndexPath*_Nonnull)index withReturnValue:(NSString*_Nullable)str;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TextDetailPopupController : UIViewController
{
    ORDER_ATTRIBUTE     _orderAttribute;
    NSIndexPath         *_index;
    NSString            *_strContent;
    NSString            *_strCurrentLocation;
}

@property id<TextDetailPopupDelegate>       delegate;
@property ORDER_ATTRIBUTE                   orderAttribute;
@property (nonatomic) NSIndexPath           *index;

@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtContent;
@property (weak, nonatomic) IBOutlet UILabel *txtCurrentLocation;

- (IBAction)didPressClosePopupButtom:(id)sender;
- (IBAction)didPressConfirmButtom:(id)sender;

-(void)setOrderAttribute:(ORDER_ATTRIBUTE)type;
-(void)setPopupContent:(NSString*)str;
-(void)setPopupCurrentLocation:(NSString*)str;

@end

NS_ASSUME_NONNULL_END
