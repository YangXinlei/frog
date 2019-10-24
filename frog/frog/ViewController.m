//
//  ViewController.m
//  Frog
//
//  Created by 鑫磊 on 2019/10/24.
//  Copyright © 2019 杨鑫磊. All rights reserved.
//

#import "ViewController.h"
#import "FrogView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:[[FrogView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)]];
}

@end
