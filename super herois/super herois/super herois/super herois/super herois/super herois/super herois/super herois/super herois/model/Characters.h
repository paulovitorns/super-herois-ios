//
//  Characters.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeroesService.h"
#import "CharactersData.h"

@interface Characters : NSObject

@property(assign, nonatomic) int code;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *copyright;
@property(strong, nonatomic) NSString *attributionText;
@property(strong, nonatomic) NSString *attributionHTML;
@property(strong, nonatomic) NSString *etag;
@property(strong, nonatomic) CharactersData *charactersData;

-(void)parseResult:(NSDictionary*)dict;

@end
