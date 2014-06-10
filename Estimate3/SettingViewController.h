//
//  SettingViewController.h
//  Estimate3
//
//  Created by 羽野 真悟 on 13/04/28.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

//#import "MasterViewController.h"
#import "RootViewController.h"

@interface SettingViewController : RootViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UILabel *sampleLabel;
    
    NSInteger value1;
    NSInteger value2;
    NSInteger value3;
    
    NSArray *fontArray;
    NSArray *sizeArray;
    NSArray *cellArray;
}

@end
