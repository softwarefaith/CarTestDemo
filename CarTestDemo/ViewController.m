//
//  ViewController.m
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "ViewController.h"
#import "MNBusinessAuditViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushAudit:(id)sender {
    
    MNBusinessAuditViewController *auditVC =[[MNBusinessAuditViewController alloc] init];
    [self.navigationController pushViewController:auditVC animated:YES];
    

}


@end
