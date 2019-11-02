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

//@property (nonatomic) UIBezierPath *path;
@property (nonatomic) NSMutableArray<Bone *> *subBonesImpl;
@property (nonatomic) Bone *superBone;

@property (nonatomic) CGPoint endSideJoint;
@property (nonatomic) CGPoint frontSideJoint;

@property (nonatomic) CGFloat minAngle;
@property (nonatomic) CGFloat maxAngle;

@end

@implementation Bone

static CGFloat const kBoneWidth = 2;
- (instancetype)initWithLength:(CGFloat)length {
    return [self initWithLength:length color:UIColor.clearColor];
}

- (instancetype)initWithLength:(CGFloat)length color:(UIColor *)color {
    if (self = [super init]) {
        _length = length;
        _layer = [CALayer new];
        _layer.bounds = CGRectMake(0.0, 0.0, kBoneWidth, length);
        _layer.backgroundColor = color.CGColor;
//        _layer.masksToBounds = NO;
        _layer.anchorPoint = CGPointMake(0.5, 0.0);
        _subBonesImpl = [NSMutableArray array];
    }
    return self;
}

- (void)attatchToBone:(Bone *)bone withMinJointAngle:(CGFloat)minAngle maxJointAngle:(CGFloat)maxAngle {
    self.minAngle = minAngle;
    self.maxAngle = maxAngle;
    
    [bone.subBonesImpl addObject:self];
    self.superBone = bone;
    [bone.layer addSublayer:self.layer];
    self.layer.position = CGPointMake(bone.layer.bounds.size.width / 2.0, bone.layer.bounds.size.height);
    self.layer.transform = CATransform3DMakeRotation(minAngle, 0, 0, 1);
}

- (void)animateToFinalPostion {
    self.layer.transform = CATransform3DMakeRotation(self.maxAngle, 0, 0, 1);
    [self.subBonesImpl enumerateObjectsUsingBlock:^(Bone * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj animateToFinalPostion];
    }];
}

- (void)animateToKeyFrame:(NSArray *)keyFrameArray {
    self.layer.transform = CATransform3DMakeRotation(self.minAngle + (self.maxAngle - self.minAngle) * [(NSNumber *)keyFrameArray.firstObject doubleValue], 0, 0, 1);
    [self.subBonesImpl enumerateObjectsUsingBlock:^(Bone * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj animateToKeyFrame:(NSArray *)keyFrameArray.lastObject];
    }];
}

- (NSArray<Bone *> *)subBones {
    return [self.subBonesImpl copy];
}

@end
