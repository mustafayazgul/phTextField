//
//  PHTextField.h
//  tf
//
//  Created by Mustafa Yazgülü on 26/01/2017.
//  Copyright © 2017 Mustafa Yazgülü. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol textFieldDelagate <UITextFieldDelegate>

@end

@protocol PHTextFieldDelegate <NSObject>

@optional
-(void)PHTextFieldDidBeginEditing:(UIView *)phTextField;
-(void)PHTextFieldTextInAction:(UIView *)phTextField tf:(UITextField *)textField;
-(BOOL)PHTextField:(UIView *)phTextField tf:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end

@interface PHTextField : UIView<UITextFieldDelegate>
{
    __unsafe_unretained id textFieldDelagate;
    __unsafe_unretained id phTextFieldDelegate;
}
@property (nonatomic, assign) id<UITextFieldDelegate> textFieldDelagate;
@property (nonatomic, assign) id<PHTextFieldDelegate> phTextFieldDelegate;

-(void)hideKeyboard;

@property BOOL isKeyboardReturnKeyShouldDone;
@property BOOL isDropDown;
@property BOOL isSecureKeyboard;
@property UIKeyboardType keyboardType;

- (void)initWithProperties:(BOOL)isCreateIconImage isTextFieldRounded:(BOOL)isTextFieldRounded textFieldCornerRadius:(CGFloat)textFieldCornerRadius textFieldBorderColor:(UIColor *)textFieldBorderColor textFieldIConImage:(UIImage *)textFieldIConImage textFieldPlaceHolder:(NSString *)textFieldPlaceHolder dropDownImage:(UIImage *)dropDownImage;
-(void)setTextFieldsFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize andFontColor:(UIColor *)fontColor;

-(NSString *)getText;
-(void)setTextCustom:(NSString *)text;
-(void)setBorderColor:(UIColor *)color;

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
