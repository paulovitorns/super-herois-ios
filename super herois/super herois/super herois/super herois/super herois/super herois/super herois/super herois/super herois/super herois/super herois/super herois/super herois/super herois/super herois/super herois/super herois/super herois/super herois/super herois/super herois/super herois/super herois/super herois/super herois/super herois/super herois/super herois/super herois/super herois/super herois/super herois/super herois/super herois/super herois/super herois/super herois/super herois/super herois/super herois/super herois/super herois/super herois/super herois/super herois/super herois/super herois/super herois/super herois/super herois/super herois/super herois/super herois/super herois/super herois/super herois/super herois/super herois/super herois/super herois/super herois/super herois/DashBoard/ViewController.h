//
//  ViewController.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Constants.h"
#import "HeroesService.h"
#import "SuperHeroCell.h"
#import "Characters.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(strong, retain) Characters *characters;
@property(strong, retain) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain) UIView *uivw_loading;

-(void) showSpinner;
-(void) removeSpinner;
-(void) requestData:(NSDictionary*)params;
-(void) registerListeners;
-(void) removeListeners;
-(void) responseData:(NSNotification*)notification;
-(void) response_NOK:(NSNotification*)notification;

@end

