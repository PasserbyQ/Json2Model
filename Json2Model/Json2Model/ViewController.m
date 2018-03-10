//
//  ViewController.m
//  Json2Model
//
//  Created by PasserbyQ on 2018/3/10.
//  Copyright © 2018年 PasserbyQ. All rights reserved.
//

#import "ViewController.h"
#import "Man.h"
#import "NSObject+QYModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Man *man = [Man json2Model:@{@"name":@"12312",@"sex":@"F",@"age":@"12"}];
    NSLog(@"%@_%d_%@",man.name,man.age,man.sex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
