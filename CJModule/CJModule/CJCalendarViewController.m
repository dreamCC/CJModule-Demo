
//
//  CJCalendarViewController.m
//  CJModule
//
//  Created by 仁和Mac on 2018/11/19.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJCalendarViewController.h"
#import <FSCalendar.h>
#import <Masonry.h>
#import <YYKit.h>

@interface CJCalendarViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@end

@implementation CJCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
}

-(void)initSubviews {
    [super initSubviews];
    
    
    FSCalendar *calendar = [[FSCalendar alloc] init];
    calendar.delegate = self;
    calendar.dataSource = self;
    
    [self.view addSubview:calendar];
    [calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@400);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            // Fallback on earlier versions
            make.top.equalTo(self.view).offset(64);
        }
    }];
    
    [calendar registerClass:[FSCalendarCell class] forCellReuseIdentifier:@"FSCalendarCell"];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[UIImage imageNamed:@"-hot"] forState:UIControlStateNormal];
    [btn setTitle:@"button" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(calendar.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    QMUIButton *btn1 = [QMUIButton buttonWithType:UIButtonTypeSystem];
    btn1.backgroundColor = [UIColor lightGrayColor];
    btn1.highlightedBackgroundColor = [UIColor darkGrayColor];
    btn1.layer.borderColor = [UIColor greenColor].CGColor;
    btn1.highlightedBorderColor = [UIColor redColor];
    btn1.layer.borderWidth = 2.f;
    btn1.titleLabel.font = UIFontBoldMake(14);
    [btn1 setImage:[UIImage imageNamed:@"-hot"] forState:UIControlStateNormal];
    [btn1 setTitle:@"button" forState:UIControlStateNormal];
    btn1.layer.cornerRadius = 4;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(20);
    }];
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor purpleColor]] forBarMetrics:UIBarMetricsDefault];
}

-(void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"hello";

    

}

-(NSString *)customNavigationBarTransitionKey {
    return @"enha";
}

-(UIColor *)containerViewBackgroundColorWhenTransitioning {
    return [UIColor darkGrayColor];
}

-(UIImage *)navigationBarBackgroundImage {
    return [YYImage imageWithColor:[UIColor purpleColor]];
}

-(UIColor *)titleViewTintColor {
    return [UIColor greenColor];
}

-(FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position {
    FSCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"FSCalendarCell" forDate:date atMonthPosition:position];
    return cell;
}

@end
