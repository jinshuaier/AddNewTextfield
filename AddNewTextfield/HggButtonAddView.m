//
//  HggButtonAddView.m
//  AddNewTextfield
//
//  Created by 胡高广 on 2017/9/18.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import "HggButtonAddView.h"

// 添加按钮的父类view的高度
#define kViewHeight 40
// 添加按钮的宽
#define kAddButtonWidth 25
// 屏幕的宽和高
#define HBScreen_W [UIScreen mainScreen].bounds.size.width
#define HBScreen_H [UIScreen mainScreen].bounds.size.height

@interface HggButtonAddView ()

/** View的个数 **/
@property (nonatomic, assign) NSInteger viewCount;

/** 除去确定按钮,其他view都添加到这个view中 */
@property (nonatomic, strong) UIView *buttonAddBGView;

/** 确定按钮 */
@property (nonatomic, strong) UIButton *sureButton;

@end


@implementation HggButtonAddView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *buttonAddBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kViewHeight)];
        [self addSubview:buttonAddBGView];
        self.buttonAddBGView = buttonAddBGView;
        
        //创建View
        UIView *firstView = [self creatEntiretyViewWithFrame:CGRectMake(0, 0, self.frame.size.width, kViewHeight)];
        [buttonAddBGView addSubview:firstView];
        
        
        // 确定按钮
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake((self.frame.size.width - 80) / 2, CGRectGetMaxY(buttonAddBGView.frame) + 5, 80, 30);
        sureButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureButton];
        self.sureButton = sureButton;
        
        // 默认为1个
        self.viewCount = 0;
    }
    
    return self;
}

//创建一个整体的View
- (UIView *)creatEntiretyViewWithFrame:(CGRect)viewRect
{
    UIView *BGView = [[UIView alloc] initWithFrame:viewRect];
    // 添加按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(10, (kViewHeight - kAddButtonWidth) / 2, kAddButtonWidth, kAddButtonWidth);
    [addButton setImage:[UIImage imageNamed:@"tianjiashuxing"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [BGView addSubview:addButton];
    
    // 文本框
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addButton.frame) + 5, 5, BGView.frame.size.width - CGRectGetMaxX(addButton.frame) - 5 - 10, kViewHeight - 10)];
    textField.placeholder = @"请编辑";
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:14];
    [BGView addSubview:textField];

    return BGView;
}

#pragma mark -- 按钮的点击事件
- (void)addButtonAction:(UIButton *)sender
{
    [self endEditing:YES];
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"shanchushuxing"]]) {
        // 删除那个view
        UIView *superView = sender.superview;
        [superView removeFromSuperview];
        // 删除到最后一个视图
        if (self.buttonAddBGView.subviews.count == 1) {
            UIView *currentView = self.buttonAddBGView.subviews[0];
            currentView.frame = CGRectMake(0, 0, self.buttonAddBGView.frame.size.width, kViewHeight);
        } else {
            // 有多个视图
            UIView *firstView = self.buttonAddBGView.subviews[0];
            CGFloat firstViewY = firstView.frame.origin.y;
            
            if (firstViewY == 40) {
                // 第一个已经删除
                firstView.frame = CGRectMake(0, 0, self.buttonAddBGView.frame.size.width, kViewHeight);
        }
            for (NSInteger i = 0; i < self.buttonAddBGView.subviews.count; i++) {
                if (i > 0) {
                    UIView *currentView = self.buttonAddBGView.subviews[i];
                    UIView *frontView = self.buttonAddBGView.subviews[i - 1];
                    if (CGRectGetMaxY(currentView.frame) - CGRectGetMaxY(frontView.frame) != kViewHeight) { // 判断两个View之间y的距离
                        CGRect frame = currentView.frame;
                        frame.origin = CGPointMake(0, currentView.frame.origin.y - 40);
                        currentView.frame = frame;
                    }
                }
            }
        }
        // view个数减一个
        self.viewCount--;
    }else {
        // 添加
        if (self.viewCount == 5) { // 限制只能添加5个
            // 这是个过期的方法,可以自行换掉
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"至多只能添加5个" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        // view个数增加一个
        self.viewCount++;
        [sender setImage:[UIImage imageNamed:@"shanchushuxing"] forState:UIControlStateNormal];
        // 创建一个新的view
        UIView *secondView = [self creatEntiretyViewWithFrame:CGRectMake(0, self.viewCount * kViewHeight, self.buttonAddBGView.frame.size.width, kViewHeight)];
        [self.buttonAddBGView addSubview:secondView];
    }
    
    // 修改视图的frame
    self.frame = CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width - 100, kViewHeight * self.buttonAddBGView.subviews.count + 40);
    self.buttonAddBGView.frame = CGRectMake(0, 0, self.frame.size.width, kViewHeight * self.buttonAddBGView.subviews.count);
    self.sureButton.frame = CGRectMake((self.frame.size.width - 80) / 2, CGRectGetMaxY(self.buttonAddBGView.frame) + 5, 80, 30);
}

// 确定按钮的执行方法
- (void)sureButtonAction:(UIButton *)sender {
    [self endEditing:YES];
    
    // 存储text的数组
    NSMutableArray *contents = [NSMutableArray array];
    // 循环获取text
    for (UIView *subview in self.buttonAddBGView.subviews) {
        UITextField *tempTextField = (UITextField *)subview.subviews[1];
        [contents addObject:tempTextField.text];
    }
    
    //代理方法
    if ([self.delegate respondsToSelector:@selector(buttonAddView:contents:)]) {
        [self.delegate buttonAddView:self contents:contents];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
