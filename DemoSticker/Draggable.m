//
//  Draggable.m
//  DemoSticker
//
//  Created by vu van long on 11/13/15.
//  Copyright © 2015 FMobileTeam. All rights reserved.
//

#import "Draggable.h"

@implementation Draggable

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginTouchMove" object:nil];
    CGPoint pt = [[touches anyObject] locationInView:self];
    startLocation = pt;
    [[self superview] bringSubviewToFront:self];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // Move relative to the original touch point
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGRect frame = [self frame];
    frame.origin.x += pt.x - startLocation.x;
    frame.origin.y += pt.y - startLocation.y;
    [self setFrame:frame];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndTouchMove" object:nil];
}

@end
