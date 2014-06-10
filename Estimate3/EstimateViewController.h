//
//  EstimateViewController.h
//  Estimate3
//
//  Created by 羽野 真悟 on 13/05/05.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSocialDialog.h"

@interface EstimateViewController : UITableViewController<UITextFieldDelegate,DDSocialDialogDelegate>
{
    NSInteger alertIndex;
    NSInteger alertSection;
    
    NSMutableArray *_objects;
    NSMutableArray *titleArray;
    NSMutableArray *moneyArray;
    
    NSMutableArray *_objects2;
    NSMutableArray *titleArray2;
    NSMutableArray *moneyArray2;
    
    NSMutableArray *_objects3;
    NSMutableArray *titleArray3;
    NSMutableArray *moneyArray3;
    
    NSArray *estimateTitleArray;
    NSMutableArray *estimateMoneyArray;
    NSMutableArray *_estimateObjext;
    NSMutableArray *resultMoneyArray;
    
    UITextField *titleField;
    UITextField *moneyField;
    UITextField *textField;
    UIBarButtonItem *menuButton;
    
    NSInteger switchFlag;
    NSInteger alertFlag;
    NSInteger lock;
    NSString *passString;
    
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
