//
//  MultitudeDelegateViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/11/26.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "MultitudeDelegateViewController.h"
#import <GLKit/GLKit.h>
#import <QMUIKit.h>
#import "CJPasswordTextField.h"
#import "CJThemeManager/CJThemeManager.h"


@interface MultitudeNewDelegate : NSObject<UITableViewDelegate>


@end

@implementation MultitudeNewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"MultitudeNewDelegate---");
}

@end


@interface MultitudeDelegateViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CJPasswordTextFieldDelegate>

@end

@implementation MultitudeDelegateViewController {
    MultitudeNewDelegate *_newDelegate;
    CJPasswordTextField *_passwordField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _newDelegate = [MultitudeNewDelegate new];

    UITableView *tabv = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    tabv.estimatedRowHeight = 0;
    tabv.estimatedSectionFooterHeight = 0;
    tabv.estimatedSectionHeaderHeight = 0;
    
    tabv.delegate = self;
    tabv.dataSource = self;
    tabv.qmui_multipleDelegatesEnabled = YES;
    tabv.delegate = _newDelegate;
    //[self.view addSubview:tabv];
    
    QMUIEmotionInputManager *inputManager = [[QMUIEmotionInputManager alloc] init];

    inputManager.emotionView.frame = CGRectMake(0, 410, self.view.frame.size.width, 300);
    inputManager.emotionView.backgroundColor = [UIColor lightGrayColor];
    //[self.view addSubview:inputManager.emotionView];
    
    UIView *inputView = [UIView new];
    inputView.frame = CGRectMake(0, 0, self.view.frame.size.width, 400);
    inputView.backgroundColor = [UIColor lightGrayColor];
    
    QMUITextField *textField = [[QMUITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    textField.backgroundColor = [UIColor purpleColor];
//    textField.delegate = self;
    textField.maximumTextLength = 10;
    textField.placeholder = @"placeholder";
    textField.font = [UIFont systemFontOfSize:14];
    textField.layer.borderWidth = 2.f;
    textField.layer.borderColor  = [UIColor blackColor].CGColor;
    textField.layer.cornerRadius = 5.f;
    
    // UITextInputTraits
    textField.enablesReturnKeyAutomatically = YES; // 是否自动管理return键，点击与否。
    textField.secureTextEntry = NO; // 秘钥形式输入。默认是NO。
    textField.textContentType = UITextContentTypeURL; // 指定输入的内容，来让系统更加合理的选择和适配的键盘和修正。
    textField.returnKeyType = UIReturnKeySend; // 键盘enturn键的样式。
    textField.keyboardAppearance = UIKeyboardAppearanceDark; // 键盘的颜色。
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation; // 键盘的样式。
    textField.autocorrectionType = UITextAutocorrectionTypeYes; // 自动给定单词提示。
    textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters; // 大写矫正。每个字母都是大写。也就是系统键盘 shift 键是否有效（这种情况就是每个字母都有效）。
    
    
    [self.view addSubview:textField];
    
    CJPasswordTextField *pwdTextField = [[CJPasswordTextField alloc] initWithFrame:CGRectMake(10, 100, 10, 40)];
    pwdTextField.backgroundColor = [UIColor lightGrayColor];
    pwdTextField.showingCursor = YES;
    pwdTextField.secureTextEntry = YES;
    pwdTextField.font = [UIFont systemFontOfSize:16];
    pwdTextField.passwordLength = 4;
    pwdTextField.tintColor = UIColorMake(239, 83, 98);
    pwdTextField.passwordBoxColor = [UIColor purpleColor];
    pwdTextField.passwordBoxSpace = 10;
    pwdTextField.passwordBoxLayerWidth = 3;
    pwdTextField.secureDotColor = pwdTextField.tintColor;
    pwdTextField.secureDotSize = CGSizeMake(6, 1);
    pwdTextField.textColor = [UIColor purpleColor];
    pwdTextField.delegate = self;
    
    [self.view addSubview:pwdTextField];
    _passwordField = pwdTextField;
   
  
}

//-(void)passwordTextDidDeleteText:(NSString *)text range:(NSRange)range {
//    NSLog(@"DeleteText:%@-%@",text,NSStringFromRange(range));
//
//}
//
//-(void)passwordTextDidInsertText:(NSString *)text range:(NSRange)range {
//    NSLog(@"InsertText:%@-%@",text,NSStringFromRange(range));
//}


-(void)textFieldNotifyStart:(NSNotification *)notify {
    NSLog(@"-UITextFieldTextDidChangeNotification");
}

-(void)textFieldNotifyBeginEding:(NSNotification *)notify {
    NSLog(@"-UITextFieldTextDidBeginEditingNotification");
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@",_passwordField.text);
}

#pragma mark ----

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL isDeleting = range.length > 0 && string.length <= 0;
    NSLog(@"%@-%@:%d",NSStringFromRange(range),string,isDeleting);
    
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"tableView:%zd",indexPath.row];
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerFooterV_id = @"headerFooterV_id";
    UITableViewHeaderFooterView *headerFooterV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerFooterV_id];
    if (!headerFooterV) {
        headerFooterV = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerFooterV_id];
    }
    headerFooterV.textLabel.text = [NSString stringWithFormat:@"---TextLable:%zd",section];
    headerFooterV.detailTextLabel.text = [NSString stringWithFormat:@"---DetailTextLable:%zd",section];
    return headerFooterV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"tableView---%@",NSStringFromUIEdgeInsets(scrollView.contentInset));

}


@end
