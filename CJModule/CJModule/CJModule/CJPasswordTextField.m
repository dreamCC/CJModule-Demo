//
//  CJPasswordTextField.m
//  CJModule
//
//  Created by 仁和Mac on 2017/11/28.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJPasswordTextField.h"

static inline NSString *FilterToNumberString(NSString *inputString) {
    NSCharacterSet *numSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *numString = [[inputString componentsSeparatedByCharactersInSet:numSet] componentsJoinedByString:@""];
    return numString;
}

@interface CJPasswordTextField()
// 用于保存输入的内容。
@property(nonatomic, strong) NSMutableString *inputString;
@property(nonatomic, strong) NSMutableArray<CALayer *> *inputLayers;

// 密码框
@property(nonatomic, strong) UIBezierPath *passwordBoxPath;
@property(nonatomic, weak) CAShapeLayer *passwordBoxLayer;

// 光标
@property(nonatomic, weak) CALayer *cursorLayer;


// ------------------
@property(nonatomic, assign) BOOL cj_secureTextEntry;
@property(nonatomic) UIKeyboardAppearance cj_keyboardAppearance;
@property(nonatomic) UIReturnKeyType cj_returnKeyType;
@property(nonatomic) BOOL cj_enablesReturnKeyAutomatically;


@end

@implementation CJPasswordTextField

-(instancetype)initWithFrame:(CGRect)frame passwordLength:(NSUInteger)passwordLength {
    self = [super initWithFrame:frame];
    if (self) {
        [self didInitializedWithPasswordLength:passwordLength];
        [self didInitializeUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame passwordLength:6];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitializedWithPasswordLength:6];
        [self didInitializeUI];
    }
    return self;
}

-(void)layoutSubviews {
    [self.passwordBoxPath removeAllPoints];
    
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width  = CGRectGetWidth(self.frame);
    if (self.passwordBoxSpace) {
        
        CGFloat passwordBoxWidth = (width - (_passwordLength-1) * _passwordBoxSpace)/_passwordLength-_passwordBoxLayerWidth;
        CGFloat passwordBoxHeight = height - _passwordBoxLayerWidth;
        if (passwordBoxWidth <= 0) {
            @throw [NSException exceptionWithName:@"The width of passwordBox less than zero " reason:@"CJPasswordTextField is too shoot or passwordBoxSpace and passwordBoxLayerWidth too long" userInfo:nil];
        }
        
        
        for (int i = 0; i < _passwordLength; i++) {
            CGRect passwordBoxFrame = (CGRect){{i*(passwordBoxWidth + _passwordBoxSpace + _passwordBoxLayerWidth) + _passwordBoxLayerWidth/2,_passwordBoxLayerWidth/2},{passwordBoxWidth,passwordBoxHeight}};
            UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:passwordBoxFrame];
            [self.passwordBoxPath appendPath:rectPath];
        }
        
    }else {
        
        CGFloat passwordBoxWidth = (width - _passwordBoxLayerWidth)/_passwordLength;
        if (passwordBoxWidth <= 0) {
            @throw [NSException exceptionWithName:@"The width of passwordBox less than zero " reason:@"CJPasswordTextField is too shoot or passwordBoxLayerWidth too long" userInfo:nil];
        }
        
        UIBezierPath *boardPath = [UIBezierPath bezierPathWithRect:CGRectMake(_passwordBoxLayerWidth/2, _passwordBoxLayerWidth/2, width - _passwordBoxLayerWidth, height - _passwordBoxLayerWidth)];
        [self.passwordBoxPath appendPath:boardPath];
        
        for (int i = 1; i < _passwordLength; i++) {
            UIBezierPath *rectPath = [UIBezierPath bezierPath];
            CGPoint startPoint = CGPointMake(i*(passwordBoxWidth) + _passwordBoxLayerWidth/2, _passwordBoxLayerWidth);
            [rectPath moveToPoint:startPoint];
            [rectPath addLineToPoint:CGPointMake(startPoint.x, height - _passwordBoxLayerWidth)];
            [self.passwordBoxPath appendPath:rectPath];
        }
        
    }
    
    _passwordBoxLayer.lineWidth   = _passwordBoxLayerWidth;
    _passwordBoxLayer.strokeColor = _passwordBoxColor.CGColor;
    _passwordBoxLayer.fillColor   = self.backgroundColor.CGColor;
    _passwordBoxLayer.path = _passwordBoxPath.CGPath;
}

-(void)tintColorDidChange {
    [super tintColorDidChange];
    self.cursorLayer.backgroundColor = self.tintColor.CGColor;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// -------------------------
-(void)didInitializedWithPasswordLength:(NSUInteger)passwordLength {
  
    _passwordLength   = passwordLength;
    _passwordBoxSpace = 0;
    _passwordBoxLayerWidth = 1.f;
    _passwordBoxColor  = [UIColor colorWithRed:89/255.0 green:88/255.0 blue:89/255.0 alpha:1];
    
    _font = [UIFont systemFontOfSize:16];
    _textColor = [UIColor colorWithRed:30/255.0 green:32/255.0 blue:40/255.0 alpha:1];
    
    _showingCursor = YES;
    
    _secureDotSize  = CGSizeMake(10, 10);
    _secureDotColor = _textColor;
}

-(void)didInitializeUI {
    self.backgroundColor = [UIColor whiteColor];
    self.secureTextEntry = NO;
    
    // 密码框
    CAShapeLayer *passwordBoxLayer = [CAShapeLayer layer];
    [self.layer addSublayer:passwordBoxLayer];
    self.passwordBoxLayer = passwordBoxLayer;
    
    // 光标
    CALayer *cursorLayer = [CALayer layer];
    cursorLayer.backgroundColor = self.tintColor.CGColor;
    cursorLayer.hidden = YES;
    cursorLayer.cornerRadius = 1;
    [self.layer addSublayer:cursorLayer];
    self.cursorLayer = cursorLayer;
    
    CABasicAnimation *cursorAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    cursorAnimation.repeatCount = HUGE;
    cursorAnimation.duration  = 0.8f;
    cursorAnimation.fromValue = @(0);
    cursorAnimation.toValue = @(1);
    cursorAnimation.removedOnCompletion = NO;
    cursorAnimation.autoreverses = YES;
    [cursorLayer addAnimation:cursorAnimation forKey:@"com.cursorAnimation.opacity"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow {
    if (!self.isFirstResponder || !_showingCursor) return;
    [self setCursorNeedsDisplay];
}

-(void)keyboardWillHidden {
    if (self.isFirstResponder && !_cursorLayer.isHidden) {
        self.cursorLayer.hidden = YES;
    }
}

-(void)displayInputString {
    !_showingCursor?:[self setCursorNeedsDisplay];

    NSInteger displayIndex = self.inputString.length - 1;
    CGFloat displayWidth  = (CGRectGetWidth(self.frame) - (_passwordLength-1) * _passwordBoxSpace)/_passwordLength;
    CGFloat displayHeight = CGRectGetHeight(self.frame);
    CGRect displayFrame   = CGRectMake(displayIndex*(displayWidth+_passwordBoxSpace), 0, displayWidth, displayHeight);
   
    if (self.isSecureTextEntry) {
        
        UIBezierPath *dotPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((displayWidth - _secureDotSize.width)/2, (displayHeight - _secureDotSize.height)/2, _secureDotSize.width, _secureDotSize.height) cornerRadius:_secureDotSize.width/2.0];
        CAShapeLayer *dotLayer = [CAShapeLayer layer];
        dotLayer.frame = displayFrame;
        dotLayer.fillColor = _secureDotColor.CGColor;
        dotLayer.path = dotPath.CGPath;
        [self.layer addSublayer:dotLayer];
        
        [self.inputLayers addObject:dotLayer];
    }else {
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = displayFrame;
        textLayer.foregroundColor = _textColor.CGColor;
        textLayer.fontSize = _font.pointSize;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.string = [[NSAttributedString alloc] initWithString:[self.inputString substringFromIndex:displayIndex]
                                                           attributes:@{NSBaselineOffsetAttributeName:@((_font.pointSize-(displayHeight))/2),
                                                                        NSFontAttributeName:_font}];
        [self.layer addSublayer:textLayer];
        
        [self.inputLayers addObject:textLayer];
    }
}

-(void)setCursorNeedsDisplay {
  
    CGFloat displayWidth  = (CGRectGetWidth(self.frame) - (_passwordLength-1) * _passwordBoxSpace)/_passwordLength;
    CGFloat displayHeight = CGRectGetHeight(self.frame);
    [CATransaction setDisableActions:YES];
    _cursorLayer.frame    = CGRectMake(self.inputString.length*(displayWidth+_passwordBoxSpace) + (displayWidth - 2)/2, (displayHeight - _font.pointSize)/2, 2, _font.pointSize + 2);
    if (!CGRectContainsRect(self.bounds, _cursorLayer.frame)) {
        _cursorLayer.hidden = YES;
    }else {
        _cursorLayer.hidden = NO;
    }
}

-(void)setText:(NSString *)text {
    if (FilterToNumberString(text).length > 0) {
        [self.inputString deleteCharactersInRange:NSMakeRange(0,self.inputString.length)];
        [self.inputLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.inputLayers removeAllObjects];
    }
   
    for (int i = 0; i < text.length; i++) {
        NSString *subString = [text substringWithRange:NSMakeRange(i, 1)];
        [self insertText:subString];
    }
}
-(NSString *)text {
    return self.inputString;
}

-(void)setSecureDotSize:(CGSize)secureDotSize {
    CGFloat minForSize = fminf(secureDotSize.width, secureDotSize.height);
    if (minForSize < 10 || minForSize > (CGRectGetHeight(self.frame) -  2*_passwordBoxLayerWidth - 10)) return;
    _secureDotSize = CGSizeMake(minForSize, minForSize);
}


#pragma mark ---- UIKeyInput
-(BOOL)hasText {
    return !!self.inputString.length;
}

-(void)insertText:(NSString *)text {
    if (![text isEqualToString:FilterToNumberString(text)]) return;
    if (text.length > 1 || self.inputString.length == _passwordLength) return;
    [self.inputString appendString:text];
    [self displayInputString];
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordTextDidInsertText:range:)]) {
        [self.delegate passwordTextDidInsertText:text range:NSMakeRange(self.inputString.length - 1, 1)];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)deleteBackward {
    if (self.inputString.length == 0) return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordTextDidDeleteText:range:)]) {
        [self.delegate passwordTextDidDeleteText:[self.inputString substringFromIndex:self.inputString.length-1] range:NSMakeRange(self.inputString.length - 1, 1)];
    }
    
    [self.inputString deleteCharactersInRange:NSMakeRange(self.inputString.length - 1, 1)];
    [self.inputLayers.lastObject performSelectorOnMainThread:@selector(removeFromSuperlayer) withObject:nil waitUntilDone:YES];
    [self.inputLayers removeLastObject];
    !_showingCursor?:[self setCursorNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

// ----------------------
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}


#pragma mark ----- UITextInputTraits
-(void)setSecureTextEntry:(BOOL)secureTextEntry {
    self.cj_secureTextEntry = secureTextEntry;
}
-(BOOL)isSecureTextEntry {
    return self.cj_secureTextEntry;
}

-(void)setEnablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically {
    self.cj_enablesReturnKeyAutomatically = enablesReturnKeyAutomatically;
}
-(BOOL)enablesReturnKeyAutomatically {
    return self.cj_enablesReturnKeyAutomatically;
}

-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType {
    self.cj_returnKeyType = returnKeyType;
}
-(UIReturnKeyType)returnKeyType {
    return self.cj_returnKeyType;
}

-(void)setKeyboardAppearance:(UIKeyboardAppearance)keyboardAppearance {
    self.cj_keyboardAppearance = keyboardAppearance;
}
-(UIKeyboardAppearance)keyboardAppearance {
    return self.cj_keyboardAppearance;
}

-(void)setAutocorrectionType:(UITextAutocorrectionType)autocorrectionType {
    
}
-(UITextAutocorrectionType)autocorrectionType {
    return UITextAutocorrectionTypeDefault;
}

-(void)setAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType {
    
}

-(UITextAutocapitalizationType)autocapitalizationType {
    return UITextAutocapitalizationTypeNone;
}

-(void)setSpellCheckingType:(UITextSpellCheckingType)spellCheckingType {
    
}
-(UITextSpellCheckingType)spellCheckingType {
    return UITextSpellCheckingTypeDefault;
}

-(void)setSmartDashesType:(UITextSmartDashesType)smartDashesType  API_AVAILABLE(ios(11.0)){
    
}

-(UITextSmartDashesType)smartDashesType  API_AVAILABLE(ios(11.0)){
    return UITextSmartDashesTypeDefault;
}
-(void)setSmartQuotesType:(UITextSmartQuotesType)smartQuotesType  API_AVAILABLE(ios(11.0)){
    
}
-(UITextSmartQuotesType)smartQuotesType  API_AVAILABLE(ios(11.0)){
    return UITextSmartQuotesTypeDefault;
}

-(void)setSmartInsertDeleteType:(UITextSmartInsertDeleteType)smartInsertDeleteType  API_AVAILABLE(ios(11.0)){
    
}
-(UITextSmartInsertDeleteType)smartInsertDeleteType  API_AVAILABLE(ios(11.0)){
    return UITextSmartInsertDeleteTypeDefault;
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType {
    
}
-(UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

-(void)setTextContentType:(UITextContentType)textContentType API_AVAILABLE(ios(10.0)){
    
}
-(UITextContentType)textContentType API_AVAILABLE(ios(10.0)){
    if (@available(iOS 11.0, *)) {
        return UITextContentTypePassword;
    }
    return UITextContentTypeTelephoneNumber;
}

-(void)setPasswordRules:(UITextInputPasswordRules *)passwordRules  API_AVAILABLE(ios(12.0)){
    
}
-(UITextInputPasswordRules *)passwordRules  API_AVAILABLE(ios(12.0)){
    return nil;
}



#pragma mark ----  lazy
-(NSMutableString *)inputString {
    if (!_inputString) {
        _inputString = [NSMutableString string];
    }
    return _inputString;
}

-(NSMutableArray<CALayer *> *)inputLayers {
    if (!_inputLayers) {
        _inputLayers = [NSMutableArray array];
    }
    return _inputLayers;
}


-(UIBezierPath *)passwordBoxPath {
    if (!_passwordBoxPath) {
        _passwordBoxPath = [UIBezierPath bezierPath];
       
    }
    return _passwordBoxPath;
}

@end
