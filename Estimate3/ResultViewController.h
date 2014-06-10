//
//  ResultViewController.h
//  Estimate3
//
//  Created by 羽野 真悟 on 13/04/29.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "DDSocialDialog.h"

@interface ResultViewController :UITableViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,DDSocialDialogDelegate>
{
    NSMutableArray *titleArray;
    NSMutableArray *titleArray2;
    NSMutableArray *titleArray3;
    NSMutableArray *resultArray;
    NSMutableArray *resultMoneyArray;
    
    UITextField *moneyField;
    
    NSInteger alertFlag;
    NSInteger sectionCount;
    NSInteger alertIndex;
    NSInteger alertSection;
    
    NSInteger month;
    NSInteger lastMonth;
    NSInteger year;
    NSInteger lastYear;
    
    NSInteger value1;
    NSInteger value2;
    NSInteger value3;
    
    NSArray *fontArray;
    NSArray *sizeArray;
    NSArray *cellArray;
    
    //DDSocialLoginDialog
    DDSocialDialog *blankDialog;
}

@end
