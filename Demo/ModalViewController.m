//
//  PKNModalViewController.m
//  KeyboardCommands
//
//  Created by Jesús on 07/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyDownNotification:) name:PKNKeyDownNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Notifications

- (void)onKeyDownNotification:(NSNotification*)notification
{
    NSString *keyChar = notification.userInfo[PKNKeyInputCharNotificationUserInfoKey];
    if ([keyChar isEqualToString:@"x"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
