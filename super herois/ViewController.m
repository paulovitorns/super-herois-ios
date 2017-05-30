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
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    
    NSString *time = [NSString stringWithFormat:@"%ld", currentTime];
    
    NSString *hasKey = [time stringByAppendingFormat:@"%@%@", @"f397d02d1f002af3626143143af1916b329a5abf", @"656ace3b6053ed496242e3d3f7dca830"];
    
    NSDictionary *parameters = @{
                                 @"orderBy":@"name",
                                 @"limit": [[NSNumber alloc] initWithInt:10],
                                 @"offset": [[NSNumber alloc] initWithInt:0],
                                 @"apikey": @"656ace3b6053ed496242e3d3f7dca830",
                                 @"ts": time,
                                 @"hash": [HeroesService md5HexDigest:hasKey]};
    
    [HeroesService getData:@"https://gateway.marvel.com:443/v1/public/characters" withFunc:nil andWithParams:parameters];
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SuperHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSE];
    
    return cell;
}

@end
