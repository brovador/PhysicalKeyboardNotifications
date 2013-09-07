//
//  PKNCommandsManager.m
//  KeyboardCommands
//
//  Created by Jesús on 07/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import "PKNCommandsManager.h"

NSString * const PKNKeyDownNotification = @"PKNKeyDownNotification";
NSString * const PKNKeyUpNotification = @"PKNKeyUpNotification";

NSString * const PKNKeyInputCodeNotificationUserInfoKey = @"PKNKeyInputCodeNotificationUserInfoKey";
NSString * const PKNKeyInputCharNotificationUserInfoKey = @"PKNKeyInputCharNotificationUserInfoKey";

@implementation PKNCommandsManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static PKNCommandsManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PKNCommandsManager alloc] init];
    });
    return sharedManager;
}

- (void)handleKeyDown:(PKNKeyInputCode)key withEventFlags:(PKNEventFlags)flags
{
    NSDictionary *userInfo = [self _userInfoForKeyCode:key withFlags:flags];
    [[NSNotificationCenter defaultCenter] postNotificationName:PKNKeyDownNotification object:self userInfo:userInfo];
}

- (void)handleKeyUp:(PKNKeyInputCode)key withEventFlags:(PKNEventFlags)flags
{
    NSDictionary *userInfo = [self _userInfoForKeyCode:key withFlags:flags];
    [[NSNotificationCenter defaultCenter] postNotificationName:PKNKeyUpNotification object:self userInfo:userInfo];
}


#pragma mark Private

- (NSDictionary*)_userInfoForKeyCode:(PKNKeyInputCode)key withFlags:(PKNEventFlags)flags
{
    NSDictionary *userInfo = @{
                               PKNKeyInputCodeNotificationUserInfoKey : @(key),
                               PKNKeyInputCharNotificationUserInfoKey : [self _charFromKeyCode:key]
                               };
    return userInfo;
}

- (NSString*)_charFromKeyCode:(PKNKeyInputCode)code
{
    NSString *chars = @"abcdefghijklmnopqrstuvwxyz";
    NSString *digits = @"1234567890";
    NSString *result = nil;
    
    if (code >= PKN_COMMAND_A && code <= PKN_COMMAND_Z) {
        result = [chars substringWithRange:NSMakeRange(code - PKN_COMMAND_A, 1)];
    } else if (code >= PKN_COMMAND_0 && code <= PKN_COMMAND_9) {
        result = [digits substringWithRange:NSMakeRange(code - PKN_COMMAND_0, 1)];
    } else {
        result = @"";
    }

    return result;
}


@end
