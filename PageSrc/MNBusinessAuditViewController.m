//
//  MNBusinessAuditViewController.m
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "MNBusinessAuditViewController.h"

@interface MNBusinessAuditViewController ()<MNPageViewControllerDataSource>

@property (nonatomic,strong) NSArray *viewControllerName;

@end

@implementation MNBusinessAuditViewController

- (void)viewDidLoad {
    
    //self.pageIndex = 2;


    self.dataSource = self;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -Delegate
-(NSInteger)numbersOfChildControllersInPageController:(MNPageViewController *)pageController {

    return 3;
    
}

- (UIViewController *)pageController:(MNPageViewController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    NSArray *array = [self viewControllerName];
    
    NSString *className = array[index];
    
    UIViewController *c = [[NSClassFromString(className) alloc] init];
    
    return c;
}

- (NSString *)pageController:(MNPageViewController *)pageController titleAtIndex:(NSInteger)index {
    
    NSArray *array = [self viewControllerName];
    return array[index];
}


- (NSArray *)viewControllerName {
    
    return @[@"VCOne",@"VCTwo",@"VCThree"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
