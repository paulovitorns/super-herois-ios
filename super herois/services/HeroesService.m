//
//  HeroesService.m
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import "HeroesService.h"

@interface HeroesService() <NSURLSessionDelegate>

@end

@implementation HeroesService

+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(void)getData:(NSString *)urlBase withFunc:(NSString *)func andWithParams:(NSDictionary *)params {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:urlBase];
    
    [manager GET:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSLog(@"Success: %@", json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
}

@end
