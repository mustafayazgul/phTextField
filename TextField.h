//
//  TextField.h
//  tf
//
//  Created by Mustafa Yazgülü on 26/01/2017.
//  Copyright © 2017 Mustafa Yazgülü. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TFieldDelegate <NSObject>
@optional
- (void)textFieldDidDelete:(UITextField *)textField;
@end

@interface TextField : UITextField<UIKeyInput>
@property (nonatomic, assign) id<TFieldDelegate> tfDelegate;
@end
