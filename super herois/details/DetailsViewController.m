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

#define HEADER_REUSE_IDENTIFIER @"HEADER_CELL"
#define DESC_CELL_REUSE @"DESC_CELL_REUSE"
#define INFO_CELL_REUSE @"InfoExtraCell"

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self parseData];
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
    
    [self.tableview registerNib:[UINib nibWithNibName:@"DescCell" bundle:nil] forCellReuseIdentifier:DESC_CELL_REUSE];
    [self.tableview registerNib:[UINib nibWithNibName:@"InfoExtraCell" bundle:nil] forCellReuseIdentifier:INFO_CELL_REUSE];
    [self.tableview registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:HEADER_REUSE_IDENTIFIER];
    
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 72.0f;
}

- (void)parseData{

    self.data = [[NSMutableArray alloc] init];

    NSString *imgUrl = [NSString stringWithFormat:@"%@.%@", self.character.thumbnail[@"path"], self.character.thumbnail[@"extension"], nil];

    NSArray *desc = [[NSArray alloc] initWithObjects:self.character.desc, nil];
    
    NSDictionary *dictIntro = @{
                                @"modified":self.character.modified,
                                @"image":imgUrl,
                                @"desc" :desc
                                };
    
    [self.data addObject:[dictIntro mutableCopy]];
    
    if([self.character.comics[@"available"] intValue] > 0){
        NSMutableDictionary *comic = [self.character.comics mutableCopy];
        [comic setValue:@"comics" forKey:@"title"];
        [comic setValue:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
        [self.data addObject:comic];
    }
    
    if([self.character.series[@"available"] intValue] > 0){
        NSMutableDictionary *series = [self.character.series mutableCopy];
        [series setValue:@"series" forKey:@"title"];
        [series setValue:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
        [self.data addObject:series];
    }
    
    if([self.character.stories[@"available"] intValue] > 0){
        NSMutableDictionary *stories = [self.character.stories mutableCopy];
        [stories setValue:@"stories" forKey:@"title"];
        [stories setValue:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
        [self.data addObject:stories];
    }
    
    if([self.character.events[@"available"] intValue] > 0){
        NSMutableDictionary *events = [self.character.events mutableCopy];
        [events setValue:@"events" forKey:@"title"];
        [events setValue:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
        [self.data addObject:events];
    }
    
//    @property(strong, nonatomic) NSArray *urls;

}

#pragma UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableDictionary *dict = [self.data objectAtIndex:section];
    
    if(section == 0){
        return [dict[@"desc"] count];
    }else{
        if([dict[@"isOpen"] boolValue]){
            return [dict[@"items"] count];
        }else{
            return 0;
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 256.0f;
    }else{
        return 69.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000000000001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADER_REUSE_IDENTIFIER];
    
    if(section == 0){
        
        HeaderViewTableViewCell *headerCell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderViewTableViewCell" owner:self options:nil] firstObject];
        
        NSMutableDictionary *intro = [self.data objectAtIndex:section];
        
        headerCell.uilbl_update.text = [NSString stringWithFormat:@"última atualização %@", intro[@"modified"], nil];
        [headerCell.uiimg_char_image sd_setImageWithURL:[NSURL URLWithString:intro[@"image"]]
                                       placeholderImage:[UIImage imageNamed:@"ic_marvel_file"]
                                                options:SDWebImageRefreshCached];
        
        headerView = (UITableViewHeaderFooterView *)headerCell.contentView;
        
    }else{
        
        InfosCell *headerCell = [[[NSBundle mainBundle] loadNibNamed:@"InfosCell" owner:self options:nil] firstObject];
        
        NSMutableDictionary *dict = [self.data objectAtIndex:section];
        
        headerCell.uilbl_info_count.text = [NSString stringWithFormat:@"%d %@", [dict[@"available"] intValue], dict[@"title"]];
        
        if([dict[@"isOpen"] boolValue]){
            headerCell.uilbl_action.text = @"ocultar";
            headerCell.uiimg_action.image = [UIImage imageNamed:@"ic_arrow_drop_up_white"];
        }else{
            headerCell.uilbl_action.text = @"expandir";
            headerCell.uiimg_action.image = [UIImage imageNamed:@"ic_arrow_drop_down_white"];
        }
        
        headerCell.uibtn_action.tag = section;
        [headerCell.uibtn_action addTarget:self action:@selector(onBtnExpand:) forControlEvents:UIControlEventTouchUpInside];
        
        headerView = (UITableViewHeaderFooterView *)headerCell.contentView;
        
    }
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
         
            DescCell *cell = [tableView dequeueReusableCellWithIdentifier:DESC_CELL_REUSE];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DescCell" owner:self options:nil];
                cell = [nib firstObject];
            }
            
            NSMutableDictionary *desc = [self.data objectAtIndex:indexPath.section];
            NSString *descStr    = [desc[@"desc"] objectAtIndex:indexPath.row];
        
            cell.uilbl_desc.text = ([descStr isEqualToString:@""]) ? @"..." : descStr;
        
        return cell;
        
    }else{
        
        InfoExtraCell *cell = [tableView dequeueReusableCellWithIdentifier:INFO_CELL_REUSE];
        
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InfoExtraCell" owner:self options:nil];
            cell = [nib firstObject];
        }
        
        NSDictionary *dictData = [self.data objectAtIndex:indexPath.section];
        NSDictionary *dictItem = [dictData[@"items"] objectAtIndex:indexPath.row];
        
        cell.uilbl_name_extra.text = dictItem[@"name"];
        if(dictItem[@"name"] != nil){
            cell.uilbl_type_extra.hidden = NO;
            if(![dictItem[@"type"] isEqualToString:@""])
                cell.uilbl_type_extra.text = dictItem[@"type"];
            else
                cell.uilbl_type_extra.text = @"...";
        }
        
        return cell;
    }
    
}

- (void)onBtnExpand:(id)sender{
    
    if([sender isKindOfClass:[UIButton class]]){
        
        UIButton *button = sender;
        
        NSMutableDictionary *dict = [self.data objectAtIndex:button.tag];
        
        if([dict[@"isOpen"] boolValue]){
            [dict setValue:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
            [self.data replaceObjectAtIndex:button.tag withObject:dict];
            [self removeRows:button.tag];
        }else{
            [dict setValue:[NSNumber numberWithBool:YES] forKey:@"isOpen"];
            [self.data replaceObjectAtIndex:button.tag withObject:dict];
            [self addRows:button.tag];
        }
        
    }
    
}

- (void)addRows:(NSInteger)section{
    
    [self.tableview beginUpdates];
    
    NSMutableDictionary *dict = [self.data objectAtIndex:section];
    
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    for (int i = 0; i < [dict[@"items"] count]; i++)
    {
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:section]];
        [self.tableview insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [self.tableview endUpdates];
}

-(void)removeRows:(NSInteger)section{
    
    [self.tableview beginUpdates];
    
    NSMutableDictionary *dict = [self.data objectAtIndex:section];
    
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    for (int i = 0; i < [dict[@"items"] count]; i++)
    {
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:section]];
        [self.tableview deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [self.tableview endUpdates];
    
}


@end
