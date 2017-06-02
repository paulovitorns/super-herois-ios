//
//  ViewController.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BuscaViewController.h"
#import "DetailsViewController.h"
#import "Constants.h"
#import "HeroesService.h"
#import "SuperHeroCell.h"
#import "Characters.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(strong, retain) Characters *characters;
@property(strong, retain) NSMutableArray *data;
@property(strong, retain) NSMutableDictionary *paramsToBeEditable;
@property (assign, nonatomic) NSInteger selectedIndex;
@property(assign, nonatomic) int countPages;
@property(assign, nonatomic) int page;
@property(assign, nonatomic) int pageSize;
@property(assign, nonatomic) BOOL hasMorePages;
@property(assign, nonatomic) BOOL hasConn;
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain) UIView *uivw_loading;
@property (weak, nonatomic) IBOutlet UIView *uiview_empty_state;
@property (weak, nonatomic) IBOutlet UIImageView *uiimg_icon_empty;
@property (weak, nonatomic) IBOutlet UILabel *uilbl_empty_desc;
@property (weak, nonatomic) IBOutlet UIButton *uibtn_search;
@property (weak, nonatomic) IBOutlet UIButton *uibtn_try_again;

-(void)hasConnection;
-(NSString*)getTimeMillis;
-(void)initParams;
-(void)prepareParams:(NSNotification*)notification;
-(void)loadMoreItens;
-(void)showSpinner;
-(void)removeSpinner;
-(void)requestData:(NSDictionary*)params;
-(void)registerListeners;
-(void)removeListeners;
-(void)responseData:(NSNotification*)notification;
-(void)response_NOK:(NSNotification*)notification;
-(void)showEmptyState;
-(void)showErrorConnection;
- (IBAction)navigateToSearch:(id)sender;
- (IBAction)onTryAgain:(id)sender;

@end


