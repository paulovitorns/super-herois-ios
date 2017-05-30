//
//  HeroesService.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"

@interface HeroesService : NSObject{
    
}
+ (NSString*)md5HexDigest:(NSString*)input;
+(void)getData:(NSString *)urlBase withFunc:(NSString *)func andWithParams:(NSDictionary *)params;
@end
