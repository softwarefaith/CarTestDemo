//
//  VCThree.m
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "VCThree.h"

@interface VCThree ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tableViews;

@end

@implementation VCThree
- (void)dealloc {
    NSLog(@"%s",__func__);
}



- (NSArray<NSString *> *)subPageItemsTagList {
    
    return @[@"Three00",@"Three002",@"Three003",@"Three004"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numbersOfTabeView {
    
    return 4;
}

- (UITableView *)tableViewsAtIndex:(NSInteger)index frame:(CGRect)frame{
    
    UITableView *tableView = [self.tableViews objectAtIndex:index];
    tableView.frame = frame;
    return tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.view.backgroundColor = [UIColor orangeColor];
    self.tableViews = [NSMutableArray arrayWithCapacity:3];

    for (int i = 0; i < 4; ++i) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = i;
        
        if (@available(iOS 11.0, *)) {
            if (tableView) {
                tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        
        
        [self.tableViews addObject:tableView];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger pageIndex = tableView.tag;
    
    
    switch (pageIndex) {
        case 0:
            return 3;
            break;
        case 1:{
            return 20;
        }
        case 2:{
            return 40;
        }
        
            
        default:
            break;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSUInteger pageIndex = tableView.tag;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =
    [NSString stringWithFormat:@"%@---%ld -- %ld",NSStringFromClass([self class]),(long)tableView.tag,(long)indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
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
