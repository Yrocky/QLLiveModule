//
//  ViewController.m
//  Example-OC
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "ViewController.h"
#import <QLLiveModuler/QLLiveModuler.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QLLiveModule * module = [[QLLiveModule alloc] initWithName:@"test"];
    QLLiveComponent * comp = [QLLiveComponent new];
    [module.dataSource addComponent:comp];
}


@end
