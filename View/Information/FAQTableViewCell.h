//
//  FAQTableViewCell.h
//  JupViec
//
//  Created by Khanhlt on 1/15/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FAQTableViewCellDelegate <NSObject>

-(void)showFAQContentInfo:(NSIndexPath*)indexPath;

@end

@interface FAQTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *showContentBtn;
@property (strong, nonatomic) NSIndexPath* indexPath;
@property id<FAQTableViewCellDelegate> delegate;
@property (assign, nonatomic) BOOL isShowContent;

- (IBAction)didClickShowContentAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
