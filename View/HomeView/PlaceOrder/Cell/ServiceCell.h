//
//  ServiceCell.h
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TYPE_POPUP,
    TYPE_ORDER,
} ServiceCellType;

@interface ServiceCell : UITableViewCell
{
    ServiceCellType     _type;
}

@property (weak, nonatomic) IBOutlet UILabel *txtServiceName;
@property (weak, nonatomic) IBOutlet UIButton *btDelete;

- (IBAction)didClickDeleteServiceButton:(id)sender;

-(void)setServiceCellType:(ServiceCellType)type;
-(void)setTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
