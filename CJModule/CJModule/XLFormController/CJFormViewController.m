//
//  CJFormViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/8/10.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJFormViewController.h"
#import <XLForm.h>

@interface CJFormViewController ()

@end

@implementation CJFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initializeForm];
}


-(void)initializeForm {
   
    XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:@"表单"];
    
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@"section-one" sectionOptions:XLFormSectionOptionCanReorder];
    
    [form addFormSection:section];
    
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:@"location" rowType:XLFormRowDescriptorTypeStepCounter];
    [section addFormRow:row];
 
    self.form = form;
}





@end






