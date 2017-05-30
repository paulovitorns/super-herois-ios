//
//  ViewController.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroesService.h"
#import "SuperHeroCell.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) responseData:(NSNotification*)notification;
-(void) response_NOK:(NSNotification*)notification;
@end

