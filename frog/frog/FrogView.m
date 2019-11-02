//
//  FrogView.m
//  Frog
//
//  Created by 鑫磊 on 2019/10/24.
//  Copyright © 2019 杨鑫磊. All rights reserved.
//

#import "FrogView.h"
#import "Bone.h"

@interface FrogAnimateKeyFrame : NSObject

@property (nonatomic) CGFloat rightBigArm;
@property (nonatomic) CGFloat rightSmallArm;
@property (nonatomic) CGFloat rightHandFinger0;
@property (nonatomic) CGFloat rightHandFinger1;
@property (nonatomic) CGFloat rightHandFinger2;

@property (nonatomic) CGFloat leftBigArm;
@property (nonatomic) CGFloat leftSmallArm;
@property (nonatomic) CGFloat leftHandFinger0;
@property (nonatomic) CGFloat leftHandFinger1;
@property (nonatomic) CGFloat leftHandFinger2;

@property (nonatomic) CGFloat rightBigLeg;
@property (nonatomic) CGFloat rightSmallLeg;
@property (nonatomic) CGFloat rightFootFinger0;
@property (nonatomic) CGFloat rightFootFinger1;
@property (nonatomic) CGFloat rightFootFinger2;

@property (nonatomic) CGFloat leftBigLeg;
@property (nonatomic) CGFloat leftSmallLeg;
@property (nonatomic) CGFloat leftFootFinger0;
@property (nonatomic) CGFloat leftFootFinger1;
@property (nonatomic) CGFloat leftFootFinger2;

@end

@implementation FrogAnimateKeyFrame

- (NSArray *)topSpineKeyFrame {
    return @[@(0), @[@(0), @[@(_rightBigArm), @[@(_rightSmallArm), @[@(_rightHandFinger0), @(_rightHandFinger1), @(_rightHandFinger2)]]],
                  @[@(_leftBigArm), @[@(_leftSmallArm), @[@(_leftHandFinger0), @(_leftHandFinger1), @(_leftHandFinger2)]]],
           ]
    ];
}

- (NSArray *)bottomSpineKeyFrame {
    return @[];
}

@end

@interface FrogView ()

@property (nonatomic) UIBezierPath *path;

@property (nonatomic) Bone *topSpine;
@property (nonatomic) Bone *bottomSpine;

@end

@implementation FrogView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    CGFloat width = frame.size.width, height = frame.size.height;
    CGFloat length = MIN(width, height);
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, length, length)]) {
        CGFloat radius = length / 2;
        CGPoint center = CGPointMake(radius, radius);
        CGRect bounds = CGRectMake(0, 0, length, length);
        
        _path = [UIBezierPath new];
        /// body
        CGFloat bodyRadius = radius / 2;
        CGRect bodyRect = CGRectInset(bounds, bodyRadius, bodyRadius);
        [_path appendPath:[UIBezierPath bezierPathWithOvalInRect:bodyRect]];
        
        
        CAShapeLayer *mainLayer = (CAShapeLayer *)self.layer;
        mainLayer.strokeColor = UIColor.greenColor.CGColor;
        mainLayer.fillColor = UIColor.greenColor.CGColor;
        mainLayer.lineWidth = 2;
        mainLayer.path = _path.CGPath;
        
        _topSpine = [[Bone alloc] initWithLength:bodyRadius / 2];
        _topSpine.layer.position = CGPointMake(CGRectGetMidX(bodyRect), CGRectGetMinY(bodyRect));
        [self.layer addSublayer:_topSpine.layer];
        
        Bone *rightShoulder = [[Bone alloc] initWithLength:({
            CGFloat topSpineEndToCenter = bodyRadius - _topSpine.length;
            sqrt(bodyRadius * bodyRadius - topSpineEndToCenter * topSpineEndToCenter);
        })];
        Bone *rightBigArm = [[Bone alloc] initWithLength:bodyRadius color:UIColor.greenColor];
        Bone *rightSmallArm = [[Bone alloc] initWithLength:rightBigArm.length * 0.65 color:UIColor.greenColor];
        [rightShoulder attatchToBone:_topSpine withMinJointAngle:-M_PI_2 maxJointAngle:-M_PI_2];
        [rightBigArm attatchToBone:rightShoulder withMinJointAngle:0 maxJointAngle:-M_PI_4];
        [rightSmallArm attatchToBone:rightBigArm withMinJointAngle:0 maxJointAngle:-(M_PI_2 + M_PI_4)];
        
        Bone *rightHandFinger0 = [[Bone alloc] initWithLength:rightSmallArm.length * 0.8 color:UIColor.greenColor];
        Bone *rightHandFinger1 = [[Bone alloc] initWithLength:rightSmallArm.length * 0.8 color:UIColor.greenColor];
        Bone *rightHandFinger2 = [[Bone alloc] initWithLength:rightSmallArm.length * 0.8 color:UIColor.greenColor];
        [rightHandFinger0 attatchToBone:rightSmallArm withMinJointAngle:-M_PI_4 * 0.3 maxJointAngle:-M_PI_4];
        [rightHandFinger1 attatchToBone:rightSmallArm withMinJointAngle:0 maxJointAngle:0];
        [rightHandFinger2 attatchToBone:rightSmallArm withMinJointAngle:M_PI_4 * 0.3 maxJointAngle:M_PI_4];
        
        
        Bone *leftShoulder = [[Bone alloc] initWithLength:({
            CGFloat topSpineEndToCenter = bodyRadius - _topSpine.length;
            sqrt(bodyRadius * bodyRadius - topSpineEndToCenter * topSpineEndToCenter);
        })];
        Bone *leftBigArm = [[Bone alloc] initWithLength:bodyRadius color:UIColor.greenColor];
        Bone *leftSmallArm = [[Bone alloc] initWithLength:leftBigArm.length * 0.65 color:UIColor.greenColor];
        [leftShoulder attatchToBone:_topSpine withMinJointAngle:M_PI_2 maxJointAngle:M_PI_2];
        [leftBigArm attatchToBone:leftShoulder withMinJointAngle:0 maxJointAngle:M_PI_4];
        [leftSmallArm attatchToBone:leftBigArm withMinJointAngle:0 maxJointAngle:(M_PI_2 + M_PI_4)];
        
        Bone *leftHandFinger0 = [[Bone alloc] initWithLength:leftSmallArm.length * 0.8 color:UIColor.greenColor];
        Bone *leftHandFinger1 = [[Bone alloc] initWithLength:leftSmallArm.length * 0.8 color:UIColor.greenColor];
        Bone *leftHandFinger2 = [[Bone alloc] initWithLength:leftSmallArm.length * 0.8 color:UIColor.greenColor];
        [leftHandFinger0 attatchToBone:leftSmallArm withMinJointAngle:M_PI_4 * 0.3 maxJointAngle:M_PI_4];
        [leftHandFinger1 attatchToBone:leftSmallArm withMinJointAngle:0 maxJointAngle:0];
        [leftHandFinger2 attatchToBone:leftSmallArm withMinJointAngle:-M_PI_4 * 0.3 maxJointAngle:-M_PI_4];
        
        
        _bottomSpine = [[Bone alloc] initWithLength:bodyRadius / 2];
        _bottomSpine.layer.position = center;
        [self.layer addSublayer:_bottomSpine.layer];
        
        Bone *rightHipbone = [[Bone alloc] initWithLength:({
            CGFloat topSpineEndToCenter = bodyRadius - _topSpine.length;
            sqrt(bodyRadius * bodyRadius - topSpineEndToCenter * topSpineEndToCenter);
        })];
        Bone *rightBigLeg = [[Bone alloc] initWithLength:bodyRadius * 1.2 color:UIColor.greenColor];
        Bone *rightSmallLeg = [[Bone alloc] initWithLength:rightBigLeg.length * 0.7 color:UIColor.greenColor];
        [rightHipbone attatchToBone:_bottomSpine withMinJointAngle:-M_PI_2 maxJointAngle:-M_PI_2];
        [rightBigLeg attatchToBone:rightHipbone withMinJointAngle:0 maxJointAngle:M_PI_4];
        [rightSmallLeg attatchToBone:rightBigLeg withMinJointAngle:0 maxJointAngle:(M_PI_2 + M_PI_4)];

        Bone *rightFootFinger0 = [[Bone alloc] initWithLength:rightSmallLeg.length * 0.6 color:UIColor.greenColor];
        Bone *rightFootFinger1 = [[Bone alloc] initWithLength:rightSmallLeg.length * 0.6 color:UIColor.greenColor];
        Bone *rightFootFinger2 = [[Bone alloc] initWithLength:rightSmallLeg.length * 0.6 color:UIColor.greenColor];
        [rightFootFinger0 attatchToBone:rightSmallLeg withMinJointAngle:-M_PI_4 maxJointAngle:-M_PI_2 - M_PI_4];
        [rightFootFinger1 attatchToBone:rightSmallLeg withMinJointAngle:-M_PI_4 * 0.5 maxJointAngle:-M_PI_2 - M_PI_4 * 0.5];
        [rightFootFinger2 attatchToBone:rightSmallLeg withMinJointAngle:0 maxJointAngle:-M_PI_2];
        
        
        Bone *leftHipbone = [[Bone alloc] initWithLength:({
            CGFloat topSpineEndToCenter = bodyRadius - _topSpine.length;
            sqrt(bodyRadius * bodyRadius - topSpineEndToCenter * topSpineEndToCenter);
        })];
        Bone *leftBigLeg = [[Bone alloc] initWithLength:bodyRadius * 1.2 color:UIColor.greenColor];
        Bone *leftSmallLeg = [[Bone alloc] initWithLength:leftBigLeg.length * 0.7 color:UIColor.greenColor];
        [leftHipbone attatchToBone:_bottomSpine withMinJointAngle:M_PI_2 maxJointAngle:M_PI_2];
        [leftBigLeg attatchToBone:leftHipbone withMinJointAngle:0 maxJointAngle:-M_PI_4];
        [leftSmallLeg attatchToBone:leftBigLeg withMinJointAngle:0 maxJointAngle:-(M_PI_2 + M_PI_4)];

        Bone *leftFootFinger0 = [[Bone alloc] initWithLength:leftSmallLeg.length * 0.6 color:UIColor.greenColor];
        Bone *leftFootFinger1 = [[Bone alloc] initWithLength:leftSmallLeg.length * 0.6 color:UIColor.greenColor];
        Bone *leftFootFinger2 = [[Bone alloc] initWithLength:leftSmallLeg.length * 0.6 color:UIColor.greenColor];
        [leftFootFinger0 attatchToBone:leftSmallLeg withMinJointAngle:M_PI_4 maxJointAngle:M_PI_2 + M_PI_4];
        [leftFootFinger1 attatchToBone:leftSmallLeg withMinJointAngle:M_PI_4 * 0.5 maxJointAngle:M_PI_2 + M_PI_4 * 0.5];
        [leftFootFinger2 attatchToBone:leftSmallLeg withMinJointAngle:0 maxJointAngle:M_PI_2];
        
    }
    return self;
}

- (FrogAnimateKeyFrame *)straightForwardArmKeyFrame {
    FrogAnimateKeyFrame *frame = [FrogAnimateKeyFrame new];
    frame.rightBigArm = 1.0;
    frame.rightSmallArm = 0.5;
    frame.rightHandFinger0 = 1.0;
    frame.rightHandFinger1 = 1.0;
    frame.rightHandFinger2 = 1.0;
    
    frame.leftBigArm = 1.0;
    frame.leftSmallArm = 0.5;
    frame.leftHandFinger0 = 1.0;
    frame.leftHandFinger1 = 1.0;
    frame.leftHandFinger2 = 1.0;
    return frame;
}
    

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"abc");
    
    [self.topSpine animateToKeyFrame:[[self straightForwardArmKeyFrame] topSpineKeyFrame]];
    [self.bottomSpine animateToFinalPostion];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
