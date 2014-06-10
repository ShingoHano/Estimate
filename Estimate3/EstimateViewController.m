//
//  EstimateViewController.m
//  Estimate3
//
//  Created by 羽野 真悟 on 13/05/05.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import "EstimateViewController.h"
#import "TSMessage.h"

@interface EstimateViewController ()

@end

@implementation EstimateViewController

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
        self.title = NSLocalizedString(@"Estimate", nil);
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
    
    self.title = NSLocalizedString(@"Estimate", nil);
    
    //変数の初期化
	alertIndex=0;
    alertSection=0;
    alertFlag=0;
    
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
    
    //予算セクションのタイトル文字列代入
    estimateTitleArray=[[NSArray alloc]initWithObjects:NSLocalizedString(@"収入合計",nil),NSLocalizedString(@"貯蓄合計",nil),NSLocalizedString(@"支出合計",nil),NSLocalizedString(@"利用可能額/月",nil),NSLocalizedString(@"利用可能額/週",nil), nil];
    
    //配列の初期化
    [self initArray];
    
    //辞書データ読み込み
    [self loadAccount];
    
    //予算算出
    [self makeEstimate];
    
    //パスワードが未設定の場合はロックをはずす
    if(passString.length<4)
    {
        lock=0;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wall.png"]];
    self.tableView.backgroundView = imageView;
    
    menuButton= [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    self.navigationItem.leftBarButtonItem=menuButton;
    
    if(lock==1 && switchFlag==1)
    {
        menuButton.enabled=true;
    }
    else
    {
        menuButton.enabled=false;
    }
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*******************************************************************
 関数名　　settingSwitch
 概要	 スイッチのオン/オフ切替時の処理
 引数     (UISwitch *)sender: スイッチ
 戻り値	なし
 *******************************************************************/
- (void)settingSwitch:(UISwitch *)sender;
{
    //スイッチがオフの時にチェンジ（オンにされた場合）
    if(switchFlag==0)
    {
        switchFlag=1;                   //スイッチフラグをオン
        [self passwordAlert];           //パスワード設定アラート表示
    }
    //スイッチがオンの時にチェンジ（オフにされた場合）
    else if(switchFlag==1)
    {
        switchFlag=0;                   //スイッチフラグをオフ
        menuButton.enabled=false;
        [self saveData];                //辞書データ書き込み
        [self.tableView reloadData];    //テーブルの更新
    }
}

/*******************************************************************
 関数名　　initArray
 概要	 各種配列の初期化処理
 引数     なし
 戻り値    なし
 *******************************************************************/
- (void)initArray
{
    //収入項目タイトル文字列初期化
    if (!titleArray) {
        titleArray = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //収入項目金額文字列初期化
    if (!moneyArray) {
        moneyArray = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //収入項目セル用文字列初期化
    if (!_objects) {
        _objects = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //貯蓄項目タイトル文字列初期化
    if (!titleArray2) {
        titleArray2 = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //貯蓄項目金額文字列初期化
    if (!moneyArray2) {
        moneyArray2 = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //貯蓄項目セル用文字列初期化
    if (!_objects2) {
        _objects2 = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //支出項目タイトル文字列初期化
    if (!titleArray3) {
        titleArray3 = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //支出項目金額文字列初期化
    if (!moneyArray3) {
        moneyArray3 = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //貯蓄項目セル用文字列初期化
    if (!_objects3) {
        _objects3 = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //予算項目タイトル文字列初期化
    if (!estimateTitleArray) {
        estimateTitleArray = [[NSArray alloc] initWithObjects:nil];
    }
    //予算項目金額文字列初期化
    if (!estimateMoneyArray) {
        estimateMoneyArray = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //予算項目セル用文字列初期化
    if (!_estimateObjext) {
        _estimateObjext = [[NSMutableArray alloc] initWithObjects:nil];
    }
    //ResultViewで利用する配列初期化
    if (!resultMoneyArray){
        resultMoneyArray= [[NSMutableArray alloc] initWithObjects:nil];
    }
}

/*******************************************************************
 関数名　　makeEstimate
 概要	 予算の算出を行う
 引数     なし
 戻り値    なし
 *******************************************************************/
-(void)makeEstimate
{
    double sum=0;                                                   //収入項目の計算結果を格納
    NSString *temp=nil;                                             //金額の文字列を格納
    
    if(moneyArray.count>0)                                          //項目が設定されている場合
    {
        for(int i=0;i<moneyArray.count;i++)                         //全ての項目の金額を加算
        {
            temp=[moneyArray objectAtIndex:i];
            sum+=temp.doubleValue;
        }
    }
    else
    {
        sum=0;                                                      //項目が未設定の場合は合計値0
    }
    
    temp=[NSString stringWithFormat:@"%f",sum];                     //合計値を文字列に変換
    [estimateMoneyArray setObject:temp atIndexedSubscript:0];       //予算項目の1行目に収入項目の合計値を格納
    
    double sum2=0;                                                  //貯蓄項目の計算結果を格納
    temp=nil;                                                       //金額の文字列を格納
    
    if(moneyArray2.count>0)                                         //項目が設定されている場合
    {
        for(int i=0;i<moneyArray2.count;i++)                        //全ての項目の金額を加算
        {
            temp=[moneyArray2 objectAtIndex:i];
            sum2+=temp.doubleValue;
        }
    }
    else
    {
        sum2=0;                                                     //項目が未設定の場合は合計値0
    }
    temp=[NSString stringWithFormat:@"%f",sum2];                    //合計値を文字列に変換
    [estimateMoneyArray setObject:temp atIndexedSubscript:1];       //予算項目の2行目に収入項目の合計値を格納
    
    double sum3=0;                                                  //支出項目の計算結果を格納
    temp=nil;                                                       //金額の文字列を格納
    
    if(moneyArray3.count>0)                                         //項目が設定されている場合
    {
        for(int i=0;i<moneyArray3.count;i++)                        //全ての項目の金額を加算
        {
            temp=[moneyArray3 objectAtIndex:i];                     //支出項目の計算結果を格納
            sum3+=temp.doubleValue;                                 //金額の文字列を格納
        }
    }
    else
    {
        sum3=0;                                                     //項目が未設定の場合は合計値0
    }
    temp=[NSString stringWithFormat:@"%f",sum3];                    //合計値を文字列に変換
    [estimateMoneyArray setObject:temp atIndexedSubscript:2];       //予算項目の3行目に支出項目の合計値を格納
    
    temp=[NSString stringWithFormat:@"%f",(sum-sum2-sum3)];         //(収入-貯蓄-支出)の合計値を文字列に格納
    [estimateMoneyArray setObject:temp atIndexedSubscript:3];       //予算項目の4行目に(収入-貯蓄-支出)の合計値を格納
    
    temp=[NSString stringWithFormat:@"%f",(sum-sum2-sum3)/52*12];   //(収入-貯蓄-支出)/52*12の合計値を文字列に格納
    [estimateMoneyArray setObject:temp atIndexedSubscript:4];       //予算項目の5行目に(収入-貯蓄-支出)/52*12の合計値を格納
    
    for(int i=0;i<5;i++)                                            //予算項目のタイトルと金額を整形する
    {
        NSString *temp1=[estimateTitleArray objectAtIndex:i];
        NSString *temp2=[estimateMoneyArray objectAtIndex:i];
        NSString *str = [self editString:temp1 edit:temp2];
        [_estimateObjext insertObject:str atIndex:i];
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
 関数名　　loadAcccount
 概要	 辞書データ読み込み
 引数　　　なし
 戻り値   なし
 *******************************************************************/
-(void)loadAccount
{
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    switchFlag=[_userDefaults integerForKey:@"SWITCHFLAG"];                 //スイッチのオンオフ
    switchFlag=(switchFlag==1)?1:0;                                         //初期化兼代入処理
    
    passString=[_userDefaults stringForKey:@"PASSWORD"];                    //パスワード文字列
    passString=passString?passString:@"";                                   //初期化兼代入処理
    lock=[_userDefaults integerForKey:@"LOCK"];
    
    titleArray=[[_userDefaults objectForKey:@"TITLEARRAY"]mutableCopy];      //セクション1タイトル文字列
    moneyArray=[[_userDefaults objectForKey:@"MONEYARRAY"]mutableCopy];      //セクション1金額文字列
    titleArray2=[[_userDefaults objectForKey:@"TITLEARRAY2"]mutableCopy];    //セクション2タイトル文字列
    moneyArray2=[[_userDefaults objectForKey:@"MONEYARRAY2"]mutableCopy];    //セクション2金額文字列
    titleArray3=[[_userDefaults objectForKey:@"TITLEARRAY3"]mutableCopy];    //セクション3タイトル文字列
    moneyArray3=[[_userDefaults objectForKey:@"MONEYARRAY3"]mutableCopy];    //セクション3金額文字列
    resultMoneyArray=[[_userDefaults objectForKey:@"RESULT_MONEY_ARRAY"]mutableCopy];   //ResultViewで利用する配列
    
    value1=[_userDefaults integerForKey:@"VALUE1"];                             //フォント種類インデックス
    value2=[_userDefaults integerForKey:@"VALUE2"];                             //フォントサイズインデックス
    value3=[_userDefaults integerForKey:@"VALUE3"];                             //セルサイズインデックス
    
    value1=value1?value1:0;
    value2=value2?value2:0;
    value3=value3?value3:0;
    
    if(titleArray.count ==0 && titleArray2.count==0 && titleArray3.count==0)   //セクション1,2,3全て未設定の場合
    {
        [self newAccount];                                                     //初回起動時用処理
    }
    
    for(int i=0;i<titleArray.count;i++)                         //セクション1のタイトルと金額を整形する
    {
        NSString *temp1=[titleArray objectAtIndex:i];
        NSString *temp2=[moneyArray objectAtIndex:i];
        NSString *str = [self editString:temp1 edit:temp2];
        [_objects insertObject:str atIndex:i];
    }
    
    for(int i=0;i<titleArray2.count;i++)                        //セクション2のタイトルと金額を整形する
    {
        NSString *temp1=[titleArray2 objectAtIndex:i];
        NSString *temp2=[moneyArray2 objectAtIndex:i];
        NSString *str = [self editString:temp1 edit:temp2];
        [_objects2 insertObject:str atIndex:i];
    }
    
    for(int i=0;i<titleArray3.count;i++)                        //セクション3のタイトルと金額を整形する
    {
        NSString *temp1=[titleArray3 objectAtIndex:i];
        NSString *temp2=[moneyArray3 objectAtIndex:i];
        NSString *str = [self editString:temp1 edit:temp2];
        [_objects3 insertObject:str atIndex:i];
    }
}

/*******************************************************************
 関数名　　newAcccount
 概要	 初回起動時の収入項目、貯蓄項目、支出項目の設定
 引数　　　なし
 戻り値   なし
 *******************************************************************/
-(void)newAccount
{
    //配列の初期化
    [self initArray];
    
    //セクション1,2,3のタイトルと金額を設定
    [titleArray insertObject:NSLocalizedString(@"給与収入",nil) atIndex:0];
    [moneyArray insertObject:@"0" atIndex:0];
    
    [titleArray2 insertObject:NSLocalizedString(@"積立貯金",nil) atIndex:0];
    [moneyArray2 insertObject:@"0" atIndex:0];
    
    [titleArray3 insertObject:NSLocalizedString(@"家賃",nil) atIndex:0];
    [moneyArray3 insertObject:@"0" atIndex:0];
    
    [titleArray3 insertObject:NSLocalizedString(@"ローン",nil) atIndex:1];
    [moneyArray3 insertObject:@"0" atIndex:1];
    
    [titleArray3 insertObject:NSLocalizedString(@"携帯電話",nil) atIndex:2];
    [moneyArray3 insertObject:@"0" atIndex:2];
    
    [titleArray3 insertObject:NSLocalizedString(@"ガス",nil) atIndex:3];
    [moneyArray3 insertObject:@"0" atIndex:3];
    
    [titleArray3 insertObject:NSLocalizedString(@"電気",nil) atIndex:4];
    [moneyArray3 insertObject:@"0" atIndex:4];
    
    [titleArray3 insertObject:NSLocalizedString(@"水道",nil) atIndex:5];
    [moneyArray3 insertObject:@"0" atIndex:5];
    
    [self saveData];
}

/*******************************************************************
 関数名　　saveData
 概要	 辞書データ書き込み
 引数　　　なし
 戻り値   なし
 *******************************************************************/
-(void)saveData
{
    //タイトルと金額の数が異なる場合は保存しない
    if((titleArray.count!=moneyArray.count) || (titleArray2.count!=moneyArray2.count) || (titleArray3.count!=moneyArray3.count))
    {
        return;
    }
    
    //データ保存
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    
    [_userDefaults setObject:(NSArray*)titleArray forKey:@"TITLEARRAY"];    //セクション1タイトル
    [_userDefaults setObject:(NSArray*)moneyArray forKey:@"MONEYARRAY"];    //セクション1金額
    
    [_userDefaults setObject:(NSArray*)titleArray2 forKey:@"TITLEARRAY2"];  //セクション2タイトル
    [_userDefaults setObject:(NSArray*)moneyArray2 forKey:@"MONEYARRAY2"];  //セクション2金額
    
    [_userDefaults setObject:(NSArray*)titleArray3 forKey:@"TITLEARRAY3"];  //セクション3タイトル
    [_userDefaults setObject:(NSArray*)moneyArray3 forKey:@"MONEYARRAY3"];  //セクション3金額
    
    [_userDefaults setInteger:switchFlag forKey:@"SWITCHFLAG"];             //スイッチのオンオフ
    [_userDefaults setObject:passString forKey:@"PASSWORD"];                //パスワード文字列
    [_userDefaults setInteger:lock forKey:@"LOCK"];                         //表示ロックのオンオフ
    
    if((titleArray.count+titleArray2.count+titleArray3.count)*3==resultMoneyArray.count)
    {
        [_userDefaults setObject:(NSArray*)resultMoneyArray forKey:@"RESULT_MONEY_ARRAY"];
    }
    else
    {
        for(int i=(titleArray.count+titleArray2.count+titleArray3.count)*3-resultMoneyArray.count;i>0;i--)
        {
            [resultMoneyArray addObject:@"0"];
            [_userDefaults setObject:(NSArray*)resultMoneyArray forKey:@"RESULT_MONEY_ARRAY"];
        }
    }
    
    [_userDefaults synchronize]; //保存を実行
}


/*******************************************************************
 関数名　　passWordAlert
 概要	 パスワードの設定と解除のアラートを表示
 引数     なし
 戻り値    なし
 *******************************************************************/
-(void)passwordAlert
{
    //ロックされていない時
    if(lock==0)
    {
        //アラートの判別用
        alertFlag=30;
        
        DDSocialDialogTheme dialogTheme = 10;
        BButtonType type=10;
        
        blankDialog = [[DDSocialDialog alloc] initWithFrame:CGRectMake(0., 0., 300., 250.) theme:dialogTheme];
        blankDialog.dialogDelegate = self;
        
        //Title Name
        blankDialog.titleLabel.text = NSLocalizedString(@"パスワード設定",nil);
 
        //Explanation
        UILabel *expLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 40, 250, 80)];
        expLabel.text=NSLocalizedString(@"データ保護のためのパスワードを設定します。半角英数字4文字以上12文字以内で入力してください。\n\n\n",nil);
        expLabel.font=[UIFont fontWithName:@"Arial" size:12];
        expLabel.textColor=[UIColor colorWithRed:0.202 green:0.3 blue:0.202 alpha:0.99];
        expLabel.numberOfLines=5;
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
        textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 140, 240, 25)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
        textField.textColor = [UIColor grayColor];
        textField.minimumFontSize = 8;
        textField.adjustsFontSizeToFitWidth = YES;
        textField.delegate = self;
        textField.text=@"";
        textField.keyboardType=UIKeyboardTypeNamePhonePad;
        [textField becomeFirstResponder];
        
        [blankDialog addSubview:textField];
        [blankDialog addSubview:expLabel];
        [blankDialog addSubview:cancelBtn];
        [blankDialog addSubview:okBtn];
        
        [blankDialog show];
    }
    
    //ロックされている時
    else
    {
        //アラートの判別用
        alertFlag=40;
        
        DDSocialDialogTheme dialogTheme = 10;
        BButtonType type=10;
        
        blankDialog = [[DDSocialDialog alloc] initWithFrame:CGRectMake(0., 0., 300., 250.) theme:dialogTheme];
        blankDialog.dialogDelegate = self;
        
        //Title Name
        blankDialog.titleLabel.text = NSLocalizedString(@"パスワード入力",nil);
        
        //Explanation
        UILabel *expLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 40, 250, 80)];
        expLabel.text=NSLocalizedString(@"データ保護のために設定したパスワードを入力してください。\n\n\n",nil);
        expLabel.font=[UIFont fontWithName:@"Arial" size:12];
        expLabel.textColor=[UIColor colorWithRed:0.202 green:0.3 blue:0.202 alpha:0.99];
        expLabel.numberOfLines=5;
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
        textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 140, 240, 25)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
        textField.textColor = [UIColor grayColor];
        textField.minimumFontSize = 8;
        textField.adjustsFontSizeToFitWidth = YES;
        textField.delegate = self;
        textField.text=@"";
        textField.keyboardType=UIKeyboardTypeNamePhonePad;
        [textField becomeFirstResponder];
        
        [blankDialog addSubview:textField];
        [blankDialog addSubview:expLabel];
        [blankDialog addSubview:cancelBtn];
        [blankDialog addSubview:okBtn];
        
        [blankDialog show];
    }
}

/*******************************************************************
 関数名　　editAlert
 概要	 項目名と金額の編集用アラート表示
 引数　　　なし
 戻り値   なし
 *******************************************************************/
-(void)editAlert
{
    //アラートの判別用
    alertFlag=10;
    
    DDSocialDialogTheme dialogTheme = 10;
    BButtonType type=10;
    
    blankDialog = [[DDSocialDialog alloc] initWithFrame:CGRectMake(0., 0., 300., 250.) theme:dialogTheme];
    blankDialog.dialogDelegate = self;
    
    //Title Name
    blankDialog.titleLabel.text = NSLocalizedString(@"項目と金額の設定",nil);
    
    //Explanation
    UILabel *expLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 40, 250, 60)];
    expLabel.text=NSLocalizedString(@"項目名を全角8文字(半角16文字)以内で、金額を半角数字で入力してください。\n\n",nil);
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
    titleField = [[UITextField alloc] initWithFrame:CGRectMake(80, 115, 180, 25)];
    titleField.borderStyle = UITextBorderStyleRoundedRect;
    titleField.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    titleField.textColor = [UIColor grayColor];
    titleField.minimumFontSize = 8;
    titleField.adjustsFontSizeToFitWidth = YES;
    titleField.delegate = self;
    titleField.keyboardType=UIKeyboardTypeDefault;
    
    //アラートのテキストフィールドのデフォルトタイトル文字列
    if(alertSection==1)
    {
        titleField.text=[titleArray objectAtIndex:alertIndex];
    }
    else if(alertSection==2)
    {
        titleField.text=[titleArray2 objectAtIndex:alertIndex];
    }
    else if(alertSection==3)
    {
        titleField.text=[titleArray3 objectAtIndex:alertIndex];
    }
    
    // UITextFieldの生成
    moneyField = [[UITextField alloc] initWithFrame:CGRectMake(80, 145, 180, 25)];
    moneyField.borderStyle = UITextBorderStyleRoundedRect;
    moneyField.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    moneyField.textColor = [UIColor grayColor];
    moneyField.minimumFontSize = 8;
    moneyField.adjustsFontSizeToFitWidth = YES;
    moneyField.delegate = self;
    moneyField.keyboardType=UIKeyboardTypeNumberPad;
    
    //アラートのテキストフィールドのデフォルト金額文字列
    if(alertSection==1)
    {
        moneyField.text=[moneyArray objectAtIndex:alertIndex];
    }
    else if(alertSection==2)
    {
        moneyField.text=[moneyArray2 objectAtIndex:alertIndex];
    }
    else if(alertSection==3)
    {
        moneyField.text=[moneyArray3 objectAtIndex:alertIndex];
    }
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 115, 60, 25)];
    label.text=NSLocalizedString(@"項目",nil);
    label.font=[UIFont fontWithName:@"Arial" size:12];
    label.textColor=[UIColor colorWithRed:0.202 green:0.3 blue:0.202 alpha:0.99];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    [blankDialog addSubview:label];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 145, 60, 25)];
    label2.text=NSLocalizedString(@"金額",nil);
    label2.font=[UIFont fontWithName:@"Arial" size:12];
    label2.textColor=[UIColor colorWithRed:0.202 green:0.3 blue:0.202 alpha:0.99];
    label2.backgroundColor=[UIColor clearColor];
    label2.textAlignment=NSTextAlignmentCenter;
    [blankDialog addSubview:label2];
    
    // アラートビューにテキストフィールドを埋め込む
    [blankDialog addSubview:titleField];
    [blankDialog addSubview:moneyField];
    [blankDialog addSubview:expLabel];
    [blankDialog addSubview:cancelBtn];
    [blankDialog addSubview:okBtn];
    
    [blankDialog show];

    // テキストフィールドをファーストレスポンダに
    [titleField becomeFirstResponder];
}

/*******************************************************************
 関数名　　willPresentAlertView
 概要	 アラートのカスタマイズ
 引数　　　:(UIAlertView *)alertView
 戻り値   なし
 *******************************************************************/
/*
- (void)willPresentAlertView:(UIAlertView *)alertView
{
    // カスタムアラートの場合
    if (alertView.tag == 1)
    {
        // アラートの表示サイズを設定
        CGRect alertFrame;
        alertFrame = CGRectMake((self.view.frame.size.width-300)/2, (self.view.frame.size.height-240)/2-55, 300, 240);
        alertView.frame = alertFrame;
        int uiButtonNum=0;
        
        // アラート上のオブジェクトの位置を修正(アラート表示サイズを変更すると位置がずれるため)
        for (UIView* view in alertView.subviews) {
            // ボタン
            if ([view isKindOfClass:NSClassFromString(@"UIThreePartButton")] ||     // iOS4用
                [view isKindOfClass:NSClassFromString(@"UIAlertButton")])           // iOS5用
            {
                // ボタンのサイズを設定
                view.frame = CGRectMake(0, 0, 120, 40);
                
                // 「いいえ」ボタン
                if (uiButtonNum == 0)
                {
                    view.center = CGPointMake(alertView.frame.size.width / 2.0-65, 200);
                }
                else if(uiButtonNum == 1)
                {
                    view.center = CGPointMake(alertView.frame.size.width / 2.0+65, 200);
                }
                uiButtonNum++;
            }
        }
    }
}*/

-(void)cancelDialog
{
    [blankDialog cancel];
}

-(void)okDialog
{
    if(alertFlag==10)                           //エディットアラート
    {
        if ([titleField.text length]==0)        //項目未入力
        {
            [self errorAlertView:0];
            return;
        }
        else if([titleField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]>16)   //項目文字数超過
        {
            [self errorAlertView:1];
            return;
        }
        else if([moneyField.text length]==0)    //金額未入力
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
            
            NSString *str = [self editString:titleField.text edit:moneyField.text];         //項目と金額を整形
            
            if(alertSection==1)                                                             //セクション1配列格納
            {
                [_objects setObject:str atIndexedSubscript:alertIndex];
                [titleArray setObject:titleField.text atIndexedSubscript:alertIndex];
                [moneyArray setObject:moneyField.text atIndexedSubscript:alertIndex];
            }
            else if(alertSection==2)                                                        //セクション2配列格納
            {
                [_objects2 setObject:str atIndexedSubscript:alertIndex];
                [titleArray2 setObject:titleField.text atIndexedSubscript:alertIndex];
                [moneyArray2 setObject:moneyField.text atIndexedSubscript:alertIndex];
            }
            else if(alertSection==3)                                                        //セクション3配列格納
            {
                [_objects3 setObject:str atIndexedSubscript:alertIndex];
                [titleArray3 setObject:titleField.text atIndexedSubscript:alertIndex];
                [moneyArray3 setObject:moneyField.text atIndexedSubscript:alertIndex];
            }
            
            [self saveData];                    //データ保存
            [self makeEstimate];                //予算算出
            [self.tableView reloadData];        //テーブルデータ更新
            [blankDialog cancel];
        }
    }
    else if(alertFlag==30)                     //パスワード設定
    {
        if ([textField.text length]==0)         //パスワード未入力
        {
            [self errorAlertView:31];
            return;
        }
        else
        {
            if( ([textField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]>12) || ([textField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]<4) ) //パスワード文字列4~12文字以外
            {
                [self errorAlertView:32];
                return;
            }
            else
            {
                NSMutableCharacterSet *checkCharSet = [[NSMutableCharacterSet alloc] init];
                [checkCharSet addCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
                [checkCharSet addCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
                [checkCharSet addCharactersInString:@"1234567890"];
                if([[textField.text stringByTrimmingCharactersInSet:checkCharSet] length] > 0)  //英数字以外
                {
                    [self errorAlertView:33];
                    return;
                }
                else
                {
                    lock=1;                         //ロック
                    menuButton.enabled=true;
                    passString=textField.text;
                    [self saveData];                //データ保存
                    [self.tableView reloadData];    //テーブル更新
                    [blankDialog cancel];
                }
            }
        }
    }
    else if(alertFlag==40)                         //パスワード入力
    {
        if(([textField.text isEqualToString:@"we all live in a yellow submarine"]))  //パスワード噴出時再設定用
        {
            [blankDialog cancel];
            lock=0;
            menuButton.enabled=false;
            [self passwordAlert];
            [textField resignFirstResponder];
            return;
        }
        
        if(!([textField.text isEqualToString:passString]))  //パスワード不一致
        {
            [self errorAlertView:41];
            return;
        }
        else                                                //パスワード一致
        {
            lock=1;                                         //ロック解除
            menuButton.enabled=true;
            [self saveData];                                //データ保存
            [self.tableView reloadData];                    //テーブル更新
            [blankDialog cancel];
        }
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
        }
        else if(alertFlag==50)                      //パスワードアラートでエラーになった場合
        {
            alertFlag=0;
            [self passwordAlert];                   //アラート再表示
        }*/
    }
    //設定画面からOKボタンが選択された場合
    else if (buttonIndex ==1)
    {/*
        if(alertFlag==10)                           //エディットアラート
        {
            if ([titleField.text length]==0)        //項目未入力
            {
                [self errorAlertView:0];
                return;
            }
            else if([titleField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]>16)   //項目文字数超過
            {
                [self errorAlertView:1];
                return;
            }
            else if([moneyField.text length]==0)    //金額未入力
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
                
                NSString *str = [self editString:titleField.text edit:moneyField.text];         //項目と金額を整形
                
                if(alertSection==1)                                                             //セクション1配列格納
                {
                    [_objects setObject:str atIndexedSubscript:alertIndex];
                    [titleArray setObject:titleField.text atIndexedSubscript:alertIndex];
                    [moneyArray setObject:moneyField.text atIndexedSubscript:alertIndex];
                }
                else if(alertSection==2)                                                        //セクション2配列格納
                {
                    [_objects2 setObject:str atIndexedSubscript:alertIndex];
                    [titleArray2 setObject:titleField.text atIndexedSubscript:alertIndex];
                    [moneyArray2 setObject:moneyField.text atIndexedSubscript:alertIndex];
                }
                else if(alertSection==3)                                                        //セクション3配列格納
                {
                    [_objects3 setObject:str atIndexedSubscript:alertIndex];
                    [titleArray3 setObject:titleField.text atIndexedSubscript:alertIndex];
                    [moneyArray3 setObject:moneyField.text atIndexedSubscript:alertIndex];
                }
                
                [self saveData];                    //データ保存
                [self makeEstimate];                //予算算出
                [self.tableView reloadData];        //テーブルデータ更新
            }
        }
        else if(alertFlag==30)                     //パスワード設定
        {
            if ([textField.text length]==0)         //パスワード未入力
            {
                [self errorAlertView:31];
                return;
            }
            else
            {
                if( ([textField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]>12) || ([textField.text lengthOfBytesUsingEncoding:NSShiftJISStringEncoding]<4) ) //パスワード文字列4~12文字以外
                {
                    [self errorAlertView:32];
                    return;
                }
                else
                {
                    NSMutableCharacterSet *checkCharSet = [[NSMutableCharacterSet alloc] init];
                    [checkCharSet addCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
                    [checkCharSet addCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
                    [checkCharSet addCharactersInString:@"1234567890"];
                    if([[textField.text stringByTrimmingCharactersInSet:checkCharSet] length] > 0)  //英数字以外
                    {
                        [self errorAlertView:33];
                        return;
                    }
                    else
                    {
                        lock=1;                         //ロック
                        menuButton.enabled=true;
                        passString=textField.text;
                        [self saveData];                //データ保存
                        [self.tableView reloadData];    //テーブル更新
                    }
                }
            }
        }
        else if(alertFlag==40)                         //パスワード入力
        {
            if(([textField.text isEqualToString:@"we all live in a yellow submarine"]))  //パスワード噴出時再設定用
            {
                lock=0;
                menuButton.enabled=false;
                [self passwordAlert];
                return;
            }
            
            if(!([textField.text isEqualToString:passString]))  //パスワード不一致
            {
                [self errorAlertView:41];
                return;
            }
            else                                                //パスワード一致
            {
                lock=1;                                         //ロック解除
                menuButton.enabled=true;
                [self saveData];                                //データ保存
                [self.tableView reloadData];                    //テーブル更新
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
                                              otherButtonTitles:@"OK", nil];
    // アラート表示
    [alertView show];*/
}

/*******************************************************************
 関数名　　insertNewObject:
 概要	 収入項目テーブルセルの追加処理
 引数　　　:(id)sender センダーオブジェクト
 戻り値   なし
 *******************************************************************/
- (void)insertNewObject:(id)sender
{
    [self initArray];                   //配列初期化
    
    NSInteger lastCell=_objects.count;  //オブジェクトの数
    
    [_objects insertObject:[NSString stringWithFormat:NSLocalizedString(@"項目名\n0",nil)] atIndex:lastCell];     //項目追加
    
    [titleArray insertObject:[NSString stringWithFormat:NSLocalizedString(@"項目名",nil)] atIndex:lastCell];
    [moneyArray insertObject:[NSString stringWithFormat:NSLocalizedString(@"0",nil)] atIndex:lastCell];
    
    for(int i=(titleArray.count-1)*3;i<(titleArray.count-1)*3+3;i++)
    {
        [resultMoneyArray insertObject:@"0" atIndex:i];
    }
    /*
    for(int i=0;i<10;i++)
    {
        [resultMoneyArray addObject:@"0"];
    }*/
    
    [self saveData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastCell inSection:1];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*******************************************************************
 関数名　　insertNewObject2:
 概要	 貯蓄項目テーブルセルの追加処理
 引数　　　:(id)sender センダーオブジェクト
 戻り値   なし
 *******************************************************************/
- (void)insertNewObject2:(id)sender
{
    [self initArray];                   //配列初期化
    
    NSInteger lastCell=_objects2.count; //オブジェクトの数
    
    [_objects2 insertObject:[NSString stringWithFormat:NSLocalizedString(@"項目名\n0",nil)] atIndex:lastCell];    //項目追加
    
    [titleArray2 insertObject:NSLocalizedString(@"項目名",nil) atIndex:lastCell];
    [moneyArray2 insertObject:NSLocalizedString(@"0",nil) atIndex:lastCell];
    
    for(int i=(titleArray.count+titleArray2.count-1)*3;i<(titleArray.count+titleArray2.count-1)*3+3;i++)
    {
        [resultMoneyArray insertObject:@"0" atIndex:i];
    }
    
    [self saveData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastCell inSection:2];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*******************************************************************
 関数名　　insertNewObject3:
 概要	 支出項目テーブルセルの追加処理
 引数　　　:(id)sender センダーオブジェクト
 戻り値   なし
 *******************************************************************/
- (void)insertNewObject3:(id)sender
{
    [self initArray];                   //配列初期化
    
    NSInteger lastCell=_objects3.count; //オブジェクトの数
    
    [_objects3 insertObject:[NSString stringWithFormat:NSLocalizedString(@"項目名\n0",nil)] atIndex:lastCell];    //項目追加
    
    [titleArray3 insertObject:NSLocalizedString(@"項目名",nil) atIndex:lastCell];
    [moneyArray3 insertObject:NSLocalizedString(@"0",nil) atIndex:lastCell];
    /*
    resultMoneyArray=[[NSMutableArray alloc]initWithObjects:nil];

    for(int i=0;i<(titleArray.count+titleArray2.count+titleArray3.count)*3;i++)
    {
        [resultMoneyArray addObject:@"0"];
    }*/
    for(int i=0;i<3;i++)
    {
        [resultMoneyArray addObject:@"0"];
    }
    [self saveData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastCell inSection:3];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Table View

/*******************************************************************
 関数名　　numberOfSectionsInTableView
 概要	 テーブルビューのセクション数を返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 戻り値   (NSInteger) :　セクション数
 *******************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(switchFlag==0)   //スイッチオフの場合
    {
        return 1;       //セクション0のみ表示
    }
    else                //スイッチオンの場合
    {
        return 5;       //セクション0~4まで表示
    }
}

/*******************************************************************
 関数名　　tableView titleForHeaderInSection
 概要	 テーブルビューのセクションのタイトル文字列を返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSInteger)section　セクション番号
 戻り値   (NSString *) セクションのタイトル文字列
 *******************************************************************/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0: // 1個目のセクションの場合
            return NSLocalizedString(@"設定",nil);
            break;
        case 1: // 2個目のセクションの場合
            return NSLocalizedString(@"収入",nil);
            break;
        case 2: // 3個目のセクションの場合
            return NSLocalizedString(@"貯蓄",nil);
            break;
        case 3: // 4個目のセクションの場合
            return NSLocalizedString(@"支出",nil);
            break;
        case 4: // 5個目のセクションの場合
            return NSLocalizedString(@"予算",nil);
            break;
    }
    return nil; //ビルド警告回避用
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
    switch (section) {
        case 0: //1個目のセクション
            if(switchFlag==0)   //スイッチオフの場合
            {
                return 1;       //セルは1つ
            }
            else
            {
                return 4;       //セルは4つ
            }
            break;
        case 1: //2個目のセクション
            return _objects.count;  //整形した項目と金額数
            break;
        case 2: //3個目のセクション
            return _objects2.count; //整形した項目と金額数
            break;
        case 3: //4個目のセクション
            return _objects3.count; //整形した項目と金額数
            break;
        case 4: //5個目のセクション
            return 5;               //セルは5つ
            break;
        default:
            return 0;
            break;
    }
}

// Customize the appearance of table view cells.

/*******************************************************************
 関数名　　tableView cellForRowAtIndexPath
 概要	 テーブルビューのセルの表示を行う
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSIndexPath *)indexPath　インデックスパス
 戻り値   (UITableViewCell *)テーブルビューのセル
 *******************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セル
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.numberOfLines=2;
    UIColor *textcolor=[UIColor colorWithHue:0.71 saturation:0.09 brightness:0.99 alpha:1.0];
    UIFont *cellFont=[UIFont fontWithName:[fontArray objectAtIndex:value1] size:[[sizeArray objectAtIndex:value2]floatValue]];
    cell.textLabel.font=cellFont;
    cell.backgroundColor=[UIColor clearColor];    
    
    UIImage *image2 = [UIImage imageNamed:@"image1"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    
    UIImage *image3 = [UIImage imageNamed:@"image2"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image3];
    
    UIImage *image4 = [UIImage imageNamed:@"image3"];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:image4];
    
    UIImage *image5 = [UIImage imageNamed:@"image4"];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:image5];
    
    UIImage *image6 = [UIImage imageNamed:@"image5"];
    UIImageView *imageView6 = [[UIImageView alloc] initWithImage:image6];
    
    UIImage *backimage1 = [UIImage imageNamed:@"back1"];
    UIImageView *backimageView1 = [[UIImageView alloc] initWithImage:backimage1];
    
    UIImage *backimage2 = [UIImage imageNamed:@"back2"];
    UIImageView *backimageView2 = [[UIImageView alloc] initWithImage:backimage2];
    
    UIImage *backimage3 = [UIImage imageNamed:@"back3"];
    UIImageView *backimageView3 = [[UIImageView alloc] initWithImage:backimage3];
    
    UIImage *backimage4 = [UIImage imageNamed:@"back4"];
    UIImageView *backimageView4 = [[UIImageView alloc] initWithImage:backimage4];
    
    if(indexPath.section==0)    //1個目のセクション
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        //セレクションスタイル
        cell.textLabel.textColor=textcolor;
        
        if(indexPath.row==0)                                            //1個目のセル
        {
            cell.backgroundView=backimageView1;
            cell.textLabel.text=NSLocalizedString(@"表示\n",nil);
            UISwitch *switchObj = [[UISwitch alloc]init];               //スイッチオブジェクト生成
            switchObj.on = (switchFlag)?YES:NO;                         //スイッチフラグが1ならオン、0ならオフ
            [switchObj addTarget:self action:@selector(settingSwitch:) forControlEvents:UIControlEventValueChanged];                                                      //スイッチチェンジの際のメソッド
            cell.accessoryView = switchObj;                             //セルに表示
        }
        else if(indexPath.row==1)                                       //2個目のセル
        {
            cell.backgroundView=backimageView2;
            cell.textLabel.text=NSLocalizedString(@"収入項目\n",nil);
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];     //項目追加ボタンの生成
            addButton.frame = CGRectMake(150, 0, 40, 40);
            [addButton addTarget:self action:@selector(insertNewObject:) forControlEvents:UIControlEventTouchUpInside];
            [addButton setImage:[UIImage imageNamed:@"add_file"] forState:UIControlStateNormal];
            [addButton setTitle:@"追加" forState:UIControlStateNormal];
            cell.accessoryView=addButton;
        }
        else if(indexPath.row==2)                                       //3個目のセル
        {
            cell.backgroundView=backimageView3;
            cell.textLabel.text=NSLocalizedString(@"貯蓄項目\n",nil);
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];     //項目追加ボタンの生成
            addButton.frame = CGRectMake(150, 0, 40, 40);
            [addButton addTarget:self action:@selector(insertNewObject2:) forControlEvents:UIControlEventTouchUpInside];
            [addButton setImage:[UIImage imageNamed:@"add_file"] forState:UIControlStateNormal];
            [addButton setTitle:@"追加" forState:UIControlStateNormal];
            cell.accessoryView=addButton;
        }
        else if(indexPath.row==3)                                       //4個目のセル
        {
            cell.backgroundView=backimageView4;
            cell.textLabel.text=NSLocalizedString(@"支出項目\n",nil);
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];     //項目追加ボタンの生成
            addButton.frame = CGRectMake(150, 0, 40, 40);
            [addButton addTarget:self action:@selector(insertNewObject3:) forControlEvents:UIControlEventTouchUpInside];
            [addButton setImage:[UIImage imageNamed:@"add_file"] forState:UIControlStateNormal];
            [addButton setTitle:@"追加" forState:UIControlStateNormal];
            cell.accessoryView=addButton;
        }
    }
    
    else if(indexPath.section==1)                                       //2個目のセクション
    {
        if(indexPath.row%5==0)
        {
            cell.backgroundView=imageView5;
        }
        else if(indexPath.row%5==1)
        {
            cell.backgroundView=imageView6;
        }
        else if(indexPath.row%5==2)
        {
            cell.backgroundView=imageView4;
        }
        else if(indexPath.row%5==3)
        {
            cell.backgroundView=imageView3;
        }
        else if(indexPath.row%5==4)
        {
            cell.backgroundView=imageView2;
        }
        UIImageView *editImage=[[UIImageView alloc]init];
        editImage.image=[UIImage imageNamed:@"gtk_edit"];
        editImage.frame = CGRectMake(150, 0, 40, 40);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        //セルのセレクションスタイル
        cell.textLabel.textColor=textcolor;
        NSDate *object = _objects[indexPath.row];
        cell.textLabel.text = [object description];
        cell.accessoryView=editImage;
    }
    
    else if(indexPath.section==2)                                       //3個目のセクション
    {
        if(indexPath.row%5==0)
        {
            cell.backgroundView=imageView3;
        }
        else if(indexPath.row%5==1)
        {
            cell.backgroundView=imageView2;
        }
        else if(indexPath.row%5==2)
        {
            cell.backgroundView=imageView5;
        }
        else if(indexPath.row%5==3)
        {
            cell.backgroundView=imageView6;
        }
        else if(indexPath.row%5==4)
        {
            cell.backgroundView=imageView4;
        }
        UIImageView *editImage=[[UIImageView alloc]init];
        editImage.image=[UIImage imageNamed:@"gtk_edit"];
        editImage.frame = CGRectMake(150, 0, 40, 40);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        //セルのセレクションスタイル
        cell.textLabel.textColor=textcolor;
        NSDate *object = _objects2[indexPath.row];
        cell.textLabel.text = [object description];
        cell.accessoryView=editImage;
    }
    
    else if(indexPath.section==3)                                       //4個目のセクション
    {
        if(indexPath.row%5==0)
        {
            cell.backgroundView=imageView6;
        }
        else if(indexPath.row%5==1)
        {
            cell.backgroundView=imageView4;
        }
        else if(indexPath.row%5==2)
        {
            cell.backgroundView=imageView3;
        }
        else if(indexPath.row%5==3)
        {
            cell.backgroundView=imageView2;
        }
        else if(indexPath.row%5==4)
        {
            cell.backgroundView=imageView5;
        }
        
        UIImageView *editImage=[[UIImageView alloc]init];
        editImage.image=[UIImage imageNamed:@"gtk_edit"];
        editImage.frame = CGRectMake(150, 0, 40, 40);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        //セルのセレクションスタイル
        cell.textLabel.textColor=textcolor;
        NSDate *object = _objects3[indexPath.row];
        cell.textLabel.text = [object description];
        cell.accessoryView=editImage;
    }
    
    else if(indexPath.section==4)                                       //5個目のセクション
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        //セルのセレクションスタイル
        NSDate *object = _estimateObjext[indexPath.row];
        cell.textLabel.text = [object description];
        cell.imageView.image=nil;
        cell.accessoryView=nil;
        
        //セルごとに背景色を設定
        if(indexPath.row==0)
        {
            cell.backgroundView=imageView2;
            cell.textLabel.textColor=textcolor;
        }
        else if(indexPath.row==1)
        {
            cell.backgroundView=imageView3;
            cell.textLabel.textColor=textcolor;
        }
        else if(indexPath.row==2)
        {
            cell.backgroundView=imageView4;
            cell.textLabel.textColor=textcolor;
        }
        else if(indexPath.row==3)
        {
            cell.backgroundView=imageView5;
            cell.textLabel.textColor=textcolor;
        }
        else if(indexPath.row==4)
        {
            cell.backgroundView=imageView6;
            cell.textLabel.textColor=textcolor;
        }
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
 関数名　　tableView viewForHeaderInSection
 概要	 セクションヘッダー用のViewを返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSInteger)section セクション番号
 戻り値   (UIView *)　セクションヘッダー用のView
 *******************************************************************/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor blackColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2048, 36.0f)];
        UIImage *bgImage = [UIImage imageNamed:@"wall.png"];
        lbl.backgroundColor = [UIColor colorWithPatternImage: bgImage];
        lbl.textColor = [UIColor blackColor];
        lbl.text = NSLocalizedString(@" 設定",nil);
        [v addSubview:lbl];
        return v;
    }
    else if (section == 1){
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor blackColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2048, 36.0f)];
        UIImage *bgImage = [UIImage imageNamed:@"wall.png"];
        lbl.backgroundColor = [UIColor colorWithPatternImage: bgImage];
        lbl.textColor = [UIColor blackColor];
        lbl.text = NSLocalizedString(@" 収入",nil);
        [v addSubview:lbl];
        return v;
    }
    else if (section == 2){
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor blackColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2048, 36.0f)];
        UIImage *bgImage = [UIImage imageNamed:@"wall.png"];
        lbl.backgroundColor = [UIColor colorWithPatternImage: bgImage];
        lbl.textColor = [UIColor blackColor];
        lbl.text = NSLocalizedString(@" 貯蓄",nil);
        [v addSubview:lbl];
        return v;
    }
    else if (section == 3){
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor blackColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2048, 36.0f)];
        UIImage *bgImage = [UIImage imageNamed:@"wall.png"];
        lbl.backgroundColor = [UIColor colorWithPatternImage: bgImage];
        lbl.textColor = [UIColor blackColor];
        lbl.text = NSLocalizedString(@" 支出",nil);
        [v addSubview:lbl];
        return v;
    }
    else if (section == 4){
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor blackColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2048, 36.0f)];
        UIImage *bgImage = [UIImage imageNamed:@"wall.png"];
        lbl.backgroundColor = [UIColor colorWithPatternImage: bgImage];
        lbl.textColor = [UIColor blackColor];
        lbl.text = NSLocalizedString(@" 予算",nil);
        [v addSubview:lbl];
        return v;
    }
    else
    {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor blackColor];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2048, 36.0f)];
        UIImage *bgImage = [UIImage imageNamed:@"wall.png"];
        lbl.backgroundColor = [UIColor colorWithPatternImage: bgImage];
        lbl.textColor = [UIColor whiteColor];
        lbl.text = @" ";
        [v addSubview:lbl];
        return v;
    }
}

/*******************************************************************
 関数名　　tableView editingStyl®eForRowAtIndexPath
 概要	 テーブルビューのエディットスタイルを返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSIndexPath *)indexPath　インデックスパス
 戻り値   (UITableViewCell *)テーブルビューのエディットスタイル
 *******************************************************************/
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //非エディット時
    if (self.editing == NO )
    {
        return UITableViewCellEditingStyleNone;
    }
    //セクション0またはセクション4の場合
    if (indexPath.section==0 || indexPath.section==4)
    {
        return UITableViewCellEditingStyleNone;
    }
    //それ以外
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
}

/*******************************************************************
 関数名　　tableView canEditRowAtIndexPath:
 概要	 テーブルビューのエディット可否を返す
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(NSIndexPath *)indexPath　インデックスパス
 戻り値   (BOOL) エディット可否
 *******************************************************************/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/*******************************************************************
 関数名　　tableView commitEditingStyle
 概要	 テーブルビューのエディット時の動作定義
 引数　　　:(UITableView *)tableView　テーブルビュー
 :(UITableViewCellEditingStyle)editingStyle エディットスタイル
 :(NSIndexPath *)indexPath　インデックスパス
 戻り値   なし
 *******************************************************************/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)      //デリート選択時
    {
        if(indexPath.section==1)                                //セクション1
        {
            //選択オブジェクトの削除
            [_objects removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [titleArray removeObjectAtIndex:indexPath.row];
            [moneyArray removeObjectAtIndex:indexPath.row];
            
            for(int i=0;i<3;i++)
            {
                [resultMoneyArray removeObjectAtIndex:indexPath.row*3];
            }
            
            [self saveData];
            [self makeEstimate];
        }
        
        else if(indexPath.section==2)                                //セクション2
        {
            //選択オブジェクトの削除
            [_objects2 removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [titleArray2 removeObjectAtIndex:indexPath.row];
            [moneyArray2 removeObjectAtIndex:indexPath.row];
            
            for(int i=0;i<3;i++)
            {
                [resultMoneyArray removeObjectAtIndex:(titleArray.count+indexPath.row)*3];
            }

            [self saveData];
            [self makeEstimate];
        }
        
        else if(indexPath.section==3)                                //セクション3
        {
            //選択オブジェクトの削除
            [_objects3 removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [titleArray3 removeObjectAtIndex:indexPath.row];
            [moneyArray3 removeObjectAtIndex:indexPath.row];
            
            for(int i=0;i<3;i++)
            {
                [resultMoneyArray removeObjectAtIndex:(titleArray.count+titleArray2.count+indexPath.row)*3];
            }
            
            [self saveData];
            [self makeEstimate];
        }
        
        //テーブルの更新
        [self.tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
    }
}

/*******************************************************************
 関数名　　tableView canMoveRowAtIndexPath
 概要	 テーブルビューのセルの移動可否
 引数     :(NSIndexPath *)indexPath　インデックスパス
 戻り値   :(BOOL) セルの移動可否
 *******************************************************************/
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section>=1 && indexPath.section<=3)
    {
        return YES;
    }
    return NO;
}

/*******************************************************************
 関数名　　tableView moveRowAtIndexPath
 概要	 テーブルビューのエディット時の動作定義
 引数　　　:(NSIndexPath *)fromIndexPath toIndexPath　:移動元インデックスパス
 :(NSIndexPath *)toIndexPath                 :移動先インデックスパス
 戻り値   :なし
 *******************************************************************/
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if(fromIndexPath.section == 1)
    {
        id item = [_objects objectAtIndex:fromIndexPath.row]; // 移動対象を保持します。
        [_objects removeObjectAtIndex:fromIndexPath.row]; // 配列から一度消します。
        [_objects insertObject:item atIndex:toIndexPath.row]; // 保持しておいた対象を挿入します。
        
        id titleItem=[titleArray objectAtIndex:fromIndexPath.row];
        id moneyItem=[moneyArray objectAtIndex:fromIndexPath.row];
        [titleArray removeObjectAtIndex:fromIndexPath.row];
        [moneyArray removeObjectAtIndex:fromIndexPath.row];
        [titleArray insertObject:titleItem atIndex:toIndexPath.row];
        [moneyArray insertObject:moneyItem atIndex:toIndexPath.row];
        
        if(fromIndexPath.row>toIndexPath.row)
        {
            for(int i=0;i<3;i++)
            {
                id item=[resultMoneyArray objectAtIndex:fromIndexPath.row*3+2];
                [resultMoneyArray removeObjectAtIndex:fromIndexPath.row*3+2];
                [resultMoneyArray insertObject:item atIndex:toIndexPath.row*3];
            }
        }
    
        else
        {
            for(int i=0;i<3;i++)
            {
                id item=[resultMoneyArray objectAtIndex:fromIndexPath.row*3+(2-i)];
                [resultMoneyArray removeObjectAtIndex:fromIndexPath.row*3+(2-i)];
                [resultMoneyArray insertObject:item atIndex:(toIndexPath.row)*3+(2-i)];
            }            
        }
        [self saveData];
    }
    
    else if(fromIndexPath.section ==  2)
    {
        id item = [_objects2 objectAtIndex:fromIndexPath.row]; // 移動対象を保持します。
        [_objects2 removeObjectAtIndex:fromIndexPath.row]; // 配列から一度消します。
        [_objects2 insertObject:item atIndex:toIndexPath.row]; // 保持しておいた対象を挿入します。
        
        id titleItem=[titleArray2 objectAtIndex:fromIndexPath.row];
        id moneyItem=[moneyArray2 objectAtIndex:fromIndexPath.row];
        [titleArray2 removeObjectAtIndex:fromIndexPath.row];
        [moneyArray2 removeObjectAtIndex:fromIndexPath.row];
        [titleArray2 insertObject:titleItem atIndex:toIndexPath.row];
        [moneyArray2 insertObject:moneyItem atIndex:toIndexPath.row];
        
        if(fromIndexPath.row>toIndexPath.row)
        {
            for(int i=0;i<3;i++)
            {
                id item=[resultMoneyArray objectAtIndex:(titleArray.count+fromIndexPath.row)*3+2];
                [resultMoneyArray removeObjectAtIndex:(titleArray.count+fromIndexPath.row)*3+2];
                [resultMoneyArray insertObject:item atIndex:(titleArray.count+toIndexPath.row)*3];
            }
        }
        else
        {
            for(int i=0;i<3;i++)
            {
                id item=[resultMoneyArray objectAtIndex:(titleArray.count+fromIndexPath.row)*3+(2-i)];
                [resultMoneyArray removeObjectAtIndex:(titleArray.count+fromIndexPath.row)*3+(2-i)];
                [resultMoneyArray insertObject:item atIndex:(titleArray.count+toIndexPath.row)*3+(2-i)];
            }            
        }
        
        [self saveData];
    }
    
    else if(fromIndexPath.section == 3)
    {
        id item = [_objects3 objectAtIndex:fromIndexPath.row]; // 移動対象を保持します。
        [_objects3 removeObjectAtIndex:fromIndexPath.row]; // 配列から一度消します。
        [_objects3 insertObject:item atIndex:toIndexPath.row]; // 保持しておいた対象を挿入します。
        
        id titleItem=[titleArray3 objectAtIndex:fromIndexPath.row];
        id moneyItem=[moneyArray3 objectAtIndex:fromIndexPath.row];
        [titleArray3 removeObjectAtIndex:fromIndexPath.row];
        [moneyArray3 removeObjectAtIndex:fromIndexPath.row];
        [titleArray3 insertObject:titleItem atIndex:toIndexPath.row];
        [moneyArray3 insertObject:moneyItem atIndex:toIndexPath.row];
        
        if(fromIndexPath.row>toIndexPath.row)
        {
            for(int i=0;i<3;i++)
            {
                id item=[resultMoneyArray objectAtIndex:(titleArray.count+titleArray2.count+fromIndexPath.row)*3+2];
                [resultMoneyArray removeObjectAtIndex:(titleArray.count+titleArray2.count+fromIndexPath.row)*3+2];
                [resultMoneyArray insertObject:item atIndex:(titleArray.count+titleArray2.count+toIndexPath.row)*3];
            }
        }
        else
        {
            for(int i=0;i<3;i++)
            {
                id item=[resultMoneyArray objectAtIndex:(titleArray.count+titleArray2.count+fromIndexPath.row)*3+(2-i)];
                [resultMoneyArray removeObjectAtIndex:(titleArray.count+titleArray2.count+fromIndexPath.row)*3+(2-i)];
                [resultMoneyArray insertObject:item atIndex:(titleArray.count+titleArray2.count+toIndexPath.row)*3+(2-i)];
            }            
        }
        
        [self saveData];
    }
}

/*******************************************************************
 関数名　　tableView targetIndexPathForMoveFromRowAtIndexPath
 概要	 テーブルビューの移動時のコミット処理
 引数    :(NSIndexPath *)sourceIndexPath toProposedIndexPath :移動元インデックスパス
 :(NSIndexPath *)proposedDestinationIndexPath        :移動先インデックスパス
 戻り値   (NSIndexPath)移動先確定後のインデックスパス
 *******************************************************************/
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        // 移動後のセクションが同じセクションならそのまま
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row inSection:proposedDestinationIndexPath.section];
    }
    else if (sourceIndexPath.section > proposedDestinationIndexPath.section)
    {
        // 移動後のセクションのほうが上(小さい)なら、元のセクションの一番上(0)にする
        return [NSIndexPath indexPathForRow:sourceIndexPath.row inSection:sourceIndexPath.section];
    }
    else {
        // 移動後のセクションのほうが下(大きい)なら、元のセクションの一番下にする
        return [NSIndexPath indexPathForRow:sourceIndexPath.row inSection:sourceIndexPath.section];
    }
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
    alertIndex=indexPath.row;       //列数
    alertSection=indexPath.section; //セクション番号/*
    if(indexPath.section>=1 && indexPath.section<=3)    //セクション1~3の場合
    {
        [self editAlert];           //エディットアラート表示
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
