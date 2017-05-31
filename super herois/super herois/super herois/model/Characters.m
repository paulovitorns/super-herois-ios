//
//  Characters.m
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import "Characters.h"

@implementation Characters

-(void)parseResult:(NSDictionary *)dict{
    
    self.code = [dict[@"code"] intValue];
    self.status = dict[@"status"];
    self.copyright = dict[@"copyright"];
    self.attributionText = dict[@"attributionText"];
    self.attributionHTML = dict[@"attributionHTML"];
    self.etag = dict[@"etag"];
    
    if([dict[@"data"] isKindOfClass:[NSDictionary class]]){
        self.charactersData = [CharactersData new];
        self.charactersData.offset = [dict[@"data"][@"offset"] intValue];
        self.charactersData.limit = [dict[@"data"][@"limit"] intValue];
        self.charactersData.total = [dict[@"data"][@"total"] intValue];
        self.charactersData.count = [dict[@"data"][@"count"] intValue];
        
        if(self.charactersData.count > 0){
            
            self.charactersData.results = [[NSMutableArray alloc] init];
            
            for(NSDictionary *dictItem in dict[@"data"][@"results"]){
                
                CharacterItem *item = [CharacterItem new];
                item.idItem = [dictItem[@"id"] intValue];
                item.name = dictItem[@"name"];
                item.desc = dictItem[@"description"];
                
                NSString *date = [NSString stringWithFormat:@"%@", [HeroesService formatDateString:dictItem[@"modified"] andSeparator:@"/"], nil];
                
                item.modified = date;
                item.thumbnail = [[NSDictionary alloc] initWithDictionary:dictItem[@"thumbnail"]];
                item.resourceURI = dictItem[@"resourceURI"];
                item.comics = [[NSDictionary alloc] initWithDictionary:dictItem[@"comics"]];
                item.series = [[NSDictionary alloc] initWithDictionary:dictItem[@"series"]];
                item.stories = [[NSDictionary alloc] initWithDictionary:dictItem[@"stories"]];
                item.events = [[NSDictionary alloc] initWithDictionary:dictItem[@"events"]];
                item.urls = [[NSArray alloc] initWithArray:dictItem[@"urls"]];
                
                [self.charactersData.results addObject:item];
                
            }
            
        }
        
    }
    
}

@end
