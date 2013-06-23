//
//  MBSwitch.m
//  MBSwitchDemo
//
//  Created by Mathieu Bolard on 22/06/13.
//  Copyright (c) 2013 Mathieu Bolard. All rights reserved.
//

#import "MBSwitch.h"
#import <QuartzCore/QuartzCore.h>


@interface MBSwitch () <UIGestureRecognizerDelegate> {
    CAShapeLayer *_knobLayer;
    CAShapeLayer *_fillLayer;
    CAShapeLayer *_backLayer;
    BOOL _on;
}
@property (nonatomic, assign) BOOL pressed;
- (CGPathRef) newPathForRoundedRect:(CGRect)rect radius:(CGFloat)radius;
- (void) setBackgroundOn:(BOOL)on animated:(BOOL)animated;
- (void) showFillLayer:(BOOL)show animated:(BOOL)animated;
- (CGRect) knobFrameForState:(BOOL)isOn;
@end

@implementation MBSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void) awakeFromNib {
    [self configure];
}

- (void) configure {
    [self setBackgroundColor:[UIColor clearColor]];
    self.onTintColor = [UIColor colorWithRed:0.27f green:0.85f blue:0.37f alpha:1.00f];
    self.offTintColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
    _on = NO;
    _pressed = NO;
    
    
    _backLayer = [[CAShapeLayer layer] retain];
    _backLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _backLayer.frame = self.bounds;
    _backLayer.cornerRadius = self.bounds.size.height/2.0;
    CGPathRef path1 = [self newPathForRoundedRect:_backLayer.bounds radius:_backLayer.bounds.size.height/2.0];
    _backLayer.path = path1;
    CGPathRelease(path1);
    [_backLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isOn"];
    _backLayer.fillColor = [_offTintColor CGColor];
    [self.layer addSublayer:_backLayer];
    
    _fillLayer = [[CAShapeLayer layer] retain];
    _fillLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _fillLayer.frame = CGRectInset(self.bounds, 1.5, 1.5);
    CGPathRef path = [self newPathForRoundedRect:_fillLayer.bounds radius:_fillLayer.bounds.size.height/2.0];
    _fillLayer.path = path;
    CGPathRelease(path);
    [_fillLayer setValue:[NSNumber numberWithBool:YES] forKey:@"isVisible"];
    _fillLayer.fillColor = [[UIColor whiteColor] CGColor];
    [self.layer addSublayer:_fillLayer];
    
    
    _knobLayer = [[CAShapeLayer layer] retain];
    _knobLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _knobLayer.frame = CGRectMake(1.0, 1.0, self.bounds.size.height-2.0, self.bounds.size.height-2.0);
    _knobLayer.cornerRadius = self.bounds.size.height/2.0;
    CGPathRef knobPath = [self newPathForRoundedRect:_knobLayer.bounds radius:_knobLayer.bounds.size.height/2.0];
    _knobLayer.path = knobPath;
    CGPathRelease(knobPath);
    _knobLayer.fillColor = [UIColor whiteColor].CGColor;
    _knobLayer.shadowColor = [UIColor blackColor].CGColor;
    _knobLayer.shadowOffset = CGSizeMake(0.0, 3.0);
    _knobLayer.shadowRadius = 3.0;
    _knobLayer.shadowOpacity = 0.3;
    [self.layer addSublayer:_knobLayer];
    
	UITapGestureRecognizer *tapGestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(tapped:)] autorelease];
	[tapGestureRecognizer setDelegate:self];
	[self addGestureRecognizer:tapGestureRecognizer];
    
	UIPanGestureRecognizer *panGestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(toggleDragged:)] autorelease];
	[panGestureRecognizer setDelegate:self];
	[self addGestureRecognizer:panGestureRecognizer];
}

#pragma mark -
#pragma mark Interaction

- (void)tapped:(UITapGestureRecognizer *)gesture
{	
	if (gesture.state == UIGestureRecognizerStateEnded)
		[self setOn:!self.on animated:YES];
}

- (void)toggleDragged:(UIPanGestureRecognizer *)gesture
{
	CGFloat minToggleX = 1.0;
	CGFloat maxToggleX = self.bounds.size.width-self.bounds.size.height+1.0;
    
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		self.pressed = YES;
	}
	else if (gesture.state == UIGestureRecognizerStateChanged)
	{
		CGPoint translation = [gesture translationInView:self];
        
		[CATransaction setDisableActions:YES];
        
		self.pressed = YES;
        
		CGFloat newX = _knobLayer.frame.origin.x + translation.x;
		if (newX < minToggleX) newX = minToggleX;
		if (newX > maxToggleX) newX = maxToggleX;
		_knobLayer.frame = CGRectMake(newX,
                                            _knobLayer.frame.origin.y,
                                            _knobLayer.frame.size.width,
                                            _knobLayer.frame.size.height);
        
        if (CGRectGetMidX(_knobLayer.frame) > CGRectGetMidX(self.bounds)
            && ![[_backLayer valueForKey:@"isOn"] boolValue]) {
            [self setBackgroundOn:YES animated:YES];
        }else if (CGRectGetMidX(_knobLayer.frame) < CGRectGetMidX(self.bounds)
                  && [[_backLayer valueForKey:@"isOn"] boolValue]){
            [self setBackgroundOn:NO animated:YES];
        }
        
        
		[gesture setTranslation:CGPointZero inView:self];
	}
	else if (gesture.state == UIGestureRecognizerStateEnded)
	{
		CGFloat toggleCenter = CGRectGetMidX(_knobLayer.frame);
        [self setOn:(toggleCenter > CGRectGetMidX(self.bounds)) animated:YES];
        self.pressed = NO;
		
	}
        
	CGPoint locationOfTouch = [gesture locationInView:self];
	if (CGRectContainsPoint(self.bounds, locationOfTouch))
		[self sendActionsForControlEvents:UIControlEventTouchDragInside];
	else
		[self sendActionsForControlEvents:UIControlEventTouchDragOutside];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
	[super touchesBegan:touches withEvent:event];
    
    self.pressed = YES;
	
	[self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
    
    self.pressed = NO;
    
	[self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesCancelled:touches withEvent:event];
    
	[self sendActionsForControlEvents:UIControlEventTouchUpOutside];
}

- (void) setPressed:(BOOL)pressed {
    if (_pressed != pressed
        || ([[_fillLayer valueForKey:@"isVisible"] boolValue] && pressed)) {
        _pressed = pressed;
        
        if (!_on) {
            [self showFillLayer:!_pressed animated:YES];
        }
    }
}

- (void) setBackgroundOn:(BOOL)on animated:(BOOL)animated {
    BOOL isOn = [[_backLayer valueForKey:@"isOn"] boolValue];
    if (on != isOn) {
        if (animated) {
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.2];
            [CATransaction setDisableActions:NO];
            _backLayer.fillColor = on ? _onTintColor.CGColor : _offTintColor.CGColor;
            [_backLayer setValue:[NSNumber numberWithBool:on] forKey:@"isOn"];
            [CATransaction commit];
        }else {
            //[CATransaction setDisableActions:YES];
            _backLayer.fillColor = on ? _onTintColor.CGColor : _offTintColor.CGColor;
            [_backLayer setValue:[NSNumber numberWithBool:on] forKey:@"isOn"];
        }
    }
}

- (void) showFillLayer:(BOOL)show animated:(BOOL)animated {
    BOOL isVisible = [[_fillLayer valueForKey:@"isVisible"] boolValue];
    if (isVisible != show) {
        CGPathRef visiblePath = [self newPathForRoundedRect:_fillLayer.bounds radius:_fillLayer.bounds.size.height/2.0];
        CGPathRef hiddenPath = CGPathCreateWithRect(CGRectMake(_fillLayer.bounds.size.width/2.0, _fillLayer.bounds.size.height/2.0, 0.0, 0.0), NULL);
        [_fillLayer setValue:[NSNumber numberWithBool:show] forKey:@"isVisible"];
        if (animated) {
            CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnim.fromValue = show ? (id)hiddenPath : (id)visiblePath;
            pathAnim.toValue = show ? (id)visiblePath : (id)hiddenPath;
            pathAnim.duration = .22;
            pathAnim.fillMode = kCAFillModeForwards;
            pathAnim.removedOnCompletion = NO;
            [_fillLayer addAnimation:pathAnim forKey:@"animatePath"];
        }else {
            [_fillLayer removeAllAnimations];
            _fillLayer.path = show ? visiblePath : hiddenPath;
        }
        CGPathRelease(visiblePath);
        CGPathRelease(hiddenPath);
    }
}


- (BOOL) isOn {
    return _on;
}

- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    if (_on != on) {
        _on = on;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    if (animated) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.3];
    }
    [CATransaction setDisableActions:!animated];
    [self setBackgroundOn:_on animated:animated];
    _knobLayer.frame = [self knobFrameForState:_on];
    if (animated) {
        [CATransaction commit];
    }
    [self showFillLayer:!_on animated:animated];
}

- (void) setThumbTintColor:(UIColor *)thumbTintColor {
    _knobLayer.fillColor = [thumbTintColor CGColor];
}

- (UIColor *) thumbTintColor {
    return [UIColor colorWithCGColor:_knobLayer.fillColor];
}

- (void) setOnTintColor:(UIColor *)onTintColor {
    _onTintColor = [onTintColor retain];
    if ([[_backLayer valueForKey:@"isOn"] boolValue]) {
        _backLayer.fillColor = [_onTintColor CGColor];
    }
}

- (void) setOffTintColor:(UIColor *)offTintColor {
    _offTintColor = [offTintColor retain];
    if (![[_backLayer valueForKey:@"isOn"] boolValue]) {
        _backLayer.fillColor = [_offTintColor CGColor];
    }
}

- (CGRect) knobFrameForState:(BOOL)isOn {
    return _knobLayer.frame = CGRectMake(isOn ? self.bounds.size.width-self.bounds.size.height+1.0 : 1.0,
                                         1.0,
                                         self.bounds.size.height-2.0,
                                         self.bounds.size.height-2.0);
}

#pragma mark Paths

- (CGPathRef) newPathForRoundedRect:(CGRect)rect radius:(CGFloat)radius
{
	CGMutablePathRef retPath = CGPathCreateMutable();
    
	CGRect innerRect = CGRectInset(rect, radius, radius);
    
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width;
	CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom = rect.origin.y + rect.size.height;
    
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = rect.origin.y;
	CGFloat outside_left = rect.origin.x;
    
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);
    
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);
    
	CGPathCloseSubpath(retPath);
    
	return retPath;
}

- (void) dealloc {
    [_onTintColor release], _onTintColor = nil;
    [_offTintColor release], _offTintColor = nil;
    [_tintColor release], _tintColor = nil;
    
    [_knobLayer release], _knobLayer = nil;
    [_fillLayer release], _fillLayer = nil;
    [_backLayer release], _backLayer = nil;
    [super dealloc];
}

@end
