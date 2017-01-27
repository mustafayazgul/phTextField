//
//  TextField.m
//  tf
//
//  Created by Mustafa Yazgülü on 26/01/2017.
//  Copyright © 2017 Mustafa Yazgülü. All rights reserved.
//

#import "TextField.h"

@implementation TextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)deleteBackward {
    [super deleteBackward];
    
    if ([_tfDelegate respondsToSelector:@selector(textFieldDidDelete:)]){
        [_tfDelegate textFieldDidDelete:self];
    }
}

@end
