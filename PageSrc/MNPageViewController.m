//
//  MNPageViewController.m
//  CarTestDemo
//
//  Created by 蔡杰 on 2018/7/8.
//  Copyright © 2018年 AllanCai. All rights reserved.
//

#import "MNPageViewController.h"

#import "MNNestTableView.h"
#import "UIViewController+MNPageExtend.h"

@interface ArtNavView : UIView

@property (nonatomic, strong) UIButton *leftBut;

@end

@implementation ArtNavView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    /*
     * 只是做一个简单示例，要加分割线或其它变化，自行扩展即可
     */
    self.backgroundColor = [UIColor colorWithWhite:1 alpha: 0];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(0, 22, 44, 44);
    UIImage *buttonimage = [UIImage imageNamed:@"barbuttonicon_back"];
    [but setImage:buttonimage forState:UIControlStateNormal];
    but.tintColor = [UIColor colorWithWhite:0 alpha: 1];
    self.leftBut = but;
    [self addSubview:but];
}

- (void)changeAlpha:(CGFloat)alpha {
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha: alpha];
    self.leftBut.tintColor = [UIColor colorWithWhite:(1 - alpha) alpha:1];
}

@end


@interface MNPageViewController ()<MNNestTableViewDelegate, MNNestTableViewDataSource>

@property (nonatomic, strong) ArtNavView *navView;

//头
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) MNNestTableView *nestTableView;
/// 当前显示的页面
@property (nonatomic, strong) UIScrollView *currentScrollView;
@property (nonatomic, strong) UIView *menuView;

@property (nonatomic, strong) UIViewController *currentViewController;

/// 展示控制器的字典
@property (nonatomic, strong) NSMutableDictionary *dispalyMap;
/// 字典控制器的字典
@property (nonatomic, strong) NSMutableDictionary *cacheMap;

//nestTableView上的子视图是否可以滚动
@property (nonatomic, assign) BOOL canContentScroll;

@end

@implementation MNPageViewController


#pragma mark - VC Life
- (void)dealloc {
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configDefaultData];
    }
    return self;
}

- (void)configDefaultData {
    _dispalyMap = @{}.mutableCopy;
    _cacheMap = @{}.mutableCopy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeTop;
    //[self setupNavgationBar];
    [self setupSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receviveScroll:) name:@"com.nestTableView.scroll" object:nil];
    
    [self adjustDisplayCopntentViewByPageIndex];
}



- (void)receviveScroll:(NSNotification *)notify {
    NSDictionary *dic = (NSDictionary *)notify.object;
    
    
    UIViewController *vc = dic[@"VC"];
    if(vc == self.currentViewController) {
        BOOL  scroll = dic[@"scroll"];
        self.nestTableView.canScroll = scroll;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Views
- (void)setupNavgationBar {
    /* 需要设置self.edgesForExtendedLayout = UIRectEdgeNone; 最好自定义导航栏
     * 在代理 - (void)pagingView:(HHHorizontalPagingView *)pagingView scrollTopOffset:(CGFloat)offset
     *做出对应处理来改变 背景色透明度
     */
    self.navView = [[ArtNavView alloc] init];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.navView.frame = CGRectMake(0, 0, size.width, 84);
    [self.view addSubview:self.navView];
    [self.navView.leftBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupSubViews {
    _nestTableView = [[MNNestTableView alloc] initWithFrame:self.view.bounds];
    _nestTableView.headerView = self.headerView;
   
  //  _nestTableView.allowGestureEventPassViews = _viewList;
    _nestTableView.delegate = self;
    _nestTableView.dataSource = self;
    
    [self.view addSubview:_nestTableView];
}

- (void)updateDisplayView:(UIView *)dispalyView {
    _nestTableView.contentView = dispalyView;
}

#pragma mark -Logic



- (void)adjustDisplayCopntentViewByPageIndex{
    if (self.pageIndex == 0) {
        [self initViewControllerWithIndex:self.pageIndex];
    } else {
        [self setSelectedPageIndex:self.pageIndex];
    }
}

#pragma mark -- 初始化子控制器
- (void)initViewControllerWithIndex:(NSInteger)index {
    
   
    self.pageIndex = index;
    NSString *title = [self fetchTitileOfControllerWithIndex:index];
    
    if ([self.dispalyMap objectForKey:title]) return;

    UIViewController *cacheViewController = [self.cacheMap objectForKey:title];
    
  // self.currentViewController = [self fetchViewControllerWithIndex:index];

    
    [self addViewControllerToParent:cacheViewController ?:  [self fetchViewControllerWithIndex:index] index:index];
    
}


- (void)addViewControllerToParent:(UIViewController *)viewController index:(NSInteger)index {
    
    self.currentViewController = viewController;
    [self addChildViewController:viewController];
    
 //   viewController.view.frame = CGRectMake(kYNPAGE_SCREEN_WIDTH * index, 0, self.pageScrollView.yn_width, self.pageScrollView.yn_height);
    
    [self updateDisplayView:viewController.view];
    
    NSString *title = [self fetchTitileOfControllerWithIndex:index];
    
    [self.dispalyMap setObject:viewController forKey:title];
    
    UIScrollView *scrollView = self.currentScrollView;
    scrollView.frame = viewController.view.bounds;
    
    [viewController didMoveToParentViewController:self];
    
   
    /// 缓存控制器
    if (![self.cacheMap objectForKey:title]) {
        [self.cacheMap setObject:viewController forKey:title];
    }
}


- (__kindof UIViewController *)fetchViewControllerWithIndex:(NSInteger)index {

    if ([self checkAgent:self.dataSource respondsToSelector:@selector(pageController:viewControllerAtIndex:) isRequired:YES]) {
      return [self.dataSource pageController:self viewControllerAtIndex:index];
    }
    return nil;
}

- (BOOL)checkAgent:(id)agent  respondsToSelector:(SEL)selector isRequired:(BOOL)require {
    
    if(agent && [agent respondsToSelector:selector]) {
        
        return YES;
    }
    if (require) {
        
        NSString *des = [NSString stringWithFormat:@"you must implementate %@",NSStringFromSelector(selector)];
        NSAssert(require == YES, des);
        return NO;
    }
    return NO;
}


- (NSInteger)maxNumsOfControllers {
    if ([self checkAgent:self.dataSource respondsToSelector:@selector(numbersOfChildControllersInPageController:) isRequired:YES]) {
        return [self.dataSource numbersOfChildControllersInPageController:self];
    }
    return 0;
}

- (NSString *)fetchTitileOfControllerWithIndex:(NSInteger)index {
    
    if ([self checkAgent:self.dataSource respondsToSelector:@selector(pageController:titleAtIndex:) isRequired:YES]) {
        return [self.dataSource pageController:self titleAtIndex:index];
    }
    
    return @"";
}

#pragma mark - Action

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Pubic

#pragma mark - Public Method
- (void)setSelectedPageIndex:(NSInteger)pageIndex {
    
    if (self.cacheMap.count > 0 && pageIndex == self.pageIndex) return;
    
    if (pageIndex > [self maxNumsOfControllers] - 1) return;
    
    [self initViewControllerWithIndex:pageIndex];
    [self removeViewController];

}



/// 移除缓存控制器
- (void)removeViewController {
    for (int i = 0; i < [self maxNumsOfControllers]; i ++) {
        if (i != self.pageIndex) {
            NSString *title = [self fetchTitileOfControllerWithIndex:i];
            if(self.dispalyMap[title]){
                [self removeViewControllerWithChildVC:self.dispalyMap[title] index:i];
            }
        }
    }
}
/// 从父类控制器移除控制器
- (void)removeViewControllerWithChildVC:(UIViewController *)childVC index:(NSInteger)index {
    
    [self removeViewControllerWithChildVC:childVC];
    
    NSString *title = [self fetchTitileOfControllerWithIndex:index];
    
    [self.dispalyMap removeObjectForKey:title];
    
    if (![self.cacheMap objectForKey:title]) {
        [self.cacheMap setObject:childVC forKey:title];
    }
}

/// 子控制器移除自己
- (void)removeViewControllerWithChildVC:(UIViewController *)childVC {
    [childVC.view removeFromSuperview];
    [childVC willMoveToParentViewController:nil];
    [childVC removeFromParentViewController];
}


- (void)addSelfToParentViewController:(UIViewController *)parentViewControler {
    [self addChildViewControllerWithChildVC:self parentVC:parentViewControler];
}

/// 添加子控制器
- (void)addChildViewControllerWithChildVC:(UIViewController *)childVC parentVC:(UIViewController *)parentVC {
    [parentVC addChildViewController:childVC];
    [parentVC didMoveToParentViewController:childVC];
    [parentVC.view addSubview:childVC.view];
}

- (void)removeSelfViewController {
    [self removeViewControllerWithChildVC:self];
}


#pragma mark - Delegate

#pragma mark - MNNestTableViewDelegate & MNNestTableViewDataSource

- (void)nestTableViewContentCanScroll:(MNNestTableView *)nestTableView {
    
    //子容器可以滚动了
    self.canContentScroll = YES;
    
    self.currentViewController.mn_subPageCanScroll = YES;
}

- (void)nestTableViewContainerCanScroll:(MNNestTableView *)nestTableView {
    
    // 当容器开始可以滚动时，将所有内容设置回到顶部
//    for (id view in self.viewList) {
//        UIScrollView *scrollView;
//        if ([view isKindOfClass:[UIScrollView class]]) {
//            scrollView = view;
//        } else if ([view isKindOfClass:[UIWebView class]]) {
//            scrollView = ((UIWebView *)view).scrollView;
//        }
//        if (scrollView) {
//            scrollView.contentOffset = CGPointZero;
//        }
//    }
}

- (void)nestTableViewDidScroll:(UIScrollView *)scrollView {
    
    // 监听容器的滚动，来设置NavigationBar的透明度
//    if (_headerView) {
//        CGFloat offset = scrollView.contentOffset.y;
//        CGFloat canScrollHeight = [_nestTableView heightForContainerCanScroll];
//        MFTransparentNavigationBar *bar = (MFTransparentNavigationBar *)self.navigationController.navigationBar;
//        if ([bar isKindOfClass:[MFTransparentNavigationBar class]]) {
//            [bar setBackgroundAlpha:offset / canScrollHeight];
//        }
//    }
}

- (CGFloat)nestTableViewContentInsetTop:(MNNestTableView *)nestTableView {
    
    // 因为这里navigationBar.translucent == YES，所以实现这个方法，返回下面的值
    
    if (IS_IPHONE_X) {
        return 88;
    } else {
        return 64;
    }
}



#pragma mark - 懒加载

- (UIView *)headerView {
    if (_headerView == nil) {
        
        // 因为将navigationBar设置了透明，所以这里设置将header的高度减少navigationBar的高度，
        // 并将header的subview向上偏移，遮挡navigationBar透明后的空白
        CGFloat offsetTop = [self nestTableViewContentInsetTop:_nestTableView];
    
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetTop, CGRectGetWidth(self.view.frame), 244)];
        
        _headerView.backgroundColor = [UIColor redColor];
        
        self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 199, CGRectGetWidth(_headerView.frame), 44)];
        self.menuView.backgroundColor = [UIColor greenColor];
        for (int i = 0 ; i < 3; i ++ ) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * (CGRectGetWidth(_headerView.frame) / 3) , 0, CGRectGetWidth(_headerView.frame) / 3, 44);
            [button setTitle:[NSString stringWithFormat:@"index-%d",i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 100 + i;
            [self.menuView addSubview:button];
        }
        [_headerView addSubview:self.menuView];
        
    }
    
    return _headerView;
}

- (void)buttonAction:(UIButton *)button {
    
    NSInteger  index  = button.tag - 100;
    [self setSelectedPageIndex:index];
    
    
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
