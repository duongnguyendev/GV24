//
//  ToolFunctions.h
//  DemoNganLuong
//
//  Created by Hung Le Dinh on 6/22/16.
//  Copyright © 2016 Hung Le Dinh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolFunctions : NSObject
+(ToolFunctions*)shareToolFunction;
- (BOOL)validateEmail:(NSString *)email;
- (BOOL)validateNumber:(NSString *)phone;
- (NSString*)parserError:(int)errorRespon;
@end
