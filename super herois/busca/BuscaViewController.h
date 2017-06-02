//
//  BuscaViewController.h
//  super herois
//
//  Created by Paulo Sales on 31/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import "ViewController.h"

@interface BuscaViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *uifield_nome_personagem;
@property (weak, nonatomic) IBOutlet UILabel *uilbl_order;
@property (weak, nonatomic) IBOutlet UIView *uiview_picker_container;
@property (weak, nonatomic) IBOutlet UIPickerView *uipicker_data;
@property (strong, nonatomic) NSArray *itens_order;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) NSDictionary *params;

- (void)initViews;
- (NSDictionary*)sendFilterParams;
- (IBAction)cancelSearch:(id)sender;
- (IBAction)openPicker:(id)sender;
- (IBAction)prepareAndSendNewSearch:(id)sender;
@end
