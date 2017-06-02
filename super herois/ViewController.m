//
//  ViewController.m
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#define CELL_REUSE @"heroesCell"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.characters = [Characters new];
    self.data = [[NSMutableArray alloc] init];
    [self requestData:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000000000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000000000001f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SuperHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSE];
    
    CharacterItem *item = [self.data objectAtIndex:indexPath.row];
    
    cell.uilbl_hero_name.text = item.name;
    cell.uilbl_hero_short_desc.text = item.desc;
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@.%@", item.thumbnail[@"path"], item.thumbnail[@"extension"], nil];
    
    [cell.uiimg_hero_image sd_setImageWithURL:[NSURL URLWithString:imgUrl]
                             placeholderImage:[UIImage imageNamed:@"ic_marvel_file"]
                                      options:SDWebImageRefreshCached];
    
    return cell;
}

-(void)showSpinner{
    
    self.uivw_loading = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [self.uivw_loading setTag:90901];
    [self.uivw_loading setBackgroundColor:[UIColor colorWithRed:35.0/255.0 green:35/255.0 blue:35/255.0 alpha:0.65]];
    [self.uivw_loading setAlpha:1.0f];
    
    UIActivityIndicatorView*  loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loading.color=[UIColor whiteColor];
    loading.center = self.uivw_loading.center;
    loading.hidesWhenStopped = YES;
    [loading startAnimating];
    [self.uivw_loading addSubview:loading];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.uivw_loading];
    [[[self view] window] bringSubviewToFront:self.uivw_loading];
}

- (void)removeSpinner{
    [self.uivw_loading removeFromSuperview];
}

-(void)requestData:(NSDictionary *)params{
    
    [self showSpinner];
    [self registerListeners];
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    NSString *time = [NSString stringWithFormat:@"%ld", currentTime];
    
    NSDictionary *parameters = @{
                                 @"orderBy":@"name",
                                 @"limit": [[NSNumber alloc] initWithInt:10],
                                 @"offset": [[NSNumber alloc] initWithInt:0],
                                 @"apikey": @"656ace3b6053ed496242e3d3f7dca830",
                                 @"ts": time,
                                 @"hash": [HeroesService generateHashKey:time]};
    
    [HeroesService getData:@"https://gateway.marvel.com:443/v1/public/characters" withFunc:AFCharactersMethod andWithParams:parameters];
}

- (void)registerListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseData:) name:AFCharactersMethod object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(response_NOK:) name:AFCharactersResponseNOK object:nil];
}

- (void)removeListeners{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AFCharactersMethod object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AFCharactersResponseNOK object:nil];
}

- (void)responseData:(NSNotification *)notification{
    
    [self removeSpinner];
    [self removeListeners];
    
    if([notification.userInfo isKindOfClass:[NSDictionary class]]){
        [self.characters parseResult:notification.userInfo];
        [self.data addObjectsFromArray:self.characters.charactersData.results];
    }
    
    [self.tableView reloadData];
}

- (void)response_NOK:(NSNotification *)notification{
    
    [self removeSpinner];
    [self removeListeners];
    
}

@end

