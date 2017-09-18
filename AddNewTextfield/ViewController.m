//
//  ViewController.m
//  AddNewTextfield
//
//  Created by 胡高广 on 2017/9/18.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import "ViewController.h"
#import "HggButtonAddView.h"

@interface ViewController () <HggButtonAddViewDelegate>

/** 展示数据的Label **/
@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HggButtonAddView *buttonAddView = [[HggButtonAddView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width - 100, 80)];
    buttonAddView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    buttonAddView.delegate = self;
    [self.view addSubview:buttonAddView];
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width - 100, 300)];
    showLabel.text = @"展示数据处";
    showLabel.font = [UIFont systemFontOfSize:14];
    showLabel.textColor = [UIColor blackColor];
    showLabel.numberOfLines = 0;
    showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel];
    self.showLabel = showLabel;

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - <HBButtonAddViewDelegate>

- (void)buttonAddView:(HggButtonAddView *)buttonAddView contents:(NSMutableArray *)contents
{
    NSString *labelTextStr = @"";
    // 循环取出text
    for (NSInteger i = 0; i < contents.count; i++) {
        if (i == 0) {
            labelTextStr = [NSString stringWithFormat:@"第%ld行text:%@", i + 1, contents[i]];
        } else {
            labelTextStr = [NSString stringWithFormat:@"%@\n第%ld行text:%@", labelTextStr, i + 1, contents[i]];
        }
    }
    self.showLabel.text = labelTextStr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
