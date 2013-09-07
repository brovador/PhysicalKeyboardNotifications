//
//  PKNViewController.m
//  KeyboardCommands
//
//  Created by Jesús on 07/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import "PhysicalKeyboardNotifications.h"
#import "ViewController.h"

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardKeyDownNotification:) name:PKNKeyDownNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardKeyUpNotification:) name:PKNKeyUpNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Private

- (void)_showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test"
                                                    message:@"This is a test alert"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)_showLabelWithText:(NSString*)text
{
    UILabel *lb = [[UILabel alloc] initWithFrame:self.view.bounds];
    [lb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:60]];
    [lb setText:text];
    [lb setTextAlignment:NSTextAlignmentCenter];
    [lb setBackgroundColor:[UIColor clearColor]];
    [[UIApplication sharedApplication].keyWindow addSubview:lb];
    [UIView animateWithDuration:0.3f animations:^{
        [lb setTransform:CGAffineTransformMakeScale(3.f, 3.f)];
        [lb setAlpha:0.f];
    } completion:^(BOOL finished) {
        [lb removeFromSuperview];
    }];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert closed by cliking: %d", buttonIndex);
}

#pragma mark Notifications

- (void)onKeyboardKeyDownNotification:(NSNotification*)notification
{
    NSString *keyChar = notification.userInfo[PKNKeyInputCharNotificationUserInfoKey];
    [self _showLabelWithText:keyChar];
    
    if ([keyChar isEqualToString:@"m"] && !self.presentedViewController) {
        [self performSegueWithIdentifier:@"showModal" sender:nil];
    } else if ([keyChar isEqualToString:@"a"]) {
        [self _showAlert];
    }
}

- (void)onKeyboardKeyUpNotification:(NSNotification*)notification
{
    PKNKeyInputCode keyCode = [notification.userInfo[PKNKeyInputCodeNotificationUserInfoKey] shortValue];
    NSString *keyChar = notification.userInfo[PKNKeyInputCharNotificationUserInfoKey];
    NSLog(@"KEY UP: %hd, CHAR: %@", keyCode, keyChar);
}

@end
