//
//  ToolFunctions.m
//  DemoNganLuong
//
//  Created by Hung Le Dinh on 6/22/16.
//  Copyright © 2016 Hung Le Dinh. All rights reserved.
//

#import "ToolFunctions.h"

@implementation ToolFunctions

+(ToolFunctions*)shareToolFunction
{
    static ToolFunctions *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ToolFunctions alloc] init];
    });
    return _sharedInstance;
}

-(BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validateNumber:(NSString *)phone
{
    NSString *phoneRegex = @"[0-9]{10,13}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}
- (NSString*)parserError:(int)errorRespon{
    switch (errorRespon) {
        case 1:
            return @"Lỗi không xác định";
            break;
        case 2:
            return @"merchant_id không tồn tại";
            break;
        case 4:
            return @"checksum không đúng";
            break;
        case 5:
            return @"Không ghi nhận được đơn hàng trên cổng thanh toán";
            break;
        case 6:
            return @"token_code không tồn tại hoặc không hợp lệ";
            break;
        case 7:
            return @"Đơn hàng chưa được thanh toán";
            break;
        case 9:
            return @"receiver_email không tồn tại";
            break;
        case 11:
            return @"receiver_email đang bị khóa hoặc phong tỏa không thể giao dịch";
            break;
        case 20:
            return @"function không đúng";
            break;
        case 21:
            return @"version không đúng hoặc không tồn tại";
            break;
        case 22:
            return @"Thiếu tham số đầu vào";
            break;
        case 23:
            return @"order_code mã đơn hàng không hợp lệ";
            break;
        case 24:
            return @"total_amount không hợp lệ";
            break;
        case 25:
            return @"currency không hợp lệ";
            break;
        case 26:
            return @"language không hợp lệ";
            break;
        case 27:
            return @"return_url không hợp lệ";
            break;
        case 28:
            return @"cancel_url không hợp lệ";
            break;
        case 29:
            return @"notify_url không hợp lệ";
            break;
        case 30:
            return @"buyer_fullname không hợp lệ";
            break;
        case 31:
            return @"buyer_email không hợp lệ";
            break;
        case 32:
            return @"buyer_mobile không hợp lệ";
            break;
        case 33:
            return @"buyer_address không hợp lệ";
            break;
        default:
            return @"Không tồn tại response code";
            break;
    }
}
@end
