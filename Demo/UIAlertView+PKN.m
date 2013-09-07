//
//  UIAlertView+PKN.m
//  KeyboardCommands
//
//  Created by Jesús on 07/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import <JRSwizzle/JRSwizzle.h>
#import "UIAlertView+PKN.h"

@implementation UIAlertView (PKN)

+ (void)load
{
    [self jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(PKN_initWithFrame:) error:NULL];
    [self jr_swizzleMethod:@selector(dismissWithClickedButtonIndex:animated:) withMethod:@selector(PKN_dismissWithClickedButtonIndex:animated:) error:NULL];
}

- (id)PKN_initWithFrame:(CGRect)frame
{
    id result = [self PKN_initWithFrame:frame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyBoardDownNotification:) name:PKNKeyDownNotification object:nil];
    return result;
}

- (void)PKN_dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self PKN_dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

#pragma mark Notifications

- (void)onKeyBoardDownNotification:(NSNotification*)notification
{
    PKNKeyInputCode code = [notification.userInfo[PKNKeyInputCodeNotificationUserInfoKey] intValue];
    if (code == PKN_COMMAND_SPACE) {
        [self PKN_dismissWithClickedButtonIndex:0 animated:YES];
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
            [self.delegate alertView:self clickedButtonAtIndex:0];
        }
    }
}

@end
