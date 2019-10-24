//
//  FrogView.m
//  Frog
//
//  Created by 鑫磊 on 2019/10/24.
//  Copyright © 2019 杨鑫磊. All rights reserved.
//

#import "FrogView.h"

@interface FrogView ()

@property (nonatomic) UIBezierPath *path;

@end

@implementation FrogView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGPoint center = CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2);
        _path = [UIBezierPath new];
        [_path addArcWithCenter:center radius:CGRectGetWidth(frame) / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        CAShapeLayer *mainLayer = (CAShapeLayer *)self.layer;
        mainLayer.strokeColor = UIColor.greenColor.CGColor;
        mainLayer.lineWidth = 2;
        mainLayer.path = _path.CGPath;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
