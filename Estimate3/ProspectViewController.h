//
//  ProspectViewController.h
//  Estimate3
//
//  Created by 羽野 真悟 on 13/04/30.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "DDSocialDialog.h"

@interface ProspectViewController :UITableViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,DDSocialDialogDelegate>
{
    NSArray *prospectTitleArray;
    NSMutableArray *prospectMoneyArray;

    NSInteger month;
    NSInteger year;
    NSInteger lastYear;
    NSInteger lastMonth;
    
    NSMutableArray *titleArray2;
    NSMutableArray *moneyArray2;
    
    UITextField *titleField;
    UITextField *moneyField;
    UITextField *textField;
    
    NSInteger alertFlag;
    NSInteger sectionCount;
    NSInteger alertIndex;
    NSInteger alertSection;
    
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
