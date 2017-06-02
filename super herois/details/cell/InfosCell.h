//
//  InfosCell.h
//  super herois
//
//  Created by Paulo Sales on 01/06/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfosCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *uilbl_info_count;
@property (weak, nonatomic) IBOutlet UILabel *uilbl_action;
@property (weak, nonatomic) IBOutlet UIImageView *uiimg_action;
@property (weak, nonatomic) IBOutlet UIButton *uibtn_action;

@end
