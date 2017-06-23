//
//  ManagerAPI.m
//  DemoNganLuong
//
//  Created by Hung Le Dinh on 6/22/16.
//  Copyright © 2016 Hung Le Dinh. All rights reserved.
//

#import "ManagerAPI.h"
#import "AFHTTPRequestOperationManager.h"

#define TIME_OUT 30

@implementation ManagerAPI

+(void)postDataFromServer:(NSString *)address andInfo:(NSDictionary *)dictInfo completionHandler:(ResponseBlock)completionBlock errorHandler:(ErrorBlock)errorBlock
{
    
    NSString * url = [NSString stringWithFormat:@"%@", address];
    NSString *encodedURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"POST == %@",encodedURL);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:TIME_OUT];
    
    [manager POST:encodedURL parameters:dictInfo
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:kNilOptions
                                                           error:&error];
    completionBlock(json);
} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    errorBlock(error);
}];
}

@end
