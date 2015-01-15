//
//  MFIHeadspaceBlobView.m
//  HeadspaceDot
//
//  Created by Marcus Ficner on 14/01/15.
//  Copyright (c) 2015 Marcus Ficner. All rights reserved.
//

#import "MFIHeadspaceBlobView.h"

@interface MFIHeadspaceBlobView () {
    double delta;
}

@end

@implementation MFIHeadspaceBlobView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }

    return self;
}

- (void)setup {
    delta = 0;
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(wobble:)];
    displayLink.frameInterval = 1;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)wobble:(CADisplayLink *)sender {
    double x = sender.timestamp;
    delta = 5*cos(x)*sin(x)+0.7*cos(x)*cos(x)*sin(2*x)*sin(0.5*x)*cos(0.1*x)+cos(0);

    CGAffineTransform rotate = CGAffineTransformMakeRotation(x/8);
    CGAffineTransformScale(rotate, 2*sin(x), 2*cos(x));
    self.layer.affineTransform = rotate;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.color set];

    CGFloat margin = 5.0;

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat halfWidth = (CGFloat) (width/2.0);
    CGFloat halfHeight = (CGFloat) (height/2.0);

    CGFloat controlPointLength = (CGFloat) (30.0+delta);

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(halfWidth, margin+delta)];
    [bezierPath addCurveToPoint:CGPointMake(width-margin+delta, halfHeight) controlPoint1:CGPointMake(halfWidth+controlPointLength, margin+delta) controlPoint2:CGPointMake(width-margin, halfHeight-controlPointLength)];
    [bezierPath addCurveToPoint:CGPointMake(halfWidth, height-margin) controlPoint1:CGPointMake(width-margin, halfHeight+controlPointLength) controlPoint2:CGPointMake(halfWidth+controlPointLength, height-margin)];
    [bezierPath addCurveToPoint:CGPointMake(margin+delta, halfHeight+delta) controlPoint1:CGPointMake(halfWidth-controlPointLength, height-margin) controlPoint2:CGPointMake(margin+delta, halfHeight+controlPointLength)];
    [bezierPath addCurveToPoint:CGPointMake(halfWidth+delta, margin+delta) controlPoint1:CGPointMake(margin+delta, halfHeight) controlPoint2:CGPointMake(halfWidth-controlPointLength, margin+delta)];
    [bezierPath closePath];

    CGContextAddPath(context, bezierPath.CGPath);
    CGContextDrawPath(context, kCGPathFill);
}


@end
