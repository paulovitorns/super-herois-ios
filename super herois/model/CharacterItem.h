//
//  CharacterItem.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterItem : NSObject

@property(assign, nonatomic) int id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSDate *modified;
@property(strong, nonatomic) NSDictionary *thumbnail;
@property(strong, nonatomic) NSString *resourceURI;
@property(strong, nonatomic) NSDictionary *comics;
@property(strong, nonatomic) NSDictionary *series;
@property(strong, nonatomic) NSDictionary *stories;
@property(strong, nonatomic) NSDictionary *events;
@property(strong, nonatomic) NSArray *urls;

@end
