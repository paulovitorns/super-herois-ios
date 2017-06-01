//
//  DetailsViewController.m
//  super herois
//
//  Created by Paulo Sales on 31/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initViews{
    self.title = self.character.name;
}

@end
