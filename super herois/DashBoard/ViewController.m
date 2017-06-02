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
    
    if(self.paramsToBeEditable == nil)
        [self initParams];
    
    [self hasConnection];
    
    if(self.hasConn)
        [self requestData:[self.paramsToBeEditable copy]];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 84.0f;
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
    if([item.desc isEqualToString:@""])
        cell.uilbl_hero_short_desc.text = @"...";
    else
        cell.uilbl_hero_short_desc.text = item.desc;
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@.%@", item.thumbnail[@"path"], item.thumbnail[@"extension"], nil];
    
    [cell.uiimg_hero_image sd_setImageWithURL:[NSURL URLWithString:imgUrl]
                             placeholderImage:[UIImage imageNamed:@"ic_marvel_file"]
     options:SDWebImageRefreshCached];
    
    if(indexPath.row == ([self.data count] - 2)){
        [self loadMoreItens];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

-(void)hasConnection{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com/m"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    
    if (!data){
        self.hasConn = NO;
        [self showErrorConnection];
    }else{
        self.hasConn = YES;
        self.uiview_empty_state.hidden = YES;
        self.tableView.hidden = NO;
    }
}

- (NSString *)getTimeMillis{
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    return [NSString stringWithFormat:@"%ld", currentTime];
}

-(void)initParams{
    
    if(self.paramsToBeEditable == nil)
        self.paramsToBeEditable = [[NSMutableDictionary alloc] init];
    
    self.page       = 0;
    self.pageSize   = 10;
    
    [self.paramsToBeEditable setValue:@"name" forKey:@"orderBy"];
    [self.paramsToBeEditable setValue:[[NSNumber alloc] initWithInt:self.pageSize] forKey:@"limit"];
    [self.paramsToBeEditable setValue:[[NSNumber alloc] initWithInt:self.page] forKey:@"offset"];
    [self.paramsToBeEditable setValue:@"656ace3b6053ed496242e3d3f7dca830" forKey:@"apikey"];
    [self.paramsToBeEditable setValue:[self getTimeMillis] forKey:@"ts"];
    [self.paramsToBeEditable setValue:[HeroesService generateHashKey:[self getTimeMillis]] forKey:@"hash"];
}

- (void)prepareParams:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:POSTSEARCHMETHOD object:nil];
    
    self.data = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    
    self.page           = 0;
    self.pageSize       = 10;
    self.hasMorePages   = NO;
    
    self.paramsToBeEditable = [notification.userInfo mutableCopy];
    [self.paramsToBeEditable setValue:[[NSNumber alloc] initWithInt:self.pageSize] forKey:@"limit"];
    [self.paramsToBeEditable setValue:[[NSNumber alloc] initWithInt:self.page] forKey:@"offset"];
    [self.paramsToBeEditable setValue:[self getTimeMillis] forKey:@"ts"];
    [self.paramsToBeEditable setValue:[HeroesService generateHashKey:[self getTimeMillis]] forKey:@"hash"];
    
    [self hasConnection];
    if(self.hasConn)
        [self requestData:[self.paramsToBeEditable copy]];
}

-(void)loadMoreItens{
    
    [self hasConnection];
    
    if(self.hasMorePages){
        [self.paramsToBeEditable setValue:[[NSNumber alloc] initWithInt:self.pageSize] forKey:@"limit"];
        [self.paramsToBeEditable setValue:[[NSNumber alloc] initWithInt:self.page] forKey:@"offset"];
        [self.paramsToBeEditable setValue:[self getTimeMillis] forKey:@"ts"];
        [self.paramsToBeEditable setValue:[HeroesService generateHashKey:[self getTimeMillis]] forKey:@"hash"];
        
        [self requestData:[self.paramsToBeEditable copy]];
        
    }
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
    [HeroesService getData:@"https://gateway.marvel.com:443/v1/public/characters" withFunc:AFCharactersMethod andWithParams:params];
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
        
        if([notification.userInfo[@"data"][@"count"] intValue] > 0){
            
            self.tableView.hidden = NO;
            self.uiview_empty_state.hidden = YES;
            
            self.characters = [Characters new];
            [self.characters parseResult:notification.userInfo];
            
            if(!self.hasMorePages){
                
                if(self.data == nil)
                    self.data = [[NSMutableArray alloc] init];
                
                if(self.characters.charactersData.total > self.pageSize){
                    self.hasMorePages   = YES;
                    self.countPages     = self.characters.charactersData.total;
                    self.page           = self.page + self.pageSize;
                }else{
                    self.hasMorePages = NO;
                }
                
            }else{
                
                self.page = self.page+self.pageSize;
                
                if(self.page >= self.countPages){
                    self.hasMorePages = NO;
                }
            }
            
            [self.data addObjectsFromArray:self.characters.charactersData.results];
        }else{
            [self showEmptyState];
        }
        
    }
    
    [self.tableView reloadData];
}

- (void)response_NOK:(NSNotification *)notification{
    [self removeSpinner];
    [self removeListeners];
}

-(void)showEmptyState{
    self.tableView.hidden = YES;
    self.uiview_empty_state.hidden = NO;
    self.uilbl_empty_desc.text = EMPTY_DESC;
    self.uibtn_search.hidden = NO;
    self.uibtn_try_again.hidden = YES;
    [self.uiimg_icon_empty setImage:[UIImage imageNamed:@"ic_warning_white_48pt"]];
}

-(void)showErrorConnection{
    self.tableView.hidden = YES;
    self.uiview_empty_state.hidden = NO;
    self.uilbl_empty_desc.text = NO_CONN_DESC;
    self.uibtn_search.hidden = YES;
    self.uibtn_try_again.hidden = NO;
    [self.uiimg_icon_empty setImage:[UIImage imageNamed:@"ic_signal_wifi_off_white_48pt"]];
}

- (IBAction)navigateToSearch:(id)sender {
    [self performSegueWithIdentifier:@"showSearchSegue" sender:self];
}

- (IBAction)onTryAgain:(id)sender {
    [self hasConnection];
    if(self.hasConn)
        [self requestData:[self.paramsToBeEditable copy]];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showSearchSegue"]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepareParams:) name:POSTSEARCHMETHOD object:nil];
        BuscaViewController *controller = segue.destinationViewController;
        controller.params = [self.paramsToBeEditable copy];
    }
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        DetailsViewController *controller = segue.destinationViewController;
        controller.character = [self.data objectAtIndex:self.selectedIndex];
    }
    
}

@end
