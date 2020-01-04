//
//  PlaceOrderCommonTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "PlaceOrderCommonTableViewCell.h"
#import "JTextView.h"
#import "Order.h"

@implementation PlaceOrderCommonTableViewCell
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_txtContent setDelegate:self];
    [_txtContent setScrollEnabled:NO];
    [_txtContent setShowsHorizontalScrollIndicator:NO];
    [_txtContent setShowsVerticalScrollIndicator:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute
{
    _ordeAttribute = attribute;
}

-(ORDER_ATTRIBUTE)orderAttribute
{
    return _ordeAttribute;
}

-(void)setOrder:(Order *)order
{
    _order = order;
    
    [self reloadViewContent];
}

-(void)setServiceInfo:(NSDictionary *)serviceInfo
{
    _serviceInfo = serviceInfo;
}

-(NSDictionary*)serviceInfo
{
    return _serviceInfo;
}

-(void)reloadViewContent
{
    switch (_ordeAttribute) {
        case ATTRIBUTE_DIADIEM:
        {
            [_txtTitle setText:@"Địa điểm làm việc"];
            
            if ([[_order workAddress] isEqualToString:@""]) {
                [_txtContent setText:@"Vị trí của bạn"];
            }
            else{
                [_txtContent setText:[_order workAddress]];
            }
        }
            break;
        case ATTRIBUTE_SONHACANHO:
        {
            [_txtTitle setText:@"Số nhà,căn hộ"];
            
            if ([[_order homeNumber] isEqualToString:@""]) {
                [_txtContent setText:@"Số nhà,căn hộ"];
            }
            else{
                [_txtContent setText:[_order homeNumber]];
            }
        }
            break;
        case ATTRIBUTE_NGAYLAMVIEC:
        {
            [_txtTitle setText:@"Ngày làm việc"];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"EEEE, dd/MM/yyyy"];
            [format setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
            
            [_txtContent setText:[format stringFromDate:[_order workDate]]];
        }
            break;
        case ATTRIBUTE_NGAYLAMTRONGTUAN:
            [_txtTitle setText:@"Làm các ngày trong tuần"];
            [_txtContent setText:@"T2, T4, T7"];
            break;
        case ATTRIBUTE_NGAYKHAOSAT:
        {
            [_txtTitle setText:@"Ngày khảo sát"];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"EEEE, dd/MM/yyyy"];
            [format setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
            
            [_txtContent setText:[format stringFromDate:[_order dayOfExamine]]];
        }
            break;
        case ATTRIBUTE_GIOKHAOSAT:
        {
            [_txtTitle setText:@"Giờ khảo sát mong muốn"];
            
            [_txtContent setText:@"Sáng 09:00 - 11:00"];
        }
            break;
        case ATTRIBUTE_GIOLAMVIEC:
            [_txtTitle setText:@"Thời gian làm việc"];
            [_txtContent setText:@"Ca sáng, 08:00 - 10:00"];
            break;
        case ATTRIBUTE_DICHVUKEMTHEO:
        {
            [_txtTitle setText:@"Dịch vụ kèm theo"];
            [_txtContent setText:@"None"];
            
            if ([[_order extraOption] count] > 0) {
                NSDictionary *option = [[_order extraOption] objectAtIndex:0];
                [_txtContent setText:[option objectForKey:@"name"]];
            }
        }
            break;
        case ATTRIBUTE_HINHTHUCTHANHTOAN:
        {
            [_txtTitle setText:@"Hình thức thanh toán"];
            [_txtContent setText:@"Tiền mặt/Chuyển khoản"];
            
            if ([[_order paymentMethod] count] > 0) {
                [_txtContent setText:[[_order paymentMethod] objectForKey:@"name"]];
            }
        }
            break;
        case ATTRIBUTE_BANGGIADICHVU:
            [_txtTitle setText:@"Bảng giá dịch vụ"];
            [_txtContent setText:@"- Giặt ghế sofa : 100K"];
            break;
        case ATTRIBUTE_GHICHU:
            [_txtTitle setText:@"Ghi chú"];
            [_txtContent setText:@"- ghi chú"];
            break;
        default:
            break;
    }
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _indexPath = index;
}

-(NSIndexPath*)indexPath
{
    return _indexPath;
}
#pragma mark - UITextFieldDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (_ordeAttribute == ATTRIBUTE_GHICHU) {
        return YES;
    }
    else if (_ordeAttribute == ATTRIBUTE_HINHTHUCTHANHTOAN)
    {
        NSArray *paymentMethods = [_serviceInfo objectForKey:@"payment_method"];
        NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSDictionary* item in paymentMethods) {
            [names addObject:[item objectForKey:@"name"]];
        }
        
        [self showPopOverFromSender:textView selectionArray:names];
        return NO;
    }
    else if (_ordeAttribute == ATTRIBUTE_DICHVUKEMTHEO)
    {
        NSArray *paymentMethods = [_serviceInfo objectForKey:@"service_extend"];
        NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSDictionary* item in paymentMethods) {
            [names addObject:[item objectForKey:@"name"]];
        }
        
        [self showPopOverFromSender:textView selectionArray:names];
        return NO;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didPressCellAtIndexPath:attributeType:)]) {
        [_delegate didPressCellAtIndexPath:_indexPath attributeType:_ordeAttribute];
    }
    
    return NO;
}

#pragma mark - PopOverMenu
-(void)showPopOverFromSender:(id)sender selectionArray:(NSArray*)list
{
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuWidth = _txtContent.frame.size.width;
    configuration.backgroundColor = [UIColor whiteColor];
    configuration.textColor = [UIColor blackColor];
    configuration.borderColor = [UIColor grayColor];
    
    [FTPopOverMenu showForSender:sender withMenuArray:list imageArray:nil configuration:configuration doneBlock:^(NSInteger selectedIndex)
    {
        //show
        if ([self orderAttribute] == ATTRIBUTE_HINHTHUCTHANHTOAN)
        {
            NSArray *paymentMethods = [[self serviceInfo] objectForKey:@"payment_method"];
            NSDictionary *code = [paymentMethods objectAtIndex:selectedIndex];
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectPaymentMethod:index:)])
            {
                [self.delegate didSelectPaymentMethod:code index:[self indexPath]];
            }
        }
        else if ([self orderAttribute] == ATTRIBUTE_DICHVUKEMTHEO)
        {
            NSArray *paymentMethods = [[self serviceInfo] objectForKey:@"service_extend"];
            NSDictionary *code = [paymentMethods objectAtIndex:selectedIndex];
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectExtentService:index:)])
            {
                [self.delegate didSelectExtentService:code index:[self indexPath]];
            }
        }
    } dismissBlock:^{
       //dismis
    }];
}
@end
