//
//  ProspectViewController.m
//  Estimate3
//
//  Created by 羽野 真悟 on 13/04/30.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import "ProspectViewController.h"
#import "TSMessage.h"

@interface ProspectViewController ()

@end

@implementation ProspectViewController

/*******************************************************************
 関数名　　initWithNibName
 概要    UIViewControllerクラスの初期処理　他Viewからの画面遷移に必要
 引数	(NSString *)nibNameOrNil        :xib
 (NSBundle *)nibBundleOrNil      :Bundle
 戻り値	(id)initWithNibName             :xibの名前
 *******************************************************************/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*******************************************************************
 関数名　　viewDidLoad
 概要		viewが呼び出された時の初期処理　各種変数の初期化など
 引数		なし
 戻り値	なし
 *******************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Prospect";
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wall.png"]];
    //    imageView.alpha=0.4;
    self.tableView.backgroundView = imageView;
    
    UIBarButtonItem *menuButton= [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    //    [menuButton setImage:[UIImage imageNamed:@"view_choose"]];
    self.navigationItem.leftBarButtonItem=menuButton;
    
    prospectTitleArray=[[NSMutableArray alloc]initWithObjects:nil];
    prospectMoneyArray=[[NSMutableArray alloc]initWithObjects:nil];
    
    [self initArray];
    [self getDate];
    [self loadAccount];
    [self makeProspect];
    /*
    for(int i=0;i<60;i++)
    {
        [prospectMoneyArray addObject:@"0"];
    }*/
    
    prospectTitleArray=[[NSArray alloc]initWithObjects:NSLocalizedString(@"前月繰越",nil),NSLocalizedString(@"当月貯蓄額",nil),NSLocalizedString(@"当月臨時収入",nil),NSLocalizedString(@"当月臨時費用",nil),NSLocalizedString(@"次月繰越",nil), nil];
    
    fontArray=[[NSArray alloc]init];
    fontArray=[NSArray arrayWithObjects:
               @"ArialHebrew",
               @"ArialHebrew-Bold",
               @"Zapfino",
               @"Oriya Sangam MN",
               @"OriyaSangamMN-Bold",
               @"Cochin",
               @"Cochin-BoldItalic",
               @"Cochin-Italic",
               @"Cochin-Bold",
               @"Baskerville",
               @"Baskerville-BoldItalic",
               @"Baskerville-Italic",
               @"Baskerville-Bold",
               @"Verdana",
               @"Verdana-Bold",
               @"Verdana-BoldItalic",
               @"Verdana-Italic",
               @"Gurmukhi MN",
               @"GurmukhiMN-Bold",
               @"Palatino",
               @"Palatino-Italic",
               @"Palatino-Bold",
               @"Palatino-Roman",
               @"Tamil Sangam MN",
               @"TamilSangamMN-Bold",
               @"Marker Felt",
               @"MarkerFelt-Wide",
               @"Courier New",
               @"CourierNewPS-ItalicMT",
               @"CourierNewPS-BoldItalicMT",
               @"CourierNewPS-BoldMT",
               @"Courier",
               @"Courier-Oblique",
               @"Courier-Bold",
               @"Courier-BoldOblique",
               @"DB LCD Temp",
               @"Trebuchet MS",
               @"Trebuchet-BoldItalic",
               @"TrebuchetMS-Italic",
               @"TrebuchetMS-Bold",
               @"Arial Rounded MT Bold",
               @"Bangla Sangam MN",
               @"BanglaSangamMN-Bold",
               @"Telugu Sangam MN",
               @"TeluguSangamMN-Bold",
               @"American Typewriter",
               @"AmericanTypewriter-Bold",
               @"Arial",
               @"Arial-ItalicMT",
               @"Arial-BoldMT",
               @"Arial-BoldItalicMT",
               @"Hiragino Kaku Gothic ProN",
               @"HiraKakuProN-W6",
               @"AppleGothic",
               @"Heiti SC",
               @"STHeitiSC-Medium",
               @"Malayalam Sangam MN",
               @"MalayalamSangamMN-Bold",
               @"Thonburi",
               @"Thonburi-Bold",
               @"Helvetica",
               @"Helvetica-BoldOblique",
               @"Helvetica-Oblique",
               @"Helvetica-Bold",
               @"Futura",
               @"Futura-MediumItalic",
               @"Futura-CondensedExtraBold",
               @"Gujarati Sangam MN",
               @"GujaratiSangamMN-Bold",
               @"Heiti K",
               @"STHeitiK-Light",
               @"Devanagari Sangam MN",
               @"DevanagariSangamMN-Bold",
               @"Heiti TC",
               @"STHeitiTC-Medium",
               @"Sinhala Sangam MN",
               @"SinhalaSangamMN-Bold",
               @"Kannada Sangam MN",
               @"KannadaSangamMN",
               @"Georgia",
               @"Georgia-Italic",
               @"Georgia-Bold",
               @"Georgia-BoldItalic",
               @"Heiti J",
               @"STHeitiJ-Light",
               @"Times New Roman",
               @"TimesNewRomanPS-ItalicMT",
               @"TimesNewRomanPS-BoldItalicMT",
               @"TimesNewRomanPS-BoldMT",
               @"Geeza Pro",
               @"GeezaPro-Bold",
               @"Helvetica Neue",
               @"HelveticaNeue-Bold",
               nil];
    
    sizeArray=[[NSArray alloc]init];
    sizeArray=[NSArray arrayWithObjects:
               @"11",@"12", @"13", @"14", @"15",@"16",@"17",@"18",@"19",@"20", nil];
    
    cellArray=[[NSArray alloc]init];
    cellArray=[NSArray arrayWithObjects:
               @"40",@"45", @"50", @"55", @"60",@"65",@"70", nil];


    [self monthChange];
    [self saveData];
}

/*******************************************************************
 関数名　　getData
 概要	 現在の年月の取得
 引数	なし
 戻り値	なし
 *******************************************************************/
-(void)getDate
{
    // 現在日付を取得
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    // 年・月・日を取得
    flags =  NSYearCalendarUnit | NSMonthCalendarUnit;
    comps = [calendar components:flags fromDate:now];
    
    year=comps.year;
    month = comps.month;
}

/*******************************************************************
 関数名　　monthChange
 概要	 前回起動時から月が変化した場合の処理
 引数	なし
 戻り値	なし
 *******************************************************************/
-(void)monthChange
{
    if(year==lastYear)
    {
        if(lastMonth==month)
        {
            return;
        }
        for(int i=0;i<5*(month-lastMonth);i++)
        {
            [prospectMoneyArray removeObjectAtIndex:0];
            [prospectMoneyArray addObject:@"0"];
        }
        
        
        int sum=0;
        
        for(int i=0;i<moneyArray2.count;i++)                        //セクション2のタイトルと金額を整形する
        {
            sum+=[[moneyArray2 objectAtIndex:i]integerValue];
        }
        NSString *sumString=[NSString stringWithFormat:@"%d",sum];
        
        for(int j=0;j<60;j++)
        {
            if(j%5==1)
            {
                [prospectMoneyArray removeObjectAtIndex:j];
                [prospectMoneyArray insertObject:sumString atIndex:j];
            }
        }
        [self makeProspect];
    }
    
    else if(year-lastYear==1)
    {
        for (int i=0;i<5*(month+12-lastMonth);i++)
        {
            [prospectMoneyArray removeObjectAtIndex:0];
                [prospectMoneyArray addObject:@"0"];
        }
        
        int sum=0;
        
        for(int i=0;i<moneyArray2.count;i++)                        //セクション2のタイトルと金額を整形する
        {
            sum+=[[moneyArray2 objectAtIndex:i]integerValue];
        }
        
        NSString *sumString=[NSString stringWithFormat:@"%d",sum];
        
        for(int j=0;j<60;j++)
        {
            if(j%5==1)
            {
                [prospectMoneyArray removeObjectAtIndex:j];
                [prospectMoneyArray insertObject:sumString atIndex:j];
            }
        }

        [self makeProspect];
    }
    
    else if(year-lastYear>=2)
    {
        for (int i=0;i<60;i++)
        {
            [prospectMoneyArray removeObjectAtIndex:0];
            [prospectMoneyArray addObject:@"0"];
        }
        
        int sum=0;
        
        for(int i=0;i<moneyArray2.count;i++)                        //セクション2のタイトルと金額を整形する
        {
            sum+=[[moneyArray2 objectAtIndex:i]integerValue];
        }
        
        NSString *sumString=[NSString stringWithFormat:@"%d",sum];
        
        for(int j=0;j<60;j++)
        {
            if(j%5==1)
            {
                [prospectMoneyArray removeObjectAtIndex:j];
                [prospectMoneyArray insertObject:sumString atIndex:j];
            }
        }
        
        [self makeProspect];        
    }
}

/*******************************************************************
 関数名　　initArray
 概要	 各種配列の初期化処理
 引数     なし
 戻り値    なし
 *******************************************************************/
-(void)initArray
{
    if(!titleArray2)
    {
        titleArray2=[[NSMutableArray alloc]initWithObjects:nil];
    }
    if(!moneyArray2)
    {
        moneyArray2=[[NSMutableArray alloc]initWithObjects:nil];
    }
}

/*******************************************************************
 関数名　　loadAcccount
 概要	 辞書データ読み込み
 引数　　　なし
 戻り値   なし
 *******************************************************************/
-(void)loadAccount
{
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    
    titleArray2=[[_userDefaults objectForKey:@"TITLEARRAY2"]mutableCopy];    //セクション2タイトル文字列
    moneyArray2=[[_userDefaults objectForKey:@"MONEYARRAY2"]mutableCopy];    //セクション2金額文字列
    prospectMoneyArray=[[_userDefaults objectForKey:@"PROSPECT_MONEY_ARRAY"]mutableCopy];
    
    value1=[_userDefaults integerForKey:@"VALUE1"];
    value2=[_userDefaults integerForKey:@"VALUE2"];
    value3=[_userDefaults integerForKey:@"VALUE3"];
    lastMonth=[_userDefaults integerForKey:@"LAST_MONTH"];
    lastYear=[_userDefaults integerForKey:@"LAST_YEAR"];
    
    value1=value1?value1:0;
    value2=value2?value2:0;
    value3=value3?value3:0;
    lastYear=lastYear?lastYear:year;
    lastMonth=lastMonth?lastMonth:month;

    int sum=0;
    
    for(int i=0;i<moneyArray2.count;i++)                        //セクション2のタイトルと金額を整形する
    {
        sum+=[[moneyArray2 objectAtIndex:i]integerValue];
    }
    
    NSString *sumString=[NSString stringWithFormat:@"%d",sum];
    
    if(prospectMoneyArray==nil)
    {
        prospectMoneyArray=[[NSMutableArray alloc]initWithObjects:nil];
        for(int i=0;i<60;i++)
        {
            [prospectMoneyArray addObject:@"0"];
        }
    }
    
    for(int j=0;j<60;j++)
    {
        if(j%5==1)
        {
            [prospectMoneyArray removeObjectAtIndex:j];
            [prospectMoneyArray insertObject:sumString atIndex:j];
        }
    }
}

/*******************************************************************
 関数名　　saveData
 概要	 辞書データ書き込み
 引数　　　なし
 戻り値   なし
 *******************************************************************/
-(void)saveData
{
    //データ保存
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    [_userDefaults setObject:(NSArray*)prospectMoneyArray forKey:@"PROSPECT_MONEY_ARRAY"];    //セクション1タイトル
    [_userDefaults setInteger:year forKey:@"LAST_YEAR"];
    [_userDefaults setInteger:month forKey:@"LAST_MONTH"];
    [_userDefaults synchronize]; //保存を実行
}

/*******************************************************************
 関数名　　makeProspect
 概要	 予算の算出を行う
 引数     なし
 戻り値    なし
 *******************************************************************/
-(void)makeProspect
{
    int sum;
    
    for(int i=0;i<12;i++)
    {
        sum=0;
        
        sum+=[[prospectMoneyArray objectAtIndex:5*i]integerValue];
        sum+=[[prospectMoneyArray objectAtIndex:5*i+1]integerValue];
        sum+=[[prospectMoneyArray objectAtIndex:5*i+2]integerValue];
        sum-=[[prospectMoneyArray objectAtIndex:5*i+3]integerValue];
        id item=[NSString stringWithFormat:@"%d",sum];
        [prospectMoneyArray removeObjectAtIndex:5*i+4];
        [prospectMoneyArray insertObject:item atIndex:5*i+4];
        
        if(i!=11)
        {
            [prospectMoneyArray removeObjectAtIndex:5*(i+1)];
            [prospectMoneyArray insertObject:item atIndex:5*(i+1)];
        }
    }
 }

/*******************************************************************
 関数名　　editString
 概要	 項目名と金額の文字列を整形して返す
 引数    :(NSString*)s1　項目名の文字列
 :(NSString*)s2  金額の文字列
 戻り値    (NSString*) - 項目名＋改行＋金額(3桁カンマ区切り)を連結した文字列
 *******************************************************************/
-(NSString*)editString:(NSString*)s1 edit:(NSString*)s2
{
    // 数値をNSNumber型へ変換
    NSNumber *number = [NSNumber numberWithDouble:s2.doubleValue];
    // NSNumberFormatterの作成
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@",###"];  //3桁カンマ区切り
    // 整形後の文字列の取得
    s2 = [formatter stringForObjectValue:number];
    // 改行を連結
    /*
     NSString *str=@"        ";
     s1=[str stringByAppendingString:s1];*/
    s1=[s1 stringByAppendingString:@"\n"];
    //タイトルと金額の連結
    return [s1 stringByAppendingString:s2];
}

/*******************************************************************
 関数名　　editAlert
 概要	 項目名と金額の編集用アラート表示
 引数　　　なし
 戻り値   なし
 *******************************************************************/
-(void)editAlert
{
    
    
    DDSocialDialogTheme dialogTheme = 10;
    BButtonType type=10;
    
    blankDialog = [[DDSocialDialog alloc] initWithFrame:CGRectMake(0., 0., 300., 250.) theme:dialogTheme];
    blankDialog.dialogDelegate = self;
    
    //Title Name
    blankDialog.titleLabel.text = NSLocalizedString(@"金額の設定",nil);
    
    //Explanation
    UILabel *expLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 40, 250, 60)];
    expLabel.text=NSLocalizedString(@"金額を半角数字で入力してください。\n\n\n",nil);
    expLabel.font=[UIFont fontWithName:@"Arial" size:12];
    expLabel.textColor=[UIColor colorWithRed:0.202 green:0.3 blue:0.202 alpha:0.99];
    expLabel.numberOfLines=4;
    expLabel.textAlignment=NSTextAlignmentCenter;
    
    //Left Button
    BButton *cancelBtn = [[BButton alloc] initWithFrame:CGRectMake(40,180, 80, 30) type:type];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelDialog) forControlEvents:UIControlEventTouchUpInside];
    
    //Right Button
    BButton *okBtn = [[BButton alloc] initWithFrame:CGRectMake(160,180, 80, 30) type:type];
    [okBtn setTitle:@"OK" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okDialog) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // UITextFieldの生成
    moneyField = [[UITextField alloc] initWithFrame:CGRectMake(80, 145, 180, 25)];
    moneyField.borderStyle = UITextBorderStyleRoundedRect;
    moneyField.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    moneyField.textColor = [UIColor grayColor];
    moneyField.text=[prospectMoneyArray objectAtIndex:alertSection*5+alertIndex];
    moneyField.minimumFontSize = 8;
    moneyField.adjustsFontSizeToFitWidth = YES;
    moneyField.delegate = self;
    moneyField.keyboardType=UIKeyboardTypeNumberPad;
    [moneyField becomeFirstResponder];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 145, 60, 25)];
    label2.text=NSLocalizedString(@"金額",nil);
    label2.font=[UIFont fontWithName:@"Arial" size:12];
    label2.textColor=[UIColor colorWithRed:0.202 green:0.3 blue:0.202 alpha:0.99];
    label2.backgroundColor=[UIColor clearColor];
    label2.textAlignment=NSTextAlignmentCenter;
    [blankDialog addSubview:label2];
    
    // アラートビューにテキストフィールドを埋め込む
    [blankDialog addSubview:moneyField];
    [blankDialog addSubview:expLabel];
    [blankDialog addSubview:cancelBtn];
    [blankDialog addSubview:okBtn];
    
    [blankDialog show];

    
    /*
    //アラートの判別用
    alertFlag=10;
    
    // UIAlertViewの生成
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"金額の設定",nil)
                                                        message:NSLocalizedString(@"金額を半角数字で入力してください。\n\n\n",nil)
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    //アラートカスタム用
    alertView.tag=1;
    moneyField = [[UITextField alloc] initWithFrame:CGRectMake(80, 75, 190, 25)];
    moneyField.borderStyle = UITextBorderStyleRoundedRect;
    moneyField.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    moneyField.textColor = [UIColor grayColor];
    moneyField.text=[prospectMoneyArray objectAtIndex:alertSection*5+alertIndex];
    moneyField.minimumFontSize = 8;
    moneyField.adjustsFontSizeToFitWidth = YES;
    moneyField.delegate = self;
    moneyField.keyboardType=UIKeyboardTypeNumberPad;
        
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 75, 60, 25)];
    label2.text=NSLocalizedString(@"金額",nil);
    label2.font=[UIFont systemFontOfSize:14];
    label2.textColor=[UIColor whiteColor];
    label2.backgroundColor=[UIColor colorWithHue:0.71 saturation:0.09 brightness:0.19 alpha:0.1];
    label2.textAlignment=NSTextAlignmentCenter;
    [alertView addSubview:label2];
    
    // アラートビューにテキストフィールドを埋め込む
    //    [alertView addSubview:titleField];
    [alertView addSubview:moneyField];
    
    ((UILabel *)[[alertView subviews] objectAtIndex:0]).font=[UIFont systemFontOfSize:16];
    ((UILabel *)[[alertView subviews] objectAtIndex:1]).font=[UIFont systemFontOfSize:14];
    //    ((UILabel *)[[alertView subviews] objectAtIndex:1]).textAlignment=NSTextAlignmentLeft;
    //    ((UILabel *)[[alertView subviews] objectAtIndex:2]).font=[UIFont systemFontOfSize:16];
    
    // アラート表示
    [alertView show];
    
    // テキストフィールドをファーストレスポンダに
    [moneyField becomeFirstResponder];*/
}
-(void)cancelDialog
{
    [blankDialog cancel];
}

-(void)okDialog
{
    if([moneyField.text length]==0)    //金額未入力
    {
        [self errorAlertView:2];
        return;
    }
    else
    {
        NSMutableCharacterSet *checkCharSet = [[NSMutableCharacterSet alloc] init];
        [checkCharSet addCharactersInString:@"1234567890"];
        if([[moneyField.text stringByTrimmingCharactersInSet:checkCharSet] length] > 0) //数字以外入力
        {
            [self errorAlertView:3];
            return;
        }
        else if(moneyField.text.longLongValue> 2147483647)                               //int上限超過
        {
            [self errorAlertView:4];
            return;
        }
        
        int temp=alertSection*5+alertIndex;
        [prospectMoneyArray removeObjectAtIndex:temp];
        [prospectMoneyArray insertObject:moneyField.text atIndex:temp];
        
        [self makeProspect];
        [self saveData];
        [self.tableView reloadData];        //テーブルデータ更新
        [blankDialog cancel];
    }
}


/*******************************************************************
 関数名　　alertView
 概要	 アラートのボタンクリック時の処理
 引数　　　:(UIAlertView *)alertView　アラート
 :(NSInteger)buttonIndex 　　クリックされたボタンインデックス
 戻り値   なし
 *******************************************************************/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //エラーアラートからOKが選択された場合、設定画面からキャンセルが選択された場合
    if (buttonIndex==0) {
        /*
        if(alertFlag==1)                            //エディットアラートでエラーになった場合
        {
            alertFlag=0;
            [self editAlert];                       //アラート再表示
        }*/
    }
    //設定画面からOKボタンが選択された場合
    else if (buttonIndex ==1)
    {
/*        if(alertFlag==10)                           //エディットアラート
        {
            if([moneyField.text length]==0)    //金額未入力
            {
                [self errorAlertView:2];
                return;
            }
            else
            {
                NSMutableCharacterSet *checkCharSet = [[NSMutableCharacterSet alloc] init];
                [checkCharSet addCharactersInString:@"1234567890"];
                if([[moneyField.text stringByTrimmingCharactersInSet:checkCharSet] length] > 0) //数字以外入力
                {
                    [self errorAlertView:3];
                    return;
                }
                else if(moneyField.text.longLongValue> 2147483647)                               //int上限超過
                {
                    [self errorAlertView:4];
                    return;
                }
                
                int temp=alertSection*5+alertIndex;
                [prospectMoneyArray removeObjectAtIndex:temp];
                [prospectMoneyArray insertObject:moneyField.text atIndex:temp];
                
                [self makeProspect];
                [self saveData];
                [self.tableView reloadData];        //テーブルデータ更新
            }
        }*/
    }
}

/*******************************************************************
 関数名　　errorAlertView:
 概要	 入力エラー表示用アラート
 引数　　　:(int)errorNumber  エラー番号
 戻り値   なし
 *******************************************************************/
- (void)errorAlertView:(int)errorNumber
{
    NSString *errorString;      //エラー文字列
    
    if(errorNumber==0)
    {
        errorString=NSLocalizedString(@"タイトルが入力されていません。\n",nil);
//        alertFlag=1;            //アラート再表示用
    }
    else if(errorNumber==1)
    {
        errorString=NSLocalizedString(@"項目名は全角8文字(半角16文字)以内で入力してください。\n",nil);
//        alertFlag=1;            //アラート再表示用
    }
    else if(errorNumber==2)
    {
        errorString=NSLocalizedString(@"金額が入力されていません。\n",nil);
//        alertFlag=1;            //アラート再表示用
    }
    else if(errorNumber==3)
    {
        errorString=NSLocalizedString(@"金額は半角数字で入力してください。\n",nil);
//        alertFlag=1;            //アラート再表示用
    }
    else if(errorNumber==4)
    {
        errorString=NSLocalizedString(@"入力された値が大きすぎます。\n",nil);
//        alertFlag=1;            //アラート再表示用
    }
    else if(errorNumber==31)
    {
        errorString=NSLocalizedString(@"文字が入力されていません。\n",nil);
//        alertFlag=50;           //アラート再表示用
    }
    else if(errorNumber==32)
    {
        errorString=NSLocalizedString(@"4文字以上12文字以内で入力してください。\n",nil);
//        alertFlag=50;           //アラート再表示用
    }
    else if(errorNumber==33)
    {
        errorString=NSLocalizedString(@"半角英数字を入力してください。\n",nil);
//        alertFlag=50;           //アラート再表示用
    }
    else if(errorNumber==41)
    {
        errorString=NSLocalizedString(@"パスワードが一致しません。\n",nil);
//        alertFlag=50;           //アラート再表示用
    }
    
    [TSMessage showNotificationInViewController:self // 通知を表示するViewController
                                      withTitle:NSLocalizedString(@"入力エラー",nil) // タイトル
                                    withMessage:errorString // メッセージ内容
                                       withType:TSMessageNotificationTypeError // 通知種類（notificationType）
     ];

    /*
    
    // UIAlertViewの生成
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"入力エラー",nil)
                                                        message:errorString
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];*/
    // アラート表示
//    [alertView show];
}


#pragma mark - Table view data source


/*******************************************************************
 関数名　　tableView titleForHeaderInSection
 概要	 テーブルビューのセクションのタイトル文字列を返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSInteger)section　セクション番号
 戻り値   (NSString *) セクションのタイトル文字列
 *******************************************************************/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%d/%02d",(month-1+section+12)%12+1>=month?year:year+1,(month-1+section+12)%12+1];

}

/*******************************************************************
 関数名　　tableView viewForHeaderInSection
 概要	 セクションヘッダー用のViewを返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSInteger)section セクション番号
 戻り値   (UIView *)　セクションヘッダー用のView
 *******************************************************************/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blackColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2048, 36.0f)];
    UIImage *bgImage = [UIImage imageNamed:@"wall.png"];
    lbl.backgroundColor = [UIColor colorWithPatternImage: bgImage];
    lbl.textColor = [UIColor blackColor];
    lbl.text = [NSString stringWithFormat:@"%d/%02d",(month-1+section+12)%12+1>=month?year:year+1,(month-1+section+12)%12+1];
    [v addSubview:lbl];
    return v;
}

/*******************************************************************
 関数名　　numberOfSectionsInTableView
 概要	 テーブルビューのセクション数を返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 戻り値   (NSInteger) :　セクション数
 *******************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 12;
}

/*******************************************************************
 関数名　　tableView numberOfRowsInSection
 概要	 テーブルビューのセクションのセル数を返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSInteger)section　セクション番号
 戻り値   (NSInteger) セクションのセル数
 *******************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
        return prospectTitleArray.count;
}

/*******************************************************************
 関数名　　tableView cellForRowAtIndexPath
 概要	 テーブルビューのセルの表示を行う
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSIndexPath *)indexPath　インデックスパス
 戻り値   (UITableViewCell *)テーブルビューのセル
 *******************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    UIColor *textcolor=[UIColor colorWithHue:0.71 saturation:0.09 brightness:0.99 alpha:1.0];
    UIFont *cellFont=[UIFont fontWithName:[fontArray objectAtIndex:value1] size:[[sizeArray objectAtIndex:value2]floatValue]];
    cell.textLabel.font=cellFont;
    
    cell.textLabel.numberOfLines=2;
    //    cell.textLabel.font= [UIFont fontWithName:@"ArialHebrew" size:17];
    cell.textLabel.textColor=textcolor;
    
    cell.textLabel.text = [self editString:[prospectTitleArray objectAtIndex:indexPath.row] edit:[prospectMoneyArray objectAtIndex:indexPath.section*5+indexPath.row]];

    
    UIImage *image1 = [UIImage imageNamed:@"image1"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    
    UIImage *image2 = [UIImage imageNamed:@"image2"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    
    UIImage *image3 = [UIImage imageNamed:@"image3"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image3];
    
    UIImage *image4 = [UIImage imageNamed:@"image4"];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:image4];
    
    UIImage *image5 = [UIImage imageNamed:@"image5"];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:image5];
    


    //    if(indexPath.section==0)                                       //2個目のセクション
    //  {
    UIImageView *editImage=[[UIImageView alloc]init];
    editImage.image=[UIImage imageNamed:@"gtk_edit"];
    editImage.frame = CGRectMake(150, 0, 40, 40);
    
    if((indexPath.section+indexPath.row)%5==0)
    {
        cell.backgroundView=imageView1;
    }
    else if((indexPath.section+indexPath.row)%5==1)
    {
        cell.backgroundView=imageView2;
    }
    else if((indexPath.section+indexPath.row)%5==2)
    {
        cell.backgroundView=imageView3;
    }
    else if((indexPath.section+indexPath.row)%5==3)
    {
        cell.backgroundView=imageView4;
    }
    else if((indexPath.section+indexPath.row)%5==4)
    {
        cell.backgroundView=imageView5;
    }
    
    if((indexPath.section==0 &&indexPath.row==0) || indexPath.row==2 || indexPath.row==3)
    {
        cell.accessoryView=editImage;
    }
    else
    {
        cell.accessoryView=nil;
    }

    return cell;
}

/*******************************************************************
 関数名　　tableView heightForRowAtIndexPath
 概要	 テーブルビューのセルの高さを返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSIndexPath *)indexPath　インデックスパス
 戻り値   (CGFloat)セルの高さの値
 *******************************************************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[cellArray objectAtIndex:value3]intValue];
}

/*******************************************************************
 関数名　　tableView didSelectRowAtIndexPath
 概要	 テーブルビューのセルが選択された際の処理
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSIndexPath *)indexPath　インデックスパス
 戻り値   なし
 *******************************************************************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    alertSection=indexPath.section;
    alertIndex=indexPath.row;
    
    if((indexPath.section==0&& indexPath.row==0) || indexPath.row==2 || indexPath.row==3)
    {
        [self editAlert];
    }
}

/*******************************************************************
 関数名　　didReceiveMemoryWarning
 概要	 メモリ警告時の処理
 引数　　　なし
 戻り値   なし
 *******************************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
