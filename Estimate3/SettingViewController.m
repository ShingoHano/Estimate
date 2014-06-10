//
//  SettingViewController.m
//  Estimate3
//
//  Created by 羽野 真悟 on 13/04/28.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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

    //タイトル設定
    self.title=@"Setting";
    
    UIBarButtonItem *menuButton= [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    self.navigationItem.leftBarButtonItem=menuButton;
    
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
    
    [self loadData];
    
    NSString *labelString=NSLocalizedString(@"セルの表示設定",nil);
    UIImage *back2 =[UIImage imageNamed:@"wall.png"];
    UILabel *fontLavel=[[UILabel alloc]init];
    fontLavel.frame=CGRectMake(0, 20, 2048, 30);
    fontLavel.text=labelString;
//    fontLavel.textColor=[UIColor colorWithHue:0.71 saturation:0.09 brightness:0.99 alpha:1.0];
    fontLavel.backgroundColor=[UIColor colorWithPatternImage:back2];
    [self.view addSubview:fontLavel];
    
    NSString *labelString2=NSLocalizedString(@"セルの表示イメージ",nil);
    UIImage *back3 =[UIImage imageNamed:@"wall.png"];
    UILabel *fontLavel2=[[UILabel alloc]init];
    fontLavel2.frame=CGRectMake(0, 250, 2048, 30);
    fontLavel2.text=labelString2;
//    fontLavel2.textColor=[UIColor colorWithHue:0.71 saturation:0.09 brightness:0.99 alpha:1.0];
    fontLavel2.backgroundColor=[UIColor colorWithPatternImage:back3];
    [self.view addSubview:fontLavel2];
    
    UIImage *back =[UIImage imageNamed:@"image2.png"];
    UIImage *img_ato;  // リサイズ後UIImage
    
    UIGraphicsBeginImageContext(CGSizeMake(320, 41));
    [back drawInRect:CGRectMake(0, 0, 320, 41)];
    img_ato = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *labelString3=NSLocalizedString(@"   給与収入\n   123,456",nil);
    sampleLabel=[[UILabel alloc]init];
    sampleLabel.frame=CGRectMake(10, 290, 300, 41);
    sampleLabel.textColor=[UIColor colorWithHue:0.71 saturation:0.09 brightness:0.99 alpha:1.0];
    sampleLabel.numberOfLines=2;
    sampleLabel.backgroundColor=[UIColor colorWithPatternImage:img_ato];
    sampleLabel.text=labelString3;
    
    UIPickerView *piv = [[UIPickerView alloc] init];
    piv.frame=CGRectMake(10,60,300,162);
    piv.delegate = self;  // デリゲートを自分自身に設定
    piv.dataSource = self;  // データソースを自分自身に設定
    piv.showsSelectionIndicator=YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        piv.frame=CGRectMake(130,60,500,162);
        
        sampleLabel.frame=CGRectMake(130, 280, 500, 41);
    }
    
    [piv selectRow:value1 inComponent:0 animated:NO];
    [piv selectRow:value2 inComponent:1 animated:NO];
    [piv selectRow:value3 inComponent:2 animated:NO];


    [self labelChange];
    [self.view addSubview:sampleLabel];
    [self.view addSubview:piv];
}

/*******************************************************************
 関数名　　saveData
 概要	 辞書データの保存処理
 引数	なし
 戻り値	なし
 *******************************************************************/
- (void)saveData
{
    //データ保存
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    
    [_userDefaults setObject:[fontArray objectAtIndex:value1] forKey:@"FONT_NAME"];
    [_userDefaults setInteger:[[sizeArray objectAtIndex:value2]intValue] forKey:@"FONT_SIZE"];
    [_userDefaults setFloat:[[cellArray objectAtIndex:value3]floatValue] forKey:@"CELL_SIZE"];
    
    [_userDefaults setInteger:value1 forKey:@"VALUE1"];
    [_userDefaults setInteger:value2 forKey:@"VALUE2"];
    [_userDefaults setInteger:value3 forKey:@"VALUE3"];
    
    [_userDefaults synchronize]; //保存を実行
}

/*******************************************************************
 関数名　　loadData
 概要	 辞書データの読み込み処理
 引数	なし
 戻り値	なし
 *******************************************************************/
- (void)loadData
{
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    
    value1=[_userDefaults integerForKey:@"VALUE1"];
    value2=[_userDefaults integerForKey:@"VALUE2"];
    value3=[_userDefaults integerForKey:@"VALUE3"];
    
    value1=value1?value1:0;
    value2=value2?value2:0;
    value3=value3?value3:0;
}

/*******************************************************************
 関数名　　labelChange
 概要	 セルの表示イメージの更新処理
 引数	なし
 戻り値	なし
 *******************************************************************/
-(void)labelChange
{
    NSString *tempString=[fontArray objectAtIndex:value1];
    NSInteger tempInteger=[[sizeArray objectAtIndex:value2]intValue];
    [sampleLabel setFont:[UIFont fontWithName:tempString size:tempInteger]];
    
    float cellInteger=[[cellArray objectAtIndex:value3]floatValue];
    
    UIImage *back =[UIImage imageNamed:@"image1"];
    UIImage *img_ato;  // リサイズ後UIImage
    
    UIGraphicsBeginImageContext(CGSizeMake(320, cellInteger));
    [back drawInRect:CGRectMake(0, 0, 320, cellInteger)];
    img_ato = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGRect frame=sampleLabel.frame;
    sampleLabel.frame=CGRectMake(frame.origin.x,frame.origin.y,frame.size.width,cellInteger);
    sampleLabel.backgroundColor=[UIColor colorWithPatternImage:img_ato];
    
    [self saveData];
}

/*******************************************************************
 関数名　　pickerView didSelectRow
 概要	 ピッカービューの選択状態の取得
 引数	:(UIPickerView *)pickerView   ピッカービュー
        :(NSInteger)row               列数
        :(NSInteger)component         何列目か
 戻り値	なし
 *******************************************************************/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    value1 = [pickerView selectedRowInComponent:0];
    value2 = [pickerView selectedRowInComponent:1];
    value3 = [pickerView selectedRowInComponent:2];
    // ラベルに表示
    [self labelChange];
}

/*******************************************************************
 関数名　　numberOfComponentsInPickerView
 概要	 ピッカービューの列数を返す
 引数	:(UIPickerView*)pickerView　ピッカービュー
 戻り値	(NSInteger) 列数
 *******************************************************************/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 3;
}

/*******************************************************************
 関数名　　pickerView numberOfRowsInComponent
 概要	 ピッカービューの行数を返す
 引数	:(UIPickerView*)pickerView　ピッカービュー
        :(NSInteger)component　何列目か
 戻り値	(NSInteger) 行数
 *******************************************************************/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return fontArray.count;  // 1列目は10行
    }
    else if(component==1)
    {
        return sizeArray.count;  // 2列目は5行
    }
    else
    {
        return cellArray.count;
    }
}

/*******************************************************************
 関数名　　pickerViewtitleForRow
 概要	 ピッカービューの選択されたデータ名を返す
 引数	:(UIPickerView*)pickerView　ピッカービュー
        :(NSInteger)row forComponent　列数
        :(NSInteger)component　何列目か
 戻り値	(NSString*)　データ名
 *******************************************************************/
-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
        return [fontArray objectAtIndex:row];
    }
    else if(component==1)
    {
        return [sizeArray objectAtIndex:row];
    }
    else
    {
        return [cellArray objectAtIndex:row];
    }
}

/*******************************************************************
 関数名　　pickerView widthForComponent
 概要	 ピッカービューの列幅を返す
 引数	:(UIPickerView*)pickerView　ピッカービュー
 :(NSInteger)component　何列目か
 戻り値	(CGFloat)　列幅
 *******************************************************************/
-(CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component
{
    if(component==0)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            return 350;
        }
        else
        {
            return 180;
        }
    }
    else
    {
        return 40;
    }
}

/*******************************************************************
 関数名　　pickerView viewForRow
 概要	 ピッカービューに表示するビューの設定
 引数	:(NSInteger)row 何行目か
 　　　　 :(NSInteger)component　何列目か
        :(UIView *)view 設定するビュー
 戻り値	(UIView *)view　設定するビュー
 *******************************************************************/
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIFont *font = [UIFont boldSystemFontOfSize:10];
	UILabel *carsLabel = [[UILabel alloc]init];
    
    if(component==0)
    {
        carsLabel.frame=CGRectMake(140, 0, 160, 35);
        carsLabel.text = [fontArray objectAtIndex:(int)row];
    }
    else if(component==1)
    {
        carsLabel.frame=CGRectMake(300, 0, 20, 35);
        carsLabel.text = [sizeArray objectAtIndex:(int)row];
    }
    else
    {
        carsLabel.frame=CGRectMake(300, 0, 20, 35);
        carsLabel.text = [cellArray objectAtIndex:(int)row];
    }
    
	carsLabel.textColor = [UIColor blackColor];
    carsLabel.font = font;
    carsLabel.backgroundColor = [UIColor clearColor];
    carsLabel.opaque = NO;
	[view addSubview:carsLabel];
    
	return carsLabel;
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
