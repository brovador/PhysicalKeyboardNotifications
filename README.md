PhysicalKeyBoardNotifications
=============================

Posting notifications on iPhone simulator when physical keyboard is pressed. Useful for debugging or playing with the interface
or application logic directly from the keyboard.

Based on the idea from: https://github.com/cloudkite/Commando


Dependencies
============
JRSwizzle - https://github.com/rentzsch/jrswizzle

Usage
=============

Add as observer for PKNKeyUpNotification or PKNKeyDownNotification

<pre>
[[NSNotificationCenter defaultCenter] addObserver:self  
                                                 selector:@selector(onKeyboardKeyDownNotification:)  
                                                     name:PKNKeyDownNotification  
                                                   object:nil];  
                                                   
[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKeyboardKeyDownNotification:)
                                                     name:PKNKeyUpNotification
                                                   object:nil];
</pre>

On notification code, recover from userInfo dictionary the pressed keyValue or a NSString representing the char

<pre>
- (void)onKeyboardKeyUpNotification:(NSNotification*)notification
{
    PKNKeyInputCode keyCode = [notification.userInfo[PKNKeyInputCodeNotificationUserInfoKey] shortValue];
    NSString *keyChar = notification.userInfo[PKNKeyInputCharNotificationUserInfoKey];
    NSLog(@"KEY UP: %hd, CHAR: %@", keyCode, keyChar);
}
</pre>

Special keys as space, return, delete or arrows will return and empty string in the key <code>PKNKeyInputCharNotificationUserInfoKey</code> there are 
several macro defined values to compare their keyCodes in <code>PkNDefines.h</code>



