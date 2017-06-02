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

+ (NSString *)generateHashKey:(NSString*)time{
    NSString *hasKey = [time stringByAppendingFormat:@"%@%@", @"f397d02d1f002af3626143143af1916b329a5abf", @"656ace3b6053ed496242e3d3f7dca830"];
    
    return [HeroesService md5HexDigest:hasKey];
}

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
    
    __block NSMutableDictionary *resposta;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:urlBase];
    
    [manager GET:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        NSLog(@"Success: %@", json);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:func object:nil userInfo:json];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",errResponse);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AFCharactersResponseNOK object:nil];
    }];
    
}

+ (NSString *) formatDateString:(NSString*)dateString andSeparator:(NSString*)separator {
    
    NSString *dia;
    NSString *mes;
    NSString *ano;
    NSString *dateFormatted;
    
    dia = [dateString substringWithRange:NSMakeRange(8,2)];
    mes = [dateString substringWithRange:NSMakeRange(5,2)];
    ano = [dateString substringWithRange:NSMakeRange(0,4)];
    dateFormatted = [NSString stringWithFormat:@"%@%@%@%@%@",dia,separator,mes,separator,ano];
    
    return  dateFormatted;
}

@end
