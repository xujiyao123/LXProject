
//
//  TantanViewController.m
//  Project_iOS
//
//  Created by 刘旭 on 16/1/21.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "TantanViewController.h"
#import "TTStackCards.h"
#import "ChosenCard.h"

@interface TantanViewController ()<TTStackCardsDelegate>

@property(nonatomic,strong) TTStackCards *stackCards;

@end

@implementation TantanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stackCards = [TTStackCards cardsWithPresenedView:self.view ttStackCardsDelegate:self];
    
}

static int i = 0;

- (TTStackSingleCardView *)ttStackCardView {
    
    
    if (i < 6) {
        i++;
        return [ChosenCard newCard];
    }
    
    return nil;
}

- (NSInteger)numberOfCardsEstimated {
    return 5;
}

- (void)ttStackCardView:(TTStackSingleCardView *)cardView movingOnDirection:(TTStackCardsDicretion)direction movingFactor:(CGFloat)factor {
    NSLog(@"moving:%f",factor);
}

- (void)ttStackCardView:(TTStackSingleCardView *)cardView didRemovedOnDirection:(TTStackCardsDicretion)direction {
    NSLog(@"over");
}

- (void)dealloc {
    self.stackCards.delegate = nil;
    i = 0;
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
