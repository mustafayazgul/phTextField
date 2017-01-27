//
//  PHTextField.m
//  tf
//
//  Created by Mustafa Yazgülü on 26/01/2017.
//  Copyright © 2017 Mustafa Yazgülü. All rights reserved.
//

#import "PHTextField.h"

@interface PHTextField();

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *lblPlaceHolder;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *dropDownImageView;
@property BOOL isCreateIconImage;
@property BOOL isTextFieldRounded;
@property CGFloat textFieldCornerRadius;
@property UIColor *textFieldBorderColor;
@property UIColor *bottomBorderColor;
@property UIImage *textFieldIConImage;
@property UIImage *dropDownImage;
@property NSString *textFieldPlaceHolder;
@property (nonatomic, strong) NSString *text;
@property NSString *textFieldFontName;
@property CGFloat textFieldFontSize;
@property UIColor *textFieldFontColor;

@end

@implementation PHTextField

@synthesize textFieldDelagate, phTextFieldDelegate;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _textFieldFontName = nil;
        _textFieldFontSize = 0;
        _textFieldFontColor = [UIColor darkGrayColor];
        _textField = [[UITextField alloc] init];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _textFieldFontName = nil;
        _textFieldFontSize = 0;
        _textFieldFontColor = [UIColor darkGrayColor];
        _textField = [[UITextField alloc] init];
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.textFieldDelagate textFieldShouldBeginEditing:textField];
    }
    else
        return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.textFieldDelagate textFieldDidBeginEditing:textField];
    }
    
    if (self.textField && [self.phTextFieldDelegate respondsToSelector:@selector(PHTextFieldDidBeginEditing:)]) {
        [self.phTextFieldDelegate PHTextFieldDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.textFieldDelagate && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.textFieldDelagate textFieldShouldEndEditing:textField];
    }
    else
        return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.textField && [self.textFieldDelagate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.textFieldDelagate textFieldDidEndEditing:textField];
    }
    
    [self locatePlaceHolderToMiddle];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    /*if (self.textField && [self.textFieldDelagate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
     return [self.textFieldDelagate textField:textField shouldChangeCharactersInRange:range replacementString:string];
     }
     */

    if ([self getText].length == 1 && string.length == 0)
        [self locatePlaceHolderToMiddle];
    
    if (self.textField && [self.phTextFieldDelegate respondsToSelector:@selector(PHTextField:tf:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.phTextFieldDelegate PHTextField:self tf:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    else
        return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (self.textField && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.textFieldDelagate textFieldShouldClear:textField];
    }
    else
        return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (self.textField && [self.textFieldDelagate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.textFieldDelagate textFieldShouldReturn:textField];
    }
    else
        return YES;
}

-(void)textInAction
{
    if (self.textField && [self.phTextFieldDelegate respondsToSelector:@selector(PHTextFieldTextInAction: tf:)]) {
        [self.phTextFieldDelegate PHTextFieldTextInAction:self tf:_textField];
    }
    
    if ([self getText].length > 0) //eger text varsa place holderda degisme olmayacak direk cik
        return;
    
    if (_lblPlaceHolder == nil)
        return;
    
    if (_textFieldPlaceHolder.length <= 0)
        return;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _lblPlaceHolder.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        CGRect frame = CGRectMake(0, -8, _lblPlaceHolder.frame.size.width, _textField.frame.size.height * 0.3);
        _lblPlaceHolder.frame = frame;
    } completion:^(BOOL finished) {

    }];
}

-(void)locatePlaceHolderToMiddle
{
    if ([self getText].length > 0) //eger text varsa place holderda degisme olmayacak direk cik
        return;
    
    if (_lblPlaceHolder == nil)
        return;
    
    if (_textFieldPlaceHolder.length <= 0)
        return;

    [UIView animateWithDuration:0.25 animations:^{
        _lblPlaceHolder.transform = CGAffineTransformMakeScale(1, 1);
        CGRect frame = CGRectMake(0, _textField.frame.origin.y, _lblPlaceHolder.frame.size.width, _textField.frame.size.height);
        _lblPlaceHolder.frame = frame;
    }];
}

- (void)initWithProperties:(BOOL)isCreateIconImage isTextFieldRounded:(BOOL)isTextFieldRounded textFieldCornerRadius:(CGFloat)textFieldCornerRadius textFieldBorderColor:(UIColor *)textFieldBorderColor textFieldIConImage:(UIImage *)textFieldIConImage textFieldPlaceHolder:(NSString *)textFieldPlaceHolder dropDownImage:(UIImage *)dropDownImage {
    
    _isCreateIconImage = isCreateIconImage;
    _isTextFieldRounded = isTextFieldRounded;
    _textFieldCornerRadius = textFieldCornerRadius;
    _textFieldBorderColor = textFieldBorderColor;
    _textFieldIConImage = textFieldIConImage;
    _textFieldPlaceHolder = textFieldPlaceHolder;
    _dropDownImage = dropDownImage;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.borderColor = _textFieldBorderColor.CGColor;
    if (_isTextFieldRounded) {
        
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = _textFieldCornerRadius;
        self.layer.masksToBounds = YES;
    }
    
    [self setNeedsDisplay];
}

-(void)setTextFieldsFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andFontColor:(UIColor *)fontColor
{
    _textFieldFontName = fontName;
    _textFieldFontSize = fontSize;
    _textFieldFontColor = fontColor;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    
    _textField.borderStyle = UITextBorderStyleNone;
    
    if (_bottomBorderColor == nil)
        _bottomBorderColor = [UIColor clearColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _bottomBorderColor.CGColor);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, height-1)];
    [path addLineToPoint:CGPointMake(width, height-1)];
    
    [_bottomBorderColor setStroke];
    [_bottomBorderColor setFill];
    [path stroke];
    
    CGContextAddPath(context, path.CGPath);
    [path fill];
    
    if (_isCreateIconImage) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(8, (height / 2) - ((height * 0.4) / 2), height * 0.4, height * 0.4);
        _iconImageView.image = self.textFieldIConImage;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImageView];
        
        _textField.frame = CGRectMake((height * 0.4) + 16, (height / 2) - ((height * 0.9) / 2), width * 0.9, height * 0.9);
    }
    else {
        _textField.frame = CGRectMake(0, (height / 2) - ((height * 0.9) / 2), width, height * 0.9);
        //_textField.frame = CGRectMake((width / 2) - ((width * 0.9) / 2), (height / 2) - ((height * 0.9) / 2), width * 0.9, height * 0.9);
    }
    
    if (_isDropDown) {
        
        CGFloat carpan;
        if (_dropDownImage == nil) {
            _dropDownImage = [UIImage imageNamed:@"arrowdown"];
            carpan = 2;
        }
        else
            carpan = 1;
        
        CGFloat valWidth;
        CGFloat valHeight;
        
        /*if ([[Utilities sharedUtilities] devType] == kDeviceTypeIphone6p) {
            
            valWidth = _dropDownImage.size.width * carpan;
            valHeight = _dropDownImage.size.height * carpan;
            
        }
        else*/ {
            
            //if (carpan == 1)
            //    carpan = 1;
            //else
            carpan = 0.7;
            
            valWidth = _dropDownImage.size.width * carpan;
            valHeight = _dropDownImage.size.height * carpan;
        }
        
        _textField.frame = CGRectMake(_textField.frame.origin.x, _textField.frame.origin.y, _textField.frame.size.width - 16 - valWidth, _textField.frame.size.height);
        
        _dropDownImageView = [[UIImageView alloc] init];
        _dropDownImageView.frame = CGRectMake(_textField.frame.origin.x + _textField.frame.size.width, (height / 2) - (valHeight / 2), valWidth, valHeight);
        _dropDownImageView.image = _dropDownImage;
        _dropDownImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_dropDownImageView];
        
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textInAction)];
        _dropDownImageView.userInteractionEnabled = YES;
        [_dropDownImageView addGestureRecognizer:tapGr];
    }
    
    if (_textFieldPlaceHolder) {
        _lblPlaceHolder = [[UILabel alloc] initWithFrame:_textField.frame];
        _lblPlaceHolder.text = _textFieldPlaceHolder;
    }
    
    if (_textFieldFontName)
        _lblPlaceHolder.font = [UIFont fontWithName:_textFieldFontName size:_textFieldFontSize];
    
    if (_textFieldPlaceHolder || _textFieldBorderColor)
        _lblPlaceHolder.textColor = _textFieldBorderColor;
        
    if (_textFieldFontSize == 0)
        _textFieldFontSize = _textField.font.pointSize;
    
    if (_textFieldFontName != nil)
        _textField.font = [UIFont fontWithName:_textFieldFontName size:_textFieldFontSize];
    else
        _textField.font = [UIFont systemFontOfSize:_textFieldFontSize];
    
    [_textField setTextColor:_textFieldFontColor];
    
    if (_isKeyboardReturnKeyShouldDone)
        [_textField setReturnKeyType:UIReturnKeyDone];
    
    [_textField setSecureTextEntry:_isSecureKeyboard];
    
    if (_keyboardType)
        _textField.keyboardType = _keyboardType;
    
    @try {
        if (_text)
            _textField.text = _text;
    } @catch (NSException *exception) {
        _textField.text = @"";
    }
    
    if (_lblPlaceHolder)
        [self addSubview:_lblPlaceHolder];
    
    [self addSubview:_textField];
    
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textInAction) forControlEvents:UIControlEventEditingDidBegin];
}

-(void)hideKeyboard
{
    [_textField resignFirstResponder];
}

-(void)setTextCustom:(NSString *)text
{
    _text = text;
    [self setNeedsDisplay];
}

-(NSString *)getText
{
    return _textField.text;
}

-(void)setBorderColor:(UIColor *)color
{
    _bottomBorderColor = color;
    [self setNeedsDisplay];
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (_textField == nil)
        return;
    
    [_textField addTarget:target action:action forControlEvents:controlEvents];
}


@end
