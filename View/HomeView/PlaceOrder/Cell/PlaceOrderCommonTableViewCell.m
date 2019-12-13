//
//  PlaceOrderCommonTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "PlaceOrderCommonTableViewCell.h"
#import "Order.h"

@implementation PlaceOrderCommonTableViewCell
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_txtContent setDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute
{
    _ordeAttribute = attribute;
}

-(void)setOrder:(Order *)order
{
    _order = order;
    
    [self reloadViewContent];
}

-(void)reloadViewContent
{
    switch (_ordeAttribute) {
        case ATTRIBUTE_DIADIEM:
            [_imgIcon setImage:[UIImage imageNamed:@"placeholder-3"]];
            [_txtTitle setText:@"ĐỊA ĐIỂM LÀM VIỆC"];
            [_txtContent setText:[_order workAddress]];
            break;
        case ATTRIBUTE_SONHACANHO:
            [_imgIcon setImage:[UIImage imageNamed:@"home-1"]];
            [_txtTitle setText:@"SỐ NHÀ/CĂN HỘ"];
            [_txtContent setText:[_order homeNumber]];
            break;
        case ATTRIBUTE_NGAYLAMVIEC:
        {
            [_imgIcon setImage:[UIImage imageNamed:@"calendar"]];
            [_txtTitle setText:@"NGÀY LÀM VIỆC"];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"EEEE, dd/MM/yyyy"];
            [format setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
            
            [_txtContent setText:[format stringFromDate:[_order workDate]]];
        }
            break;
        case ATTRIBUTE_NGAYLAMTRONGTUAN:
            [_imgIcon setImage:[UIImage imageNamed:@"calendar"]];
            [_txtTitle setText:@"LÀM CÁC NGÀY TRONG TUẦN"];
            [_txtContent setText:@"T2, T4, T7"];
            break;
        case ATTRIBUTE_NGAYKHAOSAT:
            [_imgIcon setImage:[UIImage imageNamed:@"calendar"]];
            [_txtTitle setText:@"NGÀY KHẢO SÁT"];
            [_txtContent setText:@"Thứ 4 - 20/11/2019"];
            break;
        case ATTRIBUTE_GIOKHAOSAT:
            [_imgIcon setImage:[UIImage imageNamed:@"calendar"]];
            [_txtTitle setText:@"GIỜ KHẢO SÁT MONG MUỐN"];
            [_txtContent setText:@"Sáng 09:00 - 11:00"];
            break;
        case ATTRIBUTE_GIOLAMVIEC:
            [_imgIcon setImage:[UIImage imageNamed:@"clock-1"]];
            [_txtTitle setText:@"THỜI GIAN LÀM VIỆC"];
            [_txtContent setText:@"Ca sáng, 08:00 - 10:00"];
            break;
        case ATTRIBUTE_DICHVUKEMTHEO:
            [_imgIcon setImage:[UIImage imageNamed:@"add-3"]];
            [_txtTitle setText:@"DỊCH VỤ KÈM THEO"];
            [_txtContent setText:@"None"];
            break;
        case ATTRIBUTE_HINHTHUCTHANHTOAN:
            [_imgIcon setImage:[UIImage imageNamed:@"hold"]];
            [_txtTitle setText:@"HÌNH THỨC THANH TOÁN"];
            [_txtContent setText:@"Tiền Mặt/Chuyển Khoản"];
            break;
        case ATTRIBUTE_BANGGIADICHVU:
            [_imgIcon setImage:[UIImage imageNamed:@"hold"]];
            [_txtTitle setText:@"BẢNG GIÁ DỊCH VỤ"];
            [_txtContent setText:@"- Giặt ghế sofa : 100K"];
            break;
        case ATTRIBUTE_GHICHU:
            [_imgIcon setImage:[UIImage imageNamed:@"note"]];
            [_txtTitle setText:@"GHI CHÚ"];
            [_txtContent setText:@"- Rửa bát, lau kĩ mặt bếp"];
            break;
        default:
            break;
    }
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _indexPath = index;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (_ordeAttribute == ATTRIBUTE_GHICHU) {
        return YES;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didPressCellAtIndexPath:attributeType:)]) {
        [_delegate didPressCellAtIndexPath:_indexPath attributeType:_ordeAttribute];
    }
    
    return NO;
}
@end
