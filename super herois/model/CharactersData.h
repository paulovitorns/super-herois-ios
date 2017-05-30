//
//  CharactersData.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharactersData : NSObject

@property(assign, nonatomic) int offset;
@property(assign, nonatomic) int limit;
@property(assign, nonatomic) int total;
@property(assign, nonatomic) int count;
@property(strong, nonatomic) NSArray *results;

@end
