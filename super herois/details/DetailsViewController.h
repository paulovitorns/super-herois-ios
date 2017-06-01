//
//  DetailsViewController.h
//  super herois
//
//  Created by Paulo Sales on 31/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterItem.h"

@interface DetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(strong, nonatomic) CharacterItem *character;

- (IBAction)back:(id)sender;
- (void)initViews;
@end
