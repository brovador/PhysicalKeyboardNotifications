//
//  UIApplication+KeyboardCommands.m
//  KeyboardCommands
//
//  Created by Jesús on 07/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import <JRSwizzle/JRSwizzle.h>
#import "UIApplication+PKN.h"
#import "PKNDefines.h"
#import "PKNCommandsManager.h"

#if TARGET_IPHONE_SIMULATOR

#define GSEVENT_TYPE 2
#define GSEVENT_FLAGS 12
#define GSEVENT_TYPE_KEYDOWN 10

@interface UIEvent ()
- (int *)_gsEvent;
@end

@interface UIInternalEvent : UIEvent
@end

@interface UIPhysicalButtonsEvent : UIInternalEvent
@end

@interface UIPhysicalKeyboardEvent : UIPhysicalButtonsEvent
@property (nonatomic, readonly) long _keyCode;
@property (nonatomic, assign) int _modifierFlags;
@property (nonatomic, strong) NSString *_unmodifiedInput;
@property (nonatomic, readonly) BOOL _isKeyDown;
@end

@implementation UIApplication (PKN)

+ (void)load
{
    [self jr_swizzleMethod:@selector(sendEvent:) withMethod:@selector(PKN_sendEvent:) error:NULL];
    [self jr_swizzleMethod:@selector(handleKeyUIEvent:) withMethod:@selector(PKN_handleKeyUIEvent:) error:NULL];
}

- (void)PKN_handleKeyUIEvent:(UIPhysicalKeyboardEvent*)event
{
    [self PKN_handleKeyUIEvent:event];
    if (event._isKeyDown) {
        [[PKNCommandsManager sharedManager] handleKeyDown:(PKNKeyInputCode)event._keyCode withEventFlags:(PKNEventFlags)event._modifierFlags];
    } else {
        [[PKNCommandsManager sharedManager] handleKeyUp:(PKNKeyInputCode)event._keyCode withEventFlags:(PKNEventFlags)event._modifierFlags];
    }
}

- (void)PKN_sendEvent:(UIEvent*)event
{
    [self PKN_sendEvent:event];
    
    if (![event respondsToSelector:@selector(_gsEvent)]) return;
    
    int *eventMemory = [event _gsEvent];
    if (!eventMemory) return;
    
    int eventType = eventMemory[GSEVENT_TYPE];
    if (eventType != GSEVENT_TYPE_KEYDOWN) return;
    
    int eventFlags = eventMemory[GSEVENT_FLAGS];
    int tmp = eventMemory[15];
    UniChar *keycode = (UniChar *)&tmp;
    
    [[PKNCommandsManager sharedManager] handleKeyDown:(PKNKeyInputCode)*keycode withEventFlags:(PKNEventFlags)eventFlags];
    
}

@end

#endif
