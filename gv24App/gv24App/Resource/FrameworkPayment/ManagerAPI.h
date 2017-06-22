//
//  ManagerAPI.h
//  DemoNganLuong
//
//  Created by Hung Le Dinh on 6/22/16.
//  Copyright © 2016 Hung Le Dinh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerAPI : NSObject

//+(ManagerAPI *)shareManager;

typedef void (^ResponseBlock)(NSDictionary * resultDict);
typedef void (^ErrorBlock)(NSError * error);

+(void)postDataFromServer:(NSString *)address
                  andInfo:(NSDictionary *)dictInfo
        completionHandler:(ResponseBlock)completionBlock
             errorHandler:(ErrorBlock)errorBlock;

@end
