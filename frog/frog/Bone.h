//
//  Bone.h
//  Frog
//
//  Created by 鑫磊 on 2019/10/26.
//  Copyright © 2019 杨鑫磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Bone : NSObject
@property (nonatomic, readonly) CALayer *layer;
@property (nonatomic, readonly) CGFloat length;
@property (nonatomic, readonly) NSArray<Bone *> *subBones;

- (instancetype)initWithLength:(CGFloat)length;
- (void)attatchToBone:(Bone *)bone withMinJointAngle:(CGFloat)minAngle maxJointAngle:(CGFloat)maxAngle;

- (void)animateToFinalPostion;
@end

NS_ASSUME_NONNULL_END
