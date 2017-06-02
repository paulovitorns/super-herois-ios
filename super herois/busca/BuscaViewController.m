//
//  BuscaViewController.m
//  super herois
//
//  Created by Paulo Sales on 31/05/17.
//  Copyright © 2017 Paulo Sales. All rights reserved.
//

#import "BuscaViewController.h"

@interface BuscaViewController ()

@end

@implementation BuscaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.uifield_nome_personagem.borderStyle = UITextBorderStyleLine;
    self.uifield_nome_personagem.layer.borderWidth  = 1;
    self.uifield_nome_personagem.layer.borderColor  = [[UIColor whiteColor] CGColor];
    self.uifield_nome_personagem.layer.cornerRadius = 5.0f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([self.uifield_nome_personagem isFirstResponder] && [touch view] != self.uifield_nome_personagem) {
        [self.uifield_nome_personagem resignFirstResponder];
    }
    
    if(!self.uiview_picker_container.isHidden){
        if(self.selectedIndex > -1){
            self.uiview_picker_container.hidden = TRUE;
            self.uilbl_order.text = [self.itens_order objectAtIndex:self.selectedIndex];
        }
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initViews{
    
    self.uifield_nome_personagem.delegate = self;
    self.uipicker_data.delegate   = self;
    self.uipicker_data.dataSource = self;
    self.uiview_picker_container.hidden = TRUE;
    
    self.itens_order = [[NSArray alloc] initWithObjects:@"nome A-Z",@"nome Z-A",@"Mais atualizados",@"Menos atualizados", nil];
    
    if([self.params objectForKey:@"nameStartsWith"] != nil)
        self.uifield_nome_personagem.text = [self.params objectForKey:@"nameStartsWith"];
    
    if([self.params objectForKey:@"orderBy"] != nil){
        
        if([[self.params objectForKey:@"orderBy"] isEqualToString:@"name"]){
            self.uilbl_order.text = @"nome A-Z";
        }else if([[self.params objectForKey:@"orderBy"] isEqualToString:@"-name"]){
            self.uilbl_order.text = @"nome Z-A";
        }else if([[self.params objectForKey:@"orderBy"] isEqualToString:@"modified"]){
            self.uilbl_order.text = @"Mais atualizados";
        }else if([[self.params objectForKey:@"orderBy"] isEqualToString:@"-modified"]){
            self.uilbl_order.text = @"Menos atualizados";
        }
    }
    
}

- (NSDictionary*)sendFilterParams{
    NSMutableDictionary *params = [self.params mutableCopy];
    
    if(![self.uifield_nome_personagem.text isEqualToString:@""])
        [params setValue:self.uifield_nome_personagem.text forKey:@"nameStartsWith"];
    else
        [params removeObjectForKey:@"nameStartsWith"];
     
    if([self.uilbl_order.text isEqualToString:@"nome A-Z"]){
        [params setValue:@"name" forKey:@"orderBy"];
    }else if([self.uilbl_order.text isEqualToString:@"nome Z-A"]){
        [params setValue:@"-name" forKey:@"orderBy"];
    }else if([self.uilbl_order.text isEqualToString:@"Mais atualizados"]){
        [params setValue:@"modified" forKey:@"orderBy"];
    }else if([self.uilbl_order.text isEqualToString:@"Menos atualizados"]){
        [params setValue:@"-modified" forKey:@"orderBy"];
    }else{
        [params setValue:@"name" forKey:@"orderBy"];
    }
    
    return [[NSDictionary alloc] initWithDictionary:params];
}

- (IBAction)cancelSearch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openPicker:(id)sender {
    [self.uifield_nome_personagem endEditing:YES];
    self.uiview_picker_container.hidden = FALSE;
}

- (IBAction)prepareAndSendNewSearch:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:POSTSEARCHMETHOD object:nil userInfo:[self sendFilterParams]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma PickerData
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.itens_order.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.itens_order objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedIndex = row;
    
    self.uiview_picker_container.hidden = TRUE;
    self.uilbl_order.text = [self.itens_order objectAtIndex:self.selectedIndex];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.uifield_nome_personagem) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)singleTap:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

@end
