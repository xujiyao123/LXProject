//
//  HTMLViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 16/1/22.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "HTMLViewController.h"

@interface HTMLViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:self.scrollView];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.scrollView addSubview:self.webView];
    NSString *htmlString=@"<div class=\"rich_media_content \" id=\"js_content\"><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 0.8em 0px; font-size: 1em; line-height: 1.4; white-space: normal; box-sizing: border-box; padding: 0px; border: 0px none;\"><p><a data_ue_src=\"http://www.fxzhoumo.com/detail/course.html?courseid=5143&amp;from=singlemessage&amp;isappinstalled=1#rd\" target=\"_blank\" href=\"http://www.fxzhoumo.com/detail/course.html?courseid=5143&amp;from=singlemessage&amp;isappinstalled=1#rd\" send_referrer=\"false\"></a><a data_ue_src=\"http://www.fxzhoumo.com/detail/course.html?courseid=5143&amp;from=singlemessage&amp;isappinstalled=1#rd\" target=\"_blank\" href=\"http://www.fxzhoumo.com/detail/course.html?courseid=5143&amp;from=singlemessage&amp;isappinstalled=1#rd\" send_referrer=\"false\"><img data-w=\"\" data-ratio=\"1.8201438848920863\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMicYIykQjZGWh9zhBeoRIJ3ytqgW5nib7W9u7w3CXlWcDXpr6LwUVp39A/0?wx_fmt=jpeg\"  /><br  /></a></p><p><br  /></p><p style=\"text-align: center;\"><strong style=\"\">（点击图片参与活动，加入虐狗行列！）</strong></p><p><br  /></p><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 0.8em 0px; font-size: 1em; line-height: 1.4; white-space: normal; box-sizing: border-box; padding: 0px; border: 0px none;\"><p style=\"padding: 10px; border: 1px solid rgb(192, 200, 209); font-size: 87.5%; font-family: inherit; text-align: center; text-decoration: inherit; color: rgb(51, 51, 51); background-color: rgb(239, 239, 239); box-sizing: border-box; line-height: 1.75em;\">今天茄子酱要开门见山，开诚布公，开柙出虎<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />推给大家一个<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />由wuli闺蜜PP小姐推出的良心活动<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />单身狗请绕绕绕<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />恩爱情侣站出来<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />带上你的男票女票<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />走向无止境虐狗神坛<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></p><section style=\"display: block; width: 0px; height: 0px; clear: both;\"><br  /></section></section><p><span class=\"135brush\" data-brushtype=\"text\" style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: inherit; font-family: 楷体; font-style: normal; font-variant: normal; font-weight: normal; line-height: 28.4444465637207px; orphans: auto; text-align: center; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; border-color: rgb(216, 40, 33); font-size: 18px; letter-spacing: 2px; background-color: rgb(255, 255, 255);\"><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: inherit; font-size: 16px; font-family: 宋体, SimSun; line-height: 28.4444465637207px;\"></span></strong></span></p><p><br  /></p><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; margin-top: 0px; margin-bottom: 0px; clear: both; font-size: 1em; font-family: inherit; text-align: justify; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box; text-align: center;\"><p><strong>PP小姐为你们一对对的准备了 </strong></p><p><br  /></p><p><br  /></p><strong><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; margin-top: 0px; margin-bottom: 0px; clear: both; font-size: 1em; font-family: inherit; text-align: justify; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; box-sizing: border-box; width: 100%; margin: 0.5em 0px; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"width: 100%; border-bottom: 2px solid rgb(71, 193, 168); border-color: rgb(71, 193, 168); box-sizing: border-box;\"></section><section class=\"tn-Powered-by-XIUMI\" style=\"width: 0px; margin: auto; border-top: 1em solid rgb(71, 193, 168); border-left: 0.8em solid transparent ! important; border-right: 0.8em solid transparent ! important; border-bottom-color: rgb(71, 193, 168); box-sizing: border-box;\"></section><section style=\"display: block; width: 0px; height: 0px; clear: both;\"><br  /></section></section><br  /><span style=\"color: rgb(0, 0, 0);\"><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; text-align: center; margin: 0.8em 0px 0.2em; clear: both; box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"display: inline-block; box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 0.2em 0px 0px; padding: 0px 0.5em 5px; max-width: 100%; line-height: 1; border-bottom: 1px solid rgb(71, 193, 168); font-size: 100%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); border-color: rgb(71, 193, 168); box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\">PLUS精选摄影服务<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></section></section><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 5px 1em; line-height: 1; font-size: 75%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"></section></section></section></section></span></section></strong><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; margin-top: 0px; margin-bottom: 0px; clear: both; font-size: 1em; font-family: inherit; text-align: justify; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box; padding: 0px;\"><span style=\"color: rgb(0, 0, 0);\"><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; text-align: center; margin: 0.8em 0px 0.2em; clear: both; box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"display: inline-block; box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 5px 1em; line-height: 1; font-size: 75%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\">精修照片十张，可拍单人或情侣<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /><br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />男女化妆造型各一组，Angelababy造型团队签约化妆师帮你们化！<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /><br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />浪漫情侣服装各一套，全部品牌服装随便试<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /><br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />原片全部赠送，每对情侣最少六十张原片</section></section></section></section></span></section></section><section style=\"display: block; width: 0px; height: 0px; clear: both;\"><span style=\"color: rgb(50, 222, 190);\"></span><br  /></section></section><p><br  /></p><p><img data-w=\"\" data-ratio=\"0.6654676258992805\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMNicV1auqHXUVF7Rra5ByibKHlpn27hgv8VhQKKVQo6Yn984oiaa6ntkzQ/0?wx_fmt=jpeg\"  /><br  /></p></section><p><img data-w=\"\" data-ratio=\"0.6654676258992805\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMe0EricjFljxxYHibWOWUf0dWexiaYkfzp29AskNKao7Hufw1ibsuOM94og/0?wx_fmt=jpeg\"  /></p><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; text-align: center; margin: 0.8em 0px 0.2em; clear: both; box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"display: inline-block; box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 0.2em 0px 0px; padding: 0px 0.5em 5px; max-width: 100%; line-height: 1; border-bottom: 1px solid rgb(71, 193, 168); font-size: 100%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); border-color: rgb(71, 193, 168); box-sizing: border-box;\"><strong>男士服装搭配小课堂</strong><br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></section><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 5px 1em; line-height: 1; font-size: 75%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\">由第五空间高级服装讲师讲解<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></section></section></section><section style=\"display: block; width: 0px; height: 0px; clear: both;\"><br  /></section></section><p><br  /></p><p><img data-w=\"\" data-ratio=\"1.5\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMM2KRPf5XEibEDiaNN5rVw8AT5PtK4f2ojELibPeYDOSrWdOpZWtJ8gibH3A/0?wx_fmt=jpeg\"  /><br  /><img data-w=\"\" data-ratio=\"1.3327338129496402\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMbfz9QkJCfaQl4icOe3E6SAfkynJicqlaFFXRz47MCFcoNnQENfFBoJvg/0?wx_fmt=jpeg\"  /></p><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; text-align: center; margin: 0.8em 0px 0.2em; clear: both; box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"display: inline-block; box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 0.2em 0px 0px; padding: 0px 0.5em 5px; max-width: 100%; line-height: 1; border-bottom: 1px solid rgb(71, 193, 168); font-size: 100%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); border-color: rgb(71, 193, 168); box-sizing: border-box;\"><strong>选衣搭配亲密游戏</strong><br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></section><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 5px 1em; line-height: 1; font-size: 75%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box;\"><p style=\"box-sizing: border-box; line-height: normal;\">现场投票数最高的一对情侣<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />将赢得坚果手机一部哦<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></p></section></section><section style=\"display: block; width: 0px; height: 0px; clear: both;\"><br  /></section></section><p><br  /></p><p><img data-w=\"\" data-ratio=\"0.6600719424460432\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMPMt86jIWKzBhfYllEmQhNyNGZibLjpnBwGFox91zpn6MhotyVqmHK7w/0?wx_fmt=jpeg\"  /></p><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; text-align: center; margin: 0.8em 0px 0.2em; clear: both; box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"display: inline-block; box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 0.2em 0px 0px; padding: 0px 0.5em 5px; max-width: 100%; line-height: 1; border-bottom: 1px solid rgb(71, 193, 168); font-size: 100%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); border-color: rgb(71, 193, 168); box-sizing: border-box;\"><strong>甜蜜下午茶</strong><br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></section><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 5px 1em; line-height: 1; font-size: 75%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\">精美甜点随便吃~<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></section></section></section><section style=\"display: block; width: 0px; height: 0px; clear: both;\"><br  /></section></section><p><br  /></p><p><img data-w=\"\" data-ratio=\"0.6654676258992805\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMM4icmlb7jmcwdkzsKxFib4VcGDj2wRGkqz8MjnD8l6ib25EeEqQh971eSQ/0?wx_fmt=jpeg\"  /></p><p><img data-w=\"\" data-ratio=\"0.6654676258992805\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMvF6QAKagibgzoksiceibgOlTZlqECaox98qqXqmicfD8n4EJfyZvjVibPRQ/0?wx_fmt=jpeg\"  /><br  /></p><p><img data-w=\"\" data-ratio=\"1.4982014388489209\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMZBL68zb7QWU5sAvdv1VKnGLeXHW4atHPLrXYA4zDFnib0ah6DZKyMzw/0?wx_fmt=jpeg\"  /></p><section class=\"tn-Powered-by-XIUMI\" style=\"border: 0px none; text-align: center; margin: 0.8em 0px 0.2em; clear: both; box-sizing: border-box; padding: 0px;\"><section class=\"tn-Powered-by-XIUMI\" style=\"display: inline-block; box-sizing: border-box;\"><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 0.2em 0px 0px; padding: 0px 0.5em 5px; max-width: 100%; line-height: 1; border-bottom: 1px solid rgb(71, 193, 168); font-size: 100%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); border-color: rgb(71, 193, 168); box-sizing: border-box;\"><strong>舒适的环境</strong><br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></section><section class=\"tn-Powered-by-XIUMI\" style=\"margin: 5px 1em; line-height: 1; font-size: 75%; font-family: inherit; text-decoration: inherit; color: rgb(71, 193, 168); box-sizing: border-box;\"><p style=\"box-sizing: border-box; line-height: normal;\">第五空间的服饰随便试<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  />极具情调的摆设，怎样拍都好看<br class=\"tn-Powered-by-XIUMI\" style=\"box-sizing: border-box;\"  /></p></section></section><section style=\"display: block; width: 0px; height: 0px; clear: both;\"><br  /></section></section><section class=\"135brush\" data-brushtype=\"text\" style=\"\"><p style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; clear: both; min-height: 1em; white-space: pre-wrap; line-height: 1.5em;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; font-family: 宋体; font-size: 14px;\"><br  /></span></p></section><p><img data-w=\"\" data-ratio=\"0.5629496402877698\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMdkHWJnMlx5SaUiapk9aJSgJQg7XvK0JlL0cop8ys5nA53q8sGxFJsZQ/0?wx_fmt=jpeg\"  /><br  /><img data-w=\"\" data-ratio=\"0.75\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMM9YtjECcM7fTAnoq2hXeKsib4cH3qmlBLmiaD8OWiaJAh4VtJpLchdEeug/0?wx_fmt=jpeg\"  /><br  /><img data-w=\"\" data-ratio=\"0.75\" data-s=\"300,640\" data-type=\"jpeg\" data-src=\"http://mmbiz.qpic.cn/mmbiz/5VKv9h7zaKxTdbBkiaEQfTrtWLcUZ9nMMUtj47iatdceWMrO9Cqn0iaSA8u1ySxr1wP6fUDwqxNia8BaGT7FkHRUdQ/0?wx_fmt=jpeg\"  /><br  /></p><p style=\"margin: 1.5em 0px 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; clear: both; min-height: 1em; white-space: pre-wrap; color: rgb(62, 62, 62); font-size: 16px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: 楷体; line-height: 25.6000003814697px; background-color: rgb(255, 255, 255);\"><img data-type=\"png\" data-ratio=\"1\" data-w=\"30\" data-src=\"http://mmbiz.qpic.cn/mmbiz/yqVAqoZvDibG89wj0CAra1LNI661MRyL7bg1eNNgx5vWHguwBSrpyJnpaokVhqkzbhPAh2ft2NDeibGUuibGqnfnQ/640?wx_fmt=png\" style=\"margin: 0px 0px 0px 1em; padding: 0px; height: auto !important; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; vertical-align: top; width: auto !important; visibility: visible !important;\" width=\"auto\"  /> &nbsp;<span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(255, 41, 65); font-size: 18px;\"><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: inherit; font-size: 1em; line-height: 1.6em;\">时间</strong><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; line-height: 1.6em;\">：</span></span><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: inherit; font-family: 宋体, SimSun; line-height: 28.4444465637207px; font-size: 14px;\">2016年1月23日 14：00-18：00</span></p><p style=\"margin: 1.5em 0px 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; clear: both; min-height: 1em; white-space: pre-wrap; color: rgb(62, 62, 62); font-size: 16px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: 楷体; line-height: 25.6000003814697px; background-color: rgb(255, 255, 255);\"><img data-type=\"png\" data-ratio=\"1\" data-w=\"30\" data-src=\"http://mmbiz.qpic.cn/mmbiz/yqVAqoZvDibG89wj0CAra1LNI661MRyL7AAIicWvZTWLHlviaiboqI9UI5bicxlYghflp2821icfFib3jxwmDbosicxIOQ/640?wx_fmt=png\" style=\"margin: 0px 0px 0px 1em; padding: 0px; height: auto !important; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; font-family: 宋体, SimSun; font-size: 14px; line-height: 28.4444465637207px; color: inherit; vertical-align: top; width: 30px !important; visibility: visible !important;\" width=\"30px\"  /> &nbsp;<span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(255, 41, 65); font-size: 18px;\"><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; line-height: 28.4444465637207px;\">地点：</span></strong></span><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(56, 56, 56); line-height: 28.4444465637207px; font-family: 宋体, SimSun; font-size: 14px;\"></span></strong><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; font-family: 宋体, SimSun; font-size: 14px; line-height: 28.4444465637207px;\">北京市王府井东方新天地B1层BB65A第五空间</span></p><p style=\"margin: 1.5em 0px 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; clear: both; min-height: 1em; white-space: pre-wrap; color: rgb(62, 62, 62); font-size: 16px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: 楷体; line-height: 25.6000003814697px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(56, 56, 56); font-family: 宋体, SimSun; font-size: 14px; line-height: 28.4444465637207px;\"><img data-type=\"png\" data-ratio=\"1\" data-w=\"30\" data-src=\"http://mmbiz.qpic.cn/mmbiz/yqVAqoZvDibG89wj0CAra1LNI661MRyL7AAIicWvZTWLHlviaiboqI9UI5bicxlYghflp2821icfFib3jxwmDbosicxIOQ/640?wx_fmt=png\" style=\"margin: 0px 0px 0px 1em; padding: 0px; height: auto !important; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: inherit; line-height: 28.4444465637207px; vertical-align: top; width: 30px !important; visibility: visible !important;\" width=\"30px\"  /><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; font-family: 楷体; line-height: 25.6000003814697px;\"> </span></span><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(255, 41, 65);\"><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; font-size: 18px; line-height: 25.6000003814697px;\">价格</span></strong></span><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(56, 56, 56); font-family: 宋体, SimSun; font-size: 14px; line-height: 28.4444465637207px;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; font-family: 楷体; line-height: 25.6000003814697px; color: rgb(255, 41, 65); font-size: 18px;\"><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; line-height: 28.4444465637207px;\">：</span></strong></span><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; font-family: 楷体; line-height: 25.6000003814697px;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; line-height: 28.4444465637207px; font-family: 宋体, SimSun;\"></span></strong><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(0, 0, 0); line-height: 28.4444465637207px;\">520元/对，限量10对</span></span></p><p style=\"margin: 1.5em 0px 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; clear: both; min-height: 1em; white-space: pre-wrap; color: rgb(62, 62, 62); font-size: 16px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; font-family: 楷体; line-height: 25.6000003814697px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(56, 56, 56); font-family: 宋体, SimSun; font-size: 14px; line-height: 28.4444465637207px;\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(0, 0, 0); line-height: 28.4444465637207px;\"><br  /></span></span></p><hr  /><p><br  /></p><p><br  /></p><p><strong style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(62, 62, 62); font-family: 楷体; font-size: 16px; font-style: normal; font-variant: normal; letter-spacing: normal; line-height: 28.4444465637207px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; max-width: 100%; box-sizing: border-box !important; word-wrap: break-word !important; color: rgb(255, 79, 121);\">点击阅读原文，直接报名即可！</span></strong></p></div>";
    
//    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
//                          "<head> \n"
//                          "<style type=\"text/css\"> \n"
//                          "body {font-size: %d; font-family: \"%@\"; color: %@;}\n"
//                          "</style> \n"
//                          "</head> \n"
//                          "<body>%@</body> \n"
//                          "</html>", 12, @"FZLTXHK", @"rgb(255, 79, 121)", @"html"];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect frame = webView.frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, webView.bottom + 100, SCREEN_WIDTH, 20)];
    label.text = @"test";
    label.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, label.bottom + 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
