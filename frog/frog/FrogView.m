//
//  FrogView.m
//  Frog
//
//  Created by 鑫磊 on 2019/10/24.
//  Copyright © 2019 杨鑫磊. All rights reserved.
//

#import "FrogView.h"
#import "Bone.h"

@interface FrogView ()

@property (nonatomic) UIBezierPath *path;

@property (nonatomic) Bone *topSpine;

@end

@implementation FrogView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width, height = frame.size.height;
        CGPoint center = CGPointMake(width / 2, height / 2);
        CGRect bounds = CGRectMake(0, 0, width, height);
        
        _path = [UIBezierPath new];
        /// body
        CGRect bodyRect = CGRectInset(bounds, width / 4, height / 4);
        [_path appendPath:[UIBezierPath bezierPathWithOvalInRect:bodyRect]];
        
//        /// left arm
//        CGPoint leftArmJoint0Point = CGPointMake(center.x, center.y / 2 + center.y / 4);
//        CGPoint leftArmJoint1Point = CGPointMake(0 + width / 8,center.y / 2 + center.y / 4);
//        CGPoint leftArmJoint2Point = CGPointMake(leftArmJoint1Point.x - width / 16, leftArmJoint1Point.y - height / 16);
//        [_path moveToPoint:leftArmJoint0Point];
//        [_path addLineToPoint:leftArmJoint1Point];
//        [_path addLineToPoint:leftArmJoint2Point];
//
//        CGPoint leftHandFinger0Point = CGPointMake(leftArmJoint2Point.x - width / 16, leftArmJoint2Point.y);
//        CGPoint leftHandFinger1Point = CGPointMake(leftArmJoint2Point.x - width / 16, leftArmJoint2Point.y - height / 16);
//        CGPoint leftHandFinger2Point = CGPointMake(leftArmJoint2Point.x, leftArmJoint2Point.y - height / 16);
//        [_path addLineToPoint:leftHandFinger0Point];
//        [_path moveToPoint:leftArmJoint2Point];
//        [_path addLineToPoint:leftHandFinger1Point];
//        [_path moveToPoint:leftArmJoint2Point];
//        [_path addLineToPoint:leftHandFinger2Point];
//        [_path moveToPoint:leftArmJoint2Point];
        
        
        CAShapeLayer *mainLayer = (CAShapeLayer *)self.layer;
        mainLayer.strokeColor = UIColor.greenColor.CGColor;
        mainLayer.lineWidth = 2;
        mainLayer.path = _path.CGPath;
        
        Bone *rightBone0 = [[Bone alloc] initWithLength:bodyRect.size.width / 2];
        Bone *rightBone1 = [[Bone alloc] initWithLength:30];
        Bone *rightBone2 = [[Bone alloc] initWithLength:20];
        
        _topSpine = [[Bone alloc] initWithLength:bodyRect.size.height / 4];
        _topSpine.layer.position = CGPointMake(CGRectGetMidX(bodyRect), CGRectGetMinY(bodyRect));
        [self.layer addSublayer:_topSpine.layer];
        [rightBone0 attatchToBone:_topSpine withMinJointAngle:-M_PI_2 maxJointAngle:-M_PI_2];
        
        [rightBone1 attatchToBone:rightBone0 withMinJointAngle:0 maxJointAngle:-M_PI_4];
        [rightBone2 attatchToBone:rightBone1 withMinJointAngle:0 maxJointAngle:-(M_PI_2 + M_PI_4)];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"abc");
    
    [self.topSpine animateToFinalPostion];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
