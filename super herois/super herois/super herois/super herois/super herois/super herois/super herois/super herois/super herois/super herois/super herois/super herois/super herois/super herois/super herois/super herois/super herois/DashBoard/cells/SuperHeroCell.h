//
//  SuperHeroCell.h
//  super herois
//
//  Created by Paulo Sales on 29/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperHeroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *uilbl_hero_name;
@property (weak, nonatomic) IBOutlet UILabel *uilbl_hero_short_desc;
@property (weak, nonatomic) IBOutlet UIImageView *uiimg_hero_image;

@end
