//
//  ExtendServicePopupController.h
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JButton;
@class PopupView;

NS_ASSUME_NONNULL_BEGIN

@interface ExtendServicePopupController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray     *_totalservice;
    NSMutableArray     *_selectedservice;
}

@property (weak, nonatomic) IBOutlet JButton *btConfirm;
@property (weak, nonatomic) IBOutlet PopupView *popupView;
@property (weak, nonatomic) IBOutlet UITableView *tbExtendService;

- (IBAction)didClickConfirmButton:(id)sender;

-(void)setTotalService:(NSArray*)totalservice;
-(void)setSelectedService:(NSArray*)selectedservice;

@end

NS_ASSUME_NONNULL_END
