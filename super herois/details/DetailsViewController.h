//
//  DetailsViewController.h
//  super herois
//
//  Created by Paulo Sales on 31/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CharacterItem.h"
#import "HeaderViewTableViewCell.h"
#import "InfosCell.h"
#import "InfoExtraCell.h"
#import "DescCell.h"

@interface DetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(strong, nonatomic) CharacterItem *character;
@property(strong, nonatomic) NSMutableArray *data;

- (IBAction)back:(id)sender;
- (void)initViews;
- (void)parseData;
- (void)onBtnExpand:(id)sender;
- (void)addRows:(NSInteger)section;
- (void)removeRows:(NSInteger)section;

@end
