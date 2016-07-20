//
//  public.h
//  sinaNews
//
//  Created by a on 16/6/21.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#ifndef public_h
#define public_h


//屏幕尺寸
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height


//收藏数据库文件路径
#define SHOUCANG_DBPATH @"shoucangData.sqlite"


//接口
//首页
//头条接口
#define SHOUYE_TOUTIAO @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=506&urlSign=9370ed2967&behavior=manual&channel=news_toutiao&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"


//推荐接口
#define SHOUYE_TUIJIAN @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=413&urlSign=82279a1147&behavior=auto&channel=news_tuijian&furtherKey_otherParameter_actionKey=furtherKey_otherParameter_updateAction&length=20&offset=0&p=0&pullDirection=down&pullTimes=1&replacedFlag=0&s=20"



//视频接口
#define SHOUYE_SHIPIN @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=715&urlSign=e2b22a4d4d&behavior=manual&channel=news_video&p=1&pullDirection=down&pullTimes=4&replacedFlag=1&s=20"



//娱乐接口
#define SHOUYE_YULE @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=360&urlSign=518545f8cb&behavior=manual&channel=news_ent&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//体育接口
#define SHOUYE_TIYU @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=851&urlSign=b68811b4c4&behavior=manual&channel=news_sports&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//财经接口
#define SHOUYE_CAIJING @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=789&urlSign=049ae06a0f&behavior=manual&channel=news_finance&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//科技接口
#define SHOUYE_KEJI @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=613&urlSign=3f302b3aac&behavior=manual&channel=news_tech&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//汽车接口
#define SHOUYE_QICHE @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=701&urlSign=c43d676635&behavior=manual&channel=news_auto&cityCode=310100&feedShowStyle=miaocheStyle&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&resolution=1242*2208&s=20"



//图片接口
#define SHOUYE_TUPIAN @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=297&urlSign=e4395c9923&behavior=auto&channel=news_pic&p=1&pullDirection=down&pullTimes=1&replacedFlag=0&s=20"


//军事接口
#define SHOUYE_JUNSHI @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=796&urlSign=deed9f9b30&behavior=manual&channel=news_mil&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//社会接口
#define SHOUYE_SHEHUI @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=320&urlSign=f52beac934&behavior=manual&channel=news_sh&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//搞笑接口
#define SHOUYE_GAOXIAO @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=734&urlSign=0adb7e48b0&behavior=manual&channel=news_funny&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"




//NBA接口
#define SHOUYE_NBA @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=270&urlSign=44726f4ce4&behavior=manual&channel=news_nba&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//八卦接口
#define SHOUYE_BAGUA @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=600&urlSign=9d882cedb7&behavior=manual&channel=news_gossip&p=1&pullDirection=down&pullTimes=2&replacedFlag=0&s=20"



//时尚接口
#define SHOUYE_SHISHANG @"http://newsapi.sina.cn/?resource=feed&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=975&urlSign=2d34cb0f62&behavior=auto&channel=news_fashion&p=1&pullDirection=down&pullTimes=1&replacedFlag=0&s=20"





//热门
#define REMEN @"http://newsapi.sina.cn/?resource=rank/list&accessToken=&chwm=3023_0001&city=CHXX0116&connectionType=2&deviceId=7b13fce4fc93f672672a445019c47c63770f623c&deviceModel=apple-iphone6plus&from=6051093012&idfa=03881729-4F69-4EE3-8AF2-BEB116405AE0&idfv=193FEEA0-E952-45BE-812A-9BF5D7FEDF3E&imei=7b13fce4fc93f672672a445019c47c63770f623c&location=31.211164%2C121.483025&osVersion=9.3.2&resolution=1242x2208&ua=apple-iphone6plus__SinaNews__5.1__iphone__9.3.2&weiboSuid=&weiboUid=&wm=b207&rand=588&urlSign=03c96ee04d"



//发现
//吃喝玩乐

//明星榜
//赛事直播
//新浪众测
//H5小游戏

//新浪爱拍
//识趣玩物
//牛眼看盘
//新浪小说

//热映影讯
//彩票开奖
//时尚美搭
//高考院校


#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

#import "UMSocial.h"

#import "CoreData+MagicalRecord.h"


#import "ShouCangModelData.h"



#endif /* public_h */
