//
//  HggButtonAddView.h
//  AddNewTextfield
//
//  Created by 胡高广 on 2017/9/18.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HggButtonAddView;

@protocol HggButtonAddViewDelegate <NSObject>

- (void)buttonAddView:(HggButtonAddView *)buttonAddView contents:(NSMutableArray *)contents;

@end


@interface HggButtonAddView : UIView

/** 协议 **/
@property (nonatomic, assign) id <HggButtonAddViewDelegate>delegate;

@end
