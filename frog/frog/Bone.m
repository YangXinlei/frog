//
//  Bone.m
//  Frog
//
//  a simple bone system
//
//  Created by 鑫磊 on 2019/10/26.
//  Copyright © 2019 杨鑫磊. All rights reserved.
//

#import "Bone.h"

@interface Bone ()

@property (nonatomic) UIBezierPath *path;
@property (nonatomic) NSMutableArray<Bone *> *subBonesImpl;
@property (nonatomic) Bone *superBone;

@property (nonatomic) CGPoint endSideJoint;
@property (nonatomic) CGPoint frontSideJoint;

@end

@implementation Bone

- (instancetype)initWithLength:(CGFloat)length {
    if (self = [super init]) {
        _length = length;
        _layer = [CAShapeLayer new];
//        _layer.masksToBounds = NO;
        _layer.anchorPoint = CGPointMake(0.5, 0.0);
        _layer.lineWidth = 2.0;
        _layer.strokeColor = UIColor.redColor.CGColor;
        
        _path = [UIBezierPath bezierPath];
        [_path moveToPoint:CGPointZero];
        [_path addLineToPoint:CGPointMake(0.0, length)];
        _layer.path = _path.CGPath;
//        _layer.frame = CGRectMake(0, 0, 2, length);
        _subBonesImpl = [NSMutableArray array];
    }
    return self;
}

- (void)attatchToBone:(Bone *)bone withMinJointAngle:(CGFloat)minAngle maxJointAngle:(CGFloat)maxAngle {
    [bone.subBonesImpl addObject:self];
    self.superBone = bone;
    [bone.layer addSublayer:self.layer];
    self.layer.position = CGPointMake(bone.layer.bounds.size.width / 2.0, bone.layer.bounds.size.height);
    self.layer.transform = CATransform3DMakeRotation(minAngle, 0, 0, 1);
}

- (NSArray<Bone *> *)subBones {
    return [self.subBonesImpl copy];
}

@end
